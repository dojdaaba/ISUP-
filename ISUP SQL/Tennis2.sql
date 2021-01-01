

create table JOUEUR
( NuJOUEUR     int,
   NOM          varchar(12),
   PRENOM       varchar(14),
   AnNaiss      smallint,
   NATIONALITE  varchar(12));

create table RENCONTRE
( NuGAGNANT    int,
   NuPERDANT    int,
   LIEUTOURNOI  varchar(15),
   ANNEE        smallint);

create table GAIN
( NuJOUEUR     int,
   LIEUTOURNOI  varchar(15),
   ANNEE        smallint,
   PRIME        decimal,
   NOMSPONSOR   varchar(10));


insert into JOUEUR
  values (1, 'MARTINEZ', 'Conchita', 1972, 'Espagne');
insert into JOUEUR
  values (2, 'NAVRATILOVA', 'Martina', 1957, 'Etats-Unis');
insert into JOUEUR
  values (3, 'GRAF', 'Steffi', 1969, 'Allemagne');
insert into JOUEUR
  values (4, 'HALARD', 'Julie', 1970, 'France');
insert into JOUEUR
  values (5, 'PIERCE', 'Mary', 1975, 'France');
insert into JOUEUR
  values (6, 'EDBERG', 'Stephan', 1966, 'Suede');
insert into JOUEUR
  values (7, 'LARSSON', 'Magnus', 1970, 'Suede');
insert into JOUEUR
  values (8, 'LECONTE', 'Henri', 1963, 'France');
insert into JOUEUR
  values (9, 'FORGET', 'Guy', 1965, 'France');
insert into JOUEUR
  values (10, 'FLEURIAN', 'Jean-Philippe', 1965, 'France');
insert into JOUEUR
  values (11, 'WILANDER', 'Mats', 1964, 'Suede');
insert into JOUEUR
  values (12, 'CONNORS', 'Jimmy', 1952, 'Etats-Unis');
insert into JOUEUR
  values (13, 'McENROE', 'John', 1959, 'Etats-Unis');
insert into JOUEUR
  values (14, 'SAMPRAS', 'Pete', 1972, 'Etats-Unis');

insert into RENCONTRE
  values (13, 9, 'Roland Garros', 1990);
insert into RENCONTRE
  values (11, 12, 'Roland Garros', 1990);
insert into RENCONTRE
  values (13, 11, 'Roland Garros', 1990);
insert into RENCONTRE
  values (2, 3, 'Roland Garros', 1990);
insert into RENCONTRE
  values (13, 12, 'Roland Garros', 1992);
insert into RENCONTRE
  values (6, 14, 'Roland Garros', 1992);
insert into RENCONTRE
  values (11, 9, 'Roland Garros', 1992);
insert into RENCONTRE
  values (8, 7, 'Roland Garros', 1992);
insert into RENCONTRE
  values (13, 8, 'Roland Garros', 1992);
insert into RENCONTRE
  values (6, 11, 'Roland Garros', 1992);
insert into RENCONTRE
  values (13, 6, 'Roland Garros', 1992);
insert into RENCONTRE
  values (2, 3, 'Roland Garros', 1992);
insert into RENCONTRE
  values (14, 10, 'Roland Garros', 1994);
insert into RENCONTRE
  values (8, 9, 'Roland Garros', 1994);
insert into RENCONTRE
  values (14, 8, 'Roland Garros', 1994);
insert into RENCONTRE
  values (2, 4, 'Roland Garros', 1994);
insert into RENCONTRE
  values (1, 3, 'Roland Garros', 1994);
insert into RENCONTRE
  values (2, 1, 'Roland Garros', 1994);
insert into RENCONTRE
  values (11, 8, 'Wimbledon', 1989);
insert into RENCONTRE
  values (12, 13, 'Wimbledon', 1989);
insert into RENCONTRE
  values (11, 12, 'Wimbledon', 1989);
insert into RENCONTRE
  values (3, 2, 'Wimbledon', 1989);
insert into RENCONTRE
  values (14, 13, 'Wimbledon', 1992);
insert into RENCONTRE
  values (6, 9, 'Wimbledon', 1992);
insert into RENCONTRE
  values (6, 14, 'Wimbledon', 1992);
insert into RENCONTRE
  values (3, 5, 'Wimbledon', 1992);
insert into RENCONTRE
  values (2, 4, 'Wimbledon', 1992);
insert into RENCONTRE
  values (3, 2, 'Wimbledon', 1992);
insert into RENCONTRE
  values (14, 10, 'Wimbledon', 1993);
insert into RENCONTRE
  values (7, 9, 'Wimbledon', 1993);
insert into RENCONTRE
  values (14, 7, 'Wimbledon', 1993);
insert into RENCONTRE
  values (1, 5, 'Wimbledon', 1993);
insert into RENCONTRE
  values (2, 4, 'Wimbledon', 1993);
insert into RENCONTRE
  values (1, 2, 'Wimbledon', 1993);
insert into RENCONTRE
  values (12, 9, 'Flushing Meadow', 1989);
insert into RENCONTRE
  values (2, 3, 'Flushing Meadow', 1989);
insert into RENCONTRE
  values (12, 7, 'Flushing Meadow', 1991);

insert into GAIN
  values (14, 'Roland Garros', 1992, 0.2e6, 'Peugeot');
insert into GAIN
  values (14, 'Roland Garros', 1994, 1.8e6, 'Reebok');
insert into GAIN
  values (14, 'Wimbledon', 1992, 0.7e6, 'Peugeot');
insert into GAIN
  values (14, 'Wimbledon', 1993, 1.4e6, 'Peugeot');
insert into GAIN
  values (13, 'Roland Garros', 1990, 1.1e6, 'Kennex');
insert into GAIN
  values (13, 'Roland Garros', 1992, 1.5e6, 'Kennex');
insert into GAIN
  values (13, 'Wimbledon', 1989, 0.35e6, 'Donnay');
insert into GAIN
  values (13, 'Wimbledon', 1992, 0.4e6, 'Kennex');
insert into GAIN
  values (12, 'Roland Garros', 1990, 0.4e6, 'Dunlop');
insert into GAIN
  values (12, 'Roland Garros', 1992, 0.2e6, 'Dunlop');
insert into GAIN
  values (12, 'Wimbledon', 1989, 0.6e6, 'Dunlop');
insert into GAIN
  values (12, 'Flushing Meadow', 1989, 1.6e6, 'Dunlop');
insert into GAIN
  values (12, 'Flushing Meadow', 1991, 1.8e6, 'Lacoste');
insert into GAIN
  values (11, 'Roland Garros', 1990, 0.7e6, 'Kennex');
insert into GAIN
  values (11, 'Roland Garros', 1992, 0.5e6, 'Kennex');
insert into GAIN
  values (11, 'Wimbledon', 1989, 1.0e6, 'Dunlop');
insert into GAIN
  values (10, 'Roland Garros', 1994, 0.6e6, 'Peugeot');
insert into GAIN
  values (10, 'Wimbledon', 1993, 0.5e6, 'Peugeot');
insert into GAIN
  values (8, 'Roland Garros', 1992, 0.5e6, 'Lacoste');
insert into GAIN
  values (8, 'Roland Garros', 1994, 1.0e6, 'Reebok');
insert into GAIN
  values (8, 'Wimbledon', 1989, 0.35e6, 'Peugeot');
insert into GAIN
  values (7, 'Roland Garros', 1992, 0.2e6, 'Donnay');
insert into GAIN
  values (7, 'Wimbledon', 1993, 0.8e6, 'Reebok');
insert into GAIN
  values (7, 'Flushing Meadow', 1991, 1.0e6, 'Donnay');
insert into GAIN
  values (6, 'Roland Garros', 1992, 0.9e6, 'Dunlop');
insert into GAIN
  values (6, 'Wimbledon', 1992, 1.2e6, 'Dunlop');
insert into GAIN
  values (5, 'Wimbledon', 1992, 0.3e6, 'Dunlop');
insert into GAIN
  values (5, 'Wimbledon', 1993, 0.35e6, 'Reebok');
insert into GAIN
  values (4, 'Roland Garros', 1994, 0.4e6, 'Lacoste');
insert into GAIN
  values (4, 'Wimbledon', 1992, 0.3e6, 'Lacoste');
insert into GAIN
  values (4, 'Wimbledon', 1993, 0.35e6, 'Lacoste');
insert into GAIN
  values (9, 'Roland Garros', 1990, 0.4e6, 'Peugeot');
insert into GAIN
  values (9, 'Roland Garros', 1992, 0.2e6, 'Peugeot');
insert into GAIN
  values (9, 'Roland Garros', 1994, 0.6e6, 'Reebok');
insert into GAIN
  values (9, 'Wimbledon', 1992, 0.4e6, 'Peugeot');
insert into GAIN
  values (9, 'Wimbledon', 1993, 0.5e6, 'Reebok');
insert into GAIN
  values (9, 'Flushing Meadow', 1989, 0.9e6, 'Lacoste');
insert into GAIN
  values (3, 'Roland Garros', 1990, 0.5e6, 'Donnay');
insert into GAIN
  values (3, 'Roland Garros', 1992, 0.55e6, 'Donnay');
insert into GAIN
  values (3, 'Roland Garros', 1994, 0.4e6, 'Reebok');
insert into GAIN
  values (3, 'Wimbledon', 1989, 0.75e6, 'Donnay');
insert into GAIN
  values (3, 'Wimbledon', 1992, 0.85e6, 'Donnay');
insert into GAIN
  values (3, 'Flushing Meadow', 1989, 0.7e6, 'Donnay');
insert into GAIN
  values (2, 'Roland Garros', 1990, 0.8e6, 'Vittel');
insert into GAIN
  values (2, 'Roland Garros', 1992, 0.9e6, 'Vittel');
insert into GAIN
  values (2, 'Roland Garros', 1994, 1.2e6, 'Donnay');
insert into GAIN
  values (2, 'Wimbledon', 1989, 0.4e6, 'Vittel');
insert into GAIN
  values (2, 'Wimbledon', 1992, 0.5e6, 'Vittel');
insert into GAIN
  values (2, 'Wimbledon', 1993, 0.6e6, 'Donnay');
insert into GAIN
  values (2, 'Flushing Meadow', 1989, 1.0e6, 'Vittel');
insert into GAIN
  values (1, 'Wimbledon', 1993, 0.9e6, 'Nike');
insert into GAIN
  values (1, 'Roland Garros', 1994, 0.8e6, 'Nike');


