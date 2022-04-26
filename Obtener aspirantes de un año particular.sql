--CENTRAL
   SELECT  a.alu_apellido_al + ', ' + a.alu_nombre_al as Nombre, a.alu_mail_al FROM ALUMNOS a
   WHERE year(dbo.fecha_ingreso_real(alu_codigo)) = 2020
   and not exists(select * from alumnos_extension_aulica aea 
   where a.alu_codigo = aea.alu_codigo )
   and a.alu_sir_codigo not in(2,10)
   order by alu_apellido_al, alu_nombre_al

   --resistencia
   SELECT a.alu_apellido_al + ', ' + a.alu_nombre_al as Nombre,a.alu_mail_al FROM ALUMNOS_EXTENSION_AULICA AEA
   INNER JOIN ALUMNOS A
   ON AEA.ALU_CODIGO = A.ALU_CODIGO
   WHERE YEAR(dbo.fecha_ingreso_real(aea.alu_codigo)) = 2020
   and a.alu_sir_codigo not in (10,2)
   ORDER BY ALU_APELLIDO_AL, ALU_NOMBRE_AL

 


   SELECT  a.alu_apellido_al + ', ' + a.alu_nombre_al as Nombre, a.alu_mail_al FROM ALUMNOS a
   WHERE year(dbo.fecha_ingreso_real(alu_codigo)) = 2020
   and a.alu_sir_codigo not in (10,2)
   order by alu_apellido_al, alu_nombre_al
