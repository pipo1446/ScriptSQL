--SECUENCIA DE ELIMINACIÓN DE UN CAMBIO DE PLAN MAL REALIZADO
/*
DELETE FROM INASISTENCIA_ALUMNOS
WHERE IAL_ALC_ALU_CODIGO = 15440

SELECT * FROM NOTAS_ALMNOS
WHERE NOA_ALC_ALU_CODIGO = 15440

DELETE FROM ALUMNO_COMISION
WHERE ALC_ALU_CODIGO = 15440


DELETE FROM EQUIVALENCIAS_MATERIAS
WHERE EQM_EQA_ALU_CODIGO = 15440


DELETE FROM EQUIVALENCIAS_ALUMNOS
WHERE EQA_ALU_CODIGO = 15440

DELETE FROM DATOS_PADRE_MADRE
WHERE DPM_ALU_CODIGO = 15440

DELETE FROM DOMICILIOS
WHERE DOM_ALU_CODIGO = 15440

DELETE FROM ALUMNOS
WHERE ALU_CODIGO = 15440

TENER EN CUENTA EL HISTORICO_SITUACION_REVISTA
*/


--INASISTENCIA_ALUMNOS
7743	2019	1	15440	2019-03-08 00:00:00.000	0.00	0	0	NULL	2019-03-08 16:48:37.130	CECIR	NULL	NULL	0.00	0.00
7743	2019	1	15440	2019-03-13 00:00:00.000	2.00	0	0	NULL	2019-03-13 15:48:56.320	CECIR	NULL	NULL	2.00	0.00
7743	2019	1	15440	2019-03-15 00:00:00.000	1.00	0	0	NULL	2019-03-15 16:08:10.890	CECIR	NULL	NULL	1.00	0.00
7743	2019	1	15440	2019-03-20 00:00:00.000	2.00	0	0	NULL	2019-03-20 16:44:27.180	CECIR	NULL	NULL	2.00	0.00
7743	2019	1	15440	2019-03-22 00:00:00.000	3.00	0	0	NULL	2019-03-22 18:03:47.687	CECIR	NULL	NULL	3.00	0.00
7743	2019	1	15440	2019-03-27 00:00:00.000	2.00	0	0	NULL	2019-03-27 15:25:09.260	CECIR	NULL	NULL	2.00	0.00


--ALUMNO_COMISION
7743	2019	1	15440	0	0	0	NULL	2019-03-07 00:00:00.000	0	0	0	87.50	NULL	2019-03-07 00:00:00.000	NULL	NULL			2-41-84	CECIR	0	C	NULL	NULL	0	NULL

--EQUIVALENCIAS_MATERIAS
84	2	41	160	15440	1	NULL	NULL	NULL	NULL	6.00	2014-04-04 00:00:00.000	NULL	45	5	2	33	66	173
84	2	41	161	15440	1	NULL	NULL	NULL	NULL	6.00	2014-04-04 00:00:00.000	NULL	45	5	2	33	66	173
84	2	41	357	15440	1	NULL	NULL	NULL	NULL	8.00	2013-09-09 00:00:00.000	NULL	43	10	2	33	66	357
84	2	41	1110	15440	1	NULL	NULL	NULL	NULL	7.00	2016-02-23 00:00:00.000	NULL	51	70	2	33	66	132
84	2	41	1111	15440	1	NULL	NULL	NULL	NULL	7.00	2016-07-26 00:00:00.000	NULL	52	99	2	33	66	134


--EQUIVALENCIAS_ALUMNOS
84	2	41	160	15440	2019-03-01 00:00:00.000	Resolución	145/19	6.00	NULL	NULL	I
84	2	41	161	15440	2019-03-01 00:00:00.000	Resolución	145/19	6.00	NULL	NULL	I
84	2	41	357	15440	2019-03-01 00:00:00.000	Resolución	145/19	8.00	NULL	NULL	I
84	2	41	1110	15440	2019-03-01 00:00:00.000	Resolución	145/19	7.00	NULL	NULL	I
84	2	41	1111	15440	2019-03-01 00:00:00.000	Resolución	145/19	7.00	NULL	NULL	I


--DATOS_PADRE_MADRE
15440	M	Quinta 	Hilaria Ester	2	3	156	xxx	03783-15694456
15440	P	Cariaga	Justo Domingo	2	424	155	xxx	03783-15399786


--DOMICILIOS
15440	1	Bş Laguna Seca 148 Viv. Sector 29 Casa Nş 21	2	9	8896	03794-15694456
15440	2	Bş Laguna Seca 148 Viv. Sector 29 Casa Nş 21	2	9	8896	03794-15399786 (papá)
15440	3	Bş Laguna Seca 148 Viv. Sector 29 Casa Nş 21	2	9	8896	03794-15694456/4471224









