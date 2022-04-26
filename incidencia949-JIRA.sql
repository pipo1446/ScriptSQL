

--Datos de contacto: Apellido y Nombre: Luciana Abdala | Email: dec.psicologia@ucp.edu.ar | Teléfono: 3794700594 Descripción del problema:Solicito si por favor nos pueden enviar un listado, a todas las facultades, con la siguiente información:

--Sede

--Carrera

--Año (solo alumnos de 1° y 2° año)

--Apellido, Nombre, Teléfono de contacto

--Materias que cursa

--% de inasistencias (solo los que superaron el 20% de inasistencias a la fecha)

--IMPORTANTE: Solo tener en cuenta a los alumnos que desaprobaron al menos 2 instancias de evaluación. Considerar ausentes como desaprobados.

--Muchas gracias.
SELECT  AET.EXT_DESCRIPCION, AET.CARRERA, AET.ALU_APELLIDO_AL, AET.ALU_NOMBRE_AL,  AC.COM_DESCRIPCION, 
dbo.INASISTENCIAS_EXCEDIDAS(AC.COM_CODIGO, AC.COA_ANO, AC.COA_CUATRIMESTRE, AC.ALU_CODIGO, AC.MAT_CODIGO, AC.PES_CODIGO,
AC.CAR_CODIGO,AC.FAC_CODIGO) AS PORCENTAJE

 FROM VW_ALUMNOS_COMISIONES AC
INNER JOIN VW_ALUMNOS_EXTENSION_AULICA_TOTAL AET
ON AC.ALU_CODIGO = AET.ALU_CODIGO AND AC.ALU_NRO_DOC_AL = AET.ALU_NRO_DOC_AL
WHERE AC.COA_ANO = 2021
AND AC.COA_CUATRIMESTRE IN (1,3)
AND AET.ALU_SIR_CODIGO IN(1,5) --ACTIVO, REINCORPORADO A CURSAR
AND YEAR(dbo.Fecha_ingreso_Real(AET.ALU_CODIGO)) > = 2020
and dbo.INASISTENCIAS_EXCEDIDAS(AC.COM_CODIGO, AC.COA_ANO, AC.COA_CUATRIMESTRE, AC.ALU_CODIGO, AC.MAT_CODIGO, AC.PES_CODIGO,
AC.CAR_CODIGO,AC.FAC_CODIGO) > 20
AND dbo.CANTIDAD_EVALUACIONES_APROBADAS_ALUMNOS_POR_COMISION (AC.ALU_CODIGO,AC.COM_CODIGO,AC.COA_ANO,AC.COA_CUATRIMESTRE) >=2
ORDER BY AET.EXT_DESCRIPCION, AET.CARRERA


 

  
