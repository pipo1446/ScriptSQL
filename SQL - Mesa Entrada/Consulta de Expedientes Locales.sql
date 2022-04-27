
--CONSULTAS PARA ACCEDER A EXPEDIENTES LOCALES
--verifica que tenga permisos para acceder a la opción
SELECT p.tipo_acceso, p.descrip 
       FROM SEDECENTRAL.DBO.permisos P INNER JOIN SEDECENTRAL.DBO.usuarios u 
       ON p.cod_grupo = u.cod_grupo 
       WHERE (((u.userid) = 'ADOLFOS')  AND ((p.opcion) = 'EXPTEABM'))

--GUARDA TipoPermiso = p.tipo_acceso
--luego va al formulario de nuevo expediente local (FrmAbmExpte)

   ----------------------------cargar_iniciador()--------------------------------------------

   --PERSONAL ADMINISTRATIVO EXPEDIENTESUCP
    SELECT asg.id, 
         rtrim(per.apellido) AS apellido,(rtrim(per.nombre)) AS nombre, cgo.cargo_descripcion 
         FROM dbo.asignacion asg 
         INNER JOIN dbo.cargo cgo 
		 ON asg.cod_cargo = cgo.cod_cargo 
         INNER JOIN dbo.personal_admin per
         ON asg.cod_personal = per.cod_personal 
         INNER JOIN dbo.oficinas ofi
         ON cgo.cod_oficina = ofi.cod_oficina

		 --DOCENTES -SEDECENTRAL
		 SELECT distinct L.leg_codigo as doc_codigo, L.apellido as doc_descripcion, L.nombre as doc_nombre 
    FROM SRV10.SEDECENTRAL.dbo.LEGAJOS as L 
    inner join SRV10.SEDECENTRAL.dbo.relacion_laboral as RL
	 on L.leg_codigo = RL.leg_codigo and L.sede = RL.sede 
    where RL.sed_codigo = 1 ORDER BY APELLIDO,NOMBRE

	     --ALUMNOS, trae todos sin distinción de situación de revista
	SELECT alu.alu_codigo, alu.alu_apellido_al, alu.alu_nombre_al, pes.pes_codigo 
     FROM SEDECENTRAL.DBO.alumnos alu INNER JOIN SEDECENTRAL.DBO.plan_estudio pes
     ON alu.alu_pes_codigo = pes.pes_codigo 
     AND alu.alu_pes_car_fac_codigo = pes.pes_car_fac_codigo 
     AND alu.alu_pes_car_codigo = pes.pes_car_codigo 
     ORDER BY alu.alu_apellido_al,alu.alu_nombre_al

	 --ALUMNOS GRADUADOS, sir = 8
	 SELECT alu.alu_codigo, alu.alu_apellido_al, alu.alu_nombre_al, pes.pes_codigo 
     FROM SEDECENTRAL.DBO.alumnos alu 
	 INNER JOIN SEDECENTRAL.DBO.plan_estudio pes
     ON alu.alu_pes_codigo = pes.pes_codigo 
     AND alu.alu_pes_car_fac_codigo = pes.pes_car_fac_codigo 
     AND alu.alu_pes_car_codigo = pes.pes_car_codigo 
     where alu_sir_codigo = 8 
	 ORDER BY alu.alu_apellido_al,alu.alu_nombre_al

	 --PERSONAS EXTERNAS
	 SELECT Per_id, per_ape, per_nom FROM PersonasExternas 
	 ORDER BY per_ape,per_nom

	 --ALUMNOS POSGRADO
	 SELECT alu.alu_codigo, alu.apellido, alu.nombre, pes.pes_codigo 
      FROM POSGRADO.dbo.alumnos alu INNER JOIN POSGRADO.dbo.plan_estudio pes 
      ON alu.plan_estudio = pes.pes_codigo 
	  AND alu.facultad = pes.fac_codigo   
	  AND alu.carrera = pes.car_codigo 
      ORDER BY alu.apellido,alu.nombre

	  --DOCENTES POSGRADO
	  SELECT DISTINCT DOC_CODIGO, APELLIDO, NOMBRE FROM POSGRADO.dbo.DOCENTES 
	  WHERE LEN(APELLIDO) > 3 AND LEN(NOMBRE) > 3 ORDER BY APELLIDO, NOMBRE

	  --------------------FIN CargarIniciador()------------------------------------

	  ---------------------CargarCombos()------------------------------------------
	  
	  --SEDES
	  select SED_CODIGO,SED_DESCRIPCION from sedes

	  --ESTADOS
	  select * from estado
	  where est_id in(0,1,2,3)


	  --TIPO INICIADOR
	  SELECT cod_tipo,detalle FROM tipo_referente

	  --PLAN ESTUDIO
	  SELECT Car.car_codigo, Car.car_descripcion, Ples.pes_codigo, Ples.pes_descripcion 
       FROM SEDECENTRAL.DBO.carrera Car 
       INNER JOIN SEDECENTRAL.DBO.plan_estudio Ples 
       ON Car.car_codigo = ples.pes_car_codigo
       AND Car.car_fac_codigo = Ples.pes_car_fac_codigo 
       ORDER BY Ples.pes_descripcion ASC

	   --TIPO DOCUMENTO
	   SELECT tipo_documento,detalle FROM tipo_documento ORDER BY tipo_documento

	   --OBJETO
	   SELECT Cod_Obj, detalle_obj FROM objetos ORDER BY Cod_Obj

	   -------------------CargarCombos()-FIN--------------------------

	   -----------------------CargarTabla1()---------------------------
	   ---------------CARGA LA GRILLA DE LOS EXPEDIENTES---------------

	      SELECT * FROM Vista_Expedientes 
         WHERE (estado = 1 or estado = 2) 
		 and Sed_codigo = VblSedeLocal 
		AND Nro_expte LIKE '% TxtBdaEpteNro.Text %' AND ano LIKE '%TxtBdaAnio.Text%'

		--tendría que realizar el filtro por el Nro_expte y Ano  