 
 --cuantos alumnos registraron sus asistencias en saenz peña hasta el momento
 SELECT COUNT(*),  INFO_DISPOSITIVO, SED_CODIGO FROM ASISTENCIA_VIRTUAL
                      where SED_CODIGO = 11 --sede a evaluar
                      GROUP BY INFO_DISPOSITIVO,SED_CODIGO



--vamos a mostrar solamente los que marcaron su asistencia por alguno de los medios disponibles


--vamos a tener que poner como parámetros la fecha_qr de la tabla asistencia_virtual

select count(*) cantidad_conexiones,ac.fac_descripcion, ac.plan_cursado_descripcion, ac.com_plan_raiz,ac.com_descripcion,
 av.INFO_DISPOSITIVO, convert(varchar(10),av.FECHA_QR,103) registro_asistencia_alumno
from srvsql.sedespeña.dbo.vw_alumnos_comisiones ac
inner join ASISTENCIA_VIRTUAL av
on ac.com_codigo = av.COM_CODIGO and ac.coa_ano = av.AÑO and ac.coa_cuatrimestre = av.CUATRIMESTRE
and ac.com_sed_codigo = av.SED_CODIGO and ac.alu_codigo = av.ALU_CODIGO
where av.SED_CODIGO = 11
group by ac.fac_descripcion, ac.plan_cursado_descripcion, ac.com_plan_raiz,ac.com_descripcion, 
 av.INFO_DISPOSITIVO,convert(varchar(10),av.FECHA_QR,103) 


-- order by ac.fac_descripcion, ac.plan_cursado_descripcion, registro_asistencia_alumno




SELECT a.FECHA ,a.UsuarioId ,b.UsuarioNombre, b.InstitucionId, c.InstitucionNombre , a.cant
from ( SELECT convert(char, AuditoriaSesionFecha , 102) FECHA ,UsuarioId , COUNT(*) cant
FROM [AUDITORIA_SESION]
where AuditoriaSesionAccion = 'Login'
group by convert(char, AuditoriaSesionFecha , 102) , UsuarioId) as a, 
[USUARIO] as b, INSTITUCION as c
where b.UsuarioId = a.UsuarioId and c.InstitucionId = b.InstitucionId
order by a.Fecha , a.UsuarioId