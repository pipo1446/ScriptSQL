

SELECT     PASES.NRO_PASE AS id, MESA_ENTRADA.NRO_EXPTE AS Nro, MESA_ENTRADA.ANO AS Ano, SEDES.SED_DESCRIPCION AS Sede, 
                      (CASE WHEN OFICINAS.DETALLE IS NULL THEN '<Sin datos>' ELSE OFICINAS.DETALLE END) AS Origen, OFICINAS_1.DETALLE AS Destino, 
                      CONVERT(VARCHAR, PASES.FECHA_HORA_PASE_ORIGEN, 103) AS Fecha, PASES.ID AS id2, ASIGNACION.ID AS asignacion
FROM         OFICINAS RIGHT OUTER JOIN
                      OFICINAS AS OFICINAS_1 
					   RIGHT OUTER JOIN
                      PASES INNER JOIN
                      MESA_ENTRADA ON PASES.ID = MESA_ENTRADA.ID INNER JOIN
                      SEDES ON MESA_ENTRADA.SED_CODIGO = SEDES.SED_CODIGO INNER JOIN
                      PERSONAL_ADMIN INNER JOIN
                      ASIGNACION ON PERSONAL_ADMIN.COD_PERSONAL = ASIGNACION.COD_PERSONAL INNER JOIN
                      CARGO ON ASIGNACION.COD_CARGO = CARGO.COD_CARGO INNER JOIN
                      OFICINAS AS OFICINAS_2 ON CARGO.COD_OFICINA = OFICINAS_2.COD_OFICINA 
					  ON PASES.COD_OFI_PER_DES = OFICINAS_2.COD_OFICINA 
					  ON OFICINAS_1.COD_OFICINA = PASES.COD_OFI_PER_DES 
					  ON OFICINAS.COD_OFICINA = PASES.COD_OFI_PER_ORI
WHERE     (PASES.FECHA_HORA_PASE_DESTINO IS NULL) AND (PERSONAL_ADMIN.USERID = 'adolfos') AND (MESA_ENTRADA.ESTADO = 1 OR MESA_ENTRADA.ESTADO = 2) AND (dbo.ultimopase(PASES.ID,PASES.NRO_PASE) = 1)
			AND ((ASIGNACION.VIGENTE_HASTA IS  NULL) OR (ASIGNACION.VIGENTE_HASTA > GETDATE()))

--LOS EXPEDIENTES QUE TODAVIA NO SE RECEPCIONARON EN LA OFICINA DEL USUARIO LOGEADO
--CONSULTA MODIFICADA PARA ENTENDERLA
select p.nro_pase as id, me.nro_expte, me.ano,s.sed_descripcion as sede_expediente,
o.detalle origen, ofi.detalle destino,convert(varchar(10), p.fecha_hora_pase_origen,103) as fecha_origen_del_pase, 
p.id as id2, a.id as asignacion from pases p
inner join mesa_entrada me
on p.id = me.id
inner join sedes s
on me.sed_codigo = s.sed_codigo
inner join oficinas o
on p.cod_ofi_per_ori = o.cod_oficina
inner join oficinas ofi
on p.cod_ofi_per_des = ofi.cod_oficina
inner join cargo c
on ofi.cod_oficina = c.cod_oficina
inner join asignacion a
on c.cod_cargo = a.cod_cargo
inner join personal_admin pa
on a.cod_personal = pa.cod_personal
where (p.fecha_hora_pase_destino is null) and (pa.userid = 'adolfos')
and (me.estado = 1 or me.estado = 2)
and (dbo.ultimopase(p.id,p.nro_pase) = 1)
and ((a.vigente_hasta is null) or (a.vigente_hasta > getdate()))

-----------------------------------------------------------------------------------------------------------------------------
SELECT     PASES.NRO_PASE AS id, MESA_ENTRADA.NRO_EXPTE AS Nro, MESA_ENTRADA.ANO AS Ano, SEDES.SED_DESCRIPCION AS Sede, 
                      (CASE WHEN OFICINAS.DETALLE IS NULL THEN '<Sin datos>' ELSE OFICINAS.DETALLE END) AS Origen,
					   OFICINAS_1.DETALLE AS Destino, 
                      CONVERT(VARCHAR, PASES.FECHA_HORA_PASE_ORIGEN, 103) AS Fecha, PASES.ID AS id2
FROM         OFICINAS AS OFICINAS_1 RIGHT OUTER JOIN
                      PASES INNER JOIN
                      MESA_ENTRADA ON PASES.ID = MESA_ENTRADA.ID INNER JOIN
                      SEDES ON MESA_ENTRADA.SED_CODIGO = SEDES.SED_CODIGO INNER JOIN
                      PERSONAL_ADMIN INNER JOIN
                      ASIGNACION ON PERSONAL_ADMIN.COD_PERSONAL = ASIGNACION.COD_PERSONAL INNER JOIN
                      CARGO ON ASIGNACION.COD_CARGO = CARGO.COD_CARGO INNER JOIN
                      OFICINAS AS OFICINAS_2 ON CARGO.COD_OFICINA = OFICINAS_2.COD_OFICINA ON PASES.COD_OFI_PER_ORI = OFICINAS_2.COD_OFICINA ON 
                      OFICINAS_1.COD_OFICINA = PASES.COD_OFI_PER_DES LEFT OUTER JOIN
                      OFICINAS ON PASES.COD_OFI_PER_ORI = OFICINAS.COD_OFICINA
WHERE     (PASES.FECHA_HORA_PASE_DESTINO IS NULL) AND (PERSONAL_ADMIN.USERID = 'ADOLFOS') AND ((MESA_ENTRADA.ESTADO = 1) OR (MESA_ENTRADA.ESTADO = 2))  AND (dbo.ultimopase(PASES.ID,PASES.NRO_PASE) = 1) 
			AND ((ASIGNACION.VIGENTE_HASTA IS  NULL) OR (ASIGNACION.VIGENTE_HASTA > GETDATE()))

--todos los expedientes enviados de la oficina del usuario logeado pero que no fueron recepcionados 
--por las correspondientes areas.
--CONSULTA MODIFICADA PARA ENTENDERLA
select p.nro_pase as id, me.nro_expte, me.ano,s.sed_descripcion as sede_expediente,
o.detalle origen, ofi.detalle destino,convert(varchar(10), p.fecha_hora_pase_origen,103) as fecha_origen_del_pase, 
p.id as id2, a.id as asignacion from pases p
inner join mesa_entrada me
on p.id = me.id
inner join sedes s
on me.sed_codigo = s.sed_codigo
inner join oficinas o
on p.cod_ofi_per_ori = o.cod_oficina
inner join oficinas ofi
on p.cod_ofi_per_des = ofi.cod_oficina
inner join cargo c
on o.cod_oficina = c.cod_oficina
inner join asignacion a
on c.cod_cargo = a.cod_cargo
inner join personal_admin pa
on a.cod_personal = pa.cod_personal
where (p.fecha_hora_pase_destino is null) and (pa.userid = 'ADOLFOS')
and (me.estado = 1 or me.estado = 2)
and (dbo.ultimopase(p.id,p.nro_pase) = 1)
and ((a.vigente_hasta is null) or (a.vigente_hasta > getdate()))


--------------------------------------------------------------------------------------------------------------------------------------
		


--ESTA CONSULTA OBTIENE LOS EXPDIENTES DEMORADOS EN LA OFICINA DEL USUARIO LOGEADO
SELECT PASES_1.NRO_PASE AS id, MESA_ENTRADA.NRO_EXPTE AS Nro, MESA_ENTRADA.ANO AS Ano, SEDES.SED_DESCRIPCION AS Sede, 
                      (CASE WHEN OFICINAS.DETALLE IS NULL THEN '<Sin datos>' ELSE OFICINAS.DETALLE END) AS Origen, RTRIM(PERSONAL_ADMIN.APELLIDO) 
                      + ', ' + RTRIM(PERSONAL_ADMIN.NOMBRE) AS apellido, CONVERT(VARCHAR, PASES_1.FECHA_HORA_PASE_DESTINO, 103) AS Fecha, 
                      MESA_ENTRADA.ID AS Expr1, MESA_ENTRADA.COD_OBJ,PASES_1.ID AS ID2
FROM         PERSONAL_ADMIN RIGHT OUTER JOIN
                      ASIGNACION RIGHT OUTER JOIN
                      PASES AS PASES_1 INNER JOIN
                      MESA_ENTRADA ON PASES_1.ID = MESA_ENTRADA.ID INNER JOIN
                      SEDES ON MESA_ENTRADA.SED_CODIGO = SEDES.SED_CODIGO LEFT OUTER JOIN
                      PERSONAL_ADMIN AS PERSONAL_ADMIN_1 INNER JOIN
                      ASIGNACION AS ASIGNACION_1 ON PERSONAL_ADMIN_1.COD_PERSONAL = ASIGNACION_1.COD_PERSONAL INNER JOIN
                      CARGO ON ASIGNACION_1.COD_CARGO = CARGO.COD_CARGO INNER JOIN
                      OFICINAS AS OFICINAS_2 ON CARGO.COD_OFICINA = OFICINAS_2.COD_OFICINA
					   ON PASES_1.COD_OFI_PER_DES = OFICINAS_2.COD_OFICINA
					   ON ASIGNACION.ID = PASES_1.COD_PERSONAL_DESTINO 
					   LEFT OUTER JOIN  OFICINAS 
					  ON PASES_1.COD_OFI_PER_DES = OFICINAS.COD_OFICINA
					  ON PERSONAL_ADMIN.COD_PERSONAL = ASIGNACION.COD_PERSONAL
WHERE     (NOT (PASES_1.FECHA_HORA_PASE_DESTINO IS NULL)) AND (PERSONAL_ADMIN_1.USERID = 'ADOLFOS') AND (MESA_ENTRADA.ESTADO = 1 OR
                      MESA_ENTRADA.ESTADO = 2)   AND (dbo.ultimopase(PASES_1.ID,PASES_1.NRO_PASE) = 1)
			AND ((ASIGNACION_1.VIGENTE_HASTA IS  NULL) OR (ASIGNACION_1.VIGENTE_HASTA > GETDATE()))
ORDER BY ASIGNACION.ID DESC



--debería traer los expedientes que no fueron recepcionados todavia


PASES_1.NRO_PASE AS id, MESA_ENTRADA.NRO_EXPTE AS Nro, MESA_ENTRADA.ANO AS Ano, SEDES.SED_DESCRIPCION AS Sede, 
                      (CASE WHEN OFICINAS.DETALLE IS NULL THEN '<Sin datos>' ELSE OFICINAS.DETALLE END) AS Origen, RTRIM(PERSONAL_ADMIN.APELLIDO) 
                      + ', ' + RTRIM(PERSONAL_ADMIN.NOMBRE) AS apellido, CONVERT(VARCHAR, PASES_1.FECHA_HORA_PASE_DESTINO, 103) AS Fecha, 
                      MESA_ENTRADA.ID AS Expr1, MESA_ENTRADA.COD_OBJ,PASES_1.ID AS ID2

select p.id, me.nro_expte,me.ano, o.detalle destino,convert(varchar(10),p.fecha_hora_pase_destino,103), 
       me.id, me.cod_obj, p.id as id2 from personal_admin pa
inner join asignacion a
on pa.cod_personal = a.cod_personal
inner join cargo c
on a.cod_cargo = c.cod_cargo
inner join oficinas o
on c.cod_oficina = o.cod_oficina
inner join pases p
on o.cod_oficina = p.cod_ofi_per_des
inner join mesa_entrada me
on p.id = me.id
where pa.userid = 'adolfos' 
and p.id = 11411
and p.fecha_hora_pase_destino is null
and (me.estado = 1 or me.estado = 2) --en trámite o re-activo
and (a.vigente_hasta is null or a.vigente_hasta > getdate())--para determinar si esta vigente el personal en el cargo
except

select p.id, p.nro_pase, o.detalle destino from personal_admin pa
inner join asignacion a
on pa.cod_personal = a.cod_personal
inner join cargo c
on a.cod_cargo = c.cod_cargo
inner join oficinas o
on c.cod_oficina = o.cod_oficina
inner join pases p
on o.cod_oficina = p.cod_ofi_per_des
inner join mesa_entrada me
on p.id = me.id
where pa.userid = 'adolfos' 
and p.fecha_hora_pase_destino is null
and p.id = 11411
and (me.estado = 1 or me.estado = 2) --en trámite o re-activo
and (a.vigente_hasta is null or a.vigente_hasta > getdate())--para determinar si esta vigente el personal en el cargo

and dbo.ultimopase(p.id, p.nro_pase)= 1 --determina que sea la oficina del que se logeo el último en recibir el expediente
                                        -- y no uno anterior y que se haya realizado un pase sin recepción, es decir
										-- que p.fecha_hora_pase_destino sea null pero su nro_pase sea 2 y el maximo
										--nro_pase para ese id sea 4

sp_helptext 'dbo.ultimopase'

ALTER FUNCTION UltimoPase (@id_expte int,@nro_pase int)  
RETURNS BIT  
AS  

BEGIN  
DECLARE @MAXIMOEXPTE INT  
DECLARE @DEVOLVER BIT  
SET @DEVOLVER = 0  
SET @MAXIMOEXPTE = (SELECT MAX(NRO_PASE) FROM PASES WHERE ID = @ID_EXPTE)  
IF @MAXIMOEXPTE = @NRO_PASE  
 BEGIN  
 SET @DEVOLVER = 1  
 END  
  
RETURN @DEVOLVER  
END  

select * from pases where id = 16923
and fecha_hora_pase_destino is null

select max(nro_pase) from pases 
where id = 13407

select * from mesa_entrada
where id = 16923







