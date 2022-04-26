




--EJECUTAR EL SCRIPT DESDE LA SEDE ORIGEN DEL ALUMNO.

--parámetros (dniAlumno, sedeDestino, sedeOrigen,Observación(Nro Expte, cambio a sede destino))
BEGIN TRY
BEGIN TRAN
DECLARE @dniAlumno numeric(18,0), @sedeDestino int, @observacion varchar(500), @sedeOrigen int

--ASIGNAR LOS VALORES ANTES DE COMENZAR LA MIGRACIÓN
set @dniAlumno = '37256030'
set @sedeDestino = 2
set @sedeOrigen = 5
set @observacion = 'Cambio a Sede Goya Expte 9/2022- SEDE CURUZU'


DECLARE @GOYA INT, @LIBRES INT, @POSADAS INT, @CURUZU INT, @FORMOSA INT, @RESISTENCIA INT, @SAENZPEÑA INT, @CENTRAL INT
	SET @GOYA = 2
	SET @LIBRES = 3
	SET @POSADAS = 4
	SET @CURUZU = 5
	SET @FORMOSA = 6
	SET @RESISTENCIA = 10
	SET @SAENZPEÑA = 11
	SET @CENTRAL = 1

DECLARE @ExisteEnDestino int

 IF @sedeOrigen = @sedeDestino
	BEGIN
		SELECT 'SELECCIONAR SEDE DESTINO DISTINTA A LA SEDE ORIGEN'
		ROLLBACK TRAN
		RETURN
	end

--1)EXISTE EN SEDE DESTINO? SI- Salimos, NO- Seguimos el siguiente paso.

IF @sedeDestino = @GOYA
	BEGIN
		SELECT @ExisteEnDestino = count(ALU_CODIGO) FROM SEDEGOYA.DBO.ALUMNOS WHERE ALU_NRO_DOC_AL  = @dniAlumno
	END

  ELSE IF @sedeDestino = @CENTRAL
	BEGIN
		SELECT @ExisteEnDestino = count(ALU_CODIGO) FROM SEDECENTRAL.DBO.ALUMNOS A
		WHERE ALU_NRO_DOC_AL  = @dniAlumno
		
		
	END

 ELSE IF @sedeDestino = @LIBRES
	BEGIN
		SELECT @ExisteEnDestino = count(*) FROM SEDEPLIBRES.DBO.ALUMNOS WHERE ALU_NRO_DOC_AL  = @dniAlumno
	END
 
  ELSE IF @sedeDestino = @POSADAS
	BEGIN
		SELECT @ExisteEnDestino = count(*) FROM SEDEPOSADAS.DBO.ALUMNOS WHERE ALU_NRO_DOC_AL  = @dniAlumno
	END

  ELSE IF @sedeDestino = @CURUZU
	BEGIN
		SELECT @ExisteEnDestino = count(*) FROM SEDECURUZU.DBO.ALUMNOS WHERE ALU_NRO_DOC_AL  = @dniAlumno
	END
   
 ELSE IF @sedeDestino = @FORMOSA
	BEGIN
		SELECT @ExisteEnDestino = count(*) FROM SEDEFORMOSA.DBO.ALUMNOS WHERE ALU_NRO_DOC_AL  = @dniAlumno
	END


  ELSE IF @sedeDestino = @SAENZPEÑA
	BEGIN
		SELECT @ExisteEnDestino = count(*) FROM SEDESPEÑA.DBO.ALUMNOS WHERE ALU_NRO_DOC_AL  = @dniAlumno
	END
   ELSE
       BEGIN
			SELECT 'NO EXISTE LA SEDE INGRESADA POR PARÁMETRO'
			ROLLBACK TRAN
			RETURN
	   END
   
   IF @ExisteEnDestino > 0
		BEGIN
			SELECT 'EXISTE LEGAJO EN SEDE DESTINO'
			ROLLBACK TRAN
			RETURN
		END







	DECLARE @SITUACION_REVISTA INT

	SELECT @SITUACION_REVISTA = COUNT(ALU_CODIGO) FROM ALUMNOS WHERE ALU_NRO_DOC_AL = @dniAlumno
	and ALU_SIR_CODIGO NOT IN(2,4,8,10,9,11)
	
--2	Baja
--4	Activo que no cursa
--8	Graduado
--9	Suspendido
--10	Abandono Aspirante
--11	Cambio de Sede


	IF @SITUACION_REVISTA = 0
		BEGIN
			SELECT 'Consultar con Académica por NO tener situación de revista Activo , Reincorporado o Completo Cursado'
			ROLLBACK TRAN
			RETURN
		END

		
--3)CURSOR CON LOS DATOS  DEL ALUMNO QUE SE VA A MIGRAR(ALU_NRO_DOC_AL)
      DECLARE @ALU_CODIGO INT, @ALU_CODIGO_ANT INT, @ALU_CODIGO_INSERTADO INT, @ALU_CODIGO_NUEVO INT
	  SET @ALU_CODIGO_ANT = 0

	 
      DECLARE CALUMNOS CURSOR

	  FOR SELECT ALU_CODIGO FROM ALUMNOS WHERE ALU_NRO_DOC_AL = @dniAlumno order by alu_codigo
	  OPEN CALUMNOS

	  FETCH CALUMNOS INTO @ALU_CODIGO

	  WHILE (@@FETCH_STATUS = 0)
		BEGIN
		    
			   
			     EXEC dbo.Insertar_Legajo_alumno @ALU_CODIGO,@ALU_CODIGO_ANT,@sedeDestino,  @ALU_CODIGO_INSERTADO OUTPUT;
			   
				
				 
				 EXEC dbo.Insertar_Datos_Padre_Madre @alu_codigo, @sedeDestino, @ALU_CODIGO_INSERTADO
                 
				 EXEC dbo.Insertar_Domicilios @alu_codigo,@ALU_CODIGO_INSERTADO,@sedeDestino
				 				 
				 EXEC dbo.Insertar_Historico_Situacion_Revista @alu_codigo,@ALU_CODIGO_INSERTADO, @sedeDestino 

				 EXEC dbo.Insertar_Comisiones_Planilla_Formativa @alu_codigo,@sedeDestino,@ALU_CODIGO_INSERTADO
				
	             EXEC dbo.Insertar_Mesa_Finales_Alumno @alu_codigo, @ALU_CODIGO_INSERTADO, @sedeDestino
				 
				 EXEC dbo.Insertar_Equivalencias_Alumnos @alu_codigo, @ALU_CODIGO_INSERTADO,@sedeDestino

				 EXEC dbo.Insertar_Antecedente_Alumno_Atributo @alu_codigo,@ALU_CODIGO_INSERTADO,@sedeDestino


				 SET  @ALU_CODIGO_ANT  = @ALU_CODIGO_INSERTADO
     
	 
	
 
         FETCH CALUMNOS INTO @ALU_CODIGO
		 END
		CLOSE CALUMNOS
		DEALLOCATE CALUMNOS
		
	
		EXEC dbo.Insertar_Estudios_Cursados @dniAlumno,@sedeDestino
				
		EXEC dbo.Insertar_Situacion_Revista_Cambio_Sede @dniAlumno, @observacion 
		
		COMMIT TRAN
		SELECT 'SE COMPLETÓ LA MIGRACIÓN DEL LEGAJO DEL ALUMNO'
END TRY
BEGIN CATCH
	SELECT ERROR_MESSAGE()
    ROLLBACK TRAN
END CATCH







