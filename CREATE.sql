CREATE TABLE adoptante (
    id_adoptante              NUMBER(10) NOT NULL,
    preferencia_tipo_animal   VARCHAR2(255) NOT NULL,
    preferencia_sexo          VARCHAR2(255) NOT NULL,
    tipo_hogar                VARCHAR2(255) NOT NULL,
    preferencia_tamano_animal VARCHAR2(255) NOT NULL
);

ALTER TABLE adoptante ADD CONSTRAINT adoptante_pk PRIMARY KEY ( id_adoptante );

CREATE TABLE animal (
    id_animal                    NUMBER(10) NOT NULL,
    nombre_animal                VARCHAR2(255) NOT NULL,
    temperamento_id_temperamento NUMBER(10) NOT NULL,
    sexo_id_sexo                 NUMBER(10) NOT NULL,
    color_id_color               NUMBER(10) NOT NULL,
    raza_id_raza                 NUMBER(10) NOT NULL
);

ALTER TABLE animal ADD CONSTRAINT animal_pk PRIMARY KEY ( id_animal );

CREATE TABLE ciudad (
    id_ciudad        NUMBER(10) NOT NULL,
    nombre_ciudad    VARCHAR2(255) NOT NULL,
    comuna_id_comuna NUMBER(10) NOT NULL
);

ALTER TABLE ciudad ADD CONSTRAINT ciudad_pk PRIMARY KEY ( id_ciudad );

CREATE TABLE color (
    id_color NUMBER(10) NOT NULL,
    color    VARCHAR2(255) NOT NULL
);

ALTER TABLE color ADD CONSTRAINT color_pk PRIMARY KEY ( id_color );

CREATE TABLE comuna (
    id_comuna        NUMBER(10) NOT NULL,
    nombre_comuna    VARCHAR2(255) NOT NULL,
    region_id_region NUMBER(10) NOT NULL
);

ALTER TABLE comuna ADD CONSTRAINT comuna_pk PRIMARY KEY ( id_comuna );

CREATE TABLE datos_contacto (
    id_datoscontacto        NUMBER(10) NOT NULL,
    rut                     VARCHAR2(255),
    nombre                  VARCHAR2(255) NOT NULL,
    apellido                VARCHAR2(255) NOT NULL,
    edad                    NUMBER(10) NOT NULL,
    fecha_nacimiento        VARCHAR2(255) NOT NULL,
    direccion               VARCHAR2(255) NOT NULL,
    ciudad                  VARCHAR2(255) NOT NULL,
    comuna                  VARCHAR2(255) NOT NULL,
    region                  VARCHAR2(255) NOT NULL,
    adoptante_id_adoptante  NUMBER(10),
    hogar_temporal_id_hogar NUMBER(10),
    ciudad_id_ciudad        NUMBER(10) NOT NULL
);

CREATE UNIQUE INDEX datos_contacto__idx ON
    datos_contacto (
        hogar_temporal_id_hogar
    ASC );

ALTER TABLE datos_contacto ADD CONSTRAINT datos_contacto_pk PRIMARY KEY ( id_datoscontacto );

CREATE TABLE hogar_temporal (
    id_hogar         NUMBER(10) NOT NULL,
    fotos_hogar      BLOB,
    metraje_patio    VARCHAR2(255) NOT NULL,
    transporte       VARCHAR2(255) NOT NULL,
    dtcnt_iddtnct    NUMBER(10),
    disponibilidad   VARCHAR2(255) NOT NULL,
    cantidadanimales NUMBER(10) NOT NULL,
    dtcnt_id_dtcnt   NUMBER(10)
);

CREATE UNIQUE INDEX hogar_temporal__idx ON
    hogar_temporal (
        dtcnt_iddtnct
    ASC );

ALTER TABLE hogar_temporal ADD CONSTRAINT hogar_temporal_pk PRIMARY KEY ( id_hogar );

CREATE TABLE mascota_rescatada (
    id_mascota_rescatada    NUMBER(10) NOT NULL,
    tipo_animal             VARCHAR2(255) NOT NULL,
    sexo                    VARCHAR2(255) NOT NULL,
    raza                    VARCHAR2(255),
    color                   VARCHAR2(255) NOT NULL,
    tempreamento            VARCHAR2(255) NOT NULL,
    tamano                  VARCHAR2(255) NOT NULL,
    foto_animal_rescatado   BLOB,
    hogar_temporal_id_hogar NUMBER(10),
    animal_id_animal        NUMBER(10) NOT NULL
);

ALTER TABLE mascota_rescatada ADD CONSTRAINT mascota_rescatada_pk PRIMARY KEY ( id_mascota_rescatada );

CREATE TABLE raza (
    id_raza NUMBER(10) NOT NULL,
    raza    VARCHAR2(255) NOT NULL
);

ALTER TABLE raza ADD CONSTRAINT raza_pk PRIMARY KEY ( id_raza );

CREATE TABLE region (
    id_region     NUMBER(10) NOT NULL,
    nombre_region VARCHAR2(255) NOT NULL
);

ALTER TABLE region ADD CONSTRAINT region_pk PRIMARY KEY ( id_region );

CREATE TABLE reporte_animal (
    id_rescatista      NUMBER(10) NOT NULL,
    tipo_animal        VARCHAR2(255),
    sexo               VARCHAR2(255),
    raza               VARCHAR2(255),
    color              VARCHAR2(255),
    temperamento       VARCHAR2(255),
    tamano             VARCHAR2(255),
    direccion          VARCHAR2(255),
    comuna             VARCHAR2(255),
    region             VARCHAR2(255),
    usuario_id_usuario NUMBER(10),
    foto_animal        BLOB,
    ciudad_id_ciudad   NUMBER(10) NOT NULL,
    animal_id_animal   NUMBER(10) NOT NULL
);

ALTER TABLE reporte_animal ADD CONSTRAINT reporte_animal_pk PRIMARY KEY ( id_rescatista );

CREATE TABLE sexo (
    id_sexo NUMBER(10) NOT NULL,
    sexo    VARCHAR2(255) NOT NULL
);

ALTER TABLE sexo ADD CONSTRAINT sexo_pk PRIMARY KEY ( id_sexo );

CREATE TABLE temperamento (
    id_temperamento NUMBER(10) NOT NULL,
    temperamento    VARCHAR2(255) NOT NULL
);

ALTER TABLE temperamento ADD CONSTRAINT temperamento_pk PRIMARY KEY ( id_temperamento );

CREATE TABLE usuario (
    id_usuario     NUMBER(10) NOT NULL,
    tipo_usuario   VARCHAR2(255) NOT NULL,
    correo         VARCHAR2(255) NOT NULL,
    telefono       VARCHAR2(255) NOT NULL,
    usuario        VARCHAR2(255) NOT NULL,
    contrasena     VARCHAR2(255) NOT NULL,
    dtcnt_id_dtcnt NUMBER(10) NOT NULL
);

ALTER TABLE usuario ADD CONSTRAINT usuario_pk PRIMARY KEY ( id_usuario );

ALTER TABLE animal
    ADD CONSTRAINT animal_color_fk FOREIGN KEY ( color_id_color )
        REFERENCES color ( id_color );

ALTER TABLE animal
    ADD CONSTRAINT animal_raza_fk FOREIGN KEY ( raza_id_raza )
        REFERENCES raza ( id_raza );

ALTER TABLE animal
    ADD CONSTRAINT animal_sexo_fk FOREIGN KEY ( sexo_id_sexo )
        REFERENCES sexo ( id_sexo );

ALTER TABLE animal
    ADD CONSTRAINT animal_temperamento_fk FOREIGN KEY ( temperamento_id_temperamento )
        REFERENCES temperamento ( id_temperamento );

ALTER TABLE ciudad
    ADD CONSTRAINT ciudad_comuna_fk FOREIGN KEY ( comuna_id_comuna )
        REFERENCES comuna ( id_comuna );

ALTER TABLE comuna
    ADD CONSTRAINT comuna_region_fk FOREIGN KEY ( region_id_region )
        REFERENCES region ( id_region );

ALTER TABLE datos_contacto
    ADD CONSTRAINT datos_contacto_adoptante_fk FOREIGN KEY ( adoptante_id_adoptante )
        REFERENCES adoptante ( id_adoptante );

ALTER TABLE datos_contacto
    ADD CONSTRAINT datos_contacto_ciudad_fk FOREIGN KEY ( ciudad_id_ciudad )
        REFERENCES ciudad ( id_ciudad );

ALTER TABLE hogar_temporal
    ADD CONSTRAINT hgtmp_dtcnt_fk FOREIGN KEY ( dtcnt_id_dtcnt )
        REFERENCES datos_contacto ( id_datoscontacto );

ALTER TABLE mascota_rescatada
    ADD CONSTRAINT mascota_rescatada_animal_fk FOREIGN KEY ( animal_id_animal )
        REFERENCES animal ( id_animal );

ALTER TABLE mascota_rescatada
    ADD CONSTRAINT msctrsct_hgtmpl_fk FOREIGN KEY ( hogar_temporal_id_hogar )
        REFERENCES hogar_temporal ( id_hogar );

ALTER TABLE reporte_animal
    ADD CONSTRAINT reporte_animal_animal_fk FOREIGN KEY ( animal_id_animal )
        REFERENCES animal ( id_animal );

ALTER TABLE reporte_animal
    ADD CONSTRAINT reporte_animal_ciudad_fk FOREIGN KEY ( ciudad_id_ciudad )
        REFERENCES ciudad ( id_ciudad );

ALTER TABLE reporte_animal
    ADD CONSTRAINT reporte_animal_usuario_fk FOREIGN KEY ( usuario_id_usuario )
        REFERENCES usuario ( id_usuario );

ALTER TABLE usuario
    ADD CONSTRAINT usuario_datos_contacto_fk FOREIGN KEY ( dtcnt_id_dtcnt )
        REFERENCES datos_contacto ( id_datoscontacto );