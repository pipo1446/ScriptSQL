
--codigo de respaldo
--del procedimiento almacenado DOCENTE_WEB_ASISTENCIAS_QR
select  CASE WHEN AQR.ASISTENCIA IS NULL THEN 'AUSENTE(NO Marc� Asistencia)' 
                  WHEN AQR.ASISTENCIA = 'AUSENTE' THEN 'AUSENTE(Marc� > 30 Min)'
				  ELSE AQR.ASISTENCIA END ASISTENCIA,
	   AQR.DOCENTE_HABILITA_ASISTENCIA, AQR.ALUMNO_REGISTRA_ASISTENCIA, AQR.diferencia_segundos,
	   AQR.SED_CODIGO, AQR.COM_CODIGO,AQR.A�O, AQR.CUATRIMESTRE, AQR.FECHA_QR, AQR.IAL_FECHA_CREAC_REG, 
	   AQR.IAL_FECHA_INASISTENCIA, AQR.IAL_CANTIDAD, AQR.IAL_FALTAS, AQR.IAL_JUSTIFICA, aqr.IAL_SANCION,
	   AC.COM_DESCRIPCION, AC.PES_DESCRIPCION, AC.APELLIDO,AC.ALU_NRO_DOC_AL,AC.ALU_SIR_CODIGO,AC.PLM_TIPO,
	   AC.PLM_REM_CODIGO_REGIMEN,AC.REM_DESCRIPCION,AC.HORARIO,AC.COM_SED_CODIGO, AC.SED_DESCRIPCION,
	   AC.CAR_DESCRIPCION, AC.FAC_DESCRIPCION, AC.MAT_DESCRIPCION, AC.COM_PLAN_RAIZ, AC.PLAN_CURSADO_DESCRIPCION,
	   AQR.DIA,AQR.horario_Desde, AQR.horario_Hasta, AQR.DOCENTE,AC.PLM_ANO, AC.PLM_CUATRIMESTRE, AQR.INFO_DISPOSITIVO, 
	   DC.DOCENTE
	 

      from srvsql.SEDEGOYA.dbo.vw_alumnos_comisiones AC
       LEFT OUTER JOIN VW_ASISTENCIA_ALUMNOS_QR_CENTRAL AQR
       ON AC.COM_CODIGO = AQR.COM_CODIGO AND AC.COA_ANO = AQR.A�O AND AC.COA_CUATRIMESTRE = AQR.CUATRIMESTRE AND AC.ALU_CODIGO = AQR.ALU_CODIGO

	   INNER JOIN SRVSQL.SEDEGOYA.DBO.VW_DOCENTES_COMISIONES DC --OBTENGO EL DOCENTE DE LA COMISI�N
      ON AC.COM_CODIGO = DC.cdo_coa_com_codigo     AND AC.COA_ANO= DC.cdo_coa_ano  AND AC.COA_CUATRIMESTRE = DC.cdo_coa_cuatrimestre

      where AC.com_codigo = @COD_COMISION  and AC.coa_ano = @A�O and AC.coa_cuatrimestre = @CUATRIMESTRE AND AC.COM_SED_CODIGO = @SED_CODIGO
	   AND AC.PES_CODIGO = @COD_PLAN AND AC.FAC_CODIGO = @COD_FACULTAD AND AC.CAR_CODIGO =@COD_CARRERA
	  AND AC.MAT_CODIGO = @COD_MATERIA--METODOLOG�A DE LA INVESTIGACI�N
	  and aqr.IAL_FECHA_INASISTENCIA = @FECHA
	 order by ac.apellido