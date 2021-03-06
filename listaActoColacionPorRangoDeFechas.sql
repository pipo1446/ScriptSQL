--LISTA DE GRADUADOS PARA UN ACTO DE COLACI?N COMPRENDIDO ENTRE FECHAS

--*SEDE REGIONAL PASO DE LOS LIBRES
--desde el 01/09/2019 al 31/08/2020

--SEDE REGIONAL GOYA
--desde el 01/09/2019 al 31/08/2020

--SEDE REGIONAL POSADAS
--desde el 26/06/2019 al 13/06/2020

--SEDE REGIONAL FORMOSA
--desde el 01/09/2019 al 31/08/2020

--CENTRAL
--desde el 01/09/2019 al 31/08/2020

--SEDE REGIONAL RESISTENCIA
--desde el 01/09/2019 al 31/08/2020


--falt? CURUZU EN EL CORREO, PERO MERCEDES DE TITULO ME LO RECORD?
--desde 01/02/2019 al 23/12/2019

DECLARE @FECHA_DESDE VARCHAR(12), @FECHA_HASTA VARCHAR(12), @SEDE INT



--ASIGNAMOS LA FECHA PASADA POR EL CORREO PARA CADA SEDE

SET @FECHA_DESDE = '01/02/2019' 
SET @FECHA_HASTA = '23/12/2019' 
SET @SEDE = 5 --cambiar el codigo de la sede

SELECT A.ALU_APELLIDO_AL +' '+A.ALU_NOMBRE_AL ALUMNO, C.CARRERA FROM ALUMNOS A
INNER JOIN
 VW_ALUMNOS_EXTENSION_AULICA_TOTAL  AEAT ON A.ALU_CODIGO = AEAT.ALU_CODIGO
 INNER JOIN  
     SEDES AS S ON AEAT.SED_CODIGO = S.SED_CODIGO 

INNER JOIN PLAN_ESTUDIO PE
ON A.ALU_PES_CAR_FAC_CODIGO = PE.PES_CAR_FAC_CODIGO
AND A.ALU_PES_CAR_CODIGO = PE.PES_CAR_CODIGO
AND A.ALU_PES_CODIGO = PE.PES_CODIGO
INNER JOIN CARRERAS C
ON PE.PES_CAR_FAC_CODIGO = C.FAC_COD
AND PE.PES_CAR_REAL = C.CAR_COD



WHERE A.ALU_FECHA_BAJA_AL >= @FECHA_DESDE AND A.ALU_FECHA_BAJA_AL <= @FECHA_HASTA
AND A.ALU_SIR_CODIGO = 8 -- ALUMNOS GRADUADOS
AND AEAT.SED_CODIGO = @SEDE
AND (select count(*) from SEDECENTRAL.dbo.grad_titulos GT where GT.alu_cod = A.ALU_CODIGO and GT.sed_codigo = A.ALU_SED_CODIGO ) = 0  
ORDER BY C.CARRERA, A.ALU_APELLIDO_AL, A.ALU_NOMBRE_AL

