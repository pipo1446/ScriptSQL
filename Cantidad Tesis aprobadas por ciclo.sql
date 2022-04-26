


--obtiene las tesis de administraci�n y comercio internacional por ciclos
--los ciclos se comprenden desde el 01/03/2017 al 28/02/2018 este ciclo ser�a del 2017, y as� por cada uno

SELECT C.CARRERA, NF.NOF_NOTA_ORAL,COUNT(*), 'Formosa', '2018' AS CICLO FROM ALUMNOS A
INNER JOIN VW_NOTAS_FINALES NF
ON A.ALU_CODIGO = NF.NOF_IFA_ALU_CODIGO AND NF.MEE_PLM_MAT_CODIGO = 240 -- ESA MATERIA SER�A TIF PARA COMERCIO INTERNACIONAL, Y PARA ADMINISTRACI�N
INNER JOIN PLAN_ESTUDIO PE
  ON A.ALU_PES_CODIGO = PE.PES_CODIGO AND A.ALU_PES_CAR_CODIGO = PE.PES_CAR_CODIGO AND A.ALU_PES_CAR_FAC_CODIGO = PE.PES_CAR_FAC_CODIGO
INNER JOIN CARRERAS C -- REALIZO UN INNER JOIN CON CARRERAS PARA QUE SOLO MUESTRE EL NOMBRE DE LA CARRERA RAIZ Y NO LA DIFERENCIA POR RESOLUCI�N
ON PE.PES_CAR_REAL = C.CAR_COD AND PE.PES_CAR_FAC_CODIGO = C.FAC_COD
--LEFT JOIN ALUMNOS_EXTENSION_AULICA AEA --ESTO COMENT� PARA SABER SI HAB�A EGRESADO DE RESISTENCIA EN ESTAS CARRERAS
--ON A.ALU_CODIGO = AEA.ALU_CODIGO
WHERE A.ALU_SIR_CODIGO = 8 AND A.ALU_PES_CODIGO IN(3,15,33,44, 4,14,36,43,58)
AND A.ALU_FECHA_BAJA_AL BETWEEN  '01/03/2018' AND '28/02/2019' --PERIODO EN EL QUE SE GRADUARON, PREFIJE ESOS VALORES POR SER SU �LTIMO FINAL
AND NF.NOF_NOTA_ORAL > = 8 --AND AEA.FECHA_HASTA IS NULL
GROUP BY NF.NOF_NOTA_ORAL, C.CARRERA
--, AEA.EXT_CODIGO
ORDER BY C.CARRERA, NF.NOF_NOTA_ORAL




