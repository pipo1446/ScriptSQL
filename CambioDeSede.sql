DECLARE @DNI VARCHAR(18), @SEDE_DESTINO INT
 SET @DNI = '42404427'
 SET @SEDE_DESTINO = 11

DECLARE @CANTIDAD INT, @EXISTE_EN_DESTINO INT



 SELECT @CANTIDAD = COUNT(ALU_CODIGO) FROM ALUMNOS
 WHERE ALU_SIR_CODIGO NOT IN(2,3,4,8,9,10,11,12)
 AND ALU_NRO_DOC_AL = @DNI

 IF	(@CANTIDAD = 0)
	BEGIN
		 PRINT	 'LA SITUACI�N DE REVISTA IMPIDE EMPEZAR A REALIZAR EL CAMBIO DE SEDE'
		 RETURN
	END

 IF	(@SEDE_DESTINO = 11)
	BEGIN
		SELECT @EXISTE_EN_DESTINO = COUNT(ALU_CODIGO) FROM SEDESPE�A.dbo.ALUMNOS WHERE ALU_NRO_DOC_AL = @DNI
	END

IF (@EXISTE_EN_DESTINO > 0)
	BEGIN
		PRINT 'Existe un legajo del alumno en Sede Destino'
		RETURN
	END
ELSE
	BEGIN
		PRINT 'Obtenemos todos los legajos del alumno base de datos origen para luego analizar'
		RETURN
	END


	
