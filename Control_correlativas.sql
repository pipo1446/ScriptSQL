select m.mat_codigo, m.mat_descripcion, m2.mat_descripcion, pm.plm_ano, pm.plm_cuatrimestre from plan_materias pm
inner join materia m
on pm.plm_mat_codigo = m.mat_codigo
inner join plan_materia_correlatividades pmc
on pm.plm_pes_codigo = pmc.pmc_plm_pes_codigo and pm.plm_pes_car_fac_codigo = pmc.pmc_plm_pes_car_fac_codigo 
and pm.plm_pes_car_codigo = pmc.pmc_plm_pes_car_codigo and plm_mat_codigo = pmc_plm_mat_codigo
inner join materia m2
on pmc.pmc_plm_mat_codigo_corr = m2.mat_codigo
where plm_pes_codigo = 81 
and m.mat_codigo = 708
order by  m2.mat_descripcion
 


select m.mat_codigo, m.mat_descripcion from plan_materias pm
inner join materia m
on pm.plm_mat_codigo = m.mat_codigo
where plm_pes_codigo = 81
AND PM.PLM_ANO = 5 
AND PM.PLM_CUATRIMESTRE = 1
order by plm_ano, plm_cuatrimestre









SELECT AC.PES_CODIGO_A, PE.PES_DESCRIPCION, M.MAT_DESCRIPCION, AC.PES_CODIGO_T, PE1.PES_DESCRIPCION, M1.MAT_DESCRIPCION FROM ARTICULACION_CARRERAS AC
INNER JOIN PLAN_ESTUDIO PE
ON AC.FAC_CODIGO_A = PE.PES_CAR_FAC_CODIGO AND AC.CAR_CODIGO_A = PE.PES_CAR_CODIGO AND AC.PES_CODIGO_A = PE.PES_CODIGO
INNER JOIN MATERIA M
ON AC.MAT_CODIGO_A = M.MAT_CODIGO
INNER JOIN MATERIA M1
ON AC.MAT_CODIGO_T = M1.MAT_CODIGO
INNER JOIN PLAN_ESTUDIO PE1
ON AC.FAC_CODIGO_T = PE1.PES_CAR_FAC_CODIGO AND AC.CAR_CODIGO_T = PE1.PES_CAR_CODIGO AND AC.PES_CODIGO_T= PE1.PES_CODIGO

WHERE   PE.PES_DESCRIPCION LIKE '%PSICOLOG%'
AND PES_CODIGO_T = 24

AND MAT_CODIGO_T IN (1163) 
ORDER BY PES_CODIGO_A DESC

SELECT plm_mat_codigo, pes_descripcion, mat_descripcion FROM VW_PLAN_MATERIAS
--WHERE PES_DESCRIPCION LIKE '%PSICOPEDAGO%'
WHERE PLM_PES_CODIGO IN(24)
AND MAT_DESCRIPCION LIKE '%evolutiva%'


---no hay transición 
--Psicología Evolutiva Adolescencia Licenciatura en Psicopedagogía (Res. Nº 1239/06)