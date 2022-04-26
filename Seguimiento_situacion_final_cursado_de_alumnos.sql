
--esta consulta es para saber si un alumno regularizó, promocionó, o quedo libre y saber el motivo
--hay que cambiar en las lineas en donde están comentadas los valores a analizar
--donde tiene los números 1,2 y 3 se debe cambiar

SELECT COM_DESCRIPCION, com_plan_raiz AS PlanRaiz, coa_ano as Año, coa_cuatrimestre as Cuat, COM_CODIGO as codCom,  
   ac.alu_nro_doc_al as Documento, ac.ALU_CODIGO as aluCod, ac.ALU_APELLIDO_AL + ', ' + ac.ALU_NOMBRE_AL as ApeNom,
   alc_estado_cursada as CurRec, convert(varchar(10),ac.alu_fecha_ingreso_al,103) as FecIngreso, ac.pes_codigo as pesCur,
   plm_ano as Curso, plm_cuatrimestre as CuatPl, ac.alu_sir_codigo as sirCod,
   mat_codigo as codMat, alc_porc_inas as porInas, case when monto_deuda > 0 then monto_deuda else 0 end as deuda,
   case when dbo.verifica_biblioteca(al.alu_codigo,bib_monto) = 1 then 'Debe' else '' end as Bibli, alc_aprobada as Aprob,
   alc_regularizada as Regul, alc_libre as libInas, alc_libre_parcial as libParc, alc_libre_tp as libTP,alc_recupera as Recup,
   noa_tipo_nota, noa_nota, convert(varchar(10),noa_fecha_nota,103) as fecNota,
   nfp_nota_oral, convert(varchar(10),nfp_fecha,103) as FecAprob, alc_inhabilitado as Inab, alc_provisoria as Prov, '' as Obs,
   ALU_CONST_TRA as CTT, ALU_COMPROMISO as compromiso, ALU_CONST_TITULO as fotTitulo, ALU_TITULO_CERTIFICADO_AL as titulo,
   ALU_PARTIDA_NAC_AL as partida, ALU_CERTIFICADO_SALUD_AL as salud, ALU_FOTOCOPIA_DNI_AL as dni, ALU_FOTOS_AL as fotos, ALU_CERTIFICADO_GRUPO_AL as grupo,
   mat_descripcion, ac.PES_DESCRIPCION as planCursada, pal.pes_descripcion as planALUMNO, convert(varchar(10),alc_fecha_insc,103) as FecInscrip
FROM dbo.VW_ALUMNOS_COMISIONES ac
left join alumnos al on ac.alu_codigo = al.alu_codigo
left join plan_estudio pal on al.alu_pes_codigo = pal.pes_codigo and al.alu_pes_car_fac_codigo = pal.pes_car_fac_codigo
left join notas_almnos na on com_codigo = noa_alc_coa_com_codigo and noa_alc_coa_ano = coa_ano
      and coa_cuatrimestre = noa_alc_coa_cuatrimestre and ac.alu_codigo = noa_alc_alu_codigo
left join notas_finales_promocionales np on com_codigo = nfp_alc_coa_com_codigo and nfp_alc_coa_ano = coa_ano
      and coa_cuatrimestre = nfp_alc_coa_cuatrimestre and ac.alu_codigo = nfp_alc_alu_codigo
left join fecha_promocionales fp on fp.fep_ano = 2019 --CAMBIAR EL AÑO PARA ANALIZAR DEUDA  --1--
and fp.fep_cuatrimestre = 2 --CAMBIAR EL CUATRIMESTRE A ANALIZAR SU DEUDA --2 --
left join deudores de on al.alu_codigo = de.alu_codigo and de.fecha_control = fp.fep_fecha_admin
left join biblioteca bb on bib_estado = 1
WHERE ((COA_ANO = 2019 AND COA_CUATRIMESTRE in (3)) or (COA_ANO = 2019 and COA_CUATRIMESTRE = 2)) --and
   and 
   (com_descripcion like '%%%') and ac.pes_descripcion like '%%' --CAMBIAR plan si corresponde y materia    
   and ac.ALU_APELLIDO_AL like '%SOTO BANGERTE%%' and ac.ALU_NOMBRE_AL like '%DAFNE%%' --COLOCAR NOMBRE Y APELLIDO A CAMBIAR --3--
   --and com_codigo in (3750,3751)
ORDER BY ac.pes_descripcion, com_descripcion, ac.ALU_APELLIDO_AL, ac.ALU_NOMBRE_AL








select alu_apellido_al + ', ' + alu_nombre_al as ApeNom, alu_nro_doc_al, de.*
from sedecentral.dbo.deudores de
left join alumnos al on de.alu_codigo = al. alu_codigo
where fecha_control >= '01/06/2019'
   --and alu_apellido_al like '%galeano%' and alu_nombre_al like '%sof'
  and de.alu_codigo = 13835
  and sed_codigo = 1
order by fecha_control desc, ApeNom

Estado = 0, está como deudor a la fecha de ejecución de la SQL.
Estado = 2, estuvo como deudor en la fecha de proceso.

Si aparece con ESTADO en 0 o en 2, en la fecha de proceso 19/06/2018, no le corresponde la promoción




sp_helptext ALUMNOS_WEB_GET_MATERIAS_FECHA_EXAMEN_P


, cev_mat_codigo AS MAT_CODIGO


-- =============================================    
-- Author:  RENE    
-- Create date: <Create Date,,>    
-- Description: <Description,,>    
-- =============================================    
ALTER PROCEDURE [dbo].[ALUMNOS_WEB_GET_MATERIAS_FECHA_EXAMEN_P]      
     --[ALUMNOS_WEB_GET_MATERIAS_FECHA_EXAMEN_P]  11468,1    
                    -- SELECT DBO.ALUMNOS_WEB_GET_CANTCAT_MATERIAS_FECHA_P_SEDE (11468,'17/04/2018',1)    
    
 @ALU_CODIGO INT,    
 @CUATRIMESTRE INT     
AS    
BEGIN    
 SET NOCOUNT ON;    
    
--WITH materias_fechas (fecha,materias)      
--AS      
--(      
 -- SELECT convert(varchar, FECHA, 103) AS FECHA,convert(varchar, FECHA, 103) + ' | ' + DBO.ALUMNOS_WEB_GET_CANTCAT_MATERIAS_FECHA_P_SEDE    
 --(    
 --@ALU_CODIGO,    
 --FECHA,@CUATRIMESTRE     
 --) AS MATERIAS    
  SELECT convert(varchar, FECHA, 103) AS FECHA, convert(varchar, FECHA, 103) + ' | ' + MAT_DESCRIPCION AS MATERIAS, cev_mat_codigo AS MAT_CODIGO    
    FROM VW_LISTA_MATERIA_FECHAS_PARCIALES    
 WHERE    
 CEV_PES_CODIGO =(SELECT ALU_PES_CODIGO FROM dbo.ALUMNOS WHERE ALU_CODIGO = @ALU_CODIGO)    
 AND DATEDIFF(day,FECHA, GETDATE())<=30     
 AND CEV_ANO = YEAR(GETDATE())    
 AND FECHA <= GETDATE()    
 AND CEV_CUATRIMESTRE IN (@CUATRIMESTRE,3,4)    
 AND CEV_MAT_CODIGO IN (    
 SELECT MAT_CODIGO FROM dbo.VW_ALUMNOS_COMISIONES AC     
 WHERE AC.ALU_CODIGO = @ALU_CODIGO     
 AND AC.PES_CODIGO=(SELECT ALU_PES_CODIGO FROM dbo.ALUMNOS WHERE ALU_CODIGO = @ALU_CODIGO)    
 AND COA_ANO = YEAR(GETDATE())    
 AND COA_CUATRIMESTRE IN (@CUATRIMESTRE,3,4)    
 GROUP BY MAT_CODIGO)      
 --se agregó la condición del código del alumno porque traía la fecha de los de resistencia o viceversa - ADOLFO 15/04/2019    
 AND CEV_ALU_CODIGO  = @ALU_CODIGO  
 --)    
 --select * from materias_fechas GROUP BY fecha,materias     
      
END   


SP_HELPTEXT ALUMNOS_WEB_SOLICITAR_TRAMITE
 
 -- =============================================  
-- Author:  RENE  
-- Create date: 26/04/2013  
-- Description: INSERTA TRAMITE, SI EXISTE UNO PENDIENTE DEL MISMO TIPO DEVUELVE CERO  
-- =============================================  
CREATE PROCEDURE [dbo].[ALUMNOS_WEB_SOLICITAR_TRAMITE]  
 @ALU_CODIGO INT,  
 @SEDE INT,  
 @ID_TIPO_TRAMITE INT,  
 @DIRIGIDO_A NVARCHAR(MAX),  
 @MATERIA NVARCHAR(MAX) =NULL,  
 @FECHA_EXAMEN DATETIME = NULL,  
 @OBSERVACIONES nvarchar(max)=NULL,  
 @OPERACION INT = NULL  
AS  
BEGIN  
 SET NOCOUNT ON;  
--inicio de variables  
DECLARE @TRAMITE_PENDIENTE INT  
SET @TRAMITE_PENDIENTE=0  
--  
-- validacion tramite tipo 1,2,3  
IF(@ID_TIPO_TRAMITE=2 or @ID_TIPO_TRAMITE=3 )  
begin  
SET @TRAMITE_PENDIENTE=(SELECT COUNT(*) FROM [ALUMNOS_WEB_TRAMITES]   
      WHERE ALU_CODIGO = @ALU_CODIGO AND SEDE = @SEDE AND ID_TIPO_TRAMITE = @ID_TIPO_TRAMITE  
      AND ESTADO = 1 AND MATERIA =@MATERIA)  
end  
else  
begin  
SET @TRAMITE_PENDIENTE=(SELECT COUNT(*) FROM [ALUMNOS_WEB_TRAMITES]   
      WHERE ALU_CODIGO = @ALU_CODIGO AND SEDE = @SEDE AND ID_TIPO_TRAMITE = @ID_TIPO_TRAMITE  
      AND ESTADO = 1)   
END  
  
IF (@TRAMITE_PENDIENTE <= 4)  
BEGIN  
  
declare @ID_TRAMITE INT  
  
 IF (@OPERACION = 1)  
 BEGIN  
     INSERT INTO [dbo].[ALUMNOS_WEB_TRAMITES]  
           ([ALU_CODIGO]  
           ,[SEDE]  
           ,[ID_TIPO_TRAMITE]  
           ,[ESTADO]  
           ,[DIRIGIDO_A]  
           ,[OBSERVACIONES_UCP]  
           ,[FECHA]  
           ,[MATERIA]  
           ,[FECHA_EXAMEN])  
     VALUES  
     (@ALU_CODIGO,@SEDE,@ID_TIPO_TRAMITE,1,@DIRIGIDO_A,@OBSERVACIONES,GETDATE(),NULL,NULL)  
   SET @ID_TRAMITE=(SELECT scope_identity())  
  INSERT INTO [dbo].[ALUMNOS_WEB_HISTORIAL_TRAMITES]  
          ([ID_TRAMITE]  
          ,[DETALLE]  
          ,[FECHA])  
       VALUES  
          (@ID_TRAMITE,'TRAMITE INICIADO POR EL ALUMNO',GETDATE())  
 END    
 IF (@OPERACION = 2)  
 BEGIN  
     INSERT INTO [dbo].[ALUMNOS_WEB_TRAMITES]  
           ([ALU_CODIGO]  
           ,[SEDE]  
           ,[ID_TIPO_TRAMITE]  
           ,[ESTADO]  
           ,[DIRIGIDO_A]  
           ,[OBSERVACIONES_UCP]  
           ,[FECHA]  
           ,[MATERIA]  
           ,[FECHA_EXAMEN])  
     VALUES  
     (@ALU_CODIGO,@SEDE,@ID_TIPO_TRAMITE,1,@DIRIGIDO_A,NULL,GETDATE(),@MATERIA,@FECHA_EXAMEN)  
      SET @ID_TRAMITE=(SELECT scope_identity())  
  
   INSERT INTO [dbo].[ALUMNOS_WEB_HISTORIAL_TRAMITES]  
        ([ID_TRAMITE]  
        ,[DETALLE]  
        ,[FECHA])  
     VALUES  
        (@ID_TRAMITE,'TRAMITE INICIADO POR EL ALUMNO',GETDATE())  
 END     
  
  
  
  
SELECT  @ID_TRAMITE  
  
END   
ELSE  
BEGIN  
 SELECT 0  
END  
   
END  --END PROCEDURE