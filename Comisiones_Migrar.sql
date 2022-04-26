CREATE PROCEDURE Insertar_Comisiones_Planilla_Formativa
(
@ALU_CODIGO INT,
@SEDE_A_INSERTAR INT,
@ALU_CODIGO_DESTINO INT

)
AS

BEGIN TRY
BEGIN TRAN

--CURSOR
DECLARE @ALC_COA_COM_CODIGO INT, @ALC_COA_ANO INT, @COM_CODIGO INT, @PES_ORIGEN int,@COA_CUAT_ORIGEN INT, @FAC_ORIGEN int, @CAR_ORIGEN int, @MAT_ORIGEN INT
declare @COM_CODIGO_DESTINO INT
DECLARE CALUMNOCOMISION CURSOR
--FOR SELECT ALC_COA_COM_CODIGO, ALC_COA_ANO FROM ALUMNO_COMISION WHERE ALC_ALU_CODIGO = @ALU_CODIGO

FOR SELECT AC.ALC_COA_COM_CODIGO, AC.ALC_COA_ANO, AC.ALC_COA_CUATRIMESTRE,C.COM_PLAN_RAIZ FROM ALUMNO_COMISION AC
INNER JOIN COMISIONES C
ON AC.ALC_COA_COM_CODIGO = C.COM_CODIGO
WHERE ALC_ALU_CODIGO = @ALU_CODIGO



OPEN CALUMNOCOMISION
FETCH CALUMNOCOMISION INTO @ALC_COA_COM_CODIGO, @ALC_COA_ANO,@COA_CUAT_ORIGEN,@PES_ORIGEN

WHILE (@@FETCH_STATUS = 0)
	BEGIN

		 
           EXEC dbo.Insertar_Comision @ALC_COA_COM_CODIGO, @SEDE_A_INSERTAR,@COM_CODIGO_DESTINO OUTPUT

		   -- INSERTAR EN COM_PLAN
		   EXEC Insertar_Com_Plan @ALC_COA_COM_CODIGO,@COM_CODIGO_DESTINO, @SEDE_A_INSERTAR
		 
	    --INSERTAR EN COMISIONES_ANO

			EXEC Insertar_Comisiones_Ano @ALC_COA_COM_CODIGO,@SEDE_A_INSERTAR,@COM_CODIGO_DESTINO

		 --INSERTAR COMISION_DIAS
			EXEC Insertar_Comision_Dias @ALC_COA_COM_CODIGO,@COM_CODIGO_DESTINO, @SEDE_A_INSERTAR
	
	   --Insertar Alumno Comision
			EXEC Insertar_Alumno_Comision @ALC_COA_COM_CODIGO, @COM_CODIGO_DESTINO,@SEDE_A_INSERTAR,@ALU_CODIGO,@ALU_CODIGO_DESTINO

		 --Insertar Inasistencias ALumnos
			EXEC Insertar_Inasistencia_alumnos @ALC_COA_COM_CODIGO,@COM_CODIGO_DESTINO,@SEDE_A_INSERTAR,@ALU_CODIGO,@ALU_CODIGO_DESTINO

		 --Insertar Notas Finales Promocionales
			EXEC Insertar_Notas_Finales_Promocionales @ALC_COA_COM_CODIGO, @COM_CODIGO_DESTINO,@SEDE_A_INSERTAR,@ALU_CODIGO,@ALU_CODIGO_DESTINO

			EXEC Insertar_Fechas_Examenes @ALC_COA_COM_CODIGO,@COM_CODIGO_DESTINO,@SEDE_A_INSERTAR

			EXEC Insertar_Planilla_Formativa @ALU_CODIGO, @ALU_CODIGO_DESTINO,@SEDE_A_INSERTAR, @ALC_COA_COM_CODIGO,@COM_CODIGO_DESTINO,@ALC_COA_ANO,@COA_CUAT_ORIGEN



	FETCH CALUMNOCOMISION INTO @ALC_COA_COM_CODIGO, @ALC_COA_ANO
	END

CLOSE CALUMNOCOMISION
DEALLOCATE CALUMNOCOMISION

COMMIT TRAN

END TRY

BEGIN CATCH
ROLLBACK TRAN
END CATCH



 
 --luego equivalencias
 --luego alumno_atributo
 --antecedente_alumno
 --FIN

 ---*---REGISTRAR LAS MESAS RENDIDAS POR EL ALUMNO
ALTER PROCEDURE Insertar_Mesa_Finales_Alumno
@ALU_CODIGO_ORIGEN INT,
@ALU_CODIGO_DESTINO INT,
@SEDE_A_INSERTAR INT






AS

BEGIN TRY
BEGIN TRAN

--VARIABLES CURSOR
DECLARE @IFA_MEE_ANO NUMERIC(18,0), @IFA_MEE_LLAMADO VARCHAR(1),@IFA_ALU_CODIGO INT, @IFA_FECHA_INSCRIPCION DATETIME, @IFA_LIBRE VARCHAR(1), @IFA_OBSERV_MODIF_REG VARCHAR(200)
DECLARE @IFA_FECHA_CREAC_REG DATETIME, @IFA_USUARIO_CREAC_REG VARCHAR(50), @IFA_FECHA_MODIF_REG VARCHAR(50), @IFA_USUARIO_MODIF_REG VARCHAR(50), @IFA_SITUACION VARCHAR(200), @IFA_MEE_CODIGO INT

--VARIABLES
DECLARE @TUM_FECHA_DESDE DATETIME, @TUM_FECHA_HASTA DATETIME, @TUM_TIPO VARCHAR(1), @TUM_CODIGO_DESTINO INT, @MEE_CODIGO_DESTINO INT

--CURSOR
DECLARE CInsFinalAlumnos CURSOR
FOR
SELECT IFA_MEE_CODIGO,IFA_MEE_ANO,IFA_MEE_LLAMADO,IFA_ALU_CODIGO,IFA_FECHA_INSCRIPCION,IFA_LIBRE,IFA_OBSERV_MODIF_REG,IFA_FECHA_CREAC_REG,IFA_USUARIO_CREAC_REG,
       IFA_FECHA_MODIF_REG,IFA_USUARIO_MODIF_REG,IFA_SITUACION FROM INS_FINAL_ALUMNOS
WHERE IFA_ALU_CODIGO = @ALU_CODIGO_ORIGEN

OPEN CInsFinalAlumnos

FETCH CInsFinalAlumnos INTO @IFA_MEE_CODIGO, @IFA_MEE_ANO,@IFA_MEE_LLAMADO,@IFA_ALU_CODIGO,@IFA_FECHA_INSCRIPCION,@IFA_LIBRE,@IFA_OBSERV_MODIF_REG,@IFA_FECHA_CREAC_REG,@IFA_USUARIO_CREAC_REG,@IFA_FECHA_MODIF_REG,@IFA_USUARIO_MODIF_REG,@IFA_SITUACION

WHILE(@@FETCH_STATUS = 0)
BEGIN

--POR CADA FILA DEL CURSOR

--OBTENGO FECHA_DESDE, FECHA_HASTA, TIPO (TURNO_MESA) Y GUARDO EN VARIABLES DE LA SEDE ORIGEN
SELECT TM.TUM_FECHA_DESDE, TM.TUM_FECHA_HASTA,  TM.TUM_TIPO FROM MESA_EXAMEN ME
INNER JOIN TURNO_MESA TM
ON ME.MEE_TUM_CODIGO = TM.TUM_CODIGO
WHERE MEE_CODIGO = @IFA_MEE_CODIGO AND MEE_ANO = @IFA_MEE_ANO


IF @SEDE_A_INSERTAR = 1
BEGIN
SELECT top 1 @TUM_CODIGO_DESTINO = TUM_CODIGO FROM SEDESPE�A.DBO.TURNO_MESA
--WHERE TUM_FECHA_DESDE = CONVERT(VARCHAR(12),@TUM_FECHA_DESDE,103) AND TUM_FECHA_HASTA = CONVERT(VARCHAR(12),@TUM_FECHA_HASTA,103)
WHERE
 TUM_FECHA_DESDE BETWEEN CONVERT(VARCHAR(12),@TUM_FECHA_DESDE,103) AND  CONVERT(VARCHAR(12),@TUM_FECHA_HASTA,103)
AND TUM_FECHA_HASTA BETWEEN CONVERT(VARCHAR(12),@TUM_FECHA_DESDE,103) AND  CONVERT(VARCHAR(12),@TUM_FECHA_HASTA,103)
AND TUM_TIPO = @TUM_TIPO

SELECT @MEE_CODIGO_DESTINO = MAX(MEE_CODIGO) + 1 FROM SEDECENTRAL.dbo.MESA_EXAMEN

INSERT SEDECENTRAL.dbo.MESA_EXAMEN
SELECT @MEE_CODIGO_DESTINO,MEE_ANO,MEE_DESCRIPCION,MEE_PLM_PES_CODIGO,MEE_PLM_PES_CAR_FAC_CODIGO,MEE_PLM_PES_CAR_CODIGO,MEE_PLM_MAT_CODIGO,@TUM_CODIGO_DESTINO,MEE_ORIENTACION
FROM MESA_EXAMEN WHERE MEE_CODIGO =@IFA_MEE_CODIGO AND MEE_ANO = @IFA_MEE_ANO

INSERT SEDECENTRAL.dbo.MESA_LLAMADO
SELECT @MEE_CODIGO_DESTINO,MEL_MEE_ANO, MEL_LLAMADO,MEL_PRESIDENTE,MEL_VOCAL_1,MEL_VOCAL_2,MEL_AUL_CODIGO,MEL_SED_CODIGO,MEL_FECHA,MEL_HORA
,MEL_AV_LIBRES, MEL_AV_REGULARES,MEL_ALUMNOS,MEL_APROBADOS,MEL_AUSENTES,MEL_DESAPROBADOS,MEL_CARGA,MEL_FECHA_CARGA,MEL_HORA_CARGA,MEL_USUARIO_CARGA,MEL_INF_CORR,MEL_USU_CREAC,
MEL_FECHA_MODIF, MEL_USU_MODIF,MEL_OBSERVA_MODIF FROM MESA_LLAMADO WHERE MEL_MEE_CODIGO = @IFA_MEE_CODIGO AND MEL_MEE_ANO = @IFA_MEE_ANO


INSERT INTO SEDECENTRAL.dbo.INS_FINAL_ALUMNOS
VALUES(@MEE_CODIGO_DESTINO, @IFA_MEE_ANO,@IFA_MEE_LLAMADO,@ALU_CODIGO_DESTINO,@IFA_FECHA_INSCRIPCION,@IFA_LIBRE,@IFA_OBSERV_MODIF_REG,@IFA_FECHA_CREAC_REG,@IFA_USUARIO_CREAC_REG,@IFA_FECHA_MODIF_REG,@IFA_USUARIO_MODIF_REG,@IFA_SITUACION)

INSERT SEDECENTRAL.dbo.NOTAS_FINALES

SELECT @MEE_CODIGO_DESTINO, NOF_IFA_MEE_ANO,NOF_IFA_MEE_LLAMADO,@ALU_CODIGO_DESTINO,NOF_LIBRO,NOF_FOLIO,NOF_NOTA_ESCRITO,NOF_NOTA_ORAL,NOF_FECHA FROM NOTAS_FINALES
WHERE NOF_IFA_MEE_CODIGO = @IFA_MEE_CODIGO AND NOF_IFA_MEE_ANO = @IFA_MEE_ANO AND NOF_IFA_ALU_CODIGO = @IFA_ALU_CODIGO

END

IF @SEDE_A_INSERTAR = 2
BEGIN
SELECT top 1 @TUM_CODIGO_DESTINO = TUM_CODIGO FROM SEDESPE�A.DBO.TURNO_MESA
--WHERE TUM_FECHA_DESDE = CONVERT(VARCHAR(12),@TUM_FECHA_DESDE,103) AND TUM_FECHA_HASTA = CONVERT(VARCHAR(12),@TUM_FECHA_HASTA,103)
WHERE
 TUM_FECHA_DESDE BETWEEN CONVERT(VARCHAR(12),@TUM_FECHA_DESDE,103) AND  CONVERT(VARCHAR(12),@TUM_FECHA_HASTA,103)
AND TUM_FECHA_HASTA BETWEEN CONVERT(VARCHAR(12),@TUM_FECHA_DESDE,103) AND  CONVERT(VARCHAR(12),@TUM_FECHA_HASTA,103)
AND TUM_TIPO = @TUM_TIPO

SELECT @MEE_CODIGO_DESTINO = MAX(MEE_CODIGO) + 1 FROM SEDEGOYA.dbo.MESA_EXAMEN

INSERT SEDEGOYA.dbo.MESA_EXAMEN
SELECT @MEE_CODIGO_DESTINO,MEE_ANO,MEE_DESCRIPCION,MEE_PLM_PES_CODIGO,MEE_PLM_PES_CAR_FAC_CODIGO,MEE_PLM_PES_CAR_CODIGO,MEE_PLM_MAT_CODIGO,@TUM_CODIGO_DESTINO,MEE_ORIENTACION
FROM MESA_EXAMEN WHERE MEE_CODIGO =@IFA_MEE_CODIGO AND MEE_ANO = @IFA_MEE_ANO

INSERT SEDEGOYA.dbo.MESA_LLAMADO
SELECT @MEE_CODIGO_DESTINO,MEL_MEE_ANO, MEL_LLAMADO,MEL_PRESIDENTE,MEL_VOCAL_1,MEL_VOCAL_2,MEL_AUL_CODIGO,MEL_SED_CODIGO,MEL_FECHA,MEL_HORA
,MEL_AV_LIBRES, MEL_AV_REGULARES,MEL_ALUMNOS,MEL_APROBADOS,MEL_AUSENTES,MEL_DESAPROBADOS,MEL_CARGA,MEL_FECHA_CARGA,MEL_HORA_CARGA,MEL_USUARIO_CARGA,MEL_INF_CORR,MEL_USU_CREAC,
MEL_FECHA_MODIF, MEL_USU_MODIF,MEL_OBSERVA_MODIF FROM MESA_LLAMADO WHERE MEL_MEE_CODIGO = @IFA_MEE_CODIGO AND MEL_MEE_ANO = @IFA_MEE_ANO


INSERT INTO SEDEGOYA.dbo.INS_FINAL_ALUMNOS
VALUES(@MEE_CODIGO_DESTINO, @IFA_MEE_ANO,@IFA_MEE_LLAMADO,@ALU_CODIGO_DESTINO,@IFA_FECHA_INSCRIPCION,@IFA_LIBRE,@IFA_OBSERV_MODIF_REG,@IFA_FECHA_CREAC_REG,@IFA_USUARIO_CREAC_REG,@IFA_FECHA_MODIF_REG,@IFA_USUARIO_MODIF_REG,@IFA_SITUACION)

INSERT SEDEGOYA.dbo.NOTAS_FINALES

SELECT @MEE_CODIGO_DESTINO, NOF_IFA_MEE_ANO,NOF_IFA_MEE_LLAMADO,@ALU_CODIGO_DESTINO,NOF_LIBRO,NOF_FOLIO,NOF_NOTA_ESCRITO,NOF_NOTA_ORAL,NOF_FECHA FROM NOTAS_FINALES
WHERE NOF_IFA_MEE_CODIGO = @IFA_MEE_CODIGO AND NOF_IFA_MEE_ANO = @IFA_MEE_ANO AND NOF_IFA_ALU_CODIGO = @IFA_ALU_CODIGO

END

IF @SEDE_A_INSERTAR = 3
BEGIN
SELECT top 1 @TUM_CODIGO_DESTINO = TUM_CODIGO FROM SEDESPE�A.DBO.TURNO_MESA
--WHERE TUM_FECHA_DESDE = CONVERT(VARCHAR(12),@TUM_FECHA_DESDE,103) AND TUM_FECHA_HASTA = CONVERT(VARCHAR(12),@TUM_FECHA_HASTA,103)
WHERE
 TUM_FECHA_DESDE BETWEEN CONVERT(VARCHAR(12),@TUM_FECHA_DESDE,103) AND  CONVERT(VARCHAR(12),@TUM_FECHA_HASTA,103)
AND TUM_FECHA_HASTA BETWEEN CONVERT(VARCHAR(12),@TUM_FECHA_DESDE,103) AND  CONVERT(VARCHAR(12),@TUM_FECHA_HASTA,103)
AND TUM_TIPO = @TUM_TIPO

SELECT @MEE_CODIGO_DESTINO = MAX(MEE_CODIGO) + 1 FROM SEDEPLIBRES.dbo.MESA_EXAMEN

INSERT SEDEPLIBRES.dbo.MESA_EXAMEN
SELECT @MEE_CODIGO_DESTINO,MEE_ANO,MEE_DESCRIPCION,MEE_PLM_PES_CODIGO,MEE_PLM_PES_CAR_FAC_CODIGO,MEE_PLM_PES_CAR_CODIGO,MEE_PLM_MAT_CODIGO,@TUM_CODIGO_DESTINO,MEE_ORIENTACION
FROM MESA_EXAMEN WHERE MEE_CODIGO =@IFA_MEE_CODIGO AND MEE_ANO = @IFA_MEE_ANO

INSERT SEDEPLIBRES.dbo.MESA_LLAMADO
SELECT @MEE_CODIGO_DESTINO,MEL_MEE_ANO, MEL_LLAMADO,MEL_PRESIDENTE,MEL_VOCAL_1,MEL_VOCAL_2,MEL_AUL_CODIGO,MEL_SED_CODIGO,MEL_FECHA,MEL_HORA
,MEL_AV_LIBRES, MEL_AV_REGULARES,MEL_ALUMNOS,MEL_APROBADOS,MEL_AUSENTES,MEL_DESAPROBADOS,MEL_CARGA,MEL_FECHA_CARGA,MEL_HORA_CARGA,MEL_USUARIO_CARGA,MEL_INF_CORR,MEL_USU_CREAC,
MEL_FECHA_MODIF, MEL_USU_MODIF,MEL_OBSERVA_MODIF FROM MESA_LLAMADO WHERE MEL_MEE_CODIGO = @IFA_MEE_CODIGO AND MEL_MEE_ANO = @IFA_MEE_ANO


INSERT INTO SEDEPLIBRES.dbo.INS_FINAL_ALUMNOS
VALUES(@MEE_CODIGO_DESTINO, @IFA_MEE_ANO,@IFA_MEE_LLAMADO,@ALU_CODIGO_DESTINO,@IFA_FECHA_INSCRIPCION,@IFA_LIBRE,@IFA_OBSERV_MODIF_REG,@IFA_FECHA_CREAC_REG,@IFA_USUARIO_CREAC_REG,@IFA_FECHA_MODIF_REG,@IFA_USUARIO_MODIF_REG,@IFA_SITUACION)

INSERT SEDEPLIBRES.dbo.NOTAS_FINALES

SELECT @MEE_CODIGO_DESTINO, NOF_IFA_MEE_ANO,NOF_IFA_MEE_LLAMADO,@ALU_CODIGO_DESTINO,NOF_LIBRO,NOF_FOLIO,NOF_NOTA_ESCRITO,NOF_NOTA_ORAL,NOF_FECHA FROM NOTAS_FINALES
WHERE NOF_IFA_MEE_CODIGO = @IFA_MEE_CODIGO AND NOF_IFA_MEE_ANO = @IFA_MEE_ANO AND NOF_IFA_ALU_CODIGO = @IFA_ALU_CODIGO

END


IF @SEDE_A_INSERTAR = 4
BEGIN
SELECT top 1 @TUM_CODIGO_DESTINO = TUM_CODIGO FROM SEDESPE�A.DBO.TURNO_MESA
--WHERE TUM_FECHA_DESDE = CONVERT(VARCHAR(12),@TUM_FECHA_DESDE,103) AND TUM_FECHA_HASTA = CONVERT(VARCHAR(12),@TUM_FECHA_HASTA,103)
WHERE
 TUM_FECHA_DESDE BETWEEN CONVERT(VARCHAR(12),@TUM_FECHA_DESDE,103) AND  CONVERT(VARCHAR(12),@TUM_FECHA_HASTA,103)
AND TUM_FECHA_HASTA BETWEEN CONVERT(VARCHAR(12),@TUM_FECHA_DESDE,103) AND  CONVERT(VARCHAR(12),@TUM_FECHA_HASTA,103)
AND TUM_TIPO = @TUM_TIPO

SELECT @MEE_CODIGO_DESTINO = MAX(MEE_CODIGO) + 1 FROM SEDEPOSADAS.dbo.MESA_EXAMEN

INSERT SEDEPOSADAS.dbo.MESA_EXAMEN
SELECT @MEE_CODIGO_DESTINO,MEE_ANO,MEE_DESCRIPCION,MEE_PLM_PES_CODIGO,MEE_PLM_PES_CAR_FAC_CODIGO,MEE_PLM_PES_CAR_CODIGO,MEE_PLM_MAT_CODIGO,@TUM_CODIGO_DESTINO,MEE_ORIENTACION
FROM MESA_EXAMEN WHERE MEE_CODIGO =@IFA_MEE_CODIGO AND MEE_ANO = @IFA_MEE_ANO

INSERT SEDEPOSADAS.dbo.MESA_LLAMADO
SELECT @MEE_CODIGO_DESTINO,MEL_MEE_ANO, MEL_LLAMADO,MEL_PRESIDENTE,MEL_VOCAL_1,MEL_VOCAL_2,MEL_AUL_CODIGO,MEL_SED_CODIGO,MEL_FECHA,MEL_HORA
,MEL_AV_LIBRES, MEL_AV_REGULARES,MEL_ALUMNOS,MEL_APROBADOS,MEL_AUSENTES,MEL_DESAPROBADOS,MEL_CARGA,MEL_FECHA_CARGA,MEL_HORA_CARGA,MEL_USUARIO_CARGA,MEL_INF_CORR,MEL_USU_CREAC,
MEL_FECHA_MODIF, MEL_USU_MODIF,MEL_OBSERVA_MODIF FROM MESA_LLAMADO WHERE MEL_MEE_CODIGO = @IFA_MEE_CODIGO AND MEL_MEE_ANO = @IFA_MEE_ANO


INSERT INTO SEDEPOSADAS.dbo.INS_FINAL_ALUMNOS
VALUES(@MEE_CODIGO_DESTINO, @IFA_MEE_ANO,@IFA_MEE_LLAMADO,@ALU_CODIGO_DESTINO,@IFA_FECHA_INSCRIPCION,@IFA_LIBRE,@IFA_OBSERV_MODIF_REG,@IFA_FECHA_CREAC_REG,@IFA_USUARIO_CREAC_REG,@IFA_FECHA_MODIF_REG,@IFA_USUARIO_MODIF_REG,@IFA_SITUACION)

INSERT SEDEPOSADAS.dbo.NOTAS_FINALES

SELECT @MEE_CODIGO_DESTINO, NOF_IFA_MEE_ANO,NOF_IFA_MEE_LLAMADO,@ALU_CODIGO_DESTINO,NOF_LIBRO,NOF_FOLIO,NOF_NOTA_ESCRITO,NOF_NOTA_ORAL,NOF_FECHA FROM NOTAS_FINALES
WHERE NOF_IFA_MEE_CODIGO = @IFA_MEE_CODIGO AND NOF_IFA_MEE_ANO = @IFA_MEE_ANO AND NOF_IFA_ALU_CODIGO = @IFA_ALU_CODIGO

END

IF @SEDE_A_INSERTAR = 5
BEGIN
--EN LA SEDE DESTINO OBTENGO EL TUM_CODIGO Y GUARDO EN VARIABLE
SELECT top 1 @TUM_CODIGO_DESTINO = TUM_CODIGO FROM SEDESPE�A.DBO.TURNO_MESA
--WHERE TUM_FECHA_DESDE = CONVERT(VARCHAR(12),@TUM_FECHA_DESDE,103) AND TUM_FECHA_HASTA = CONVERT(VARCHAR(12),@TUM_FECHA_HASTA,103)
WHERE
 TUM_FECHA_DESDE BETWEEN CONVERT(VARCHAR(12),@TUM_FECHA_DESDE,103) AND  CONVERT(VARCHAR(12),@TUM_FECHA_HASTA,103)
AND TUM_FECHA_HASTA BETWEEN CONVERT(VARCHAR(12),@TUM_FECHA_DESDE,103) AND  CONVERT(VARCHAR(12),@TUM_FECHA_HASTA,103)
AND TUM_TIPO = @TUM_TIPO

SELECT @MEE_CODIGO_DESTINO = MAX(MEE_CODIGO) + 1 FROM SEDECURUZU.dbo.MESA_EXAMEN

INSERT SEDECURUZU.dbo.MESA_EXAMEN
SELECT @MEE_CODIGO_DESTINO,MEE_ANO,MEE_DESCRIPCION,MEE_PLM_PES_CODIGO,MEE_PLM_PES_CAR_FAC_CODIGO,MEE_PLM_PES_CAR_CODIGO,MEE_PLM_MAT_CODIGO,@TUM_CODIGO_DESTINO,MEE_ORIENTACION
FROM MESA_EXAMEN WHERE MEE_CODIGO =@IFA_MEE_CODIGO AND MEE_ANO = @IFA_MEE_ANO

INSERT SEDECURUZU.dbo.MESA_LLAMADO
SELECT @MEE_CODIGO_DESTINO,MEL_MEE_ANO, MEL_LLAMADO,MEL_PRESIDENTE,MEL_VOCAL_1,MEL_VOCAL_2,MEL_AUL_CODIGO,MEL_SED_CODIGO,MEL_FECHA,MEL_HORA
,MEL_AV_LIBRES, MEL_AV_REGULARES,MEL_ALUMNOS,MEL_APROBADOS,MEL_AUSENTES,MEL_DESAPROBADOS,MEL_CARGA,MEL_FECHA_CARGA,MEL_HORA_CARGA,MEL_USUARIO_CARGA,MEL_INF_CORR,MEL_USU_CREAC,
MEL_FECHA_MODIF, MEL_USU_MODIF,MEL_OBSERVA_MODIF FROM MESA_LLAMADO WHERE MEL_MEE_CODIGO = @IFA_MEE_CODIGO AND MEL_MEE_ANO = @IFA_MEE_ANO


INSERT INTO SEDECURUZU.dbo.INS_FINAL_ALUMNOS
VALUES(@MEE_CODIGO_DESTINO, @IFA_MEE_ANO,@IFA_MEE_LLAMADO,@ALU_CODIGO_DESTINO,@IFA_FECHA_INSCRIPCION,@IFA_LIBRE,@IFA_OBSERV_MODIF_REG,@IFA_FECHA_CREAC_REG,@IFA_USUARIO_CREAC_REG,@IFA_FECHA_MODIF_REG,@IFA_USUARIO_MODIF_REG,@IFA_SITUACION)

INSERT SEDECURUZU.dbo.NOTAS_FINALES

SELECT @MEE_CODIGO_DESTINO, NOF_IFA_MEE_ANO,NOF_IFA_MEE_LLAMADO,@ALU_CODIGO_DESTINO,NOF_LIBRO,NOF_FOLIO,NOF_NOTA_ESCRITO,NOF_NOTA_ORAL,NOF_FECHA FROM NOTAS_FINALES
WHERE NOF_IFA_MEE_CODIGO = @IFA_MEE_CODIGO AND NOF_IFA_MEE_ANO = @IFA_MEE_ANO AND NOF_IFA_ALU_CODIGO = @IFA_ALU_CODIGO

END

IF @SEDE_A_INSERTAR = 6
BEGIN
--EN LA SEDE DESTINO OBTENGO EL TUM_CODIGO Y GUARDO EN VARIABLE
SELECT top 1 @TUM_CODIGO_DESTINO = TUM_CODIGO FROM SEDESPE�A.DBO.TURNO_MESA
--WHERE TUM_FECHA_DESDE = CONVERT(VARCHAR(12),@TUM_FECHA_DESDE,103) AND TUM_FECHA_HASTA = CONVERT(VARCHAR(12),@TUM_FECHA_HASTA,103)
WHERE
 TUM_FECHA_DESDE BETWEEN CONVERT(VARCHAR(12),@TUM_FECHA_DESDE,103) AND  CONVERT(VARCHAR(12),@TUM_FECHA_HASTA,103)
AND TUM_FECHA_HASTA BETWEEN CONVERT(VARCHAR(12),@TUM_FECHA_DESDE,103) AND  CONVERT(VARCHAR(12),@TUM_FECHA_HASTA,103)
AND TUM_TIPO = @TUM_TIPO

SELECT @MEE_CODIGO_DESTINO = MAX(MEE_CODIGO) + 1 FROM SEDEFORMOSA.dbo.MESA_EXAMEN

INSERT SEDEFORMOSA.dbo.MESA_EXAMEN
SELECT @MEE_CODIGO_DESTINO,MEE_ANO,MEE_DESCRIPCION,MEE_PLM_PES_CODIGO,MEE_PLM_PES_CAR_FAC_CODIGO,MEE_PLM_PES_CAR_CODIGO,MEE_PLM_MAT_CODIGO,@TUM_CODIGO_DESTINO,MEE_ORIENTACION
FROM MESA_EXAMEN WHERE MEE_CODIGO =@IFA_MEE_CODIGO AND MEE_ANO = @IFA_MEE_ANO

INSERT SEDEFORMOSA.dbo.MESA_LLAMADO
SELECT @MEE_CODIGO_DESTINO,MEL_MEE_ANO, MEL_LLAMADO,MEL_PRESIDENTE,MEL_VOCAL_1,MEL_VOCAL_2,MEL_AUL_CODIGO,MEL_SED_CODIGO,MEL_FECHA,MEL_HORA
,MEL_AV_LIBRES, MEL_AV_REGULARES,MEL_ALUMNOS,MEL_APROBADOS,MEL_AUSENTES,MEL_DESAPROBADOS,MEL_CARGA,MEL_FECHA_CARGA,MEL_HORA_CARGA,MEL_USUARIO_CARGA,MEL_INF_CORR,MEL_USU_CREAC,
MEL_FECHA_MODIF, MEL_USU_MODIF,MEL_OBSERVA_MODIF FROM MESA_LLAMADO WHERE MEL_MEE_CODIGO = @IFA_MEE_CODIGO AND MEL_MEE_ANO = @IFA_MEE_ANO


INSERT INTO SEDEFORMOSA.dbo.INS_FINAL_ALUMNOS
VALUES(@MEE_CODIGO_DESTINO, @IFA_MEE_ANO,@IFA_MEE_LLAMADO,@ALU_CODIGO_DESTINO,@IFA_FECHA_INSCRIPCION,@IFA_LIBRE,@IFA_OBSERV_MODIF_REG,@IFA_FECHA_CREAC_REG,@IFA_USUARIO_CREAC_REG,@IFA_FECHA_MODIF_REG,@IFA_USUARIO_MODIF_REG,@IFA_SITUACION)

INSERT SEDEFORMOSA.dbo.NOTAS_FINALES

SELECT @MEE_CODIGO_DESTINO, NOF_IFA_MEE_ANO,NOF_IFA_MEE_LLAMADO,@ALU_CODIGO_DESTINO,NOF_LIBRO,NOF_FOLIO,NOF_NOTA_ESCRITO,NOF_NOTA_ORAL,NOF_FECHA FROM NOTAS_FINALES
WHERE NOF_IFA_MEE_CODIGO = @IFA_MEE_CODIGO AND NOF_IFA_MEE_ANO = @IFA_MEE_ANO AND NOF_IFA_ALU_CODIGO = @IFA_ALU_CODIGO

END




IF @SEDE_A_INSERTAR = 11
BEGIN
--EN LA SEDE DESTINO OBTENGO EL TUM_CODIGO Y GUARDO EN VARIABLE
SELECT top 1 @TUM_CODIGO_DESTINO = TUM_CODIGO FROM SEDESPE�A.DBO.TURNO_MESA
--WHERE TUM_FECHA_DESDE = CONVERT(VARCHAR(12),@TUM_FECHA_DESDE,103) AND TUM_FECHA_HASTA = CONVERT(VARCHAR(12),@TUM_FECHA_HASTA,103)
WHERE
 TUM_FECHA_DESDE BETWEEN CONVERT(VARCHAR(12),@TUM_FECHA_DESDE,103) AND  CONVERT(VARCHAR(12),@TUM_FECHA_HASTA,103)
AND TUM_FECHA_HASTA BETWEEN CONVERT(VARCHAR(12),@TUM_FECHA_DESDE,103) AND  CONVERT(VARCHAR(12),@TUM_FECHA_HASTA,103)
AND TUM_TIPO = @TUM_TIPO



SELECT @MEE_CODIGO_DESTINO = MAX(MEE_CODIGO) + 1 FROM SEDESPE�A.dbo.MESA_EXAMEN

INSERT SEDESPE�A.dbo.MESA_EXAMEN
SELECT @MEE_CODIGO_DESTINO,MEE_ANO,MEE_DESCRIPCION,MEE_PLM_PES_CODIGO,MEE_PLM_PES_CAR_FAC_CODIGO,MEE_PLM_PES_CAR_CODIGO,MEE_PLM_MAT_CODIGO,@TUM_CODIGO_DESTINO,MEE_ORIENTACION
FROM MESA_EXAMEN WHERE MEE_CODIGO =@IFA_MEE_CODIGO AND MEE_ANO = @IFA_MEE_ANO

INSERT SEDESPE�A.dbo.MESA_LLAMADO
SELECT @MEE_CODIGO_DESTINO,MEL_MEE_ANO, MEL_LLAMADO,MEL_PRESIDENTE,MEL_VOCAL_1,MEL_VOCAL_2,MEL_AUL_CODIGO,MEL_SED_CODIGO,MEL_FECHA,MEL_HORA
,MEL_AV_LIBRES, MEL_AV_REGULARES,MEL_ALUMNOS,MEL_APROBADOS,MEL_AUSENTES,MEL_DESAPROBADOS,MEL_CARGA,MEL_FECHA_CARGA,MEL_HORA_CARGA,MEL_USUARIO_CARGA,MEL_INF_CORR,MEL_USU_CREAC,
MEL_FECHA_MODIF, MEL_USU_MODIF,MEL_OBSERVA_MODIF FROM MESA_LLAMADO WHERE MEL_MEE_CODIGO = @IFA_MEE_CODIGO AND MEL_MEE_ANO = @IFA_MEE_ANO





INSERT INTO SEDESPE�A.dbo.INS_FINAL_ALUMNOS
VALUES(@MEE_CODIGO_DESTINO, @IFA_MEE_ANO,@IFA_MEE_LLAMADO,@ALU_CODIGO_DESTINO,@IFA_FECHA_INSCRIPCION,@IFA_LIBRE,@IFA_OBSERV_MODIF_REG,@IFA_FECHA_CREAC_REG,@IFA_USUARIO_CREAC_REG,@IFA_FECHA_MODIF_REG,@IFA_USUARIO_MODIF_REG,@IFA_SITUACION)

INSERT SEDESPE�A.dbo.NOTAS_FINALES

SELECT @MEE_CODIGO_DESTINO, NOF_IFA_MEE_ANO,NOF_IFA_MEE_LLAMADO,@ALU_CODIGO_DESTINO,NOF_LIBRO,NOF_FOLIO,NOF_NOTA_ESCRITO,NOF_NOTA_ORAL,NOF_FECHA FROM NOTAS_FINALES
WHERE NOF_IFA_MEE_CODIGO = @IFA_MEE_CODIGO AND NOF_IFA_MEE_ANO = @IFA_MEE_ANO AND NOF_IFA_ALU_CODIGO = @IFA_ALU_CODIGO

END


FETCH CInsFinalAlumnos INTO @IFA_MEE_CODIGO, @IFA_MEE_ANO,@IFA_MEE_LLAMADO,@IFA_ALU_CODIGO,@IFA_FECHA_INSCRIPCION,@IFA_LIBRE,@IFA_OBSERV_MODIF_REG,@IFA_FECHA_CREAC_REG,@IFA_USUARIO_CREAC_REG,@IFA_FECHA_MODIF_REG,@IFA_USUARIO_MODIF_REG,@IFA_SITUACION

END
CLOSE CInsFinalAlumnos
DEALLOCATE CInsFinalAlumnos

COMMIT TRAN
END TRY
BEGIN CATCH
ROLLBACK TRAN
END CATCH






-----EQUIVALENCIAS 

--INSERTO EQA_ALU_CODIGO = @ALU_CODIGO_DESTINO,LOS DEM�S CAMPOS LO COPIO DE LA TABLA ORIGEN
SELECT TOP 1 * FROM EQUIVALENCIAS_ALUMNOS
--WHERE EQA_ALU_CODIGO = 14251

--INSERTO EQM_EQA_ALU_CODIGO = @ALU_CODIGO_DESTINO, LOS DEM�S CAMPOS LO COPIO DE LA TABLA ORIGEN
SELECT TOP 1 * FROM EQUIVALENCIAS_MATERIAS

SELECT * FROM EQUIVALENCIAS_ALUMNOS EA
WHERE EQA_TIPO = 'E'

SELECT * FROM EQUIVALENCIAS_MATERIAS
WHERE EQM_EQA_ALU_CODIGO = 5


INNER JOIN EQUIVALENCIAS_MATERIAS EM
ON EA.EQA_PLM_PES_CODIGO = EM.EQM_EQA_PLM_PES_CODIGO
AND EA.EQA_PLM_PES_CAR_FAC_CODIGO = EM.EQM_EQA_PLM_PES_CAR_FAC_CODIGO
AND EA.EQA_PLM_PES_CAR_CODIGO = EM.EQM_PLM_PES_CAR_CODIGO
AND EA.EQA_ALU_CODIGO = EM.EQM_EQA_ALU_CODIGO
AND EA.EQA_PLM_MAT_CODIGO = EM.EQM_EQA_PLM_MAT_CODIGO
ORDER BY EQA_ALU_CODIGO


SELECT * FROM ALUMNO_ATRIBUTO
WHERE ALA_ANA_ALU_CODIGO = 14251

SELECT * FROM ANTECEDENTE_ALUMNO
WHERE ANA_ALU_CODIGO = 14251






