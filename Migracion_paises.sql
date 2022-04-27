
--intentaremos crear un procedimiento almacenado
--que verifique por nombre de pais
create procedure Prueba_pais
as
begin
declare @index int
declare @index2 int
declare @ultimo_registro int null
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
DECLARE @TablaIntermedia TABLE(
ID int,
ID_ORIGEN INT,
ID_DESTINO INT,
SED_CODIGO int NULL
)

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
 --select @usuario = userid from srv10.sedecentral.dbo.usuarios where userid = 'adolfos'
 --cargamos la tabla de resultado
 insert into @TablaIntermedia(id,id_origen,id_destino,sed_codigo)
        values(@index,@codigo_pais,@codigo_pais,@usuario,'1')

--consulto el último registro, si existe le sumo uno, caso contrario sera null y le asignare el valor 1
-- esto se haría en la tabla Paises Destino


--incrementamos en 1 el valor de la variable @index, para continuar el bucle
select @index = @index + 1
end
  select * from @TablaIntermedia
end


exec Prueba_pais








