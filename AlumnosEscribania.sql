
--alumnos de escribanía con fecha de ingreso 10/08/2020
select CARRERA, ALUMNO,TELEFONO_FAMILIAR, COD_POSTAL_FAMILIAR, PROVINCIA_FAMILIAR from vw_alumnos_extension_aulica
where pes_codigo = 77
and alu_fecha_ingreso_al = '10/08/2020'
ORDER BY  PROVINCIA_FAMILIAR, ALUMNO 






