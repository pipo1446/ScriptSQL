
--intentaremos crear un procedimiento almacenado
--que verifique por nombre de pais
alter procedure Prueba_pais
as
begin
declare @index int
declare @index2 int
declare @ultimo_registro int 

declare @cod_pais_destino int
declare @pais_destino varchar(200)

DECLARE @DESCRIPCION_PAISe VARCHAR(200)
DECLARE @CODIGO_PAIS_ORIGEN INT
DECLARE @CODIGO_SEDE_PAIS INT

declare @contador int
declare @codigo_pais int
declare @usuario varchar(200)
declare @descripcion_pais varchar(200)
--declaramos variable de tabla
declare @TablaPais table(
--isno sería un id autoincremental en 1
isno int identity(1,1),
cod_pais int,
desc_pais varchar(200)
)
--DECLARAMOS OTRA variable TABLA  
--DONDE GUARDAREMOS LOS RESULTADOS
--ESTA TABLA LUEGO REEMPLAZAREMOS POR LA TABLA DE LA BASE
DECLARE @TablaIntermedia TABLE(
ID int,
ID_ORIGEN INT,
ID_DESTINO INT,
SED_CODIGO int NULL
)
--ESTA TABLA LUEGO REEMPLAZAREMOS POR LA TABLA DE LA BASE
DECLARE @TablaDestino TABLE(
IDPAIS INT,
DESCRIPCION VARCHAR(100),
DESCRIPCIONCORTA VARCHAR(10),
NACIONALIDAD VARCHAR(50),
IDUSUARIO VARCHAR(128),
ALTA DATETIME
)
--DECLARAMOS ESTA VARIABLE DONDE GUARDAMOS TODOS LOS PAISES, CON LA SEDE PARA COMPARAR
DECLARE @PAIS_SEDES TABLE(
 PAISDESCRIPCION VARCHAR(200),
 PAISCODIGO INT,
 SED_PAIS INT
)

insert into @PAIS_SEDES(PAISDESCRIPCION,PAISCODIGO,SED_PAIS)

   select lower(dbo.RemoverTildes(dbo.RemoverEspaciosEnBlanco(pai_descripcion))),  pai_codigo, 1 
   from srv10.sedecentral.dbo.pais as p_central
   union
    select lower(dbo.RemoverTildes(dbo.RemoverEspaciosEnBlanco(pai_descripcion))),pai_codigo,2 
   from srv10.sedegoya.dbo.pais as p_goya
   union
    select lower(dbo.RemoverTildes(dbo.RemoverEspaciosEnBlanco(pai_descripcion))),pai_codigo,3 
   from srv10.sedeplibres.dbo.pais as p_libres
   union
    select lower(dbo.RemoverTildes(dbo.RemoverEspaciosEnBlanco(pai_descripcion))),pai_codigo,4 
   from srv10.sedeposadas.dbo.pais as p_posadas
   union
    select  lower(dbo.RemoverTildes(dbo.RemoverEspaciosEnBlanco(pai_descripcion))),pai_codigo,5 
   from srv10.sedecuruzu.dbo.pais as p_curuzu
   union
    select lower(dbo.RemoverTildes(dbo.RemoverEspaciosEnBlanco(pai_descripcion))),pai_codigo,6 
   from srv10.sedeformosa.dbo.pais as p_formosa
   union
    select lower(dbo.RemoverTildes(dbo.RemoverEspaciosEnBlanco(pai_descripcion))),pai_codigo,8 
   from srv10.sedeavellaneda.dbo.pais as p_avellaneda
   union
    select lower(dbo.RemoverTildes(dbo.RemoverEspaciosEnBlanco(pai_descripcion))),pai_codigo,11 
   from srv10.sedespeña.dbo.pais as p_speña



select @index = 1
insert into @TablaPais(cod_pais,desc_pais)

--traigo el codigo y la descripcion del pais en la consulta y guardo en @TablaPais
select pai_codigo,lower(dbo.RemoverTildes(dbo.RemoverEspaciosEnBlanco(pai_descripcion))) from srv10.sedecentral.dbo.pais
order by pai_codigo

--guardo en @contador la cantidad de filas de @TablaPais, para recorrer fila por fila con while
select @contador = count(isno) from @TablaPais

--recorremos fila por fila
--@index va a estar en 1 como se declaro en la linea 29
while(@index < = @contador)
begin
--obtengo el primer valor de mi tabla temporal @TablaPais
 select @codigo_pais = cod_pais, @descripcion_pais = desc_pais  from @TablaPais where isno = @index

 --traemos el usuario
 select @usuario = userid from srv10.sedecentral.dbo.usuarios where userid = 'adolfos'

 --consultamos en la tabla destino y traemos algun registro que tenga el mismo nombre
 select @cod_pais_destino=idpais ,@pais_destino= lower(dbo.RemoverTildes(dbo.RemoverEspaciosEnBlanco(descripcion)))
  from @TablaDestino where lower(dbo.RemoverTildes(dbo.RemoverEspaciosEnBlanco(descripcion))) = @descripcion_pais

 

	  --CAMBIARIAMOS POR EL NOMBRE DE LA TABLA DE BASE EN LUGAR DE LA VARIABLE DE TABLA
	  --ya se inserto en la tabla lo de sedecentral, ahora tenemos que comparar
--	  insert into Paises_Destino(idpais,descripcion,descripcioncorta,nacionalidad,idusuarioAltaRegistro,altaRegistro)
--	  values(@index,@descripcion_pais,'-','-',@usuario,getdate())
	 
  
	   insert into @TablaIntermedia(id,id_origen,id_destino,sed_codigo)
       values(@index,@codigo_pais,@index,@CODIGO_SEDE_PAIS)
		  
   
	    
 --cargamos la tabla de resultado
 --CAMBIARIAMOS POR EL NOMBRE DE LA TABLA DE BASE EN LUGAR DE LA VARIABLE DE TABLA
    --    insert into @TablaIntermedia(id,id_origen,id_destino,sed_codigo)
    --    values(@index,@codigo_pais,@index,'1')

--consulto el último registro, si existe le sumo uno, caso contrario sera null y le asignare el valor 1
-- esto se haría en la tabla Paises Destino


--incrementamos en 1 el valor de la variable @index, para continuar el bucle
select @index = @index + 1
end
  select * from @TablaIntermedia
  select * from @TablaDestino
  select * from @PAIS_SEDES
end


exec Prueba_pais

















alter procedure Prueba_Pais
as
begin

 declare @si int;
 declare @ultimo_id_pd int;
declare @ultimo_id_pi int;

--verifico si existe registro en la tabla la primera vez y elimino
declare @tiene_registro int;
declare @tiene_registro_intermedio int;

--será el contador de fila
declare @index int;
declare @index2 int;

--total de lineas
declare @total_lineas int;
declare @total_lineas2 int;

--tabla temporal con todos los paises de central
declare @Paises_Central table(
isno int identity(1,1),
nombre_pais varchar(200),
codigo_pais int,
codigo_sede int
)

--tabla temporal con los paises de las demas sedes
declare @Paises_Otras_sedes table(
isno_d int identity(1,1),
nombre_pais_d varchar(200),
codigo_pais_d int,
codigo_sede_d int
)

--variables para alojar codigo_destino, nombre del pais, codigo de sede
declare @tt_codigo_destino int;
declare @tt_nombre_pais varchar(200);
declare @tt_codigo_sede int;

--variables para cargar la tabla paises_destino, solo trayendo sedecentral,las utilizo porque necesito recorrer
declare @c_nombre_pais varchar(200);
declare @c_codigo_pais int;
declare @c_codigo_sede int;

--variables para guardar los datos de la variable del resto de los paises
declare @d_nombre_pais varchar(200);
declare @d_codigo_pais int;
declare @d_codigo_sede int;

select @tiene_registro = count(*) from paises_destino
select @tiene_registro_intermedio = count(*) from paises_intermedio

-- si tiene registro en cualquiera de las tablas elimino
if (@tiene_registro > 0)
  begin
  delete  from [dbo].[Paises_Destino]
  end

if (@tiene_registro_intermedio > 0)
  begin
  delete  from paises_intermedio
  end


  --inserto todos los registros de paises en la variable de tabla @Paises
  insert into @Paises_Central(nombre_pais,codigo_pais,codigo_sede)

  --todos los paises de sede central
  --guardamos en una variable de tabla
    select lower(dbo.RemoverTildes(dbo.RemoverEspaciosEnBlanco(pai_descripcion))) ,  pai_codigo, 1 
   from srv10.sedecentral.dbo.pais as p_central
   

   --inserto los demas registros de las sedes en la variable @Paises_Otras_sedes
     insert into @Paises_Otras_sedes(nombre_pais_d,codigo_pais_d,codigo_sede_d)
	 
	 select lower(dbo.RemoverTildes(dbo.RemoverEspaciosEnBlanco(pai_descripcion))) ,pai_codigo,2 
   from srv10.sedegoya.dbo.pais as p_goya
   union
    select lower(dbo.RemoverTildes(dbo.RemoverEspaciosEnBlanco(pai_descripcion))),pai_codigo,3 
   from srv10.sedeplibres.dbo.pais as p_libres
   union
    select lower(dbo.RemoverTildes(dbo.RemoverEspaciosEnBlanco(pai_descripcion))),pai_codigo,4 
   from srv10.sedeposadas.dbo.pais as p_posadas
   union
    select  lower(dbo.RemoverTildes(dbo.RemoverEspaciosEnBlanco(pai_descripcion))),pai_codigo,5 
   from srv10.sedecuruzu.dbo.pais as p_curuzu
   union
    select lower(dbo.RemoverTildes(dbo.RemoverEspaciosEnBlanco(pai_descripcion))),pai_codigo,6 
   from srv10.sedeformosa.dbo.pais as p_formosa
   union
    select lower(dbo.RemoverTildes(dbo.RemoverEspaciosEnBlanco(pai_descripcion))),pai_codigo,8 
   from srv10.sedeavellaneda.dbo.pais as p_avellaneda
   union
    select lower(dbo.RemoverTildes(dbo.RemoverEspaciosEnBlanco(pai_descripcion))),pai_codigo,11 
   from srv10.sedespeña.dbo.pais as p_speña

   
   --inicializamos el indice
   select @index = 1
   select @index2 = 1
   


   --guardamos el total de filas, que nos va a servir para recorrer el bucle
   select @total_lineas = count(*) from @Paises_Central

   select @total_lineas2 = count(*) from @Paises_Otras_sedes 

   


   --aca ira la linea que traigo el usuario

   --este while es solo para cargar en la tabla solo los de sede central
   while (@index <= @total_lineas)
     begin
	     select @c_nombre_pais = nombre_pais,@c_codigo_pais = codigo_pais,@c_codigo_sede = codigo_sede from @Paises_Central where isno = @index 
	 --insertamos en Paises_Destino
	    insert into Paises_Destino(IdPais,Descripcion,DescripcionCorta,Nacionalidad,IdUsuarioAltaRegistro,AltaRegistro)
		       values(@index,@c_nombre_pais,'-','-','adolfo',getdate())
     
	 --luego insertamos en Paises_intermedio
	    insert into Paises_Intermedio(id, id_origen, id_sede, id_destino)
		       values(@index,@c_codigo_pais, @c_codigo_sede,@index)


	--incrementamos el valor de @index en 1
	select @index = @index + 1
	 end


	 --recorreremos las filas de las sedes e iremos comparando con lo que tenemos en base
	 while(@index2 <= @total_lineas2)
	   begin
	    
	     select @d_nombre_pais= nombre_pais_d, @d_codigo_pais=codigo_pais_d,@d_codigo_sede=codigo_sede_d from @Paises_Otras_sedes where isno_d = @index
		     
			
			 --verifico si no existe en tabla destino y lo cargo
			 select @si = count(*)  from Paises_Destino where descripcion = @d_nombre_pais
			    if(@si < 1)
				  begin
				    

					select @ultimo_id_pd = max(idPais) + 1 from Paises_Destino
					select @ultimo_id_pi = max(id) + 1 from Paises_Intermedio

				    insert into Paises_destino
					       values(@ultimo_id_pd, @d_nombre_pais,'-','-','ADOLFOS',getdate())

					insert into Paises_Intermedio
					       values(@ultimo_id_pi,@d_codigo_pais,@d_codigo_sede,@ultimo_id_pd)
				  end

				 -- if(si > 0)
				   --begin
				     --select * from Paises_Intermedio where id_destino = 
				   --end
				select @index2 = @index2 + 1
       end


end