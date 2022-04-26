select sed_descripcion,case when cd.cod_dias = 1 then 'lunes'
                            when cd.cod_dias = 2 then 'martes'
							when cd.cod_dias = 3 then 'miercoles'
                            when cd.cod_dias = 4 then 'jueves'
							when cd.cod_dias = 5 then 'viernes'	 
							when cd.cod_dias = 6 then 'sabados'
							end dia, convert(varchar(5),cd.cod_horario_desde,108) hora_desde, convert(varchar(5),cd.cod_horario_hasta,108) hora_hasta,
							fac_descripcion, car_Descripcion, mat_descripcion

 from SRVSQL.SEDESPEÑA.DBO.COMISION_DIAS cd
inner join SRVSQL.SEDESPEÑA.DBO.VW_COMISIONES_DOCENTES cdo
on cd.cod_coa_com_codigo = cdo.cdo_coa_com_codigo 
and cd.cod_coa_ano = cdo.cdo_coa_ano 
and cd.cod_coa_cuatrimestre = cdo.cdo_coa_cuatrimestre

where cdo.cdo_coa_ano = 2020 and cdo.cdo_coa_cuatrimestre in (1,3)
order by cdo.fac_descripcion, cdo.pes_descripcion, cdo.mat_descripcion