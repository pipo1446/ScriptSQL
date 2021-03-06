set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

-- =============================================
-- Author:		Christian A. Vila
-- Create date: 24/04/2020
-- Description:	Verifica si un alumno puede rendir
--				libre materia vencida
-- =============================================
CREATE FUNCTION [dbo].[PERMITE_RENDIR_LIBRE_VENCIDA]
(
	@FAC_COD		INT,
	@CAR_COD		INT,
	@PES_COD		INT,
	@MAT_COD		INT,
	@ALU_COD		INT,
	@FECHA_MESA		DATETIME,
	@FECHA_VIGENCIA	DATETIME,
	@AÑO			INT,
	@TIPO_COMISION	INT,
	@SIT_REVISTA	INT
)
RETURNS INT
AS
BEGIN
	DECLARE @CANT INT, @RESP INT, @FECHA_VERIF DATETIME
	DECLARE @SIT_REV INT, @FECHA_SIT DATETIME, @MI_SIT INT,  @MI_FECHA DATETIME

	SELECT TOP 1 @SIT_REV = HIS_SIR_CODIGO, @FECHA_SIT = HIS_FECHA
	FROM dbo.HISTORICO_SITUACION_REVISTA a
    WHERE a.HIS_ALU_CODIGO = @ALU_COD
    AND a.HIS_FECHA = (SELECT MAX(b.HIS_FECHA)
						FROM dbo.HISTORICO_SITUACION_REVISTA b
						WHERE b.HIS_ALU_CODIGO = a.HIS_ALU_CODIGO
						AND b.HIS_FECHA < @FECHA_MESA)
    ORDER BY HIS_CODIGO DESC

	IF ISNULL(@SIT_REV,0) = 0
		BEGIN

		END
	ELSE
		BEGIN
			IF @SIT_REV = OR @SIT_REV = 2 OR @SIT_REV = 3
				BEGIN
					SET @MI_SIT = @SIT_REV
					SET @MI_FECHA = @FECHA_SIT

					SELECT TOP 1 @SIT_REV = HIS_SIR_CODIGO, @FECHA_SIT = HIS_FECHA
					FROM dbo.HISTORICO_SITUACION_REVISTA a
					WHERE a.HIS_ALU_CODIGO = @ALU_COD
					AND a.HIS_FECHA = (SELECT MIN(b.HIS_FECHA)
										FROM dbo.HISTORICO_SITUACION_REVISTA b
										WHERE b.HIS_ALU_CODIGO = a.HIS_ALU_CODIGO
										AND b.HIS_FECHA > @FECHA_MESA
										AND b.HIS_SIR_CODIGO BETWEEN 5 AND 6)
					IF NOT ISNULL(@SIT_REV,0) = 0
						BEGIN
							IF @SIT_REV <> @MI_SIT
								BEGIN
									SET @FECHA_VERIF = @FECHA_SIT
									SET @RESP = 1
								END
						END
					ELSE
						BEGIN
							SET @FECHA_VERIF = CONVERT(DATETIME, CAST(GETDATE() AS VARCHAR(12)),103)
						END

				END
			ELSE
				BEGIN
					SET @FECHA_VERIF = @FECHA_VIGENCIA
				END

			IF @AÑO < 2018 OR (@AÑO = 2018 AND @TIPO_COM = 3)
                If VerificaFecha(dFecha, dFechaVerif) Then
                    PermiterendirEstadosAlumno2018 = True
                Else
                    PermiterendirEstadosAlumno2018 = False
                End If
            Else
                If ExcedioCantidadTurnos2018(dFechaVerif) Then
                    PermiterendirEstadosAlumno2018 = False
                Else
                    PermiterendirEstadosAlumno2018 = True
                End If
            End If

		END
		
	RETURN @RESP

END

