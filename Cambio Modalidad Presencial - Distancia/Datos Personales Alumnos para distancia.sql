



--Select  * from information_schema.columns WHERE TABLE_NAME='fotos'

--referente a la pestaña DOMICILIOS 
/*VOY A TENER QUE RELACIONAR CON ALUMNOS PARA SABER EL ID QUE LO NECESITA DISTANCIA*/
 selecT TOP 1 * from domicilios
select TOP 1 * from pais
select TOP 1 * from provincia
select TOP 1 * from localidad

--referente a estudios en la pestaña ESTUDIOS_CURSADOS
select TOP 1 * from estudios_cursados
select top 1 * from instituciones 
select top 1 * from instituciones_sedes
select TOP 1 * from tipo_institucion
select TOP 1 * from titulos 

--para obtener la foto que se necesita pasar
select * from fotos
--ALUMNOS Y FOTOS SE RELACIONAN MEDIANTE DNI
--los datos necesarios del alumno para distancia
select * from alumnos

--TIPO_DOMICILIO
SELECT * FROM DOMINIOS
WHERE DOM_DOMINIO = 105

--SITUACIÓN FINAL DEL ESTUDIO CURSADO
select * from dominios
where dom_dominio = 111

--SI ES PUBLICA O PRIVADA LA INSTITUCIÓN
select * from dominios
where dom_dominio = 109

--SI ADEUDA MATERIAS EN ESTUDIOS CURSADOS(Si/No)
select * from dominios
where dom_dominio = 2

--TIPO DE INSTITUCIÓN (secundaria, terciaria, universitaria, etc)
--LO PUEDO OBTENER DE TIPO_INSTITUCION
select * from dominios
where dom_dominio = 110


SELECT * FROM TIPO_DOCUMENTO --(dni, cedula, pasaporte,etc)

--DATOS FAMILIARES, esto no tienen al parecer distancia
SELECT * FROM DATOS_PADRE_MADRE
SELECT * FROM NIVEL_ESTUDIO --(DPM_NIV_CODIGO de DATOS_PADRE_MADRE)
SELECT * FROM TITULOS --(DPM_TIT_CODIGO de DATOS_PADRE_MADRE)
SELECT * FROM DOMINIOS WHERE DOM_DOMINIO = 107 --(DPM_OCUPACION de DATOS_PADRE_MADRE)




select * from sys.key_constraints
where type = 'pk'
