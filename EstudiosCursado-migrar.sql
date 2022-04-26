BEGIN TRY
DECLARE @dniAlumno varchar(18)
DECLARE @SEDE_DESTINO INT 
DECLARE @TITULO VARCHAR(300), @INSTITUCION VARCHAR(300), @COD_INSTITUCION INT, @COD_TITULO INT, @COD_TITULO_NUEVO INT, @COD_INST_NUEVO INT
set @dniAlumno = '42404427'


DECLARE CESTUDIOS CURSOR
FOR SELECT   DBO.REMOVERTILDES(dbo.REMOVERESPACIOSENBLANCO(T.TIT_DESCRIPCION)),dbo.REMOVERTILDES(DBO.REMOVERESPACIOSENBLANCO(I.INST_NOMBRE)),
		 EC.INSTITUCION,  EC.TITULO FROM ESTUDIOS_CURSADOS EC
 
		 INNER JOIN TITULOS T
		ON EC.TITULO = T.TIT_CODIGO
		INNER JOIN INSTITUCIONES I
		ON EC.INSTITUCION = I.INST_CODIGO
		WHERE NRO_DOC = @dniAlumno

		OPEN CESTUDIOS

		FETCH CESTUDIOS INTO @TITULO, @INSTITUCION, @COD_INSTITUCION, @COD_TITULO

			WHILE(@@FETCH_STATUS = 0)
			BEGIN 

			  EXEC OBTENERCODIGODEINSTITUCION @INSTITUCION,@SEDE_DESTINO,@COD_INSTITUCION, @CODIGO_INSTITUCION = @COD_INST_NUEVO OUTPUT

			  EXEC OBTENERCODIGODETITULO @TITULO, @SEDE_DESTINO, @COD_TITULO, @CODIGO_TITULO = @COD_TITULO_NUEVO OUTPUT
			
			   INSERT INTO SEDESPE�A.DBO.ESTUDIOS_CURSADOS
			   SELECT TIPO_DOC, @dniAlumno, TIPO_ESTUDIO, @COD_INST_NUEVO,SEDE,ID,@COD_TITULO_NUEVO,FECHA_EGRESO,PROMEDIO,CANT_MATERIAS_ADEUDA,SITUACION_FINAL FROM ESTUDIOS_CURSADOS WHERE NRO_DOC = @dniAlumno

			  FETCH CESTUDIOS INTO @TITULO, @INSTITUCION, @COD_INSTITUCION, @COD_TITULO

		    END 
			
			CLOSE CESTUDIOS
			DEALLOCATE CESTUDIOS

	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE()
	
	END CATCH