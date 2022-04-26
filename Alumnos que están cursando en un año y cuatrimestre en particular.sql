
--alumnos que están cursando 2019 2do cuatrimestre
--mas de 2 materias de 4to o 5to y que no sean materias de idiomas e informática.
select alu_nro_doc_al,  alu_apellido_al, alu_nombre_al, plm_ano, pes_descripcion, count(*) as cantidad_materias_inscriptas from vw_alumnos_comisiones
where coa_ano = 2019 and coa_cuatrimestre in(2,3) and plm_ano >=4 and mat_codigo not in(38,34,389,15,20,666,513,580,609,737) 
--and com_sed_codigo = 1
--and pes_codigo in(8,31,78,86,7,60,66,84,24,51,1,35,42) 
group by alu_nro_doc_al, alu_codigo,alu_apellido_al, alu_nombre_al,  plm_ano, pes_descripcion
having count(*) > = 2

order by pes_descripcion,alu_codigo, plm_ano
compute count(pes_descripcion) by pes_descripcion
--compute count(alu_codigo) by alu_codigo
--plm_ano >= 4


