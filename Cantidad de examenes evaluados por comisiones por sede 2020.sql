--CANTIDAD DE EXAMENES TOMADOS (PARCIALES)
SELECT D.DOM_DESCRIPCION, COUNT(*) TOTAL, S.SED_DESCRIPCION FROM NOTAS_ALMNOS NA
INNER JOIN DOMINIOS D
ON NA.NOA_TIPO_NOTA = D.DOM_CODIGO AND D.DOM_DOMINIO = 21
INNER JOIN VW_ALUMNOS_COMISIONES AC
ON NA.NOA_ALC_COA_COM_CODIGO = AC.COM_CODIGO AND NA.NOA_ALC_COA_ANO = AC.COA_ANO 
AND NA.NOA_ALC_COA_CUATRIMESTRE = AC.COA_CUATRIMESTRE AND NA.NOA_ALC_ALU_CODIGO = AC.ALU_CODIGO AND AC.COM_TIPO_COMISION = 1
INNER JOIN SEDES S
ON AC.COM_SED_CODIGO = S.SED_CODIGO
WHERE NA.NOA_ALC_COA_ANO = 2020 AND AC.COA_ANO = 2020
--AND NOA_ALC_COA_CUATRIMESTRE IN(1,2,3)
AND AC.COM_TIPO_COMISION = 1 --SOLO COMISIONES CUATRIMESTRALES Y ANUALES
AND AC.COM_SED_CODIGO = 10 --

GROUP BY D.DOM_DESCRIPCION,S.SED_DESCRIPCION
--ORDER BY D.DOM_DESCRIPCION

UNION
--CANTIDAD DE EXAMENES TOMADOS (PARCIALES)
SELECT D.DOM_DESCRIPCION, COUNT(*) TOTAL, S.SED_DESCRIPCION FROM NOTAS_ALMNOS NA
INNER JOIN DOMINIOS D
ON NA.NOA_TIPO_NOTA = D.DOM_CODIGO AND D.DOM_DOMINIO = 21
INNER JOIN VW_ALUMNOS_COMISIONES AC
ON NA.NOA_ALC_COA_COM_CODIGO = AC.COM_CODIGO AND NA.NOA_ALC_COA_ANO = AC.COA_ANO 
AND NA.NOA_ALC_COA_CUATRIMESTRE = AC.COA_CUATRIMESTRE AND NA.NOA_ALC_ALU_CODIGO = AC.ALU_CODIGO AND AC.COM_TIPO_COMISION = 1
INNER JOIN SEDES S
ON AC.COM_SED_CODIGO = S.SED_CODIGO
WHERE NA.NOA_ALC_COA_ANO = 2020 AND AC.COA_ANO = 2020
--AND NOA_ALC_COA_CUATRIMESTRE IN(1,2,3)
AND AC.COM_TIPO_COMISION = 1 --SOLO COMISIONES CUATRIMESTRALES Y ANUALES
AND AC.COM_SED_CODIGO = 1 --

GROUP BY D.DOM_DESCRIPCION,S.SED_DESCRIPCION

UNION
--CANTIDAD DE EXAMENES TOMADOS (PARCIALES)
SELECT D.DOM_DESCRIPCION, COUNT(*) TOTAL, S.SED_DESCRIPCION FROM SEDEGOYA.DBO.NOTAS_ALMNOS NA
INNER JOIN SEDEGOYA.DBO.DOMINIOS D
ON NA.NOA_TIPO_NOTA = D.DOM_CODIGO AND D.DOM_DOMINIO = 21
INNER JOIN SEDEGOYA.DBO.VW_ALUMNOS_COMISIONES AC
ON NA.NOA_ALC_COA_COM_CODIGO = AC.COM_CODIGO AND NA.NOA_ALC_COA_ANO = AC.COA_ANO 
AND NA.NOA_ALC_COA_CUATRIMESTRE = AC.COA_CUATRIMESTRE AND NA.NOA_ALC_ALU_CODIGO = AC.ALU_CODIGO AND AC.COM_TIPO_COMISION = 1
INNER JOIN SEDEGOYA.DBO.SEDES S
ON AC.COM_SED_CODIGO = S.SED_CODIGO
WHERE NA.NOA_ALC_COA_ANO = 2020 AND AC.COA_ANO = 2020
--AND NOA_ALC_COA_CUATRIMESTRE IN(1,2,3)
AND AC.COM_TIPO_COMISION = 1 --SOLO COMISIONES CUATRIMESTRALES Y ANUALES
AND AC.COM_SED_CODIGO = 2 --

GROUP BY D.DOM_DESCRIPCION,S.SED_DESCRIPCION
--ORDER BY D.DOM_DESCRIPCION

UNION
--CANTIDAD DE EXAMENES TOMADOS (PARCIALES)
SELECT D.DOM_DESCRIPCION, COUNT(*) TOTAL, S.SED_DESCRIPCION FROM SEDEPLIBRES.DBO.NOTAS_ALMNOS NA
INNER JOIN SEDEPLIBRES.DBO.DOMINIOS D
ON NA.NOA_TIPO_NOTA = D.DOM_CODIGO AND D.DOM_DOMINIO = 21
INNER JOIN SEDEPLIBRES.DBO.VW_ALUMNOS_COMISIONES AC
ON NA.NOA_ALC_COA_COM_CODIGO = AC.COM_CODIGO AND NA.NOA_ALC_COA_ANO = AC.COA_ANO 
AND NA.NOA_ALC_COA_CUATRIMESTRE = AC.COA_CUATRIMESTRE AND NA.NOA_ALC_ALU_CODIGO = AC.ALU_CODIGO AND AC.COM_TIPO_COMISION = 1
INNER JOIN SEDEPLIBRES.DBO.SEDES S
ON AC.COM_SED_CODIGO = S.SED_CODIGO
WHERE NA.NOA_ALC_COA_ANO = 2020 AND AC.COA_ANO = 2020
--AND NOA_ALC_COA_CUATRIMESTRE IN(1,2,3)
AND AC.COM_TIPO_COMISION = 1 --SOLO COMISIONES CUATRIMESTRALES Y ANUALES
AND AC.COM_SED_CODIGO = 3 --

GROUP BY D.DOM_DESCRIPCION,S.SED_DESCRIPCION
--ORDER BY D.DOM_DESCRIPCION

UNION
--CANTIDAD DE EXAMENES TOMADOS (PARCIALES)
SELECT D.DOM_DESCRIPCION, COUNT(*) TOTAL, S.SED_DESCRIPCION FROM SEDEPOSADAS.DBO.NOTAS_ALMNOS NA
INNER JOIN SEDEPOSADAS.DBO.DOMINIOS D
ON NA.NOA_TIPO_NOTA = D.DOM_CODIGO AND D.DOM_DOMINIO = 21
INNER JOIN SEDEPOSADAS.DBO.VW_ALUMNOS_COMISIONES AC
ON NA.NOA_ALC_COA_COM_CODIGO = AC.COM_CODIGO AND NA.NOA_ALC_COA_ANO = AC.COA_ANO 
AND NA.NOA_ALC_COA_CUATRIMESTRE = AC.COA_CUATRIMESTRE AND NA.NOA_ALC_ALU_CODIGO = AC.ALU_CODIGO AND AC.COM_TIPO_COMISION = 1
INNER JOIN SEDEPOSADAS.DBO.SEDES S
ON AC.COM_SED_CODIGO = S.SED_CODIGO
WHERE NA.NOA_ALC_COA_ANO = 2020 AND AC.COA_ANO = 2020
--AND NOA_ALC_COA_CUATRIMESTRE IN(1,2,3)
AND AC.COM_TIPO_COMISION = 1 --SOLO COMISIONES CUATRIMESTRALES Y ANUALES
AND AC.COM_SED_CODIGO = 4 -- COMISION SEDE

GROUP BY D.DOM_DESCRIPCION,S.SED_DESCRIPCION
--ORDER BY D.DOM_DESCRIPCION

UNION
--CANTIDAD DE EXAMENES TOMADOS (PARCIALES)
SELECT D.DOM_DESCRIPCION, COUNT(*) TOTAL, S.SED_DESCRIPCION FROM SEDECURUZU.DBO.NOTAS_ALMNOS NA
INNER JOIN SEDECURUZU.DBO.DOMINIOS D
ON NA.NOA_TIPO_NOTA = D.DOM_CODIGO AND D.DOM_DOMINIO = 21
INNER JOIN SEDECURUZU.DBO.VW_ALUMNOS_COMISIONES AC
ON NA.NOA_ALC_COA_COM_CODIGO = AC.COM_CODIGO AND NA.NOA_ALC_COA_ANO = AC.COA_ANO 
AND NA.NOA_ALC_COA_CUATRIMESTRE = AC.COA_CUATRIMESTRE AND NA.NOA_ALC_ALU_CODIGO = AC.ALU_CODIGO AND AC.COM_TIPO_COMISION = 1
INNER JOIN SEDECURUZU.DBO.SEDES S
ON AC.COM_SED_CODIGO = S.SED_CODIGO
WHERE NA.NOA_ALC_COA_ANO = 2020 AND AC.COA_ANO = 2020
--AND NOA_ALC_COA_CUATRIMESTRE IN(1,2,3)
AND AC.COM_TIPO_COMISION = 1 --SOLO COMISIONES CUATRIMESTRALES Y ANUALES
AND AC.COM_SED_CODIGO = 5 --

GROUP BY D.DOM_DESCRIPCION,S.SED_DESCRIPCION
--ORDER BY D.DOM_DESCRIPCION

UNION
--CANTIDAD DE EXAMENES TOMADOS (PARCIALES)
SELECT D.DOM_DESCRIPCION, COUNT(*) TOTAL, S.SED_DESCRIPCION FROM SEDEFORMOSA.DBO.NOTAS_ALMNOS NA
INNER JOIN SEDEFORMOSA.DBO.DOMINIOS D
ON NA.NOA_TIPO_NOTA = D.DOM_CODIGO AND D.DOM_DOMINIO = 21
INNER JOIN SEDEFORMOSA.DBO.VW_ALUMNOS_COMISIONES AC
ON NA.NOA_ALC_COA_COM_CODIGO = AC.COM_CODIGO AND NA.NOA_ALC_COA_ANO = AC.COA_ANO 
AND NA.NOA_ALC_COA_CUATRIMESTRE = AC.COA_CUATRIMESTRE AND NA.NOA_ALC_ALU_CODIGO = AC.ALU_CODIGO AND AC.COM_TIPO_COMISION = 1
INNER JOIN SEDEFORMOSA.DBO.SEDES S
ON AC.COM_SED_CODIGO = S.SED_CODIGO
WHERE NA.NOA_ALC_COA_ANO = 2020 AND AC.COA_ANO = 2020
--AND NOA_ALC_COA_CUATRIMESTRE IN(1,2,3)
AND AC.COM_TIPO_COMISION = 1 --SOLO COMISIONES CUATRIMESTRALES Y ANUALES
AND AC.COM_SED_CODIGO = 6 --

GROUP BY D.DOM_DESCRIPCION,S.SED_DESCRIPCION
--ORDER BY D.DOM_DESCRIPCION

UNION
--CANTIDAD DE EXAMENES TOMADOS (PARCIALES)
SELECT D.DOM_DESCRIPCION, COUNT(*) TOTAL, S.SED_DESCRIPCION FROM SEDESPE�A.DBO.NOTAS_ALMNOS NA
INNER JOIN SEDESPE�A.DBO.DOMINIOS D
ON NA.NOA_TIPO_NOTA = D.DOM_CODIGO AND D.DOM_DOMINIO = 21
INNER JOIN SEDESPE�A.DBO.VW_ALUMNOS_COMISIONES AC
ON NA.NOA_ALC_COA_COM_CODIGO = AC.COM_CODIGO AND NA.NOA_ALC_COA_ANO = AC.COA_ANO 
AND NA.NOA_ALC_COA_CUATRIMESTRE = AC.COA_CUATRIMESTRE AND NA.NOA_ALC_ALU_CODIGO = AC.ALU_CODIGO AND AC.COM_TIPO_COMISION = 1
INNER JOIN SEDESPE�A.DBO.SEDES S
ON AC.COM_SED_CODIGO = S.SED_CODIGO
WHERE NA.NOA_ALC_COA_ANO = 2020 AND AC.COA_ANO = 2020
--AND NOA_ALC_COA_CUATRIMESTRE IN(1,2,3)
AND AC.COM_TIPO_COMISION = 1 --SOLO COMISIONES CUATRIMESTRALES Y ANUALES
AND AC.COM_SED_CODIGO = 11 --

GROUP BY D.DOM_DESCRIPCION,S.SED_DESCRIPCION
ORDER BY D.DOM_DESCRIPCION, S.SED_DESCRIPCION







