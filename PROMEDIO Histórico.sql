---PROMEDIO POR GRADUADO - PERIODO ULTIMOS 5 AÑOS - SOLICITÓ COLUSSI NARELLA
--- EXPORTAR EL RESLTADO A EXCEL, SACAR PROMEDIO HISTÓRICO SUMANDO LA COLUMNA Promedio/ cantidad de registrs resultado

----- OJOOOO!!!! VER A QUE SEDE APUNTA LA FUNCIÓN en el SELECT!!
--- Las FECHAS SON DESDE EL ÚLTIMO FIN DEL CICLO, 5 AÑOS HACIA ATRÁS, por ejemplo hoy 20/03/19,
-- fin del ciclo 2018 es 02/03/19 (fin turno febrero 2019), fecha 5 años atrás inicio del ciclo Marzo 2014

-- OR

--- Las FECHAS SON DESDE EL ÚLTIMO FIN DEL CICLO, 5 AÑOS HACIA ATRÁS, por ejemplo hoy 08/10/2020,
-- fin del ciclo 2019 es 29/02/2020 (fin turno febrero 2020), fecha 5 años atrás inicio del ciclo Marzo 2015

-- OR

--- Las FECHAS SON DESDE EL ÚLTIMO FIN DEL CICLO, 5 AÑOS HACIA ATRÁS, por ejemplo hoy 29/06/2021,
-- fin del ciclo 2020 es 09/03/2021 (fin turno febrero 2021), fecha 5 años atrás inicio del ciclo Marzo 2016---
--- mas abajo PROM DE LA PROMOCIÓN

SELECT A.SED_DESCRIPCION,A.fac_descripcion,A.car_descripcion,A.pes_descripcion,
ape_nom as Apellido_Nombre, ---CAMBIAR SEDE
SEDEGOYA.DBO.PROMEDIO_CON_APLAZOS_CONVERTIDO(ALU_CODIGO,A.CAR_FAC_CODIGO,A.CAR_CODIGO,A.ALU_PES_CODIGO) as Promedio, ---CAMBIAR SEDE
A.ALU_FECHA_EGRESO_AL,
A.sir_descripcion 

FROM vw_ALUMNOS A
---inicio del ciclo ----fin del turno
WHERE A.ALU_SIR_CODIGO IN (8) AND A.car_FAC_CODIGO = 3 and A.pes_descripcion LIKE '%NUTRIC%%' 
--- (A.ALU_FECHA_EGRESO_AL >='05/03/2014' FECHA DE INGRESO  AND A.ALU_FECHA_EGRESO_AL <= '28/02/2019' FECHA FIN TURNO CICLO 2018
--AND (A.ALU_FECHA_EGRESO_AL >='02/03/2015' AND A.ALU_FECHA_EGRESO_AL <= '29/02/2020' )and A.SED_DESCRIPCION like '%FORMOSA%'
--AND (A.ALU_FECHA_EGRESO_AL >='01/03/2013' AND A.ALU_FECHA_EGRESO_AL <= '28/02/2018' )and A.SED_DESCRIPCION like '%posada%'
AND (A.ALU_FECHA_EGRESO_AL >='07/03/2016' AND A.ALU_FECHA_EGRESO_AL <= '09/03/2021' )--FECHA FIN  CICLO 2020
and A.SED_DESCRIPCION like '%GOY%' --- CAMBIAR SEDE
--AND DBO.PROMEDIO_CON_APLAZOS_CONVERTIDO(ALU_CODIGO,A.car_FAC_CODIGO,A.CAR_CODIGO,A.ALU_PES_CODIGO) >=8

order by promedio desc, ape_nom



SELECT (9.24
+9.16
+9.08
+9.03
+8.87
+8.84
+8.83
+8.79
+8.68
+8.67
+8.44
+8.39
+8.38
+8.35
+8.28
+8.23
+8.18
+7.88
+7.88
+7.85
+7.83
+7.82
+7.81
+7.76
+7.75
+7.74
+7.73
+7.62
+7.61
+7.46
+7.38
+7.38
+7.37
+7.36
+7.35
+7.30
+7.30
+7.23
+7.19
+7.00
+6.96
+6.91
+6.88
+6.83
+6.82
+6.80
+6.77
+6.71
+6.69
+6.62
+6.50
+6.33
+6.17
+6.13
+6.05
+5.65) /56