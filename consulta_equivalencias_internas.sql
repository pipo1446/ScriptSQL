 
  --creo que puede pasar el caso que un alumno tenga los dos tipos de equivalencias,
 -- pero van a tener diferentes codigo de alumno.
  -- equivalencias internas
  --tablas utilizadas: equivalencias_alumnos, equivalancias_materias
  --                   materia, alumnos, plan_estudio
  --PASANDO EL ALU_CODIGO OBTENGO TODAS LAS EQUIVALENCIAS.
  
  select  convert(varchar(10), ea.eqa_fecha_normativa,103) as fecha_normativa,ea.eqa_tipo_normativa as tipo_normativa,
   ea.eqa_nro_resolucion as resolucion, case ea.eqa_tipo when 'I' then 'Interna' else 'Externa' end as tipo, m1.mat_descripcion +':'+ convert(varchar(10),em.eqm_nota_aprob) + ' ' + em.eqm_nota_concepto as materia_que_trae_aprobadas , 
   convert(varchar(10),em.eqm_fecha_aprob,103) as fecha_aprobacion,  em.eqm_libro as libro, em.eqm_folio as folio,
         m.mat_descripcion as materia_reconocida, ea.eqa_nota as nota_reconocida, pe.pes_descripcion,a.alu_apellido_al + ',' + a.alu_nombre_al as alumno  from equivalencias_materias em
  inner join materia m
  on em.eqm_eqa_plm_mat_codigo = m.mat_codigo
  inner join materia m1
  on em.eqm_plm_mat_codigo = m1.mat_codigo
  inner join alumnos a
  on em.eqm_eqa_alu_codigo = a.alu_codigo
  inner join equivalencias_alumnos ea
  on em.eqm_eqa_plm_pes_codigo = ea.eqa_plm_pes_codigo and em.eqm_eqa_plm_pes_car_fac_codigo = ea.eqa_plm_pes_car_fac_codigo and em.eqm_eqa_plm_pes_car_codigo = ea.eqa_plm_pes_car_codigo
     and em.eqm_eqa_plm_mat_codigo = ea.eqa_plm_mat_codigo and em.eqm_eqa_alu_codigo = ea.eqa_alu_codigo
  inner join plan_Estudio pe
  on em.eqm_eqa_plm_pes_codigo = pe.pes_codigo and em.eqm_eqa_plm_pes_car_fac_codigo = pe.pes_car_fac_codigo and em.eqm_eqa_plm_pes_car_codigo = pe.pes_car_codigo
  where em.eqm_eqa_alu_codigo = 15003
  order by m.mat_descripcion


  --update equivalencias_alumnos
  --set eqa_tipo_normativa = 'Disposición de equivalencias'
  --where eqa_alu_codigo = 15063 
  

  --equivalencias externas
  --tablas utilizadas: equivalencias_alumnos, equivalencias_materias
  --                   plan_estudio,materia, alumnos

  select em.eqm_universidad, em.eqm_facultad, em.eqm_carrera, em.eqm_materia + ': ' + convert(varchar(5),em.eqm_nota_aprob) + ' '+  em.eqm_nota_concepto as materia,
         convert(varchar(10),em.eqm_fecha_aprob,103) fecha_aprobacion,em.eqm_libro, em.eqm_folio, pe.pes_descripcion,
		 m.mat_descripcion,convert(varchar(10),ea.eqa_fecha_normativa,103) as fecha_normativa, ea.eqa_tipo_normativa, ea.eqa_nro_resolucion, ea.eqa_nota, ea.eqa_tipo,
		 a.alu_apellido_al + ',' + a.alu_nombre_al as alumno  
  from equivalencias_materias em
   inner join equivalencias_alumnos ea
     on em.eqm_eqa_plm_pes_codigo = ea.eqa_plm_pes_codigo and em.eqm_eqa_plm_pes_car_fac_codigo = ea.eqa_plm_pes_car_fac_codigo and em.eqm_eqa_plm_pes_car_codigo = ea.eqa_plm_pes_car_codigo
        and em.eqm_eqa_plm_mat_codigo = ea.eqa_plm_mat_codigo and em.eqm_eqa_alu_codigo = ea.eqa_alu_codigo
   inner join plan_estudio pe
     on em.eqm_eqa_plm_pes_codigo = pe.pes_codigo and em.eqm_eqa_plm_pes_car_fac_codigo = pe.pes_car_fac_codigo and em.eqm_eqa_plm_pes_car_codigo = pe.pes_car_codigo 
   inner join materia m
     on em.eqm_eqa_plm_mat_codigo = m.mat_codigo
   inner join alumnos a
     on em.eqm_eqa_alu_codigo = a.alu_codigo
  where em.eqm_eqa_alu_codigo = 15003
  order by mat_descripcion

  select * from equivalencias_alumnos
  where eqa_alu_codigo = 15003


  

  select top 1 * from equivalencias_materias
  where eqm_eqa_alu_codigo = 15003

  select top 1 * from equivalencias_alumnos
  where eqa_alu_codigo = 15003











