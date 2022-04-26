select * from alumnos
where alu_apellido_al like '%romero%'
and alu_nombre_al like '%juan no%'
--39171689
--12948

select * from dominios --combo Para: 1-Cursar, 2 -Rendir CmbPara
where dom_dominio = 39

select * from turno_mesa
--tum_tipo: 0- Ordinario, 1-Extraordinario, 2-Especial (Tipo de Turno)


select * from vw_dominios --1-Regular, 2-Libre(Tipo de Examen) CmbTipo
where dom_dominio = 40

SELECT * FROM DOMINIOS
WHERE DOM_DOMINIO = 2  -- 1-Si, 2-No  CmbSituación(Habilitado)


select * from administracion
where adm_cursa_final = 2
order by adm_fecha desc

--adm_alu_codigo CODIGO DE ALUMNO
--adm_fecha      FECHA DEL REGISTRO
--adm_situacion  HABILITADO(1) , NO HABILITADO(2)
--adm_cursa_final 1-CURSAR, 2-RENDIR
--adm_tum_codigo  CODIGO DEL TURNO DE EXAMEN (relacionar con TURNO_MESA)
--adm_tipo        LIBRE, REGULAR


--si es una mesa especial se debe seleccionar la materia al momento de habilitar para rendir desde administración
-- Función MESAS_ESPECIALES_ALUMNOS 

  
--Hay que solicitar a García la creación de un procidimento almacenado(dni,cod_carrera, turno, habilitado)
-- Existe alguna manera de saber a qué turno se inscribió el alumno en el sistema de García?
-- Como se distinguen los turnos especiales de los ordinarios y extraordinarios__
-- ya que se pueden presentar casos de superposición de turnos por ej. ordinarios con especiales.



