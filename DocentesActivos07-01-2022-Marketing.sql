
DECLARE @PROFESOR INT, @ACTIVO INT
SET @PROFESOR = 97
SET @ACTIVO = 1

SELECT DISTINCT APELLIDO, NOMBRE, MAIL, MAIL_2 FROM LEGAJOS L
INNER JOIN RELACION_LABORAL RL
ON L.LEG_CODIGO = RL.LEG_CODIGO
AND L.SEDE = RL.SEDE
AND RL.CARGO = @PROFESOR
AND (RL.FECHA_FIN > GETDATE() OR RL.FECHA_FIN IS NULL)
AND RL.ESTADO = @ACTIVO
AND SITUACION = @ACTIVO

ORDER BY APELLIDO, NOMBRE

--personas que tiene relaciòn laboral como profesor de grado activas con situación de revista activas en sus legajos
-- no significa que estén o por estar designados en alguna comisión.