
--PERSONAL NO DOCENTES
--INGRESARON ENTRE 2014 Y 2019
--NOMBRE, APELLIDO, FECHA NACIMIENTO, SEDE Y EL ?REA
--cambiar L.SITUACION(1 ACTIVO, 2 BAJA)

					  SELECT S1.SED_DESCRIPCION AS SEDE_LEGAJO, L.APELLIDO, L.NOMBRE, L.NUMERO_DOC,S2.SED_DESCRIPCION AS SEDE_RELACION_LABORAL, CONVERT(VARCHAR(10),L.FECHA_INGRESO,103) FECHA_INGRESO,  C.CARGO_DESCRIPCION, CONVERT(VARCHAR(10), RL.FECHA_INICIO,103) INICIO_EN_EL_CARGO, CONVERT(VARCHAR(10),FECHA_BAJA,103) FECHA_BAJA FROM LEGAJOS L
					  INNER JOIN RELACION_LABORAL RL
					  ON L.LEG_CODIGO = RL.LEG_CODIGO AND L.SEDE = RL.SEDE
					  INNER JOIN EXPEDIENTESUCP.DBO.CARGO C
					  ON RL.CARGO = C.COD_CARGO 
					  INNER JOIN SEDES S1
					  ON L.SEDE = S1.SED_CODIGO
					  INNER JOIN SEDES S2
					  ON RL.SED_CODIGO = S2.SED_CODIGO
					  WHERE RL.CARGO <> 97  AND L.SITUACION = 2 -- AND ESTADO = 2
					  AND YEAR(L.FECHA_INGRESO) BETWEEN '2014' AND '2019'
					  ORDER BY L.SEDE,RL.SED_CODIGO, L.FECHA_INGRESO,L.APELLIDO, L.NOMBRE




