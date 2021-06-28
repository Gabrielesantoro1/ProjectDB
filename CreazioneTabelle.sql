create table Allergia
(
	NomeAllergia varchar(30) primary key
)

create table Cittadino
(
	Nome varchar(15) not null,
	Cognome varchar(20) not null,
	CodiceFiscale numeric(8) primary key,
	Età integer not null,
	Città varchar(25) not null,
	Indirizzo varchar(35),
	Positività boolean not null,
	Categoria varchar(30) not null check(Categoria = 'Categoria Fragile' or Categoria = 'Personale Sanitario' or Categoria = 'Altro' )
)

create table Soffre
(
	Cittadino numeric(8)
			  references Cittadino(CodiceFiscale),
	Allergia varchar(30) 
			  references Allergia(NomeAllergia),
	primary key(Cittadino,Allergia)
)

create table Convocazione
(
	CodiceConvocazione numeric(9) primary key,
	DataPrimaDose date not null,
	DataSecondaDose date,
	Ora time,
	IDCentro numeric(4) not null,
	TipoVaccino varchar(10) not null,
	Cittadino numeric(8) unique
			  references Cittadino(CodiceFiscale)
)

create table Prenotazione
(
	CodicePrenotazione numeric(9) unique,
	Cittadino numeric(8)
			  references Cittadino(CodiceFiscale),
	RecTel numeric(10),
	Email varchar(25),
	primary key(CodicePrenotazione,Cittadino)
)

create table CittadinoVaccinando
(
	CodiceFiscale numeric(8) primary key
				  references Cittadino(CodiceFiscale),
	Convocazione numeric(9)
				 references Convocazione(CodiceConvocazione)
)

create table CittadinoVaccinato
(
	CodiceFiscale numeric(8) primary key
				  references Cittadino(CodiceFiscale),
	ReazioneAllergica boolean
)

create table Medico
(
	Matricola numeric(7) primary key,
	Specializzazione varchar(20) check (Specializzazione = 'Medico di Base' or Specializzazione = 'Altro'),
	Cittadino numeric(8)
			  references Cittadino(CodiceFiscale)
)

create table Affidamento
(
	CittadinoVaccinando numeric(8) primary key
						references CittadinoVaccinando(CodiceFiscale),
	Medico numeric(7) 
		   references Medico(Matricola)
)

create table Osservazione
(
	CittadinoVaccinato numeric(8) primary key
					   references CittadinoVaccinato(CodiceFiscale),
	Medico numeric(7) 
		   references Medico(Matricola),
	TempoOsservazione integer check (TempoOsservazione >= 15)
)

create table CentroVaccinale
(
	IDCentro numeric(4) primary key,
	Città varchar(25),
	Indirizzo varchar(35),
	unique(Città,Indirizzo)
)

create table Afferenza
(
	Medico numeric(7) primary key
		   references Medico(Matricola),
	CentroVaccinale numeric(4)
		            references CentroVaccinale(IDCentro)
)

create table Approviggionamento 
(
	CentroVaccinale numeric(4) 
					references CentroVaccinale(IDCentro),
	Vaccino varchar(10)
			references Vaccino(NomeVaccino),
	Fiale integer check(Fiale >= 0),
	primary key(CentroVaccinale,Vaccino)
)

create table Vaccino
(
	NomeVaccino varchar(10) primary key,
	Efficacia integer check(Efficacia >= 97),
	EtàMax integer not null,
	EtàMin integer not null,
	Richiamo boolean not null,
	IntTemp integer
)

create table Lotto
(
	NumLotto numeric(5),
	Vaccino varchar(10)
			references Vaccino(NomeVaccino),
	DataProd date,
	Scadenza date not null,
	ReazioniAllergiche boolean,
	primary key(NumLotto,Vaccino)
)

create table Report
(
	Data date,
	CittadinoVaccinato numeric(8) 
					   references CittadinoVaccinato(CodiceFiscale),
	Vaccino varchar(10),
	Lotto numeric(5),
	IDCentro numeric(4)
			 references CentroVaccinale(IDCentro),
	Medico numeric(7)
		   references Medico(Matricola),
	primary key(Data,CittadinoVaccinato)
)

create table Aggiornamento
(
	Convocazione numeric(9) primary key
				 references Convocazione(CodiceConvocazione),
	Medico numeric(6)
		   references Medico(Matricola),
	DataSecondaDose date
)

create table Acesso
(
	Cittadino numeric(8) 
			  references Cittadino(CodiceFiscale),
	Vaccino varchar(10)
			references Vaccino(NomeVaccino),
	primary key(Cittadino, Vaccino)
)

create table PuoSomministrare
(
	Medico numeric(6)
		   references Medico(Matricola),
	Vaccino varchar(10)
			references Vaccino(NomeVaccino),
	primary key(Medico,Vaccino)
)

select *
from Cittadino

insert into Cittadino values ('Daniele','Roccaforte','48579632','21','Alcamo','Via rimandato', 'false','Altro'),
insert into Cittadino values ('Lauree','Feckey','48931755','29','Beirut','748 Esch Park','false','Categoria Fragile');
insert into Cittadino values ('Courtney','Coneron','46702505','14','Changchun','455 Oxford Circle','true','Personale Sanitario');
insert into Cittadino values ('Aileen','Hilldrup','45420328','39','Anau','3268 Sloan Pass','true','Altro');
insert into Cittadino values ('Damien','Amort','35983334','46','Belén Gualcho','0986 Arrowood Place','true','Categoria Fragile');
insert into Cittadino values ('Avictor','Bungey','50708932','28','São Sebastião','909 Hagan Circle','true','Personale Sanitario');
insert into Cittadino values ('Anjanette','Rangall','51879950','72','Gamut','774 7th Court','true','Altro');
insert into Cittadino values ('Ursala','Haucke','6061233','44','Nova Odessa','642 Mallory Place','true','Categoria Fragile');
insert into Cittadino values ('Faydra','Acory','17800982','56','Viale','38766 Mosinee Alley','false','Personale Sanitario');
insert into Cittadino values ('Marchelle','O Dee','13122548','23','Néa Ionía','70728 Westerfield Place','false','Altro');
insert into Cittadino values ('Joscelin','Ruttgers','32402280','36','Gaocheng','4034 Magdeline Crossing','false','Categoria Fragile');
insert into Cittadino values ('Jacintha','Mears','31069288','30','Debelets','4 Sage Point','true','Personale Sanitario');
insert into Cittadino values ('Bram','Leary','3740149','68','Huangbao','2 Russell Terrace','false','Altro');
insert into Cittadino values ('Trude','Herrero','54251727','92','Aygek','62 Shopko Road','false','Categoria Fragile');
insert into Cittadino values ('Sal','Delahunty','26651477','24','Dongguang','3224 Waxwing Terrace','true','Personale Sanitario');
insert into Cittadino values ('Carlene','Kinahan','36400771','32','Dhaka','563 Hazelcrest Avenue','false','Altro');
insert into Cittadino values ('Lilith','Kingh','55499787','15','Demerval Lobão','6 Paget Street','true','Categoria Fragile');
insert into Cittadino values ('Prent','Jacketts','56833185','16','Ivanovo','6315 Tomscot Terrace','false','Personale Sanitario');
insert into Cittadino values ('Zea','Pilsworth','23620653','98','de Mayo','88309 Crest Line Way','false','Altro');
insert into Cittadino values ('Gabriele','Santoro','25207845','21','Torino','Via Speranza', 'false','Categoria Fragile');

select*
From Allergia

insert into Allergia values ('Asma allergica');
insert into Allergia values ('Orticaria');
insert into Allergia values ('Farmaci sulfamidici');
insert into Allergia values ('FANS');
insert into Allergia values ('Farmaci chemioterapici');
insert into Allergia values ('Pollinosi');
insert into Allergia values ('Alimentare');

select *
From Soffre

insert into Soffre values('25207845','FANS');
insert into Soffre values('26651477','Pollinosi');
insert into Soffre values('32402280','Orticaria');
insert into Soffre values('45420328','Orticaria');

select *
from Convocazione

insert into Convocazione (CodiceConvocazione, DataPrimaDose, Ora, IDCentro, TipoVaccino, Cittadino) values('20865105','2020-05-13','11:25','4528','Coronax','32402280');
insert into Convocazione (CodiceConvocazione, DataPrimaDose, Ora, IDCentro, TipoVaccino, Cittadino) values('52230059','2020-02-27','20:50','9654','Covidin','17800982');
insert into Convocazione (CodiceConvocazione, DataPrimaDose, Ora, IDCentro, TipoVaccino, Cittadino) values('23278048','2020-01-23','14:10','8542','Coronax','46702505');
insert into Convocazione (CodiceConvocazione, DataPrimaDose, Ora, IDCentro, TipoVaccino, Cittadino) values('7992211','2020-01-25','12:15','9654','Flustop','13122548');
insert into Convocazione (CodiceConvocazione, DataPrimaDose, Ora, IDCentro, TipoVaccino, Cittadino) values('27438120','2020-11-17','15:25','4528','Flustop','55499787');
insert into Convocazione (CodiceConvocazione, DataPrimaDose, Ora, IDCentro, TipoVaccino, Cittadino) values('50579980','2020-03-19','11:50','3654','Covidin','50708932');
insert into Convocazione (CodiceConvocazione, DataPrimaDose, Ora, IDCentro, TipoVaccino, Cittadino) values('57673845','2020-11-02','11:55','2548','Covidin','3740149');
insert into Convocazione (CodiceConvocazione, DataPrimaDose, Ora, IDCentro, TipoVaccino, Cittadino) values('25526554','2020-01-11','19:50','3654','Coronax','26651477');
insert into Convocazione (CodiceConvocazione, DataPrimaDose, Ora, IDCentro, TipoVaccino, Cittadino) values('43543332','2020-04-19','7:05','2548','Flustop','23620653');

select *
from CentroVaccinale

insert into CentroVaccinale values('4528','Gamut','Via Hola cicos');
insert into CentroVaccinale values('9654','Torino','Viale Enaudi');
insert into CentroVaccinale values('2548','Beirut','Via Clandestino');
insert into CentroVaccinale values('3654','São Sebastião','Vias Los Pollos Hermanos');
insert into CentroVaccinale values('8542','Viale','Via della Maria');

select *
from Prenotazione

insert into Prenotazione (CodicePrenotazione, Cittadino, RecTel) values('548724698','35983334','5847596821');
insert into Prenotazione (CodicePrenotazione, Cittadino, Email) values('125487658','45420328','aillenhiddrup@gmallo.com');
insert into Prenotazione (CodicePrenotazione, Cittadino, RecTel) values('125487745','48931755','4587421254');
insert into Prenotazione (CodicePrenotazione, Cittadino, Email) values('365894587','26651477','sal00@hotmallo.com');
insert into Prenotazione (CodicePrenotazione, Cittadino, RecTel) values('658475892','51879950','4587421548');
insert into Prenotazione (CodicePrenotazione, Cittadino, Email) values('955665462','48579632','daniele33@nguaiat.com');
insert into Prenotazione (CodicePrenotazione, Cittadino, RecTel) values('564897652','55499787','5487596524');
insert into Prenotazione (CodicePrenotazione, Cittadino, Email) values('213546238','23620653','Zea@alice.com');

select * 
from Medico

insert into Medico values ('5874965','Medico di Base','46702505');
insert into Medico values ('2541684','Altro','50708932');
insert into Medico values ('2548752','Altro','17800982');
insert into Medico values ('2154879','Medico di Base','31069288');
insert into Medico values ('2569845','Medico di Base','26651477');
insert into Medico values ('2154779','Altro','56833185');

select *
from Vaccino

insert into Vaccino values('Flustop','99','80','15','false','30');
insert into Vaccino values('Covidin','98','70','18','true','25');
insert into Vaccino values('Coronax','100','60','10','true','60');

select *
from Lotto

insert into Lotto values ('78546','Flustop','2020-01-25','2021-01-25','true'); 
insert into Lotto values ('25498','Covidin','2020-01-11','2021-01-11','false'); 
insert into Lotto values ('36548','Coronax','2019-12-22','2020-12-22','false'); 
insert into Lotto values ('25416','Coronax','2019-12-31','2020-12-31','false'); 
insert into Lotto values ('21359','Covidin','2020-01-01','2021-01-01','false'); 
insert into Lotto values ('36587','Flustop','2020-02-02','2021-02-02','true'); 
insert into Lotto values ('96547','Covidin','2020-02-03','2021-02-03','false'); 
insert into Lotto values ('36521','Flustop','2020-02-25','2021-02-25','false'); 

select *
from CittadinoVaccinando

insert into CittadinoVaccinando values ('35983334','20865105');
insert into CittadinoVaccinando values ('45420328','52230059');
insert into CittadinoVaccinando values ('48931755','23278048');
insert into CittadinoVaccinando values ('26651477','7992211');
insert into CittadinoVaccinando values ('51879950','27438120');
insert into CittadinoVaccinando values ('48579632','50579980');
insert into CittadinoVaccinando values ('55499787','57673845');
insert into CittadinoVaccinando values ('23620653','25526554');

select *
from CittadinoVaccinato

insert into CittadinoVaccinato values ('35983334','false');
insert into CittadinoVaccinato values ('46702505','false');
insert into CittadinoVaccinato values ('48579632','false');
insert into CittadinoVaccinato values ('51879950','true');
insert into CittadinoVaccinato values ('56833185','false');
insert into CittadinoVaccinato values ('25207845','false');

select *
from Report

insert into Report values ('2020-05-13','35983334','Coronax','36587','3654','5874965');
insert into Report values ('2020-08-26','46702505','Covidin','78546','8542','2541684');

select *
from Afferenza

insert into Afferenza values ('5874965','3654');
insert into Afferenza values ('2541684','8542');
insert into Afferenza values ('2548752','2548');
insert into Afferenza values ('2154779','8542');
insert into Afferenza values ('2569845','9654');















