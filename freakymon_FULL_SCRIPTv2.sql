-- ----------------------------------------------------------------
-- -   Author     : Anthony Figueroa                              -
-- -   Num.Est    : 841-23-9272                                   -
-- -   Curso      : SICI-4030                                     -
-- -   Sección    : KM1                                           -
-- -   Source     : EntregaProyecto-3-Anthony.sql                 -
-- -   Comentario : Este script es para la creacion de database de-
--                  freakymon go                                  -
-- ----------------------------------------------------------------
-- ----------------------------------------------------------------
-- -  EL SET ECHO ON permite ver la corrida en pantalla.         -
-- ----------------------------------------------------------------
SET ECHO ON
-- ----------------------------------------------------------------
-- - Nombre de Usuario y Fecha del Sistema. Se tienen que indicar –
-- ----------------------------------------------------------------
SHOW USER
SELECT systimestamp FROM dual;
-- ----------------------------------------------------------------
-- -   Aquí se borran las tablas en caso de tener que volver a   -
-- -  crearlas, esta sub dividido por niveles.                    -
-- ----------------------------------------------------------------
-- DROP TABLE tablas de nivel 3
DROP TABLE inventario; 
DROP TABLE girada; 
DROP TABLE captura; 
DROP TABLE pelea; 
DROP TABLE gym_mon; 
DROP TABLE ataque_mon; 
DROP TABLE tipo_mon; 

-- DROP TABLE de tablas nivel 2
DROP TABLE freakymon; 
---------------------------------------------------
-- freakydex excepcion tabla nivel 3 con recursion
DROP TABLE freakydex; 
--------------------------------------------------
DROP TABLE jugador; 
DROP TABLE ataque; 


-- DROP TABLE de tablas nivel 1
DROP TABLE cuenta;
DROP TABLE item; 
DROP TABLE freakystop; 
DROP TABLE gym; 
DROP TABLE tipo; 

-- ----------------------------------------------------------------
-- - Nombre de Usuario y Fecha del Sistema. Se tienen que indicar –
-- ----------------------------------------------------------------
SHOW USER
SELECT systimestamp FROM dual;
-- ----------------------------------------------------------------
-- -   Creacion tabla tipo nivel-1                                -
-- ----------------------------------------------------------------
CREATE TABLE tipo (
      id_pk                     NUMBER(3)    NOT NULL,
      nombre                    VARCHAR2 (25)  NOT NULL, 
      descr                     VARCHAR2 (150) NOT NULL,
CONSTRAINT tipo_id_pk            PRIMARY KEY (id_pk));
-- ----------------------------------------------------------------
-- - Nombre de Usuario y Fecha del Sistema. Se tienen que indicar –
-- ----------------------------------------------------------------
SHOW USER
SELECT systimestamp FROM dual;
-- ----------------------------------------------------------------
-- -   Creacion tabla gym nivel-1                                 -
-- ----------------------------------------------------------------
CREATE TABLE gym (
      id_pk                     NUMBER(3)    NOT NULL,
      nombre                    VARCHAR2(25) NOT NULL,
      descr                     VARCHAR2(150) NOT NULL,
      latitud                   NUMBER(7,4) NOT NULL,
      longitud                  NUMBER(7,4) NOT NULL,
      comentario               VARCHAR2 (150),   
CONSTRAINT gym_id_pk            PRIMARY KEY (id_pk));
-- ----------------------------------------------------------------
-- - Nombre de Usuario y Fecha del Sistema. Se tienen que indicar –
-- ----------------------------------------------------------------
SHOW USER
SELECT systimestamp FROM dual;
-- ----------------------------------------------------------------
-- -   Creacion tabla freakystop nivel-1                          -
-- ----------------------------------------------------------------
CREATE TABLE freakystop (
      id_pk                     NUMBER(3)    NOT NULL,
      nombre                    VARCHAR2(25) NOT NULL,
      descr                     VARCHAR2(150) NOT NULL,
      latitud                   NUMBER(7,4) NOT NULL,
      longitud                  NUMBER(7,4) NOT NULL,
      commentario               VARCHAR2 (150),   
CONSTRAINT freakystop_id_pk            PRIMARY KEY (id_pk));
-- ----------------------------------------------------------------
-- - Nombre de Usuario y Fecha del Sistema. Se tienen que indicar –
-- ----------------------------------------------------------------
SHOW USER
SELECT systimestamp FROM dual;
-- ----------------------------------------------------------------
-- -   Creacion tabla item nivel-1                              -
-- ----------------------------------------------------------------
CREATE TABLE item (
      id_pk                     NUMBER(3)    NOT NULL,
      nombre                    VARCHAR2(25) NOT NULL,
      descr                     VARCHAR2(150) NOT NULL,
CONSTRAINT item_id_pk            PRIMARY KEY (id_pk));
-- ----------------------------------------------------------------
-- - Nombre de Usuario y Fecha del Sistema. Se tienen que indicar –
-- ----------------------------------------------------------------
SHOW USER
SELECT systimestamp FROM dual;
-- ----------------------------------------------------------------
-- -   Creacion tabla cuenta nivel-2                              -
-- ----------------------------------------------------------------
CREATE TABLE cuenta (
      username_pk             VARCHAR2 (25)    NOT NULL,
      email                   VARCHAR2 (35)   NOT NULL,
      password                VARCHAR2 (35)   NOT NULL, 
      tipo_cuenta             VARCHAR2 (10)       NOT NULL, 
      fecha_creado            DATE           NOT NULL, 
      fecha_accesso           DATE           NOT NULL, 
      intentos_fallidos       NUMBER (2)     NOT NULL, 
CONSTRAINT cuenta_id_pk            PRIMARY KEY (username_pk));

-- ----------------------------------------------------------------
-- - Nombre de Usuario y Fecha del Sistema. Se tienen que indicar –
-- ----------------------------------------------------------------
SHOW USER
SELECT systimestamp FROM dual;
-- ----------------------------------------------------------------
-- -   Creacion tabla ataque nivel-2                              -
-- ----------------------------------------------------------------
CREATE TABLE ataque (
      id_pk                   NUMBER (3), 
      tipo_id_fk              NUMBER (3) NOT NULL, 
      nombre                  VARCHAR2(25) NOT NULL, 
      descr                   VARCHAR2(150) NOT NULL, 
CONSTRAINT ataque_id_pk       PRIMARY KEY (id_pk),
CONSTRAINT tipo_id_fk		FOREIGN KEY (tipo_id_fk)
    				      REFERENCES tipo(id_pk)
);
-- ----------------------------------------------------------------
-- - Nombre de Usuario y Fecha del Sistema. Se tienen que indicar –
-- ----------------------------------------------------------------
SHOW USER
SELECT systimestamp FROM dual;
-- ----------------------------------------------------------------
-- -   Creacion tabla jugador nivel-2                              -
-- ----------------------------------------------------------------
CREATE TABLE jugador (
      cuenta_id_pk_fk         VARCHAR2 (25) NOT NULL, 
      nombre                  VARCHAR2 (20) NOT NULL, 
      inicial                 VARCHAR2 (1), 
      apellido_paterno        VARCHAR2 (20) NOT NULL, 
      apellido_materno        VARCHAR2 (20), 
      linea_1                 VARCHAR2 (100) NOT NULL, 
      linea_2                 VARCHAR2 (100), 
      urb                     VARCHAR2 (25) NOT NULL, 
      ciudad                  VARCHAR2 (25) NOT NULL, 
      estado                  VARCHAR2 (25) NOT NULL, 
      zip_code                NUMBER (5) NOT NULL, 
      nacimiento              DATE NOT NULL, 
      color                   VARCHAR2 (10), 
      comentario              VARCHAR2 (150), 
CONSTRAINT jugador_id_pk      PRIMARY KEY (cuenta_id_pk_fk),
CONSTRAINT cuenta_id_pk_fk    FOREIGN KEY (cuenta_id_pk_fk)
    				      REFERENCES cuenta(username_pk)
);
-- ----------------------------------------------------------------
-- - Nombre de Usuario y Fecha del Sistema. Se tienen que indicar –
-- ----------------------------------------------------------------
SHOW USER
SELECT systimestamp FROM dual;
-- ----------------------------------------------------------------
-- -   Creacion tabla freakydex nivel-3    (excepcion)            -
-- ----------------------------------------------------------------
CREATE TABLE freakydex (
      id_pk             NUMBER (3) NOT NULL,
      jugador_id_fk     VARCHAR2 (25) NOT NULL, 
      freakydex_id_fk   NUMBER (3), 
      nombre            VARCHAR2 (20) NOT NULL, 
      dulces            NUMBER (3) DEFAULT (0), 
      dulces_xl         NUMBER (3) DEFAULT (0), 
      estrella          NUMBER (1) DEFAULT (0), 
CONSTRAINT freakydex_id_pk            PRIMARY KEY (id_pk), 
CONSTRAINT jugador_id_fk              FOREIGN KEY (jugador_id_fk)
                                      REFERENCES jugador(cuenta_id_pk_fk), 
CONSTRAINT id_fk                      FOREIGN KEY (freakydex_id_fk)
                                      REFERENCES freakydex(id_pk)
);
-- ----------------------------------------------------------------
-- - Nombre de Usuario y Fecha del Sistema. Se tienen que indicar –
-- ----------------------------------------------------------------
SHOW USER
SELECT systimestamp FROM dual;
-- ----------------------------------------------------------------
-- -   Creacion tabla freakymon nivel-2                          -
-- ----------------------------------------------------------------
CREATE TABLE freakymon (
      id_pk                   NUMBER (3) NOT NULL, 
      freakydex_id_fk         NUMBER (3), 
      nombre                  VARCHAR2(25) NOT NULL, 
      genero                  VARCHAR2 (1) NOT NULL, 
      hp_max                  NUMBER (4) NOT NULL, 
      hp_actual               NUMBER (4) NOT NULL, 
      cp                      NUMBER (6) NOT NULL, 
      altura                  NUMBER (9,3) NOT NULL, 
      peso                    NUMBER (9,2) NOT NULL, 
CONSTRAINT freakymon_id_pk    PRIMARY KEY (id_pk), 
CONSTRAINT freakydex_id_fk	  FOREIGN KEY (freakydex_id_fk) 
                                REFERENCES freakydex(id_pk)
);

-- ----------------------------------------------------------------
-- - Nombre de Usuario y Fecha del Sistema. Se tienen que indicar –
-- ----------------------------------------------------------------
SHOW USER
SELECT systimestamp FROM dual;
-- ----------------------------------------------------------------
-- -   Creacion tabla tipo_mon nivel-3                          -
-- ----------------------------------------------------------------
CREATE TABLE tipo_mon (
      freakymon_id_pk_fk            NUMBER (3) NOT NULL,
      tipo_id_pk_fk                 NUMBER (3) NOT NULL, 
CONSTRAINT tipo_mon_pk        PRIMARY KEY (freakymon_id_pk_fk,tipo_id_pk_fk), 
CONSTRAINT freakymon_id_pk_fk FOREIGN KEY (freakymon_id_pk_fk)
                              REFERENCES freakymon(id_pk), 
CONSTRAINT tipo_id_pk_fk      FOREIGN KEY (tipo_id_pk_fk)
                              REFERENCES tipo(id_pk)
); 
-- ----------------------------------------------------------------
-- - Nombre de Usuario y Fecha del Sistema. Se tienen que indicar –
-- ----------------------------------------------------------------
SHOW USER
SELECT systimestamp FROM dual;
-- ----------------------------------------------------------------
-- -   Creacion tabla ataque_mon nivel-3                          -
-- ----------------------------------------------------------------
CREATE TABLE ataque_mon (
      freakymon_id_pk_fk      NUMBER (3) NOT NULL, 
      ataque_id_pk_fk         NUMBER (3) NOT NULL, 
      cantidad_dmg            NUMBER (4) NOT NULL, 
CONSTRAINT ataque_mon_id_pk   PRIMARY KEY (freakymon_id_pk_fk, ataque_id_pk_fk), 
CONSTRAINT ataque_mon_freakymon_id_fk FOREIGN KEY (freakymon_id_pk_fk) 
                              REFERENCES freakymon(id_pk), 
CONSTRAINT ataque_mon_ataque_id_fk    FOREIGN KEY (ataque_id_pk_fk)
                              REFERENCES ataque(id_pk)
); 
-- ----------------------------------------------------------------
-- - Nombre de Usuario y Fecha del Sistema. Se tienen que indicar –
-- ----------------------------------------------------------------
SHOW USER
SELECT systimestamp FROM dual;
-- ----------------------------------------------------------------
-- -   Creacion tabla ataque_mon nivel-3                          -
-- ----------------------------------------------------------------
CREATE TABLE gym_mon(
      gym_id_pk_fk           NUMBER (3) NOT NULL, 
      freakymon_id_pk_fk     NUMBER (3) NOT NULL, 
      fecha_registro         DATE       NOT NULL, 
      fecha_derrota          DATE, 
      vitorias               NUMBER (4) DEFAULT (0), 
CONSTRAINT gym_mon_id_pk     PRIMARY KEY (gym_id_pk_fk,freakymon_id_pk_fk), 
CONSTRAINT gym_mon_freakymon_id_fk   FOREIGN KEY (freakymon_id_pk_fk)
                             REFERENCES freakymon(id_pk), 
CONSTRAINT gym_mon_gym_id_pk_fk      FOREIGN KEY (gym_id_pk_fk)
                             REFERENCES gym(id_pk)
);
-- ----------------------------------------------------------------
-- - Nombre de Usuario y Fecha del Sistema. Se tienen que indicar –
-- ----------------------------------------------------------------
SHOW USER
SELECT systimestamp FROM dual;
-- ----------------------------------------------------------------
-- -   Creacion tabla pelea      nivel-3                          -
-- ----------------------------------------------------------------
CREATE TABLE pelea(
      freakymon_id_pk_fk      NUMBER (3) NOT NULL, 
      gym_id_pk_fk            NUMBER (3) NOT NULL, 
      fecha_hora              TIMESTAMP NOT NULL, 
      resultados              VARCHAR2 (10), 
CONSTRAINT pela_id_pk                     PRIMARY KEY (freakymon_id_pk_fk, gym_id_pk_fk), 
CONSTRAINT pela_freakymon_id_pk_fk        FOREIGN KEY (freakymon_id_pk_fk)
                                          REFERENCES freakymon(id_pk), 
CONSTRAINT pelea_gym_id_pk_fk             FOREIGN KEY (gym_id_pk_fk)
                                          REFERENCES gym(id_pk)
);
-- ----------------------------------------------------------------
-- - Nombre de Usuario y Fecha del Sistema. Se tienen que indicar –
-- ----------------------------------------------------------------
SHOW USER
SELECT systimestamp FROM dual;
-- ----------------------------------------------------------------
-- -   Creacion captura          nivel-3                          -
-- ----------------------------------------------------------------
CREATE TABLE captura (
      freakymon_id_pk_fk           NUMBER (3) NOT NULL, 
      jugador_id_pk_fk             VARCHAR2 (25) NOT NULL, 
      latitud                      NUMBER (10,6) NOT NULL, 
      longitud                     NUMBER (10,6) NOT NULL, 
      fecha_hora                   TIMESTAMP NOT NULL, 
CONSTRAINT captura_id_pk                   PRIMARY KEY (freakymon_id_pk_fk,jugador_id_pk_fk),
CONSTRAINT captura_freakymon_id_pk_fk      FOREIGN KEY (freakymon_id_pk_fk)
                                           REFERENCES freakymon(id_pk), 
CONSTRAINT captura_jugador_id_pk_fk        FOREIGN KEY (jugador_id_pk_fk)
                                           REFERENCES jugador(cuenta_id_pk_fk)
); 
-- ----------------------------------------------------------------
-- - Nombre de Usuario y Fecha del Sistema. Se tienen que indicar –
-- ----------------------------------------------------------------
SHOW USER
SELECT systimestamp FROM dual;
-- ----------------------------------------------------------------
-- -   Creacion girada          nivel-3                          -
-- ----------------------------------------------------------------
CREATE TABLE girada (
      spin_num_pk             NUMBER (3) NOT NULL, 
      jugador_id_pk_fk        VARCHAR2 (25) NOT NULL, 
      item_id_pk_fk           NUMBER (3) NOT NULL,
      gym_id_fk               NUMBER (3), 
      freakystop_id_fk        NUMBER (3), 
      fecha_hora              TIMESTAMP NOT NULL, 
      cantidad                NUMBER (3) DEFAULT (1), 
CONSTRAINT girada_id_pk       PRIMARY KEY (spin_num_pk, jugador_id_pk_fk, item_id_pk_fk), 
CONSTRAINT girada_jugador_id_pk_fk     FOREIGN KEY (jugador_id_pk_fk)
                                       REFERENCES jugador(cuenta_id_pk_fk),
CONSTRAINT girada_item_id_pk_fk        FOREIGN KEY (item_id_pk_fk)
                                       REFERENCES item(id_pk), 
CONSTRAINT girada_gym_id_fk            FOREIGN KEY (gym_id_fk)
                                       REFERENCES gym(id_pk), 
CONSTRAINT girada_freakystop_id_fk     FOREIGN KEY (freakystop_id_fk) 
                                       REFERENCES freakystop(id_pk)
); 

-- ----------------------------------------------------------------
-- - Nombre de Usuario y Fecha del Sistema. Se tienen que indicar –
-- ----------------------------------------------------------------
SHOW USER
SELECT systimestamp FROM dual;
-- ----------------------------------------------------------------
-- -   Creacion captura          nivel-3                          -
-- ----------------------------------------------------------------

CREATE TABLE inventario (
      jugador_id_pk_fk        VARCHAR2 (25) NOT NULL, 
      item_id_pk_fk           NUMBER (3) NOT NULL, 
      cantidad                NUMBER (3) NOT NULL, 
      fecha_actualizacion     DATE NOT NULL, 
CONSTRAINT inventario_pk                  PRIMARY KEY (jugador_id_pk_fk, item_id_pk_fk), 
CONSTRAINT inventario_jugador_id_pk_fk    FOREIGN KEY (jugador_id_pk_fk)
                                          REFERENCES jugador(cuenta_id_pk_fk),
CONSTRAINT inventario_item_id_pk_fk       FOREIGN KEY (item_id_pk_fk)
                                          REFERENCES item(id_pk)
); 



-- ----------------------------------------------------------------
-- - Nombre de Usuario y Fecha del Sistema. Se tienen que indicar –
-- ----------------------------------------------------------------
SHOW USER
SELECT systimestamp FROM dual;

-- ----------------------------------------------------------------
-- -   Insertar datos tabla: tipo                                 -
-- ----------------------------------------------------------------
INSERT INTO tipo VALUES (568, 'Agua', 'Relacionado con ataques y freakymones acuáticos.');
INSERT INTO tipo VALUES (542, 'Fuego', 'Utilizado en ataques de calor y freakymones ardientes.');
INSERT INTO tipo VALUES (125, 'Planta', 'Asociado a ataques de naturaleza y freakymones de flora.');
INSERT INTO tipo VALUES (985, 'Roca', 'Enfocado en ataques de piedra y freakymones resistentes.');
INSERT INTO tipo VALUES (245, 'Psíquico', 'Conectado con ataques mentales y freakymones con poderes psíquicos.');
INSERT INTO tipo VALUES (642, 'Eléctrico', 'Genera ataques de rayos y se relaciona con freakymones eléctricos.');
INSERT INTO tipo VALUES (888, 'Fantasma', 'Relacionado con ataques intangibles y freakymones espectrales.');
INSERT INTO tipo VALUES (21, 'Lucha', 'Diseñado para ataques físicos y freakymones combatientes.');
INSERT INTO tipo VALUES (982, 'Volador', 'Asociado a ataques aéreos y freakymones alados.');
INSERT INTO tipo VALUES (101, 'Veneno', 'Relacionado con ataques tóxicos y freakymones venenosos.');

-- Inserts para parte 2 de proyecto final 
INSERT INTO tipo VALUES (111, 'Dragón', 'Relacionado con ataques y freakymones dragones.');
INSERT INTO tipo VALUES (222, 'Hielo', 'Enfocado en ataques de hielo y freakymones árticos.');
INSERT INTO tipo VALUES (333, 'Acero', 'Utilizado en ataques metálicos y freakymones duros.');
INSERT INTO tipo VALUES (444, 'Insecto', 'Asociado con ataques rápidos y freakymones insectoides.');
INSERT INTO tipo VALUES (555, 'Oscuro', 'Conectado con ataques sombríos y freakymones oscuros.');
INSERT INTO tipo VALUES (666, 'Hada', 'Relacionado con ataques mágicos y freakymones encantados.');
INSERT INTO tipo VALUES (777, 'Normal', 'Ataques comunes usados por freakymones ordinarios.');
INSERT INTO tipo VALUES (889, 'Tierra', 'Relacionado con ataques terrestres y freakymones subterráneos.');
INSERT INTO tipo VALUES (999, 'Rayo', 'Genera ataques eléctricos en freakymones relampagueantes.');
INSERT INTO tipo VALUES (123, 'Explosivo', 'Explosivos masivos en freakymones destructivos.');

-- ----------------------------------------------------------------
-- - Nombre de Usuario y Fecha del Sistema. Se tienen que indicar –
-- ----------------------------------------------------------------
SHOW USER
SELECT systimestamp FROM dual;
-- ----------------------------------------------------------------
-- -   Datos de la tabla gym                                      -
-- ----------------------------------------------------------------
INSERT INTO gym VALUES (1, 'Tower Peak', 'Un gimnasio en lo alto de una torre.', 37.7749, -122.4194, 'Verificar acceso a zonas elevadas.');
INSERT INTO gym VALUES (2, 'Mystic Haven', 'Refugio rodeado de energía mística.', 40.7128, -74.0060, 'Revisar spawn de freakymons especiales.');
INSERT INTO gym VALUES (3, 'Fiery Plains', 'Un gimnasio en un paisaje volcánico.', 34.0522, -118.2437, 'Añadir efectos visuales de lava.');
INSERT INTO gym VALUES (4, 'Frost Fortress', 'Fortaleza cubierta de hielo y nieve.', 41.8781, -87.6298, 'Confirmar clima invernal en la región.');
INSERT INTO gym VALUES (5, 'Thunder Dome', 'Una arena electrizante para batallas.', 29.7604, -95.3698, 'Ajustar frecuencia de tipos eléctricos.');
INSERT INTO gym VALUES (6, 'Rocky Ascent', 'Gimnasio situado en una montaña rocosa.', 39.7392, -104.9903, 'Asegurar conectividad en áreas remotas.');
INSERT INTO gym VALUES (7, 'Grassland Grove', 'Un santuario en medio de verdes campos.', 25.7617, -80.1918, 'Ideal para eventos temáticos.');
INSERT INTO gym VALUES (8, 'Phantom Shadows', 'Gimnasio envuelto en un aura misteriosa.', 33.4484, -112.0740, 'Revisar ambientación nocturna.');
INSERT INTO gym VALUES (9, 'Steel Citadel', 'Una imponente fortaleza metálica.', 47.6062, -122.3321, null);
INSERT INTO gym VALUES (10, 'Dragon''s Lair', 'Refugio lleno de dragones legendarios.', 32.7157, -117.1611, null);

-- Inserts para parte 2 del proyecto final 
INSERT INTO gym VALUES (11, 'Shadow Abyss', 'Un gimnasio sumido en la oscuridad eterna.', 36.1627, -86.7816, 'Explorar las profundidades para eventos especiales.');
INSERT INTO gym VALUES (12, 'Solar Shrine', 'Santuario iluminado por una energía solar intensa.', 51.5074, -0.1278, 'Ideal para eventos solares y temáticos.');
INSERT INTO gym VALUES (13, 'Oceanic Spire', 'Una torre situada en medio del océano.', 22.3964, 114.1095, 'Confirmar la conectividad remota en la torre.');
INSERT INTO gym VALUES (14, 'Crystal Cavern', 'Caverna brillante repleta de cristales luminosos.', -33.8688, 151.2093, 'Agregar efectos de iluminación especial.');
INSERT INTO gym VALUES (15, 'Blazing Peak', 'Gimnasio en la cima de una montaña volcánica activa.', 48.8566, 2.3522, 'Verificar frecuencias de spawn volcánico.');
INSERT INTO gym VALUES (16, 'Frozen Wasteland', 'Región desolada cubierta de hielo y viento helado.', 55.7558, 37.6173, 'Habilitar clima extremo para batallas intensas.');
INSERT INTO gym VALUES (17, 'Stormy Bastion', 'Fortaleza construida para resistir tormentas furiosas.', 35.6895, 139.6917, 'Añadir barreras contra tormentas en la interfaz.');
INSERT INTO gym VALUES (18, 'Emerald Grove', 'Un gimnasio rodeado de un bosque esmeralda.', 13.7563, 100.5018, 'Perfecto para eventos ecológicos y primavera.');
INSERT INTO gym VALUES (19, 'Golden Arena', 'Arena reluciente diseñada para combates legendarios.', 37.9838, 23.7275, 'Arena dedicada a enfrentamientos épicos.');
INSERT INTO gym VALUES (20, 'Twilight Citadel', 'Ciudadela bañada en la penumbra del atardecer.', 40.4168, -3.7038, 'Revisar ambientación nocturna con temática de penumbra.');

-- ----------------------------------------------------------------
-- - Nombre de Usuario y Fecha del Sistema. Se tienen que indicar –
-- ----------------------------------------------------------------
SHOW USER
SELECT systimestamp FROM dual;
-- ----------------------------------------------------------------
-- -   Datos de la tabla freakystop                               -
-- ----------------------------------------------------------------
INSERT INTO freakystop VALUES (1, 'Mystic Fountain', 'Fuente antigua llena de energía.', 37.7749, -122.4194, 'Verificar frecuencia de giradas.');
INSERT INTO freakystop VALUES (2, 'Ancient Oak', 'Un roble legendario en el bosque.', 40.7128, -74.0060, 'Revisar si se activa en eventos temáticos.');
INSERT INTO freakystop VALUES (3, 'Urban Mural', 'Un mural vibrante en el centro.', 34.0522, -118.2437, 'Confirmar accesibilidad en áreas urbanas.');
INSERT INTO freakystop VALUES (4, 'Sandy Shore', 'Freakystop ubicado en la playa.', 41.8781, -87.6298, 'Evaluar interacción con clima marino.');
INSERT INTO freakystop VALUES (5, 'Clock Tower', 'Una torre con un reloj icónico.', 29.7604, -95.3698, 'Asegurar visibilidad en la interfaz del mapa.');
INSERT INTO freakystop VALUES (6, 'Hidden Waterfall', 'Cascada oculta en un cañón.', 39.7392, -104.9903, 'Revisar conectividad en zonas rurales.');
INSERT INTO freakystop VALUES (7, 'Blooming Garden', 'Jardín lleno de coloridas flores.', 25.7617, -80.1918, 'Ideal para eventos de primavera.');
INSERT INTO freakystop VALUES (8, 'Haunted Tree', 'Árbol embrujado con historia oscura.', 33.4484, -112.0740, 'Añadir efectos visuales nocturnos.');
INSERT INTO freakystop VALUES (9, 'Iron Bridge', 'Un puente de hierro sobre el río.', 47.6062, -122.3321, 'Compatible con eventos relacionados con agua.');
INSERT INTO freakystop VALUES (10, 'Dragon''s Gate', 'Entrada decorada con dragones.', 32.7157, -117.1611, 'Asegurar coherencia con las temáticas cercanas.');

-- Inserts para parte 2 del proyecto final 
INSERT INTO freakystop VALUES (11, 'Mystic Lagoon', 'Un lago rodeado de energía mística.', 34.0522, -118.2437, 'Confirmar frecuencias de spawn en aguas místicas.');
INSERT INTO freakystop VALUES (12, 'Dragon Fountain', 'Fuente decorada con dragones legendarios.', 36.7783, -119.4179, 'Ideal para eventos temáticos con dragones.');
INSERT INTO freakystop VALUES (13, 'Sunset Grove', 'Un santuario rodeado de árboles al atardecer.', 40.7306, -73.9352, 'Santuario perfecto para reuniones al atardecer.');
INSERT INTO freakystop VALUES (14, 'Silver Archway', 'Un arco plateado que brilla bajo la luz de la luna.', -34.6037, -58.3816, 'Arco plateado para eventos nocturnos.');
INSERT INTO freakystop VALUES (15, 'Golden Pillar', 'Pilar dorado que simboliza la grandeza.', 48.8584, 2.2945, 'Zona dorada para celebraciones épicas.');
INSERT INTO freakystop VALUES (16, 'Thunder Cavern', 'Cueva electrificada con energía acumulada.', 59.3293, 18.0686, 'Cueva adecuada para eventos eléctricos.');
INSERT INTO freakystop VALUES (17, 'Crystal Meadow', 'Pradera cristalina llena de flores mágicas.', 12.9716, 77.5946, 'Pradera especial para eventos primaverales.');
INSERT INTO freakystop VALUES (18, 'Echo Forest', 'Un bosque donde se escuchan ecos misteriosos.', 31.2304, 121.4737, 'Bosque ideal para misiones misteriosas.');
INSERT INTO freakystop VALUES (19, 'Moonlit Bridge', 'Puente iluminado por la luz de la luna llena.', 39.9042, 116.4074, 'Puente temático para eventos nocturnos.');
INSERT INTO freakystop VALUES (20, 'Starlit Tower', 'Torre que brilla con las estrellas en la noche.', 41.9028, 12.4964, 'Torre estrellada para encuentros celestiales.');

-- ----------------------------------------------------------------
-- - Nombre de Usuario y Fecha del Sistema. Se tienen que indicar –
-- ----------------------------------------------------------------
SHOW USER
SELECT systimestamp FROM dual;
-- ----------------------------------------------------------------
-- -   Datos de la tabla item                                     -
-- ----------------------------------------------------------------
INSERT INTO item VALUES (1, 'Pokéball Básica', 'Una Pokéball estándar para capturar Freakymons.');
INSERT INTO item VALUES (2, 'Súper Pokéball', 'Una Pokéball mejorada con mayor tasa de captura.');
INSERT INTO item VALUES (3, 'Ultraball', 'Una Pokéball avanzada para Freakymons difíciles.');
INSERT INTO item VALUES (4, 'Poción', 'Cura 20 puntos de vida a un Freakymon.');
INSERT INTO item VALUES (5, 'Súper Poción', 'Cura 50 puntos de vida a un Freakymon.');
INSERT INTO item VALUES (6, 'Revivir', 'Revive un Freakymon debilitado con la mitad de su vida.');
INSERT INTO item VALUES (7, 'Incienso Místico', 'Atrae Freakymons al jugador durante 30 minutos.');
INSERT INTO item VALUES (8, 'Cebo Brillante', 'Aumenta la frecuencia de aparición en un Freakystop.');
INSERT INTO item VALUES (9, 'Huevo de la Suerte', 'Duplica la experiencia ganada por 30 minutos.');
INSERT INTO item VALUES (10, 'Piedra Evolutiva', 'Permite evolucionar a ciertos Freakymons especiales.');

-- Inserts para parte 2 del proyecto final 
INSERT INTO item VALUES (11, 'Max Pocion', 'Cura completamente los puntos de vida de un Freakymon.');
INSERT INTO item VALUES (12, 'Hyper Ball', 'Pokéball avanzada con alta tasa de captura.');
INSERT INTO item VALUES (13, 'Restaurador Total', 'Elimina todas las alteraciones de estado.');
INSERT INTO item VALUES (14, 'Escudo de Baya', 'Escudo temporal que protege de ataques críticos.');
INSERT INTO item VALUES (15, 'Amuleto de Experiencia', 'Duplica la experiencia ganada por 10 minutos.');
INSERT INTO item VALUES (16, 'Caña Especial', 'Caña especial para atrapar Freakymons acuáticos.');
INSERT INTO item VALUES (17, 'Cebo Helado', 'Aumenta la probabilidad de aparición en áreas frías.');
INSERT INTO item VALUES (18, 'Fragmento de Estrella', 'Incrementa las recompensas por tiempo limitado.');
INSERT INTO item VALUES (19, 'Bomba Lunar', 'Causa daño en área a Freakymons oscuros.');
INSERT INTO item VALUES (20, 'Repelente', 'Evita encuentros con Freakymons salvajes por 5 minutos.');

-- ----------------------------------------------------------------
-- - Nombre de Usuario y Fecha del Sistema. Se tienen que indicar –
-- ----------------------------------------------------------------
SHOW USER
SELECT systimestamp FROM dual;
-- ----------------------------------------------------------------
-- -   Datos de la tabla cuenta                                     -
-- ----------------------------------------------------------------
INSERT INTO cuenta VALUES ('AshKetchum', 'ashketchum@gmail.com', 'pika2024!', 'usuario', TO_DATE('01-nov-2024', 'DD-MON-YYYY'), TO_DATE('27-nov-2024', 'DD-MON-YYYY'), 0);
INSERT INTO cuenta VALUES ('MistyStar', 'mistystar@gmail.com', 'waterGym9*', 'usuario', TO_DATE('15-oct-2024', 'DD-MON-YYYY'), TO_DATE('26-nov-2024', 'DD-MON-YYYY'), 2);
INSERT INTO cuenta VALUES ('BrockBoulder', 'brockrock@gmail.com', 'onix2023#', 'usuario', TO_DATE('20-sep-2024', 'DD-MON-YYYY'), TO_DATE('25-nov-2024', 'DD-MON-YYYY'), 1);
INSERT INTO cuenta VALUES ('TeamRocket123', 'rocketboss@villain.com', 'meowth$99', 'usuario', TO_DATE('05-aug-2024', 'DD-MON-YYYY'), TO_DATE('27-nov-2024', 'DD-MON-YYYY'), 0);
INSERT INTO cuenta VALUES ('PikachuFan98', 'pikaFan98@gmail.com', 'thunder!44', 'usuario', TO_DATE('15-jul-2024', 'DD-MON-YYYY'), TO_DATE('27-nov-2024', 'DD-MON-YYYY'), 0);
INSERT INTO cuenta VALUES ('GymLeaderGary', 'garyoak@rival.com', 'rival100!', 'usuario', TO_DATE('18-jun-2024', 'DD-MON-YYYY'), TO_DATE('25-nov-2024', 'DD-MON-YYYY'), 3);
INSERT INTO cuenta VALUES ('FreakyMaster1', 'master1@gmail.com', 'freakyMon3', 'usuario', TO_DATE('10-nov-2024', 'DD-MON-YYYY'), TO_DATE('20-nov-2024', 'DD-MON-YYYY'), 1);
INSERT INTO cuenta VALUES ('RedTrainer', 'redtrainer@gmail.com', 'char$izard', 'usuario', TO_DATE('07-nov-2024', 'DD-MON-YYYY'), TO_DATE('27-nov-2024', 'DD-MON-YYYY'), 0);
INSERT INTO cuenta VALUES ('BlueFlame9', 'blueFlame9@gmail.com', 'blaze9876', 'usuario', TO_DATE('01-sep-2024', 'DD-MON-YYYY'), TO_DATE('24-nov-2024', 'DD-MON-YYYY'), 2);
INSERT INTO cuenta VALUES ('GreenRanger', 'greenRanger@poke.com', 'bulbaGrow!', 'usuario', TO_DATE('12-aug-2024', 'DD-MON-YYYY'), TO_DATE('27-nov-2024', 'DD-MON-YYYY'), 0);

-- Inserts para parte 2 del proyecto final 
INSERT INTO cuenta VALUES ('SilverTrainer', 'silvertrainer@freakymon.com', 'silver$123', 'usuario', TO_DATE('2024-11-15', 'YYYY-MM-DD'), TO_DATE('2024-11-25', 'YYYY-MM-DD'), 0);
INSERT INTO cuenta VALUES ('GoldenChampion', 'goldenchampion@freakymon.com', 'gold#9876', 'usuario', TO_DATE('2024-11-10', 'YYYY-MM-DD'), TO_DATE('2024-11-24', 'YYYY-MM-DD'), 1);
INSERT INTO cuenta VALUES ('DragonMaster', 'dragonmaster@freakymon.com', 'dragon!2024', 'usuario', TO_DATE('2024-11-05', 'YYYY-MM-DD'), TO_DATE('2024-11-23', 'YYYY-MM-DD'), 0);
INSERT INTO cuenta VALUES ('WaterRuler', 'waterruler@freakymon.com', 'waterKing@', 'usuario', TO_DATE('2024-10-20', 'YYYY-MM-DD'), TO_DATE('2024-11-22', 'YYYY-MM-DD'), 2);
INSERT INTO cuenta VALUES ('ElectricSurge', 'electricsurge@freakymon.com', 'electricPower#', 'usuario', TO_DATE('2024-10-15', 'YYYY-MM-DD'), TO_DATE('2024-11-21', 'YYYY-MM-DD'), 1);
INSERT INTO cuenta VALUES ('FireBlaze', 'fireblaze@freakymon.com', 'fireBurns1', 'usuario', TO_DATE('2024-10-10', 'YYYY-MM-DD'), TO_DATE('2024-11-20', 'YYYY-MM-DD'), 3);
INSERT INTO cuenta VALUES ('GrassGuardian', 'grassguardian@freakymon.com', 'grassForever2', 'usuario', TO_DATE('2024-10-05', 'YYYY-MM-DD'), TO_DATE('2024-11-19', 'YYYY-MM-DD'), 2);
INSERT INTO cuenta VALUES ('DarkAvenger', 'darkavenger@freakymon.com', 'darkLord99!', 'usuario', TO_DATE('2024-09-25', 'YYYY-MM-DD'), TO_DATE('2024-11-18', 'YYYY-MM-DD'), 0);
INSERT INTO cuenta VALUES ('MysticMage', 'mysticmage@freakymon.com', 'mysticMagic@', 'usuario', TO_DATE('2024-09-20', 'YYYY-MM-DD'), TO_DATE('2024-11-17', 'YYYY-MM-DD'), 0);
INSERT INTO cuenta VALUES ('WindWhisperer', 'windwhisperer@freakymon.com', 'windFree#3', 'usuario', TO_DATE('2024-09-15', 'YYYY-MM-DD'), TO_DATE('2024-11-16', 'YYYY-MM-DD'), 1);

-- ----------------------------------------------------------------
-- - Nombre de Usuario y Fecha del Sistema. Se tienen que indicar –
-- ----------------------------------------------------------------
SHOW USER
SELECT systimestamp FROM dual;
-- ----------------------------------------------------------------
-- -   Datos de la tabla ataque                                     -
-- ----------------------------------------------------------------
INSERT INTO ataque VALUES (1, 642, 'Impacto Trueno', 'Descarga eléctrica que paraliza al rival.');
INSERT INTO ataque VALUES (2, 985, 'Roca Afilada', 'Fragmentos de roca lanzados a alta velocidad.');
INSERT INTO ataque VALUES (3, 542, 'Llamarada', 'Intenso chorro de fuego que quema todo a su paso.');
INSERT INTO ataque VALUES (4, 568, 'Tsunami', 'Gran ola que arrasa con todo a su paso.');
INSERT INTO ataque VALUES (5, 245, 'Confusión', 'Ataque mental que desorienta al enemigo.');
INSERT INTO ataque VALUES (6, 125, 'Latigazo', 'Látigo de lianas utilizado para atacar a distancia.');
INSERT INTO ataque VALUES (7, 888, 'Sombra Nocturna', 'Energía oscura que causa daño desde las sombras.');
INSERT INTO ataque VALUES (8, 021, 'Puñetazo Feroz', 'Golpe directo que rompe defensas.');
INSERT INTO ataque VALUES (9, 982, 'Tornado', 'Viento fuerte que levanta y lanza a los enemigos.');
INSERT INTO ataque VALUES (10, 101, 'Niebla Tóxica', 'Neblina venenosa que debilita a todos los cercanos.');

-- Inserts para parte 2 del proyecto final 
INSERT INTO ataque VALUES (11, 111, 'Colmillo Dragón', 'Ataque feroz que utiliza colmillos para desgarrar al enemigo.');
INSERT INTO ataque VALUES (12, 222, 'Hielo Ártico', 'Ráfaga de hielo que congela todo a su paso.');
INSERT INTO ataque VALUES (13, 333, 'Puño Metálico', 'Golpe demoledor con puño revestido de acero.');
INSERT INTO ataque VALUES (14, 444, 'Corte Frenético', 'Ataque rápido y devastador con gran precisión.');
INSERT INTO ataque VALUES (15, 555, 'Oscuridad Absoluta', 'Suma las sombras para causar daño masivo.');
INSERT INTO ataque VALUES (16, 666, 'Encanto Divino', 'Poder celestial que aturde al adversario.');
INSERT INTO ataque VALUES (17, 777, 'Golpe Ordinario', 'Un golpe básico que puede ser utilizado repetidamente.');
INSERT INTO ataque VALUES (18, 889, 'Terremoto Devastador', 'Sacude el suelo para causar daño masivo a varios enemigos.');
INSERT INTO ataque VALUES (19, 999, 'Relámpago Fulminante', 'Impacto eléctrico que paraliza y aturde al rival.');
INSERT INTO ataque VALUES (20, 123, 'Explosión Estelar', 'Una explosión masiva con efectos devastadores.');


-- ----------------------------------------------------------------
-- - Nombre de Usuario y Fecha del Sistema. Se tienen que indicar –
-- ----------------------------------------------------------------
SHOW USER
SELECT systimestamp FROM dual;
-- ----------------------------------------------------------------
-- -   Datos de la tabla jugador                                  -
-- ----------------------------------------------------------------
INSERT INTO jugador VALUES ('AshKetchum', 'Ash', 'J', 'Ketchum', NULL, 'Oak St. 12', 'Apt. 4B', 'Pallet Town', 'Los Angeles', 'CA', 11000, TO_DATE('1998-05-22', 'YYYY-MM-DD'), 'Rojo', 'Líder de su equipo FreakyMon.');
INSERT INTO jugador VALUES ('MistyStar', 'Misty', 'L', 'Waterflower', NULL, 'Cerulean 8', NULL, 'Cerulean City', 'Houston', 'TX', 12000, TO_DATE('1997-07-01', 'YYYY-MM-DD'), 'Azul', 'Fanática de los tipos agua.');
INSERT INTO jugador VALUES ('BrockBoulder', 'Brock', 'T', 'Slate', NULL, 'Pewter Lane 42', NULL, 'Pewter City', 'New York City', 'NY', 13000, TO_DATE('1995-04-11', 'YYYY-MM-DD'), 'Amarillo', 'Especialista en tipos roca.');
INSERT INTO jugador VALUES ('TeamRocket123', 'Jessie', 'C', 'Boss', 'James', 'Rocket HQ 1', 'Floor 3', 'Villain''s Alley', 'Miami', 'FL', 14000, TO_DATE('1994-11-14', 'YYYY-MM-DD'), NULL, NULL);
INSERT INTO jugador VALUES ('PikachuFan98', 'Jamie', 'E', 'Sparks', NULL, 'Thunder St. 56', NULL, 'Vermillion City', 'Chicago', 'IL', 15000, TO_DATE('1999-03-05', 'YYYY-MM-DD'), 'Amarillo', 'Amante de los FreakyMons eléctricos.');
INSERT INTO jugador VALUES ('GymLeaderGary', 'Gary', NULL, 'Oak', NULL, 'Rivalry Rd. 78', 'Apt. 1A', 'Viridian City', 'Philadelphia', 'PA', 16000, TO_DATE('1996-12-15', 'YYYY-MM-DD'), 'Amarillo', 'Rival del líder de Pallet Town.');
INSERT INTO jugador VALUES ('FreakyMaster1', 'Linda', NULL, 'Trainer', NULL, 'Gym St. 22', NULL, 'Saffron City', 'Seattle', 'WA', 17000, TO_DATE('2000-02-20', 'YYYY-MM-DD'), 'Amarillo', 'Ganadora del último torneo FreakyMon.');
INSERT INTO jugador VALUES ('RedTrainer', 'Red', NULL, 'Champion', NULL, 'Victory Rd. 10', NULL, 'Indigo Plateau', 'Las Vegas', 'NV', 18000, TO_DATE('1995-08-12', 'YYYY-MM-DD'), 'Rojo', 'Campeón retirado de FreakyMon.');
INSERT INTO jugador VALUES ('BlueFlame9', 'Kelly', NULL, 'Flame', NULL, 'Blaze Blvd. 89', 'Suite 2B', 'Cinnabar Island', 'Atlanta', 'GA', 19000, TO_DATE('2001-06-28', 'YYYY-MM-DD'), 'Azul', 'Amante de los tipos fuego.');
INSERT INTO jugador VALUES ('GreenRanger', 'Finn', 'H', 'Leaf', NULL, 'Forest Dr. 45', NULL, 'Celadon City', 'Phoenix', 'AZ', 20000, TO_DATE('1997-01-19', 'YYYY-MM-DD'), 'Rojo', NULL);

-- Inserts para parte 2 del proyecto final 
INSERT INTO jugador VALUES ('SilverTrainer', 'Alex', 'A', 'Silverstone', 'Trainer', 'Grove St. 12', 'Apt. 2B', 'Pallet Grove', 'Los Angeles', 'CA', 90210, TO_DATE('1998-01-01', 'YYYY-MM-DD'), 'ROJO', 'Estratega habil');
INSERT INTO jugador VALUES ('GoldenChampion', 'Jordan', 'J', 'Goldman', NULL, 'Champion Rd. 8', NULL, 'Champion City', 'New York', 'NY', 10001, TO_DATE('1997-12-12', 'YYYY-MM-DD'), 'AZUL', 'Campeon global');
INSERT INTO jugador VALUES ('DragonMaster', 'Kai', 'K', 'Drake', 'Hunter', 'Dragon Hill 22', NULL, 'Dragons Den', 'Houston', 'TX', 77001, TO_DATE('1996-11-11', 'YYYY-MM-DD'), 'AZUL', 'Especialista en Dragon');
INSERT INTO jugador VALUES ('WaterRuler', 'Morgan', 'M', 'Rivera', NULL, 'Waterfall Lane 5', 'Suite 4A', 'River Town', 'Miami', 'FL', 33101, TO_DATE('1995-10-10', 'YYYY-MM-DD'), 'AMARILLO', NULL);
INSERT INTO jugador VALUES ('ElectricSurge', 'Blake', 'B', 'Spark', NULL, 'Lightning Rd. 45', NULL, 'Thunder Village', 'Seattle', 'WA', 98101, TO_DATE('1994-09-09', 'YYYY-MM-DD'), 'AMARILLO', 'Creador tactico');
INSERT INTO jugador VALUES ('FireBlaze', 'Taylor', 'T', 'Ember', 'Flame', 'Flame Blvd. 10', NULL, 'Flame Ridge', 'Chicago', 'IL', 60601, TO_DATE('1993-08-08', 'YYYY-MM-DD'), 'ROJO', 'Famoso en batallas');
INSERT INTO jugador VALUES ('GrassGuardian', 'Charlie', 'C', 'Forest', NULL, 'Grass Field 3', 'Cottage 1', 'Grassland', 'Austin', 'TX', 73301, TO_DATE('1992-07-07', 'YYYY-MM-DD'), 'AZUL', 'Defensor de la naturaleza');
INSERT INTO jugador VALUES ('DarkAvenger', 'Drew', 'D', 'Shade', 'Night', 'Shadow Path 1', NULL, 'Shadow Alley', 'Phoenix', 'AZ', 85001, TO_DATE('1991-06-06', 'YYYY-MM-DD'), 'ROJO', 'Estilo sombrio');
INSERT INTO jugador VALUES ('MysticMage', 'Quinn', 'Q', 'Myst', NULL, 'Mystic Circle 7', 'Floor 3', 'Mystic Vale', 'Boston', 'MA', 2108, TO_DATE('1990-05-05', 'YYYY-MM-DD'), 'AMARILLO', NULL);
INSERT INTO jugador VALUES ('WindWhisperer', 'Riley', 'R', 'Windley', NULL, 'Windy Heights 9', NULL, 'Windy Plains', 'San Francisco', 'CA', 94101, TO_DATE('1989-04-04', 'YYYY-MM-DD'), 'ROJO', 'Explorador alto');

-- ----------------------------------------------------------------
-- - Nombre de Usuario y Fecha del Sistema. Se tienen que indicar –
-- ----------------------------------------------------------------
SHOW USER
SELECT systimestamp FROM dual;
-- ----------------------------------------------------------------
-- -   Datos de la tabla freakydex                                -
-- ----------------------------------------------------------------
INSERT INTO freakydex (id_pk, jugador_id_fk, freakydex_id_fk, nombre, dulces, dulces_xl, estrella)
VALUES (1, 'AshKetchum', NULL, 'Pikachu', 100, 50, 1);

INSERT INTO freakydex (id_pk, jugador_id_fk, freakydex_id_fk, nombre, dulces, dulces_xl, estrella)
VALUES (2, 'AshKetchum', 1, 'Raichu', 200, 100, 1);

INSERT INTO freakydex (id_pk, jugador_id_fk, freakydex_id_fk, nombre, dulces, dulces_xl, estrella)
VALUES (3, 'MistyStar', NULL, 'Squirtle', 80, 40, 0);

INSERT INTO freakydex (id_pk, jugador_id_fk, freakydex_id_fk, nombre, dulces, dulces_xl, estrella)
VALUES (4, 'MistyStar', 3, 'Wartortle', 150, 75, 1);

INSERT INTO freakydex (id_pk, jugador_id_fk, freakydex_id_fk, nombre, dulces, dulces_xl, estrella)
VALUES (5, 'MistyStar', 4, 'Blastoise', 250, 125, 1);

INSERT INTO freakydex (id_pk, jugador_id_fk, freakydex_id_fk, nombre, dulces, dulces_xl, estrella)
VALUES (6, 'BrockBoulder', NULL, 'Geodude', 120, 60, 0);

INSERT INTO freakydex (id_pk, jugador_id_fk, freakydex_id_fk, nombre, dulces, dulces_xl, estrella)
VALUES (7, 'BrockBoulder', 6, 'Graveler', 200, 100, 1);

INSERT INTO freakydex (id_pk, jugador_id_fk, freakydex_id_fk, nombre, dulces, dulces_xl, estrella)
VALUES (8, 'BrockBoulder', 7, 'Golem', 300, 150, 1);

INSERT INTO freakydex (id_pk, jugador_id_fk, freakydex_id_fk, nombre, dulces, dulces_xl, estrella)
VALUES (9, 'TeamRocket123', NULL, 'Meowth', 150, 70, 1);

INSERT INTO freakydex (id_pk, jugador_id_fk, freakydex_id_fk, nombre, dulces, dulces_xl, estrella)
VALUES (10, 'TeamRocket123', 9, 'Persian', 250, 120, 1);

-- Inserts para parte 2 del proyecto final 
INSERT INTO freakydex VALUES (11, 'SilverTrainer', NULL, 'Dratini', 50, 25, 0);
INSERT INTO freakydex VALUES (12, 'GoldenChampion', 11, 'Dragonair', 100, 50, 1);
INSERT INTO freakydex VALUES (13, 'DragonMaster', 12, 'Dragonite', 150, 75, 1);
INSERT INTO freakydex VALUES (14, 'WaterRuler', NULL, 'Squirtle', 60, 30, 0);
INSERT INTO freakydex VALUES (15, 'ElectricSurge', 13, 'Electabuzz', 80, 40, 0);
INSERT INTO freakydex VALUES (16, 'FireBlaze', NULL, 'Charmander', 40, 20, 0);
INSERT INTO freakydex VALUES (17, 'GrassGuardian', 14, 'Bulbasaur', 50, 25, 0);
INSERT INTO freakydex VALUES (18, 'DarkAvenger', 15, 'Umbreon', 90, 45, 1);
INSERT INTO freakydex VALUES (19, 'MysticMage', NULL, 'Espeon', 70, 35, 0);
INSERT INTO freakydex VALUES (20, 'WindWhisperer', 16, 'Pidgey', 30, 15, 0);


-- ----------------------------------------------------------------
-- - Nombre de Usuario y Fecha del Sistema. Se tienen que indicar –
-- ----------------------------------------------------------------
SHOW USER
SELECT systimestamp FROM dual;
-- ----------------------------------------------------------------
-- -   Datos de la tabla freakymon                                -
-- ----------------------------------------------------------------
INSERT INTO freakymon VALUES (234, NULL, 'Bulbasaur', 'M', 35, 35, 1500, 0.4, 6.0);
INSERT INTO freakymon VALUES (512, 1, 'Pikachu', 'M', 100, 90, 4000, 0.8, 20.0);
INSERT INTO freakymon VALUES (678, NULL, 'Charmander', 'M', 40, 40, 1800, 0.5, 20.0);
INSERT INTO freakymon VALUES (893, 3, 'Squirtle', 'M', 80, 70, 2200, 1.0, 30.0);
INSERT INTO freakymon VALUES (112, 4, 'Wartortle', 'M', 120, 110, 3000, 1.5, 85.0);
INSERT INTO freakymon VALUES (431, NULL, 'Eevee', 'F', 50, 50, 1500, 0.5, 20.0);
INSERT INTO freakymon VALUES (789, 6, 'Geodude', 'M', 100, 90, 2500, 1.2, 90.0);
INSERT INTO freakymon VALUES (135, 7, 'Graveler', 'M', 150, 140, 3500, 1.6, 120.0);
INSERT INTO freakymon VALUES (560, NULL, 'Pidgey', 'F', 40, 40, 1600, 0.3, 5.0);
INSERT INTO freakymon VALUES (912, 9, 'Meowth', 'F', 80, 75, 2300, 0.6, 50.0);

-- Inserts para parte 2 del proyecto final 
INSERT INTO freakymon VALUES (101, NULL, 'Dratini', 'F', 120, 110, 4500, 1.8, 3.3);
INSERT INTO freakymon VALUES (102, 11, 'Dragonair', 'F', 150, 140, 5500, 4.0, 16.5);
INSERT INTO freakymon VALUES (103, 12, 'Dragonite', 'M', 200, 180, 10000, 2.2, 210.0);
INSERT INTO freakymon VALUES (104, NULL, 'Blastoise', 'M', 190, 180, 5800, 1.6, 85.5);
INSERT INTO freakymon VALUES (105, 13, 'Electabuzz', 'M', 130, 120, 5200, 1.1, 30.0);
INSERT INTO freakymon VALUES (106, NULL, 'Flareon', 'F', 150, 140, 4800, 0.9, 25.0);
INSERT INTO freakymon VALUES (107, 14, 'Ivysaur', 'M', 120, 115, 3500, 1.0, 13.0);
INSERT INTO freakymon VALUES (108, 15, 'Umbreon', 'F', 160, 150, 4800, 1.0, 27.0);
INSERT INTO freakymon VALUES (109, NULL, 'Jolteon', 'M', 130, 125, 4600, 0.8, 24.5);
INSERT INTO freakymon VALUES (110, 16, 'Spearow', 'M', 60, 55, 1800, 0.3, 2.0);

-- ----------------------------------------------------------------
-- - Nombre de Usuario y Fecha del Sistema. Se tienen que indicar –
-- ----------------------------------------------------------------
SHOW USER
SELECT systimestamp FROM dual;
-- ----------------------------------------------------------------
-- -   Datos de la tabla tipo_mon                                 -
-- ----------------------------------------------------------------
INSERT INTO tipo_mon VALUES (234, 125);
INSERT INTO tipo_mon VALUES (512, 642);
INSERT INTO tipo_mon VALUES (678, 125);
INSERT INTO tipo_mon VALUES (893, 568);
INSERT INTO tipo_mon VALUES (112, 568);
INSERT INTO tipo_mon VALUES (431, 125);
INSERT INTO tipo_mon VALUES (789, 985);
INSERT INTO tipo_mon VALUES (135, 985);
INSERT INTO tipo_mon VALUES (560, 982);
INSERT INTO tipo_mon VALUES (912, 888);
INSERT INTO tipo_mon VALUES (234, 101);

-- Inserts para parte 2 del proyecto final 
INSERT INTO tipo_mon VALUES (101, 111); 
INSERT INTO tipo_mon VALUES (102, 111); 
INSERT INTO tipo_mon VALUES (103, 111); 
INSERT INTO tipo_mon VALUES (104, 568); 
INSERT INTO tipo_mon VALUES (105, 642); 
INSERT INTO tipo_mon VALUES (106, 542); 
INSERT INTO tipo_mon VALUES (107, 125);
INSERT INTO tipo_mon VALUES (108, 555); 
INSERT INTO tipo_mon VALUES (109, 642); 
INSERT INTO tipo_mon VALUES (110, 982); 


-- ----------------------------------------------------------------
-- - Nombre de Usuario y Fecha del Sistema. Se tienen que indicar –
-- ----------------------------------------------------------------
SHOW USER
SELECT systimestamp FROM dual;
-- ----------------------------------------------------------------
-- -   Datos de la tabla ataque_mon                               -
-- ----------------------------------------------------------------
INSERT INTO ataque_mon VALUES (234, 6, 12);
INSERT INTO ataque_mon VALUES (512, 1, 16);
INSERT INTO ataque_mon VALUES (678, 3, 20);
INSERT INTO ataque_mon VALUES (893, 8, 11);
INSERT INTO ataque_mon VALUES (112, 4, 12);
INSERT INTO ataque_mon VALUES (431, 10, 21);
INSERT INTO ataque_mon VALUES (789, 2, 9);
INSERT INTO ataque_mon VALUES (135, 7, 14);
INSERT INTO ataque_mon VALUES (560, 9, 19);
INSERT INTO ataque_mon VALUES (912, 5, 30);
INSERT INTO ataque_mon VALUES (112, 8, 17);
INSERT INTO ataque_mon VALUES (789, 7, 19);
INSERT INTO ataque_mon VALUES (678, 9, 31);

-- Inserts para parte 2 del proyecto final 
INSERT INTO ataque_mon VALUES (101, 1, 120);
INSERT INTO ataque_mon VALUES (102, 1, 140);
INSERT INTO ataque_mon VALUES (102, 3, 130);
INSERT INTO ataque_mon VALUES (103, 1, 200);
INSERT INTO ataque_mon VALUES (103, 3, 190);
INSERT INTO ataque_mon VALUES (103, 5, 180);
INSERT INTO ataque_mon VALUES (104, 4, 150);
INSERT INTO ataque_mon VALUES (105, 6, 170);
INSERT INTO ataque_mon VALUES (106, 3, 140);
INSERT INTO ataque_mon VALUES (107, 2, 130);


-- ----------------------------------------------------------------
-- - Nombre de Usuario y Fecha del Sistema. Se tienen que indicar –
-- ----------------------------------------------------------------
SHOW USER
SELECT systimestamp FROM dual;
-- ----------------------------------------------------------------
-- -   Datos de la tabla gym_mon                                  -
-- ----------------------------------------------------------------
INSERT INTO gym_mon VALUES (1, 234, '10-NOV-2024', NULL, 5);
INSERT INTO gym_mon VALUES (2, 512, '12-NOV-2024', NULL, 7);
INSERT INTO gym_mon VALUES (3, 678, '11-NOV-2024', '20-NOV-2024', 4);
INSERT INTO gym_mon VALUES (4, 893, '15-NOV-2024', NULL, 6);
INSERT INTO gym_mon VALUES (5, 112, '17-NOV-2024', NULL, 8);
INSERT INTO gym_mon VALUES (6, 431, '14-NOV-2024', NULL, 3);
INSERT INTO gym_mon VALUES (7, 789, '13-NOV-2024', NULL, 9);
INSERT INTO gym_mon VALUES (8, 135, '18-NOV-2024', NULL, 2);
INSERT INTO gym_mon VALUES (9, 560, '16-NOV-2024', '22-NOV-2024', 5);
INSERT INTO gym_mon VALUES (10, 912, '19-NOV-2024', NULL, 7);

-- Inserts para parte 2 del proyecto final 
INSERT INTO gym_mon VALUES (11, 101, '01-DEC-2024', NULL, 2);
INSERT INTO gym_mon VALUES (12, 102, '02-DEC-2024', '03-DEC-2024', 3);
INSERT INTO gym_mon VALUES (13, 103, '04-DEC-2024', NULL, 5);
INSERT INTO gym_mon VALUES (14, 104, '05-DEC-2024', NULL, 1);
INSERT INTO gym_mon VALUES (15, 105, '06-DEC-2024', NULL, 4);
INSERT INTO gym_mon VALUES (16, 106, '07-DEC-2024', '08-DEC-2024', 3);
INSERT INTO gym_mon VALUES (17, 107, '09-DEC-2024', NULL, 6);
INSERT INTO gym_mon VALUES (18, 108, '10-DEC-2024', NULL, 5);
INSERT INTO gym_mon VALUES (19, 109, '11-DEC-2024', '12-DEC-2024', 2);
INSERT INTO gym_mon VALUES (20, 110, '13-DEC-2024', NULL, 4);


-- ----------------------------------------------------------------
-- - Nombre de Usuario y Fecha del Sistema. Se tienen que indicar –
-- ----------------------------------------------------------------
SHOW USER
SELECT systimestamp FROM dual;
-- ----------------------------------------------------------------
-- -   Datos de la tabla pelea                                    -
-- ----------------------------------------------------------------
INSERT INTO pelea VALUES (234, 1, '25-NOV-2024 02:30:00 PM', 'Derrota');
INSERT INTO pelea VALUES (512, 2, '25-NOV-2024 03:00:00 PM', 'Victoria');
INSERT INTO pelea VALUES (678, 3, '26-NOV-2024 10:00:00 AM', 'Derrota');
INSERT INTO pelea VALUES (893, 4, '26-NOV-2024 12:15:00 PM', 'Derrota');
INSERT INTO pelea VALUES (112, 5, '27-NOV-2024 04:00:00 PM', 'Victoria');
INSERT INTO pelea VALUES (431, 6, '27-NOV-2024 04:30:00 PM', 'Derrota');
INSERT INTO pelea VALUES (789, 7, '28-NOV-2024 10:00:00 AM', 'Victoria');
INSERT INTO pelea VALUES (135, 8, '28-NOV-2024 11:00:00 AM', 'Victoria');
INSERT INTO pelea VALUES (560, 9, '29-NOV-2024 09:30:00 AM', 'Derrota');
INSERT INTO pelea VALUES (912, 10, '29-NOV-2024 10:15:00 AM', 'Victoria');

-- Inserts para parte 2 del proyecto final 
INSERT INTO pelea VALUES (101, 11, '01-DEC-2024 10:30:00 AM', 'Victoria');
INSERT INTO pelea VALUES (102, 12, '02-DEC-2024 11:00:00 AM', 'Derrota');
INSERT INTO pelea VALUES (103, 13, '03-DEC-2024 09:45:00 AM', 'Victoria');
INSERT INTO pelea VALUES (104, 14, '04-DEC-2024 02:15:00 PM', 'Victoria');
INSERT INTO pelea VALUES (105, 15, '05-DEC-2024 01:30:00 PM', 'Derrota');
INSERT INTO pelea VALUES (106, 16, '06-DEC-2024 12:20:00 PM', 'Derrota');
INSERT INTO pelea VALUES (107, 17, '07-DEC-2024 03:10:00 PM', 'Victoria');
INSERT INTO pelea VALUES (108, 18, '08-DEC-2024 04:00:00 PM', 'Derrota');
INSERT INTO pelea VALUES (109, 19, '09-DEC-2024 05:45:00 PM', 'Victoria');
INSERT INTO pelea VALUES (110, 20, '10-DEC-2024 06:30:00 PM', 'Victoria');


-- ----------------------------------------------------------------
-- - Nombre de Usuario y Fecha del Sistema. Se tienen que indicar –
-- ----------------------------------------------------------------
SHOW USER
SELECT systimestamp FROM dual;
-- ----------------------------------------------------------------
-- -   Datos de la tabla captura                                  -
-- ----------------------------------------------------------------
INSERT INTO captura VALUES (512, 'AshKetchum', 37.7749, -122.4194, '15-NOV-2024 10:30:00 AM');
INSERT INTO captura VALUES (678, 'MistyStar', 40.7128, -74.0060, '12-NOV-2024 03:00:00 PM');
INSERT INTO captura VALUES (789, 'BrockBoulder', 34.0522, -118.2437, '10-NOV-2024 09:45:00 AM');
INSERT INTO captura VALUES (893, 'GymLeaderGary', 39.7392, -104.9903, '09-NOV-2024 12:00:00 PM');
INSERT INTO captura VALUES (112, 'FreakyMaster1', 41.8781, -87.6298, '14-NOV-2024 06:00:00 PM');
INSERT INTO captura VALUES (135, 'BlueFlame9', 29.7604, -95.3698, '13-NOV-2024 11:15:00 AM');
INSERT INTO captura VALUES (560, 'TeamRocket123', 33.4484, -112.0740, '08-NOV-2024 10:30:00 PM');
INSERT INTO captura VALUES (912, 'RedTrainer', 25.7617, -80.1918, '07-NOV-2024 02:20:00 PM');
INSERT INTO captura VALUES (431, 'PikachuFan98', 32.7157, -117.1611, '06-NOV-2024 08:00:00 AM');
INSERT INTO captura VALUES (234, 'GreenRanger', 47.6062, -122.3321, '05-NOV-2024 04:50:00 PM');


-- Inserts para parte 2 del proyecto final 
INSERT INTO captura VALUES (101, 'AshKetchum', 37.7749, -122.4194, '01-DEC-2024 10:00:00 AM');
INSERT INTO captura VALUES (102, 'MistyStar', 40.7128, -74.0060, '02-DEC-2024 11:15:00 AM');
INSERT INTO captura VALUES (103, 'BrockBoulder', 34.0522, -118.2437, '03-DEC-2024 09:50:00 AM');
INSERT INTO captura VALUES (104, 'TeamRocket123', 41.8781, -87.6298, '04-DEC-2024 02:20:00 PM');
INSERT INTO captura VALUES (105, 'PikachuFan98', 29.7604, -95.3698, '05-DEC-2024 01:45:00 PM');
INSERT INTO captura VALUES (106, 'GymLeaderGary', 39.7392, -104.9903, '06-DEC-2024 12:30:00 PM');
INSERT INTO captura VALUES (107, 'FreakyMaster1', 25.7617, -80.1918, '07-DEC-2024 03:30:00 PM');
INSERT INTO captura VALUES (108, 'RedTrainer', 33.4484, -112.0740, '08-DEC-2024 04:30:00 PM');
INSERT INTO captura VALUES (109, 'BlueFlame9', 47.6062, -122.3321, '09-DEC-2024 05:50:00 PM');
INSERT INTO captura VALUES (110, 'GreenRanger', 32.7157, -117.1611, '10-DEC-2024 06:40:00 PM');

-- ----------------------------------------------------------------
-- - Nombre de Usuario y Fecha del Sistema. Se tienen que indicar –
-- ----------------------------------------------------------------
SHOW USER
SELECT systimestamp FROM dual;
-- ----------------------------------------------------------------
-- -   Datos de la tabla girada                                  -
-- ----------------------------------------------------------------
INSERT INTO girada VALUES (1, 'AshKetchum', 1, 1, NULL, '20-NOV-2024 10:15:00 AM', 3);
INSERT INTO girada VALUES (2, 'MistyStar', 2, NULL, 1, '20-NOV-2024 11:30:00 AM', 1);
INSERT INTO girada VALUES (3, 'BrockBoulder', 4, NULL, 2, '20-NOV-2024 01:45:00 PM', 2);
INSERT INTO girada VALUES (4, 'TeamRocket123', 3, 2, NULL, '21-NOV-2024 08:00:00 AM', 1);
INSERT INTO girada VALUES (5, 'PikachuFan98', 7, 3, NULL, '21-NOV-2024 09:30:00 AM', 5);
INSERT INTO girada VALUES (6, 'GymLeaderGary', 6, NULL, 6, '21-NOV-2024 10:50:00 AM', 2);
INSERT INTO girada VALUES (7, 'FreakyMaster1', 9, 4, NULL, '22-NOV-2024 02:00:00 PM', 1);
INSERT INTO girada VALUES (8, 'RedTrainer', 8, NULL, 8, '22-NOV-2024 04:15:00 PM', 4);
INSERT INTO girada VALUES (9, 'BlueFlame9', 5, 5, NULL, '23-NOV-2024 07:50:00 AM', 2);
INSERT INTO girada VALUES (10, 'GreenRanger', 10, 6, NULL, '23-NOV-2024 12:30:00 PM', 1);

-- Inserts para parte 2 del proyecto final 
INSERT INTO girada VALUES (11, 'AshKetchum', 11, 1, NULL, '01-DEC-2024 10:30:00 AM', 3);
INSERT INTO girada VALUES (12, 'MistyStar', 12, NULL, 2, '02-DEC-2024 11:00:00 AM', 2);
INSERT INTO girada VALUES (13, 'BrockBoulder', 13, 3, NULL, '03-DEC-2024 09:45:00 AM', 4);
INSERT INTO girada VALUES (14, 'TeamRocket123', 14, NULL, 4, '04-DEC-2024 02:20:00 PM', 1);
INSERT INTO girada VALUES (15, 'PikachuFan98', 15, 5, NULL, '05-DEC-2024 01:50:00 PM', 5);
INSERT INTO girada VALUES (16, 'GymLeaderGary', 16, NULL, 6, '06-DEC-2024 12:30:00 PM', 3);
INSERT INTO girada VALUES (17, 'FreakyMaster1', 17, 7, NULL, '07-DEC-2024 03:10:00 PM', 2);
INSERT INTO girada VALUES (18, 'RedTrainer', 18, NULL, 8, '08-DEC-2024 04:20:00 PM', 4);
INSERT INTO girada VALUES (19, 'BlueFlame9', 19, 9, NULL, '09-DEC-2024 05:40:00 PM', 3);
INSERT INTO girada VALUES (20, 'GreenRanger', 20, NULL, 10, '10-DEC-2024 06:45:00 PM', 2);


-- ----------------------------------------------------------------
-- - Nombre de Usuario y Fecha del Sistema. Se tienen que indicar –
-- ----------------------------------------------------------------
SHOW USER
SELECT systimestamp FROM dual;
-- ----------------------------------------------------------------
-- -   Datos de la tabla inventario                               -
-- ----------------------------------------------------------------
INSERT INTO inventario VALUES ('AshKetchum', 1, 5, '29-NOV-2024');
INSERT INTO inventario VALUES ('MistyStar', 2, 3, '29-NOV-2024');
INSERT INTO inventario VALUES ('BrockBoulder', 3, 15, '28-NOV-2024');
INSERT INTO inventario VALUES ('TeamRocket123', 7, 5, '27-NOV-2024');
INSERT INTO inventario VALUES ('PikachuFan98', 9, 10, '29-NOV-2024');
INSERT INTO inventario VALUES ('GymLeaderGary', 6, 1, '26-NOV-2024');
INSERT INTO inventario VALUES ('FreakyMaster1', 4, 20, '29-NOV-2024');
INSERT INTO inventario VALUES ('RedTrainer', 5, 2, '29-NOV-2024');
INSERT INTO inventario VALUES ('BlueFlame9', 10, 3, '28-NOV-2024');
INSERT INTO inventario VALUES ('GreenRanger', 8, 12, '27-NOV-2024');


-- Inserts para parte 2 del proyecto final 
INSERT INTO inventario VALUES ('AshKetchum', 11, 10, '01-DEC-2024');
INSERT INTO inventario VALUES ('MistyStar', 12, 15, '02-DEC-2024');
INSERT INTO inventario VALUES ('BrockBoulder', 13, 5, '03-DEC-2024');
INSERT INTO inventario VALUES ('TeamRocket123', 14, 8, '04-DEC-2024');
INSERT INTO inventario VALUES ('PikachuFan98', 15, 12, '05-DEC-2024');
INSERT INTO inventario VALUES ('GymLeaderGary', 16, 20, '06-DEC-2024');
INSERT INTO inventario VALUES ('FreakyMaster1', 17, 25, '07-DEC-2024');
INSERT INTO inventario VALUES ('RedTrainer', 18, 10, '08-DEC-2024');
INSERT INTO inventario VALUES ('BlueFlame9', 19, 7, '09-DEC-2024');
INSERT INTO inventario VALUES ('GreenRanger', 20, 15, '10-DEC-2024');



-- ----------------------------------------------------------------
-- -   Guarda los datos. De no ponerse, como quiera los guarda   -
-- - en una corrida.  Se deja para explicar su uso.             -
-- ----------------------------------------------------------------
COMMIT;


-- ----------------------------------------------------------------
-- - Nombre de Usuario y Fecha del Sistema. Se tienen que indicar –
-- ----------------------------------------------------------------
SHOW USER
SELECT systimestamp FROM dual;
-- ---------------------------------------------------------------------
-- SELECT de todas las entidades de la base de datos                   -
-- ---------------------------------------------------------------------
-- Obtener todos los datos de la tabla "tipo"
SELECT * FROM tipo;

-- Obtener todos los datos de la tabla "gym"
SELECT * FROM gym;

-- Obtener todos los datos de la tabla "freakystop"
SELECT * FROM freakystop;

-- Obtener todos los datos de la tabla "item"
SELECT * FROM item;

-- Obtener todos los datos de la tabla "cuenta"
SELECT * FROM cuenta;

-- Obtener todos los datos de la tabla "ataque"
SELECT * FROM ataque;

-- Obtener todos los datos de la tabla "jugador"
SELECT * FROM jugador;

-- Obtener todos los datos de la tabla "freakydex"
SELECT * FROM freakydex;

-- Obtener todos los datos de la tabla "freakymon"
SELECT * FROM freakymon;

-- Obtener todos los datos de la tabla "tipo_mon"
SELECT * FROM tipo_mon;

-- Obtener todos los datos de la tabla "ataque_mon"
SELECT * FROM ataque_mon;

-- Obtener todos los datos de la tabla "gym_mon"
SELECT * FROM gym_mon;

-- Obtener todos los datos de la tabla "pelea"
SELECT * FROM pelea;

-- Obtener todos los datos de la tabla "captura"
SELECT * FROM captura;

-- Obtener todos los datos de la tabla "inventario"
SELECT * FROM inventario;

-- Obtener todos los datos de la tabla "girada"
SELECT * FROM girada;
