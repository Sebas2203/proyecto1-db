DROP TABLE GARAJE_X_VEHICULO;
DROP TABLE VEHICULO;
DROP TABLE GARAJE_X_RESERVA;
DROP TABLE GARAJE;
DROP TABLE RESERVA_X_CLIENTE;
DROP TABLE TELEFONOS_X_CLIENTE;
DROP TABLE CLIENTE;



--CREACION DE TABLAS 

CREATE TABLE CLIENTE (
    CL_ID INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
    CL_PRIMER_NOMBRE VARCHAR2(40) NOT NULL,
    CL_SEGUNDO_NOMBRE VARCHAR2(40) NOT NULL,
    CL_PRIMER_APELLIDO VARCHAR2(40) NOT NULL,
    CL_SEGUNDO_APELLIDO VARCHAR2(40) NOT NULL,
    --CL_TELEFONOS
    CL_DIRECCION VARCHAR(255) NOT NULL,
    
    --PRIMARY KEY
    CONSTRAINT PK_CL_ID PRIMARY KEY(CL_ID),
    
    --CONSTRAINT 
    CONSTRAINT CK_PRIMER_NOMBRE CHECK(LENGTH(TRIM(CL_PRIMER_NOMBRE)) >= 2),
    CONSTRAINT CK_SEGUNDO_NOMBRE CHECK(LENGTH(TRIM(CL_SEGUNDO_NOMBRE))>= 2),
    CONSTRAINT CK_PRIMER_APELLIDO CHECK(LENGTH(TRIM(CL_PRIMER_APELLIDO)) >= 3),
    CONSTRAINT CK_SEGUNDO_APELLIDO CHECK(LENGTH(TRIM(CL_SEGUNDO_APELLIDO)) >= 3)
);
 
--ATRIBUTO MULTIVALUADO TELEFONOS
CREATE TABLE TELEFONOS_X_CLIENTE (
    TXC_ID INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
    TXC_CL_ID INTEGER NOT NULL,
    TXC_NUMERO INTEGER NOT NULL,
    
    CONSTRAINT PK_TXC_ID PRIMARY KEY(TXC_ID),
    CONSTRAINT FK_TXC_CL FOREIGN KEY(TXC_CL_ID) REFERENCES CLIENTE(CL_ID),
    --CONSTRIANTS
    CONSTRAINT UQ_TXC_NUMERO UNIQUE(TXC_CL_ID,TXC_NUMERO)
);




CREATE TABLE RESERVA(
    RS_ID INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
    RS_PRECIO DECIMAL(5,2) NOT NULL,
    --REVISAR FECHAS
    RS_FECHA_INICIO DATE NOT NULL,
    RS_FECHA_FINAL DATE NOT NULL,
    RS_DIAS_RESERVA INTEGER NOT NULL,
    
    --PRIMARY KEY
    CONSTRAINT PK_RS_ID PRIMARY KEY(RS_ID),
    CONSTRAINT CK_RS_PRECIO CHECK(LENGTH(TRIM(RS_PRECIO)) >= 10),--Precio en dolares
    CONSTRAINT CK_RS_DIAS_RESERVA CHECK(LENGTH(TRIM(RS_DIAS_RESERVA)) >= 1),
    --Restriccion para no permitir que se asigne una misma reserva ya asignada para una fecha
    CONSTRAINT UI_RS_FECHAS UNIQUE(RS_ID, RS_FECHA_INICIO, RS_FECHA_FINAL)
);

CREATE TABLE RESERVA_X_CLIENTE(
    RXC_CL_ID INTEGER NOT NULL,
    RXC_RS_ID INTEGER NOT NULL,
    --LLAVE PRIMARY COMPUESTA
    CONSTRAINT PK_RXC_CL_RS PRIMARY KEY (RXC_CL_ID, RXC_RS_ID),
    CONSTRAINT FK_RXC_CL FOREIGN KEY(RXC_CL_ID) REFERENCES CLIENTE(CL_ID),
    CONSTRAINT FK_RXC_RS FOREIGN KEY(RXC_RS_ID) REFERENCES RESERVA(RS_ID)
    
);

-------------------------------------------------------


CREATE TABLE GARAJE(
    GJ_ID INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
    
    --PRIMARY KEY
    CONSTRAINT PK_GJ_ID PRIMARY KEY(GJ_ID)
);

CREATE TABLE GARAJE_X_RESERVA(
    GXR_GJ_ID INTEGER NOT NULL,
    GXR_RS_ID INTEGER NOT NULL,
    
    --LLAVE PRIMARY COMPUESTA
    CONSTRAINT PK_GXR_GJ_RS PRIMARY KEY (GXR_GJ_ID, GXR_RS_ID),
    CONSTRAINT FK_GXR_GJ FOREIGN KEY(GXR_GJ_ID) REFERENCES GARAJE(GJ_ID),
    CONSTRAINT FK_GXR_RS FOREIGN KEY(GXR_RS_ID) REFERENCES RESERVA(RS_ID)
);


CREATE TABLE VEHICULO(
    VH_ID INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
    VH_MARCA VARCHAR2(15) NOT NULL,
    VH_MODELO VARCHAR2(15) NOT NULL,
    VH_PLACA INTEGER NOT NULL,
    VH_COLOR VARCHAR2(10) NOT NULL,
    VH_LITROS_GASOLINA DECIMAL(5,2) NOT NULL,
    VH_PRECIO_X_HORA DECIMAL(5,2) NOT NULL,
    
    --PRIMARY KEY
    CONSTRAINT PK_VH_ID PRIMARY KEY(VH_ID),
    
    --CONSTRAINTS
    CONSTRAINT UI_VH_PLACA UNIQUE(VH_PLACA),
    CONSTRAINT CK_VH_PLACA CHECK(LENGTH(TRIM(VH_PLACA)) = 6),
    CONSTRAINT CK_VH_MARCA CHECK(LENGTH(TRIM(VH_MARCA)) >= 2),
    CONSTRAINT CK_VH_MODELO CHECK(LENGTH(TRIM(VH_MODELO)) >= 2),
    CONSTRAINT CK_VH_COLOR CHECK(LENGTH(TRIM(VH_COLOR)) >= 4),
    CONSTRAINT CH_LITROS_GASOLINA CHECK (VH_LITROS_GASOLINA >= 0),
    CONSTRAINT CH_PRECIO_X_HORA CHECK (VH_PRECIO_X_HORA >= 0)
    
);

CREATE TABLE GARAJE_X_VEHICULO(
    GXV_GJ_ID INTEGER NOT NULL,
    GXV_VH_ID INTEGER NOT NULL,
    
    --LLAVE PRIMARY COMPUESTA
    CONSTRAINT PK_GXV_GJ_VH PRIMARY KEY (GXV_GJ_ID, GXV_VH_ID),
    CONSTRAINT FK_GXV_GJ FOREIGN KEY(GXV_GJ_ID) REFERENCES GARAJE(GJ_ID),
    CONSTRAINT FK_GXV_VH FOREIGN KEY(GXV_VH_ID) REFERENCES VEHICULO(VH_ID)
);


