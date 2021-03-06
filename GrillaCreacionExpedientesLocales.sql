

--esta consulta es para cargar la grilla de creación de expedientes locales(SEDECENTRAL)
SELECT ID, ANO,SED_DESCRIPCION, SED_CODIGO,ESTADO,FECHA_CREACION_REG, 
FECHA_HORA_INICIAL,COD_OBJ,FAC_CODIGO,NRO_EXPTE,Detalle_Obj, 
TIPO_INICIADOR,FECHA_TENTATIVA,COD_INICIADOR,est_desc, EEV.Expte_FecPas, EEV.Expte_Per_Max, EEV.Expte_ConPase,
CASE TIPO_INICIADOR WHEN 1 THEN (SELECT DISTINCT TOP 1 APELLIDO +','+ NOMBRE FROM SEDECENTRAL.dbo.LEGAJOS L INNER JOIN SEDECENTRAL.dbo.RELACION_LABORAL RL ON L.LEG_CODIGO = RL.LEG_CODIGO AND RL.SEDE = L.SEDE AND RL.CARGO = 97 WHERE RL.LEG_CODIGO = VE.COD_INICIADOR  AND RL.SEDE = VE.SED_CODIGO ) --DOCENTES
					WHEN 2 THEN (SELECT INICIADOR FROM VW_ALUMNOS_SEDES WHERE ALU_CODIGO = VE.COD_INICIADOR AND ALU_SED_CODIGO = VE.SED_CODIGO) --ALUMNOS
                    WHEN 3 THEN (SELECT RTRIM(PA.APELLIDO) +', '+ PA.NOMBRE  FROM ASIGNACION A INNER JOIN PERSONAL_ADMIN PA ON A.COD_PERSONAL = PA.COD_PERSONAL WHERE A.ID = VE.COD_INICIADOR ) --PERSONAL ADMINISTRATIVO
					WHEN 4 THEN (SELECT INICIADOR FROM VW_ALUMNOS_SEDES WHERE ALU_CODIGO = VE.COD_INICIADOR AND ALU_SED_CODIGO = VE.SED_CODIGO) --EGRESADOS
                    WHEN 5 THEN (SELECT  PER_APE+ ', '+PER_NOM FROM PersonasExternas WHERE PER_ID = VE.COD_INICIADOR  ) --PERSONAS EXTERNAS
					WHEN 6 THEN (SELECT APELLIDO +', '+NOMBRE FROM POSGRADO.dbo.ALUMNOS WHERE ALU_CODIGO = VE.COD_INICIADOR ) -- ALUMNOS POSGRADO
					WHEN 7 THEN (SELECT APELLIDO +','+ NOMBRE FROM POSGRADO.dbo.DOCENTES WHERE DOC_CODIGO =  VE.COD_INICIADOR) --DOCENTES POSGRADO

 END AS INICIADOR
FROM Vista_Expedientes VE

CROSS APPLY dbo.Estado_Expte_Varios(VE.ID, VE.COD_OBJ) EEV
WHERE ESTADO IN(1,2) 
AND SED_CODIGO = 1 -- esto cambia en base a la sede
ORDER BY VE.ANO DESC, VE.NRO_EXPTE DESC


CREATE FUNCTION [dbo].[Estado_Expte_Varios](@Id INT, @PrmCodObj int)    --59240, 205
--ESTA FUNCIÓN SOLO SE UTILIZA PARA DETERMINAR EL COLOR DE LAS FILAS DE LA GRILLA DE ABM, PASES, CIERRE EXPEDIENTES  
RETURNS @TablaEstado TABLE     
(    
Expte_FecPas DATETIME  NULL,    
Expte_Per_Max Int null,    
Expte_ConPase int not null    
)    
--Expte_Fec_Hs_PaseOrigen DATETIME NOT NULL,    
AS    
BEGIN    
 DECLARE @VbCodPers INT, @VbCantPas INT, @VbCodOfi INT     
 DECLARE @VbFecPas DATETIME    
 DECLARE @VbPerMax INT  
 --, @VerifNulo INT    
   
     
 SELECT @VbCantPas = ISNULL(COUNT(*),0) FROM Pases WHERE Id = @Id    

 --@VbCantPas = 2

 SET @VbPerMax = 0    
 IF @VbCantPas > 0  --TIENE PASES EL EXPEDIENTE  
  BEGIN    

select * from PASES where ID = 59240

select * from PASES p
INNER JOIN MESA_ENTRADA ME
ON p.ID = ME.ID
where p.COD_PERSONAL_ORIGEN = 0
and YEAR (p.FECHA_HORA_PASE_ORIGEN) = 2021
AND ME.ESTADO IN(1,2)
AND ME.SED_CODIGO = 1


  --@VbCodPers = 600
  --@VbFecPas = 17/05/2021

   SELECT @VbCodPers = Cod_Personal_Origen, @VbFecPas= Fecha_Hora_Pase_Origen     
    FROM Pases    
    WHERE  Id = @Id AND    
    Nro_Pase = (SELECT MAX(Nro_Pase) FROM Pases WHERE Id = @Id)  
       
BEGIN    
   IF @VbCodPers = 0  --PASE SIN RECEPCIÓN, no recibió el area destino, pero realizó pase para seguir curso del expediente
   
     --BUSCAR EL DESTINATARIO
    SELECT @VbCodPers = Cod_Personal_Destino, @VbFecPas= Fecha_Hora_Pase_Destino     
    FROM Pases    
    WHERE  Id = @Id AND    
    Nro_Pase = (SELECT MAX(Nro_Pase) FROM Pases WHERE Id = @Id)  
 END    
      
   --Obtengo el codigo de oficina q junto con el codObj me van ayudar a determinar el permax    
   SELECT  COD_OFICINA FROM Asignacion INNER JOIN Cargo    
   ON Asignacion.Cod_Cargo = Cargo.Cod_Cargo     
   WHERE 560 = Asignacion.Id    
      
   --Una vez obtenido el codOfi busco el periodoMax para dicho obj y Cargo    
   SELECT  Periodo_Max FROM Periodos_Max    
   WHERE Cod_Obj = 205 AND Cod_Oficina = 3    
  
          
   --Si la consulta anterior no obtiene el permax tiene q asumir como valor por defecto 2    
   BEGIN    
    IF @VbPerMax = 0     
     SET @VbPerMax = 2    
   END      
  END    
 ELSE IF @VbCantPas = 0    
  BEGIN    
   SET @VbPerMax = 2    
  END     
BEGIN    
 insert @TablaEstado    
 select @VbFecPas, @VbPerMax, @VbCantPas --FECHA_ENVIO O RECEPCION,PERÍODO MAXIMO QUE ESTÁ EN LA OFICINA, CANTIDAD DE PASES DEL EXPEDIENTE   
END    
      
RETURN     
END    
    
    
