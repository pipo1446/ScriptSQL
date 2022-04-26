

select distinct cdoc.fac_codigo, cdoc.fac_descripcion,cdoc.car_codigo,cdoc.car_descripcion, cdoc.pes_codigo, cdoc.pes_descripcion,
       cdoc.com_sed_codigo, cdoc.sed_descripcion, cdoc.cdo_coa_ano, cdoc.cdo_coa_cuatrimestre,cdoc.doc_completo,
	   cdoc.cdo_doc_codigo,cdoc.cdo_doc_sede, cdoc.cdo_coa_com_codigo, cdoc.com_descripcion, cdoc.mat_codigo, cdoc.mat_descripcion,
	   datepart(dw,ia.ial_fecha_inasistencia),cd.cod_dias, convert(varchar(5),cd.cod_horario_desde,108) hora_desde,
	   convert(varchar(5),cd.cod_horario_hasta,108) hora_hasta, ia.ial_fecha_inasistencia,
	   SUBSTRING(convert(char(20),ia.ial_fecha_creac_reg,121),1,16) Fecha_hora_creacion

	    from srvsql.sedecentral.dbo.vw_comisiones_docentes cdoc

		inner join srvsql.sedecentral.dbo.comision_dias cd --obtengo dias y horario de la clase
		on cdoc.cdo_coa_com_codigo = cd.cod_coa_com_codigo and cdoc.cdo_coa_cuatrimestre = cd.cod_coa_cuatrimestre
		   and cdoc.cdo_coa_ano = cd.cod_coa_ano

		inner join srvsql.sedecentral.dbo.inasistencia_alumnos ia --obtengo la fecha_inasistencia y la fecha que activó el docente
		on cdoc.cdo_coa_com_codigo = ia.ial_alc_coa_com_codigo and cdoc.cdo_coa_cuatrimestre =ia.ial_alc_coa_cuatrimestre
		   and cdoc.cdo_coa_ano = ia.ial_alc_coa_ano
		   and datepart(dw,ia.ial_fecha_inasistencia) = cd.cod_dias --obtiene el horario del día fecha_inasistencia

		where cdoc.cdo_coa_com_codigo = 8560 
		      and cdoc.fac_codigo = 2
		      and cdoc.car_codigo = 41
			  and cdoc.pes_codigo = 84
			  and cdoc.cdo_coa_ano = 2020
			  and cdoc.cdo_coa_cuatrimestre = 1
			  and cdoc.cdo_doc_codigo = 1995
			  and cdoc.cdo_doc_sede = 1
			  
		


