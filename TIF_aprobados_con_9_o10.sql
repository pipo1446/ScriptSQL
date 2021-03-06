
SELECT M.MAT_DESCRIPCION, A.ALUMNO, A.EXT_DESCRIPCION, A.PLAN_ESTUDIO, YEAR(NF.NOF_FECHA) A?O_APROBACION, NF.NOF_NOTA_ORAL FROM NOTAS_FINALES NF
INNER JOIN MESA_EXAMEN ME
ON NF.NOF_IFA_MEE_CODIGO = ME.MEE_CODIGO AND NF.NOF_IFA_MEE_ANO = ME.MEE_ANO
INNER JOIN PLAN_MATERIAS PM
ON ME.MEE_PLM_MAT_CODIGO = PM.PLM_MAT_CODIGO AND ME.MEE_PLM_PES_CODIGO = PM.PLM_PES_CODIGO 
AND ME.MEE_PLM_PES_CAR_FAC_CODIGO = PM.PLM_PES_CAR_FAC_CODIGO AND ME.MEE_PLM_PES_CAR_CODIGO = PM.PLM_PES_CAR_CODIGO
AND ME.MEE_PLM_MAT_CODIGO = PM.PLM_MAT_CODIGO
INNER JOIN VW_ALUMNOS_EXTENSION_AULICA_TOTAL A
ON NF.NOF_IFA_ALU_CODIGO = A.ALU_CODIGO
INNER JOIN MATERIA M
ON PM.PLM_MAT_CODIGO = M.MAT_CODIGO
WHERE PM.PLM_REM_CODIGO_REGIMEN = 5 --DEFENSA TIP EL REGIMEN
AND NF.NOF_NOTA_ORAL > 8
AND YEAR(NF.NOF_FECHA) BETWEEN 2020 AND 2021 --ENTRE LOS A?OS
AND A.SED_CODIGO = 11 --RESISTENCIA
AND A.ALU_SIR_CODIGO = 8 --GRADUADO
ORDER BY YEAR(NF.NOF_FECHA),EXT_DESCRIPCION,PLAN_ESTUDIO, ALUMNO







--ALUMNOS QUE CURSARON LA PPS EN AREA CLINICA ANTES DEL 2018 Y SE GRADUABAN CON DICHA MATERIA(NO ES UNA MATERIA DEL REGIMEN DEFENSA TIF)
-- CON NOTA SUPERIOR A 8 Y QUE TBN HAYAN APROBADO EL TALLER DE ELABORACI?N DEL TRABAJO INTEGRADOR FINAL CON NOTA SUPERIOR A 8

SELECT A.ALU_APELLIDO_AL, A.ALU_NOMBRE_AL, A.PLAN_ESTUDIO, A.EXT_DESCRIPCION, M.MAT_DESCRIPCION, NF.NOF_NOTA_ORAL,YEAR(A.ALU_FECHA_BAJA_AL) FROM MESA_EXAMEN ME
INNER JOIN NOTAS_FINALES NF
ON ME.MEE_CODIGO = NF.NOF_IFA_MEE_CODIGO AND ME.MEE_ANO = NF.NOF_IFA_MEE_ANO
INNER JOIN VW_ALUMNOS_EXTENSION_AULICA_TOTAL A
ON NF.NOF_IFA_ALU_CODIGO = A.ALU_CODIGO AND NF.NOF_FECHA = A.ALU_FECHA_BAJA_AL
INNER JOIN MATERIA M
ON ME.MEE_PLM_MAT_CODIGO = M.MAT_CODIGO

---CONSIDERO LOS QUE APROBARON EL TALLER DE ELABORACI?N DEL TRABAJO FINAL (762) CON NOTA_ORAL > 8
INNER JOIN NOTAS_FINALES NF1
ON A.ALU_CODIGO = NF1.NOF_IFA_ALU_CODIGO
INNER JOIN MESA_EXAMEN ME1
ON NF1.NOF_IFA_MEE_CODIGO = ME1.MEE_CODIGO AND NF1.NOF_IFA_MEE_ANO = ME1.MEE_ANO 
AND ME1.MEE_PLM_MAT_CODIGO = 762 AND ME1.MEE_PLM_PES_CODIGO = 66 AND ME1.MEE_PLM_PES_CAR_CODIGO = 33
AND ME1.MEE_PLM_PES_CAR_FAC_CODIGO = 2 AND NF1.NOF_NOTA_ORAL > 8
---FIN CONSIDERACI?N

WHERE ME.MEE_PLM_MAT_CODIGO = 555 --PPS EN AREA CLINICA
AND ME.MEE_PLM_PES_CODIGO = 66
AND ME.MEE_PLM_PES_CAR_CODIGO = 33
AND ME.MEE_PLM_PES_CAR_FAC_CODIGO = 2
--MEE_CODIGO, MEE_ANO
AND NF.NOF_NOTA_ORAL > 8 --NOTA SUPERIOR A 8
AND A.ALU_SIR_CODIGO = 8 --GRADUADO
AND YEAR(A.ALU_FECHA_BAJA_AL) BETWEEN 2017 AND 2020 --QUE HAYAN APROBADO ENTRE EL 2017 AL 2020 INCLUSIVE
ORDER BY YEAR(A.ALU_FECHA_BAJA_AL), A.ALU_APELLIDO_AL, A.ALU_NOMBRE_AL




-- POSGRADO ESPECIALIZACIONES--

SELECT APELLIDO, NOMBRE, S.DESCRIPCION,PM.CARRERA, PM.MAT_DESCRIPCION, NF.NOTA FROM ALUMNOS A --FACULTAD, CARRERA, PLAN_ESTUDIO
INNER JOIN SEDES S ON A.SEDE = S.SED_CODIGO
INNER JOIN VW_PLAN_MATERIAS PM ON A.FACULTAD = PM.FAC_CODIGO  AND A.CARRERA = PM.CAR_CODIGO AND A.PLAN_ESTUDIO = PM.PES_CODIGO AND PM.TIPO = 3 --MAT_CODIGO, MAT_DESCRIPCION
cross apply DBO.NOTAS_FINALES_FX(A.ALU_CODIGO) NF
WHERE A.SIT_REVISTA = 8 AND NF.MAT_CODIGO = PM.MAT_CODIGO
AND PM.TIPO = 3 --TRABAJO INTEGRADOR FINAL
AND NF.NOTA BETWEEN 9 AND 10
AND PM.CARRERA LIKE '%ESPECIALIZA%'
ORDER BY S.DESCRIPCION, A.APELLIDO, A.NOMBRE


