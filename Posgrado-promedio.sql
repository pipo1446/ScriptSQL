



select a.apellido, a.nombre,m.descripcion, dbo.promedio(vw.parcial, vw.recuperatorio) promedio  from vw_total_notas vw  --dbo.promedio_con_aplazos(vw.alu_codigo) PROMEDIO
inner join alumnos a
on vw.alu_codigo = a.alu_codigo
inner join materia m
on vw.mat_codigo = m.mat_codigo
where a.facultad = 5 and a.carrera = 3 and a.plan_estudio = 1 and a.sede = 1
and m.mat_codigo in(91,90,88,89,94,92,95,93) 

group by a.apellido, a.nombre,m.descripcion, dbo.promedio(vw.parcial, vw.recuperatorio)

order by a.apellido, a.nombre,dbo.promedio(vw.parcial, vw.recuperatorio)
compute avg(dbo.promedio(vw.parcial, vw.recuperatorio)) by  a.apellido, a.nombre--,dbo.promedio(vw.parcial, vw.recuperatorio)