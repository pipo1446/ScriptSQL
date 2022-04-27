-- CUADRO DE BAJAS POR COHORTE  -  SEGÚN TABLAS ORIGINALES DE GÉNESIS
-- POR CARRERA
select se.sed_nomenc as Sede, ca.fac_cod as Fac, fac_descripcion, ca.car_cod as Car, ca.carrera, an.ano,
   a2008 = (select count(distinct al.alu_codigo)
			from alumnos al
			inner join vw_alumnos_extension_aulica_total eal on al.alu_codigo = eal.alu_codigo
            left join plan_estudio pe on al.alu_pes_codigo = pe.pes_codigo
			left join carreras cai on pe.pes_car_real = cai.car_cod and pe.pes_car_fac_codigo = cai.fac_cod
			inner join sedecentral.dbo.anio_cuatrimestre ani on cuatrimestre = 1 and ani.ano = 2008 -- Ciclos
			where pe.pes_modalidad = 1 -- Modalidad presencial
			  and al.alu_fecha_baja_al >= ani.inicio_ciclo and al.alu_fecha_baja_al <= ani.fin_ciclo
			  and al.alu_sir_codigo in (2,3)
			  and year(dbo.fecha_ingreso_carrera(al.alu_nro_doc_al, cai.fac_cod, cai.car_cod)) = an.ano -- Cohorte dejar fijo
			  and al.alu_nro_doc_al not in -- Excluye cambios de plan de estudios
				  (select al1.alu_nro_doc_al
				   from alumnos al1
				   left join plan_estudio pe1 on al1.alu_pes_codigo = pe1.pes_codigo
				   where pe1.pes_modalidad = 1 and pe1.pes_car_real = pe.pes_car_real and pe1.pes_car_fac_codigo = pe.pes_car_fac_codigo 
					 and al1.alu_fecha_ingreso_al > al.alu_fecha_ingreso_al)
			  and eal.SED_CODIGO = ca.sede and (eal.FECHA_HASTA IS NULL OR eal.FECHA_HASTA >= ani.inicio_ciclo)
              and cai.fac_cod = ca.fac_cod and cai.car_cod = ca.car_cod),
   a2009 = (select count(distinct al.alu_codigo)
			from alumnos al
			inner join vw_alumnos_extension_aulica_total eal on al.alu_codigo = eal.alu_codigo
            left join plan_estudio pe on al.alu_pes_codigo = pe.pes_codigo
			left join carreras cai on pe.pes_car_real = cai.car_cod and pe.pes_car_fac_codigo = cai.fac_cod
			inner join sedecentral.dbo.anio_cuatrimestre ani on cuatrimestre = 1 and ani.ano = 2009 -- Ciclos
			where pe.pes_modalidad = 1 -- Modalidad presencial
			  and al.alu_fecha_baja_al >= ani.inicio_ciclo and al.alu_fecha_baja_al <= ani.fin_ciclo
			  and al.alu_sir_codigo in (2,3)
			  and year(dbo.fecha_ingreso_carrera(al.alu_nro_doc_al, cai.fac_cod, cai.car_cod)) = an.ano -- Cohorte dejar fijo
			  and al.alu_nro_doc_al not in -- Excluye cambios de plan de estudios
				  (select al1.alu_nro_doc_al
				   from alumnos al1
				   left join plan_estudio pe1 on al1.alu_pes_codigo = pe1.pes_codigo
				   where pe1.pes_modalidad = 1 and pe1.pes_car_real = pe.pes_car_real and pe1.pes_car_fac_codigo = pe.pes_car_fac_codigo 
					 and al1.alu_fecha_ingreso_al > al.alu_fecha_ingreso_al)
			  and eal.SED_CODIGO = ca.sede and (eal.FECHA_HASTA IS NULL OR eal.FECHA_HASTA >= ani.inicio_ciclo)
              and cai.fac_cod = ca.fac_cod and cai.car_cod = ca.car_cod),
   a2010 = (select count(distinct al.alu_codigo)
			from alumnos al
			inner join vw_alumnos_extension_aulica_total eal on al.alu_codigo = eal.alu_codigo
            left join plan_estudio pe on al.alu_pes_codigo = pe.pes_codigo
			left join carreras cai on pe.pes_car_real = cai.car_cod and pe.pes_car_fac_codigo = cai.fac_cod
			inner join sedecentral.dbo.anio_cuatrimestre ani on cuatrimestre = 1 and ani.ano = 2010 -- Ciclos
			where pe.pes_modalidad = 1 -- Modalidad presencial
			  and al.alu_fecha_baja_al >= ani.inicio_ciclo and al.alu_fecha_baja_al <= ani.fin_ciclo
			  and al.alu_sir_codigo in (2,3)
			  and year(dbo.fecha_ingreso_carrera(al.alu_nro_doc_al, cai.fac_cod, cai.car_cod)) = an.ano -- Cohorte dejar fijo
			  and al.alu_nro_doc_al not in -- Excluye cambios de plan de estudios
				  (select al1.alu_nro_doc_al
				   from alumnos al1
				   left join plan_estudio pe1 on al1.alu_pes_codigo = pe1.pes_codigo
				   where pe1.pes_modalidad = 1 and pe1.pes_car_real = pe.pes_car_real and pe1.pes_car_fac_codigo = pe.pes_car_fac_codigo 
					 and al1.alu_fecha_ingreso_al > al.alu_fecha_ingreso_al)
			  and eal.SED_CODIGO = ca.sede and (eal.FECHA_HASTA IS NULL OR eal.FECHA_HASTA >= ani.inicio_ciclo)
              and cai.fac_cod = ca.fac_cod and cai.car_cod = ca.car_cod), 
   a2011 = (select count(distinct al.alu_codigo)
			from alumnos al
			inner join vw_alumnos_extension_aulica_total eal on al.alu_codigo = eal.alu_codigo
            left join plan_estudio pe on al.alu_pes_codigo = pe.pes_codigo
			left join carreras cai on pe.pes_car_real = cai.car_cod and pe.pes_car_fac_codigo = cai.fac_cod
			inner join sedecentral.dbo.anio_cuatrimestre ani on cuatrimestre = 1 and ani.ano = 2011 -- Ciclos
			where pe.pes_modalidad = 1 -- Modalidad presencial
			  and al.alu_fecha_baja_al >= ani.inicio_ciclo and al.alu_fecha_baja_al <= ani.fin_ciclo
			  and al.alu_sir_codigo in (2,3)
			  and year(dbo.fecha_ingreso_carrera(al.alu_nro_doc_al, cai.fac_cod, cai.car_cod)) = an.ano -- Cohorte dejar fijo
			  and al.alu_nro_doc_al not in -- Excluye cambios de plan de estudios
				  (select al1.alu_nro_doc_al
				   from alumnos al1
				   left join plan_estudio pe1 on al1.alu_pes_codigo = pe1.pes_codigo
				   where pe1.pes_modalidad = 1 and pe1.pes_car_real = pe.pes_car_real and pe1.pes_car_fac_codigo = pe.pes_car_fac_codigo 
					 and al1.alu_fecha_ingreso_al > al.alu_fecha_ingreso_al)
			  and eal.SED_CODIGO = ca.sede and (eal.FECHA_HASTA IS NULL OR eal.FECHA_HASTA >= ani.inicio_ciclo)
              and cai.fac_cod = ca.fac_cod and cai.car_cod = ca.car_cod), 
   a2012 = (select count(distinct al.alu_codigo)
			from alumnos al
			inner join vw_alumnos_extension_aulica_total eal on al.alu_codigo = eal.alu_codigo
            left join plan_estudio pe on al.alu_pes_codigo = pe.pes_codigo
			left join carreras cai on pe.pes_car_real = cai.car_cod and pe.pes_car_fac_codigo = cai.fac_cod
			inner join sedecentral.dbo.anio_cuatrimestre ani on cuatrimestre = 1 and ani.ano = 2012 -- Ciclos
			where pe.pes_modalidad = 1 -- Modalidad presencial
			  and al.alu_fecha_baja_al >= ani.inicio_ciclo and al.alu_fecha_baja_al <= ani.fin_ciclo
			  and al.alu_sir_codigo in (2,3)
			  and year(dbo.fecha_ingreso_carrera(al.alu_nro_doc_al, cai.fac_cod, cai.car_cod)) = an.ano -- Cohorte dejar fijo
			  and al.alu_nro_doc_al not in -- Excluye cambios de plan de estudios
				  (select al1.alu_nro_doc_al
				   from alumnos al1
				   left join plan_estudio pe1 on al1.alu_pes_codigo = pe1.pes_codigo
				   where pe1.pes_modalidad = 1 and pe1.pes_car_real = pe.pes_car_real and pe1.pes_car_fac_codigo = pe.pes_car_fac_codigo 
					 and al1.alu_fecha_ingreso_al > al.alu_fecha_ingreso_al)
			  and eal.SED_CODIGO = ca.sede and (eal.FECHA_HASTA IS NULL OR eal.FECHA_HASTA >= ani.inicio_ciclo)
              and cai.fac_cod = ca.fac_cod and cai.car_cod = ca.car_cod), 
   a2013 = (select count(distinct al.alu_codigo)
			from alumnos al
			inner join vw_alumnos_extension_aulica_total eal on al.alu_codigo = eal.alu_codigo
            left join plan_estudio pe on al.alu_pes_codigo = pe.pes_codigo
			left join carreras cai on pe.pes_car_real = cai.car_cod and pe.pes_car_fac_codigo = cai.fac_cod
			inner join sedecentral.dbo.anio_cuatrimestre ani on cuatrimestre = 1 and ani.ano = 2013 -- Ciclos
			where pe.pes_modalidad = 1 -- Modalidad presencial
			  and al.alu_fecha_baja_al >= ani.inicio_ciclo and al.alu_fecha_baja_al <= ani.fin_ciclo
			  and al.alu_sir_codigo in (2,3)
			  and year(dbo.fecha_ingreso_carrera(al.alu_nro_doc_al, cai.fac_cod, cai.car_cod)) = an.ano -- Cohorte dejar fijo
			  and al.alu_nro_doc_al not in -- Excluye cambios de plan de estudios
				  (select al1.alu_nro_doc_al
				   from alumnos al1
				   left join plan_estudio pe1 on al1.alu_pes_codigo = pe1.pes_codigo
				   where pe1.pes_modalidad = 1 and pe1.pes_car_real = pe.pes_car_real and pe1.pes_car_fac_codigo = pe.pes_car_fac_codigo 
					 and al1.alu_fecha_ingreso_al > al.alu_fecha_ingreso_al)
			  and eal.SED_CODIGO = ca.sede and (eal.FECHA_HASTA IS NULL OR eal.FECHA_HASTA >= ani.inicio_ciclo)
              and cai.fac_cod = ca.fac_cod and cai.car_cod = ca.car_cod), 
   a2014 = (select count(distinct al.alu_codigo)
			from alumnos al
			inner join vw_alumnos_extension_aulica_total eal on al.alu_codigo = eal.alu_codigo
            left join plan_estudio pe on al.alu_pes_codigo = pe.pes_codigo
			left join carreras cai on pe.pes_car_real = cai.car_cod and pe.pes_car_fac_codigo = cai.fac_cod
			inner join sedecentral.dbo.anio_cuatrimestre ani on cuatrimestre = 1 and ani.ano = 2014 -- Ciclos
			where pe.pes_modalidad = 1 -- Modalidad presencial
			  and al.alu_fecha_baja_al >= ani.inicio_ciclo and al.alu_fecha_baja_al <= ani.fin_ciclo
			  and al.alu_sir_codigo in (2,3)
			  and year(dbo.fecha_ingreso_carrera(al.alu_nro_doc_al, cai.fac_cod, cai.car_cod)) = an.ano -- Cohorte dejar fijo
			  and al.alu_nro_doc_al not in -- Excluye cambios de plan de estudios
				  (select al1.alu_nro_doc_al
				   from alumnos al1
				   left join plan_estudio pe1 on al1.alu_pes_codigo = pe1.pes_codigo
				   where pe1.pes_modalidad = 1 and pe1.pes_car_real = pe.pes_car_real and pe1.pes_car_fac_codigo = pe.pes_car_fac_codigo 
					 and al1.alu_fecha_ingreso_al > al.alu_fecha_ingreso_al)
			  and eal.SED_CODIGO = ca.sede and (eal.FECHA_HASTA IS NULL OR eal.FECHA_HASTA >= ani.inicio_ciclo)
              and cai.fac_cod = ca.fac_cod and cai.car_cod = ca.car_cod),
   a2015 = (select count(distinct al.alu_codigo)
			from alumnos al
			inner join vw_alumnos_extension_aulica_total eal on al.alu_codigo = eal.alu_codigo
            left join plan_estudio pe on al.alu_pes_codigo = pe.pes_codigo
			left join carreras cai on pe.pes_car_real = cai.car_cod and pe.pes_car_fac_codigo = cai.fac_cod
			inner join sedecentral.dbo.anio_cuatrimestre ani on cuatrimestre = 1 and ani.ano = 2015 -- Ciclos
			where pe.pes_modalidad = 1 -- Modalidad presencial
			  and al.alu_fecha_baja_al >= ani.inicio_ciclo and al.alu_fecha_baja_al <= ani.fin_ciclo
			  and al.alu_sir_codigo in (2,3)
			  and year(dbo.fecha_ingreso_carrera(al.alu_nro_doc_al, cai.fac_cod, cai.car_cod)) = an.ano -- Cohorte dejar fijo
			  and al.alu_nro_doc_al not in -- Excluye cambios de plan de estudios
				  (select al1.alu_nro_doc_al
				   from alumnos al1
				   left join plan_estudio pe1 on al1.alu_pes_codigo = pe1.pes_codigo
				   where pe1.pes_modalidad = 1 and pe1.pes_car_real = pe.pes_car_real and pe1.pes_car_fac_codigo = pe.pes_car_fac_codigo 
					 and al1.alu_fecha_ingreso_al > al.alu_fecha_ingreso_al)
			  and eal.SED_CODIGO = ca.sede and (eal.FECHA_HASTA IS NULL OR eal.FECHA_HASTA >= ani.inicio_ciclo)
              and cai.fac_cod = ca.fac_cod and cai.car_cod = ca.car_cod), 
   a2016 = (select count(distinct al.alu_codigo)
			from alumnos al
			inner join vw_alumnos_extension_aulica_total eal on al.alu_codigo = eal.alu_codigo
            left join plan_estudio pe on al.alu_pes_codigo = pe.pes_codigo
			left join carreras cai on pe.pes_car_real = cai.car_cod and pe.pes_car_fac_codigo = cai.fac_cod
			inner join sedecentral.dbo.anio_cuatrimestre ani on cuatrimestre = 1 and ani.ano = 2016 -- Ciclos
			where pe.pes_modalidad = 1 -- Modalidad presencial
			  and al.alu_fecha_baja_al >= ani.inicio_ciclo and al.alu_fecha_baja_al <= ani.fin_ciclo
			  and al.alu_sir_codigo in (2,3)
			  and year(dbo.fecha_ingreso_carrera(al.alu_nro_doc_al, cai.fac_cod, cai.car_cod)) = an.ano -- Cohorte dejar fijo
			  and al.alu_nro_doc_al not in -- Excluye cambios de plan de estudios
				  (select al1.alu_nro_doc_al
				   from alumnos al1
				   left join plan_estudio pe1 on al1.alu_pes_codigo = pe1.pes_codigo
				   where pe1.pes_modalidad = 1 and pe1.pes_car_real = pe.pes_car_real and pe1.pes_car_fac_codigo = pe.pes_car_fac_codigo 
					 and al1.alu_fecha_ingreso_al > al.alu_fecha_ingreso_al)
			  and eal.SED_CODIGO = ca.sede and (eal.FECHA_HASTA IS NULL OR eal.FECHA_HASTA >= ani.inicio_ciclo)
              and cai.fac_cod = ca.fac_cod and cai.car_cod = ca.car_cod),
   a2017 = (select count(distinct al.alu_codigo)
			from alumnos al
			inner join vw_alumnos_extension_aulica_total eal on al.alu_codigo = eal.alu_codigo
            left join plan_estudio pe on al.alu_pes_codigo = pe.pes_codigo
			left join carreras cai on pe.pes_car_real = cai.car_cod and pe.pes_car_fac_codigo = cai.fac_cod
			inner join sedecentral.dbo.anio_cuatrimestre ani on cuatrimestre = 1 and ani.ano = 2017 -- Ciclos
			where pe.pes_modalidad = 1 -- Modalidad presencial
			  and al.alu_fecha_baja_al >= ani.inicio_ciclo and al.alu_fecha_baja_al <= ani.fin_ciclo
			  and al.alu_sir_codigo in (2,3)
			  and year(dbo.fecha_ingreso_carrera(al.alu_nro_doc_al, cai.fac_cod, cai.car_cod)) = an.ano -- Cohorte dejar fijo
			  and al.alu_nro_doc_al not in -- Excluye cambios de plan de estudios
				  (select al1.alu_nro_doc_al
				   from alumnos al1
				   left join plan_estudio pe1 on al1.alu_pes_codigo = pe1.pes_codigo
				   where pe1.pes_modalidad = 1 and pe1.pes_car_real = pe.pes_car_real and pe1.pes_car_fac_codigo = pe.pes_car_fac_codigo 
					 and al1.alu_fecha_ingreso_al > al.alu_fecha_ingreso_al)
			  and eal.SED_CODIGO = ca.sede and (eal.FECHA_HASTA IS NULL OR eal.FECHA_HASTA >= ani.inicio_ciclo)
              and cai.fac_cod = ca.fac_cod and cai.car_cod = ca.car_cod), 
   a2018 = (select count(distinct al.alu_codigo)
			from alumnos al
			inner join vw_alumnos_extension_aulica_total eal on al.alu_codigo = eal.alu_codigo
            left join plan_estudio pe on al.alu_pes_codigo = pe.pes_codigo
			left join carreras cai on pe.pes_car_real = cai.car_cod and pe.pes_car_fac_codigo = cai.fac_cod
			inner join sedecentral.dbo.anio_cuatrimestre ani on cuatrimestre = 1 and ani.ano = 2018 -- Ciclos
			where pe.pes_modalidad = 1 -- Modalidad presencial
			  and al.alu_fecha_baja_al >= ani.inicio_ciclo and al.alu_fecha_baja_al <= ani.fin_ciclo
			  and al.alu_sir_codigo in (2,3)
			  and year(dbo.fecha_ingreso_carrera(al.alu_nro_doc_al, cai.fac_cod, cai.car_cod)) = an.ano -- Cohorte dejar fijo
			  and al.alu_nro_doc_al not in -- Excluye cambios de plan de estudios
				  (select al1.alu_nro_doc_al
				   from alumnos al1
				   left join plan_estudio pe1 on al1.alu_pes_codigo = pe1.pes_codigo
				   where pe1.pes_modalidad = 1 and pe1.pes_car_real = pe.pes_car_real and pe1.pes_car_fac_codigo = pe.pes_car_fac_codigo 
					 and al1.alu_fecha_ingreso_al > al.alu_fecha_ingreso_al)
			  and eal.SED_CODIGO = ca.sede and (eal.FECHA_HASTA IS NULL OR eal.FECHA_HASTA >= ani.inicio_ciclo)
              and cai.fac_cod = ca.fac_cod and cai.car_cod = ca.car_cod) 
from sedecentral.dbo.vw_car_ciclo_inicio ca 
left join facultad fa on ca.fac_cod = fa.fac_codigo
left join sedes se on ca.sede = se.sed_codigo
left join sedecentral.dbo.anio_cuatrimestre an on cuatrimestre = 1 -- Para iterar Cohortes
where ca.carrera like '%abogac%'
  and an.ano >= 2006 and an.ano <= 2018
  and an.ano >= ca.car_ciclo_inicio
  and sede = 11
order by se.sed_nomenc, fac_descripcion, ca.carrera

/* Para Controlar Cant Anteriores - BAJAS CICLO LECTIVO - EXCLUYE CAMBIOS DE PLAN - Cantidades - Cuadro Evolución Inscriptos y Movimiento e Alumnos*/
--select al.alu_pes_car_fac_codigo, ca.carrera, count(al.alu_codigo), eal.ext_codigo
--from alumnos al
--left join plan_estudio pe on al.alu_pes_codigo = pe.pes_codigo
--left join carreras ca on pe.pes_car_real = ca.car_cod and pe.pes_car_fac_codigo = ca.fac_cod
--inner join vw_alumnos_extension_aulica_total eal on al.alu_codigo = eal.alu_codigo
--where al.alu_sir_codigo in (2,3) and al.alu_fecha_baja_al >= '01/03/2015'  and al.alu_fecha_baja_al <= '23/04/2016' -- Bajas del ciclo
--   and pe.pes_modalidad = 1 --and alu_pes_car_fac_codigo = 2 -- OJO: Cambiar facultad
--   and al.alu_nro_doc_al not in -- Excluye cambios de plan de estudios
-- (select al1.alu_nro_doc_al
--	from alumnos al1
--	left join plan_estudio pe1 on al1.alu_pes_codigo = pe1.pes_codigo
--	where pe1.pes_modalidad = 1 and pe1.pes_car_real = pe.pes_car_real and pe1.pes_car_fac_codigo = pe.pes_car_fac_codigo 
--       and al1.alu_nro_doc_al = al.alu_nro_doc_al and al1.alu_fecha_ingreso_al > al.alu_fecha_ingreso_al)
--  and ca.car_ciclo_inicio <= 2015 -- OJO .--- CAmbiar --- Calcula sólo para carreras que iniciaron
--   and eal.SED_CODIGO = 2 and (eal.FECHA_HASTA IS NULL OR eal.FECHA_HASTA > ca.car_ciclo_inicio) --> Cambiar SEDE
--group by al.alu_pes_car_fac_codigo, ca.carrera, eal.ext_codigo
--order by eal.ext_codigo, al.alu_pes_car_fac_codigo, ca.carrera


