--recursan una materia
--criminalistica
--tengo que cambiar las sedes POSADAS, FORMOSA, GOYA, LIBRES, RESISTENCIA

SELECT apellido, mat_descripcion, sed_Descripcion FROM VW_ALUMNOS_COMISIONES
WHERE PES_CODIGO = 42 AND FAC_CODIGO = 1 AND CAR_CODIGO = 12
AND ALC_REGULARIZADA = 0 AND ALC_APROBADA = 0
AND ALC_LIBRE = 1 AND ALC_LIBRE_PARCIAL = 1
AND COM_SED_CODIGO = 1
and alu_sir_codigo in(1,4,5,6,7)

UNION 



SELECT   apellido, mat_descripcion, sed_Descripcion FROM VW_ALUMNOS_COMISIONES ac
inner join plan_materias pm
  on ac.pes_codigo = pm.plm_pes_codigo and ac.fac_codigo = pm.plm_pes_car_fac_codigo and ac.car_Codigo = pm.plm_pes_car_codigo and ac.mat_codigo = pm.plm_mat_codigo
WHERE PES_CODIGO = 42 AND FAC_CODIGO = 1 AND CAR_CODIGO = 12

AND ALC_LIBRE = 1 AND ALC_PORC_INAS < 65
AND COM_SED_CODIGO = 1
and alu_sir_codigo in(1,4,5,6,7)
and pm.plm_ano = 1 and pm.plm_cuatrimestre = 1 and pm.plm_pes_codigo = 42



UNION


SELECT   apellido, mat_descripcion, sed_Descripcion
 FROM VW_ALUMNOS_COMISIONES AC
 INNER JOIN NOTAS_ALMNOS NA
 ON NA.NOA_ALC_COA_COM_CODIGO = AC.COM_CODIGO  AND NA.NOA_ALC_ALU_CODIGO = AC.ALU_CODIGO  AND NA.NOA_ALC_COA_ANO = AC.COA_ANO   AND NA.NOA_ALC_COA_CUATRIMESTRE = AC.COA_CUATRIMESTRE  
  AND NA.NOA_TIPO_NOTA = 33 AND NA.NOA_NOTA < 4 
  inner join plan_materias pm
  on ac.pes_codigo = pm.plm_pes_codigo and ac.fac_codigo = pm.plm_pes_car_fac_codigo and ac.car_Codigo = pm.plm_pes_car_codigo and ac.mat_codigo = pm.plm_mat_codigo
WHERE AC.PES_CODIGO = 42 AND AC.FAC_CODIGO = 1 AND AC.CAR_CODIGO = 12
AND AC.ALC_APROBADA = 0 AND AC.ALC_REGULARIZADA = 0
AND AC.COA_ANO = 2019 
and alu_sir_codigo in (1,4,5,6,7)
and pm.plm_ano = 1 and pm.plm_cuatrimestre = 1 and pm.plm_pes_codigo = 42

ORDER BY APELLIDO


--SOLO HICE  PARA OBTENER LOS ALUMNOS QUE PUEDEN CURSAR MATERIAS DE PRIMER AÑO PRIMER CUATRIMESTRE 
-- DE CONTADOR PÚBLICO
--PARA EL CASO QUE FUESE PARA MATERIAS DE AÑOS Y CUATRIMESTRE SUPERIORES CONSIDERAR LAS CORRELATIVAS

select distinct alu_codigo, alu_apellido_al, alu_nombre_al, SR.SIR_DESCRIPCION, mat_descripcion from vw_alumnos_comisiones AC
inner join plan_materias pm
  on ac.pes_codigo = pm.plm_pes_codigo and ac.fac_codigo = pm.plm_pes_car_fac_codigo and ac.car_Codigo = pm.plm_pes_car_codigo and ac.mat_codigo = pm.plm_mat_codigo 
INNER JOIN SITUACION_rEVISTA SR
ON SR.SIR_cODIGO = AC.ALU_SIR_CODIGO
where AC.pes_codigo = 42 and AC.fac_codigo = 1 and AC.car_codigo = 12 AND AC.COM_SED_CODIGO = 3 --CAMBIAR EL VALOR DE LA SEDE
and dbo.valida_aprobada(AC.pes_codigo, AC.fac_codigo, AC.car_codigo,AC.alu_codigo, AC.mat_codigo) = 0 --NO APROBÓ
and dbo.verifica_regularizada(AC.pes_codigo,AC.fac_codigo,AC.car_codigo, AC.alu_codigo, AC.mat_codigo, '11/02/2020') = 0 --NO REGULARIZÓ
and pm.plm_ano = 1 and pm.plm_cuatrimestre = 1 and pm.plm_pes_codigo = 42
and ac.alu_sir_codigo in(1,4,5,6,7)





