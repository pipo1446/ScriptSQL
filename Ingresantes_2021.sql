
--CENTRAL
select AEA.* from vw_alumnos_extension_aulica aea
inner join alumnos a
on aea.alu_codigo = a.alu_codigo
where aea.alu_fecha_ingreso_al = '01/03/2021'
and ext_codigo = 1
and fecha_hasta is null
and a.alu_codigo_ant = 0
and a.alu_pes_car_fac_codigo <> 0

UNION ALL
--RESISTENCIA
select AEA.* from vw_alumnos_extension_aulica aea
inner join alumnos a
on aea.alu_codigo = a.alu_codigo
where aea.alu_fecha_ingreso_al = '01/03/2021'
and ext_codigo = 2
and fecha_hasta is null
and a.alu_codigo_ant = 0
and a.alu_pes_car_fac_codigo <> 0

UNION ALL
--GOYA
select AEA.* from SEDEGOYA.DBO.vw_alumnos_extension_aulica aea
inner join alumnos a
on aea.alu_codigo = a.alu_codigo
where aea.alu_fecha_ingreso_al = '01/03/2021'
and ext_codigo = 1
and fecha_hasta is null
and a.alu_codigo_ant = 0
and a.alu_pes_car_fac_codigo <> 0

UNION ALL
--LIBRES
select AEA.* from SEDEPLIBRES.DBO.vw_alumnos_extension_aulica aea
inner join alumnos a
on aea.alu_codigo = a.alu_codigo
where aea.alu_fecha_ingreso_al = '01/03/2021'
and ext_codigo = 1
and fecha_hasta is null
and a.alu_codigo_ant = 0
and a.alu_pes_car_fac_codigo <> 0

UNION ALL
--POSADAS
select AEA.* from SEDEPOSADAS.DBO.vw_alumnos_extension_aulica aea
inner join alumnos a
on aea.alu_codigo = a.alu_codigo
where aea.alu_fecha_ingreso_al = '01/03/2021'
and ext_codigo = 1
and fecha_hasta is null
and a.alu_codigo_ant = 0
and a.alu_pes_car_fac_codigo <> 0

UNION ALL
--FORMOSA
select AEA.* from SEDEFORMOSA.DBO.vw_alumnos_extension_aulica aea
inner join alumnos a
on aea.alu_codigo = a.alu_codigo
where aea.alu_fecha_ingreso_al = '01/03/2021'
and ext_codigo = 1
and fecha_hasta is null
and a.alu_codigo_ant = 0
and a.alu_pes_car_fac_codigo <> 0

UNION ALL
--CURUZU
select AEA.* from SEDECURUZU.DBO.vw_alumnos_extension_aulica aea
inner join alumnos a
on aea.alu_codigo = a.alu_codigo
where aea.alu_fecha_ingreso_al = '01/03/2021'
and ext_codigo = 1
and fecha_hasta is null
and a.alu_codigo_ant = 0
and a.alu_pes_car_fac_codigo <> 0

UNION ALL
--SAENZ PEÑA
select AEA.* from SEDESPEÑA.DBO.vw_alumnos_extension_aulica aea
inner join alumnos a
on aea.alu_codigo = a.alu_codigo
where aea.alu_fecha_ingreso_al = '01/03/2021'
and ext_codigo = 1
and fecha_hasta is null
and a.alu_codigo_ant = 0
and a.alu_pes_car_fac_codigo <> 0

UNION ALL
--AVELLANEDA
select AEA.* from SEDEAVELLANEDA.DBO.vw_alumnos_extension_aulica aea
inner join alumnos a
on aea.alu_codigo = a.alu_codigo
where aea.alu_fecha_ingreso_al = '01/03/2021'
and ext_codigo = 1
and fecha_hasta is null
and a.alu_codigo_ant = 0
and a.alu_pes_car_fac_codigo <> 0