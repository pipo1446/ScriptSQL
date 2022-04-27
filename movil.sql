


--consultas
declare @dni int 
declare @UserId int
declare @id nvarchar(128)

set @dni=44652670
select * from srv10.sedeposadas.dbo.alumnos where alu_nro_doc_al=@dni

select @UserId=UserId from srv114.movil.[dbo].[Users]
where dni =@dni
select @id=id from srv114.movil.[dbo].[AspNetUsers]
where email = (select email from srv114.movil.[dbo].[Users]
where dni =@dni)

select * from srv114.movil.[dbo].[Users]
where dni =@dni
select * from srv114.movil.[dbo].[AspNetUsers]
where email = (select email from srv114.movil.[dbo].[Users]
where dni =@dni)

select @id,@UserId

--nuevo email
--consultas
  

 
declare @nuevo_email nvarchar(100)
set @nuevo_email = 'florncia_codutti98@hotmail.com'

update srv114.movil.[dbo].[Users]
set email = @nuevo_email
where UserId=@UserId

update srv114.movil.[dbo].[AspNetUsers]
set email = @nuevo_email
,username=@nuevo_email
where id=@id

delete srv114.movil.[dbo].[Users] where UserId=131610

--select * from srv114.movil.[dbo].[AspNetUsers] where email ='test@ucp.edu.ar'

--ADMkiyjjqbFUd2uAoM8qgOg62ojwZVuyfptz5B8YEq+1/KMryadmZQNjblhV12W+pg==
--63cabfb7-6967-4efc-a759-8154473008ae

 --update srv114.movil.[dbo].[AspNetUsers]
 --set PasswordHash=(select PasswordHash from srv114.movil.[dbo].[AspNetUsers] where email ='test@ucp.edu.ar'),
 --securityStamp=(select securityStamp from srv114.movil.[dbo].[AspNetUsers] where email ='test@ucp.edu.ar')
 --where id='f8df8fec-cc2e-455c-9c8b-bfcc190d932e'

 select * from  srv114.movil.[dbo].[Users] where UserId =131643


 select * from srv114.movil.[dbo].[AspNetUsers]
where email = 'agumorcillo@gmail.com' 

declare @NEWID varchar(255)
set @NEWID= CONVERT(varchar(255), NEWID()  )
 
 
--INSERT INTO srv114.movil.[dbo].[AspNetUsers]
--     VALUES
--           (@NEWID
--           ,'agumorcillo@gmail.com' 
--           ,1
--           ,(select PasswordHash from srv114.movil.[dbo].[AspNetUsers] where email ='test@ucp.edu.ar')
--           ,(select securityStamp from srv114.movil.[dbo].[AspNetUsers] where email ='test@ucp.edu.ar')
--           ,''
--           ,0
--           ,0
--           ,null
--           ,0
--           ,0
--           ,'agumorcillo@gmail.com')
 

