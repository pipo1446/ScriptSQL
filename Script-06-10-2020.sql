--1.  listado de alumnos del plan 74/17 que regularizaron o promocionaron el taller de práctica profesional I
--2. listado de alumnos del plan 319/09 que regularizaron o promocionaron la materia Práctica Profesional I durante el año 2019 (sumándose al curso del plan 74/17).

--Conectar a la sede para ejecutar la consulta
SELECT ALU_APELLIDO_AL AS APELLIDO, ALU_NOMBRE_AL AS NOMBRE, MAT_DESCRIPCION AS MATERIA,PLAN_CURSADO_DESCRIPCION AS CURSO_EN_EL_PLAN,COMISION, S.SED_DESCRIPCION AS SEDE, SR.SIR_DESCRIPCION AS SIT_REVISTA,
 CASE WHEN dbo.existe_nota_promocion(com_codigo,coa_ano, coa_cuatrimestre,alu_codigo) = 0 THEN 'Regularizó' else 'PROMOCIONÓ' END as SITUACION,
 PES_DESCRIPCION AS PLAN_ALUMNO from vw_alumnos_comisiones AC
 INNER JOIN SITUACION_REVISTA SR
 ON AC.ALU_SIR_CODIGO = SR.SIR_CODIGO
 INNER JOIN SEDES S
 ON AC.COM_SED_CODIGO = S.SED_CODIGO
	where coa_ano = 2019 --año cursado
	    and pes_codigo IN(78,31) --planes
		and mat_codigo  IN(28,186) --materias
		and com_sed_codigo = 10 --CAMBIAR LA SEDE
		and alc_regularizada = 1
		AND ALC_FECHA_VIGENCIA > GETDATE()
ORDER BY PES_DESCRIPCION,SITUACION, ALU_APELLIDO_AL, ALU_NOMBRE_AL



--los alumnos que regularizaron en el 2019 y aprobaron por examen final y no se cargó la equivalencia interna en el 450/18
--Conectar a la sede para ejecutar la consulta

SELECT ALU_APELLIDO_AL AS APELLIDO, ALU_NOMBRE_AL AS NOMBRE, MAT_DESCRIPCION AS MATERIA,PLAN_CURSADO_DESCRIPCION AS CURSO_EN_EL_PLAN,COMISION, S.SED_DESCRIPCION AS SEDE, SR.SIR_DESCRIPCION AS SIT_REVISTA,
 CASE WHEN dbo.existe_nota_promocion(com_codigo,coa_ano, coa_cuatrimestre,alu_codigo) = 0 THEN 'Regularizó' else 'PROMOCIONÓ' END as SITUACION,
 PES_DESCRIPCION AS PLAN_ALUMNO from vw_alumnos_comisiones AC
 INNER JOIN SITUACION_REVISTA SR
 ON AC.ALU_SIR_CODIGO = SR.SIR_CODIGO
 INNER JOIN SEDES S
 ON AC.COM_SED_CODIGO = S.SED_CODIGO
	where ac.coa_ano = 2019 --año cursado
	    and ac.pes_codigo IN(78,31) --planes
		and ac.mat_codigo  IN(28,186) --materias
		and ac.com_sed_codigo = 4 --CAMBIAR LA SEDE
		and ac.alc_regularizada = 1
		AND ac.ALC_FECHA_VIGENCIA > GETDATE()
		--AND dbo.existe_nota_promocion(com_codigo, coa_ano, coa_cuatrimestre, alu_codigo) = 1 --promocionó
		dbo.aproboMateriaExamenFinal(alu_codigo,mat_codigo, car_codigo, fac_codigo, pes_codigo) = 1  --aprobó por examen final
		--existe en el plan nuevo
		and  exists(select * from alumnos
		               where alu_pes_codigo = 86 and alu_nro_doc_al = ac.alu_nro_doc_al
					   --el alumno se encuentra su legajo en el plan nuevo
					   -- que no tengan cargada la equivalencia de la materia Taller de Práctica Profesional de la Función Judicial(1132) 
					   and dbo.alumno_aprobo_materia_equivalencia(alu_codigo,alu_pes_codigo, alu_pes_car_fac_codigo, alu_pes_car_codigo,1132) = 0)
		

ORDER BY PES_DESCRIPCION,SITUACION, ALU_APELLIDO_AL, ALU_NOMBRE_AL