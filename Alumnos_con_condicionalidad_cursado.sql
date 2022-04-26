SELECT  ALU_APELLIDO_AL, ALU_NOMBRE_AL,AC.COM_DESCRIPCION, COA_ANO, COA_CUATRIMESTRE, SR.SIR_DESCRIPCION, MIC.MIC_SITUACION FROM VW_ALUMNOS_COMISIONES AC
INNER JOIN MOTIVO_INSCRIP_CONDICIONAL MIC
ON AC.ALC_PROVISORIA = MIC.MIC_CODIGO
INNER JOIN SITUACION_REVISTA SR
ON AC.ALU_SIR_CODIGO = SR.SIR_CODIGO
WHERE COA_ANO = 2020 AND COA_CUATRIMESTRE IN(2,3)
AND ALC_PROVISORIA > 0
ORDER BY ALU_APELLIDO_AL, ALU_NOMBRE_AL


