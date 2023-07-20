/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2012                    */
/* Created on:     19/07/2023 17:48:21                          */
/*==============================================================*/

CREATE DATABASE GITHUB 
GO 
USE GITHUB
go 
if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Contribution') and o.name = 'FK_CONTRIBU_ASSOCIATI_CONTRIBU')
alter table Contribution
   drop constraint FK_CONTRIBU_ASSOCIATI_CONTRIBU
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Contribution') and o.name = 'FK_CONTRIBU_ASSOCIATI_REPOSITO')
alter table Contribution
   drop constraint FK_CONTRIBU_ASSOCIATI_REPOSITO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Repo_Topic') and o.name = 'FK_REPO_TOP_ASSOCIATI_REPOSITO')
alter table Repo_Topic
   drop constraint FK_REPO_TOP_ASSOCIATI_REPOSITO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Repo_Topic') and o.name = 'FK_REPO_TOP_ASSOCIATI_TOPIC')
alter table Repo_Topic
   drop constraint FK_REPO_TOP_ASSOCIATI_TOPIC
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Repository') and o.name = 'FK_REPOSITO_ASSOCIATI_LANGUAGE')
alter table Repository
   drop constraint FK_REPOSITO_ASSOCIATI_LANGUAGE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Repository') and o.name = 'FK_REPOSITO_ASSOCIATI_TYPEOWNE')
alter table Repository
   drop constraint FK_REPOSITO_ASSOCIATI_TYPEOWNE
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Contribution')
            and   name  = 'CONTRIBUTION_FK2'
            and   indid > 0
            and   indid < 255)
   drop index Contribution.CONTRIBUTION_FK2
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Contribution')
            and   name  = 'CONTRIBUTION_FK'
            and   indid > 0
            and   indid < 255)
   drop index Contribution.CONTRIBUTION_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Contribution')
            and   type = 'U')
   drop table Contribution
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Contributor')
            and   type = 'U')
   drop table Contributor
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Language')
            and   type = 'U')
   drop table Language
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Repo_Topic')
            and   name  = 'REPO_TOPIC_FK2'
            and   indid > 0
            and   indid < 255)
   drop index Repo_Topic.REPO_TOPIC_FK2
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Repo_Topic')
            and   name  = 'REPO_TOPIC_FK'
            and   indid > 0
            and   indid < 255)
   drop index Repo_Topic.REPO_TOPIC_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Repo_Topic')
            and   type = 'U')
   drop table Repo_Topic
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Repository')
            and   name  = 'ASSOCIATION6_FK'
            and   indid > 0
            and   indid < 255)
   drop index Repository.ASSOCIATION6_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Repository')
            and   name  = 'ASSOCIATION5_FK'
            and   indid > 0
            and   indid < 255)
   drop index Repository.ASSOCIATION5_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Repository')
            and   type = 'U')
   drop table Repository
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Topic')
            and   type = 'U')
   drop table Topic
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TypeOwner')
            and   type = 'U')
   drop table TypeOwner
go

/*==============================================================*/
/* Table: Contribution                                          */
/*==============================================================*/
create table Contribution (
   idContrubutor        int                  not null,
   idRepo               bigint               not null,
   number_Contributions     int        null,
   constraint PK_CONTRIBUTION primary key (idContrubutor, idRepo)
)

go

/*==============================================================*/
/* Index: CONTRIBUTION_FK                                       */
/*==============================================================*/
create index CONTRIBUTION_FK on Contribution (
idContrubutor ASC
)
go

/*==============================================================*/
/* Index: CONTRIBUTION_FK2                                      */
/*==============================================================*/
create index CONTRIBUTION_FK2 on Contribution (
idRepo ASC
)
go

/*==============================================================*/
/* Table: Contributor                                           */
/*==============================================================*/
create table Contributor (
   idContrubutor        int           identity(1,1)       not null,
   contrubtor           int                  null,
   constraint PK_CONTRIBUTOR primary key nonclustered (idContrubutor),
   constraint AK_IDENTIFIER_1_CONTRIBU unique (idContrubutor),
   constraint AK_IDENTIFIER_2_CONTRIBU unique (idContrubutor)
)
ALTER TABLE Contributor
ALTER COLUMN contrubtor varchar(max);
go

/*==============================================================*/
/* Table: Language                                              */
/*==============================================================*/
create table Language (
   idLanguage           int          identity(1,1)           not null,
   language             varchar(100)         null,
   constraint PK_LANGUAGE primary key nonclustered (idLanguage)
)
go

/*==============================================================*/
/* Table: Repo_Topic                                            */
/*==============================================================*/
create table Repo_Topic (
   idTopic              int          identity(1,1)           not null,
   idRepo               bigint               not null,
   constraint PK_REPO_TOPIC primary key (idTopic, idRepo)
)
go

/*==============================================================*/
/* Index: REPO_TOPIC_FK                                         */
/*==============================================================*/
create index REPO_TOPIC_FK on Repo_Topic (
idTopic ASC
)
go

/*==============================================================*/
/* Index: REPO_TOPIC_FK2                                        */
/*==============================================================*/
create index REPO_TOPIC_FK2 on Repo_Topic (
idRepo ASC
)
go

/*==============================================================*/
/* Table: Repository                                            */
/*==============================================================*/
create table Repository (
   idRepo               bigint               not null,
   idTypeOwner          int                  null,
   idLanguage           int                  not null,
   fullName             int                  null,
   createdAt            datetime             null,
   startCount           int                  null,
   description          text                 null,
   htmlUrl              text                 null,
   contributorsUrl      int                  null,
   openIssuesCount_     int                  null,
   forks                int                  null,
   constraint PK_REPOSITORY primary key nonclustered (idRepo),
   constraint AK_IDENTIFIER_1_REPOSITO unique (idRepo),
   constraint AK_IDENTIFIER_2_REPOSITO unique (idRepo),
   constraint AK_IDENTIFIER_3_REPOSITO unique (idRepo),
   constraint AK_IDENTIFIER_4_REPOSITO unique (idRepo),
   constraint AK_IDENTIFIER_5_REPOSITO unique (idRepo)
)
go
ALTER TABLE Repository
ALTER COLUMN fullName varchar(max);
ALTER TABLE Repository
ALTER COLUMN contributorsUrl VARCHAR(1000);

/*==============================================================*/
/* Index: ASSOCIATION5_FK                                       */
/*==============================================================*/
create index ASSOCIATION5_FK on Repository (
idLanguage ASC
)
go

/*==============================================================*/
/* Index: ASSOCIATION6_FK                                       */
/*==============================================================*/
create index ASSOCIATION6_FK on Repository (
idTypeOwner ASC
)
go

/*==============================================================*/
/* Table: Topic                                                 */
/*==============================================================*/
create table Topic (
   idTopic              int          identity(1,1)           not null,
   topic                varchar(100)         null,
   constraint PK_TOPIC primary key nonclustered (idTopic),
   constraint AK_IDENTIFIER_1_TOPIC unique (idTopic)
)
go

/*==============================================================*/
/* Table: TypeOwner                                             */
/*==============================================================*/
create table TypeOwner (
   idTypeOwner          int           identity(1,1)          not null,
   typeOwner            varchar(100)         null,
   constraint PK_TYPEOWNER primary key nonclustered (idTypeOwner),
   constraint AK_IDENTIFIER_1_TYPEOWNE unique (idTypeOwner)
)
go

alter table Contribution
   add constraint FK_CONTRIBU_ASSOCIATI_CONTRIBU foreign key (idContrubutor)
      references Contributor (idContrubutor)
go

alter table Contribution
   add constraint FK_CONTRIBU_ASSOCIATI_REPOSITO foreign key (idRepo)
      references Repository (idRepo)
go

alter table Repo_Topic
   add constraint FK_REPO_TOP_ASSOCIATI_REPOSITO foreign key (idRepo)
      references Repository (idRepo)
go

alter table Repo_Topic
   add constraint FK_REPO_TOP_ASSOCIATI_TOPIC foreign key (idTopic)
      references Topic (idTopic)
go

alter table Repository
   add constraint FK_REPOSITO_ASSOCIATI_LANGUAGE foreign key (idLanguage)
      references Language (idLanguage)
go

alter table Repository
   add constraint FK_REPOSITO_ASSOCIATI_TYPEOWNE foreign key (idTypeOwner)
      references TypeOwner (idTypeOwner)
go

use GITHUB
SELECT * from Language 
go
select * from Language
select * from TypeOwner
select * from Repository 
select * from Contributor 
delete from Contributor
DBCC CHECKIDENT (Contributor, RESEED, 1)
select * from Topic
select * from Contribution 


-- Drop the foreign key constraints first
ALTER TABLE Contribution
   DROP CONSTRAINT FK_CONTRIBU_ASSOCIATI_CONTRIBU;
   
ALTER TABLE Contribution
   DROP CONSTRAINT FK_CONTRIBU_ASSOCIATI_REPOSITO;

-- Drop the table if it exists
IF OBJECT_ID('Contribution', 'U') IS NOT NULL
   DROP TABLE Contribution;

GO -- Separate batches

-- Recreate the table
CREATE TABLE Contribution (
   idContrubutor INT NOT NULL,
   idRepo BIGINT NOT NULL,
   number_Contributions INT NULL,
   CONSTRAINT PK_CONTRIBUTION PRIMARY KEY (idContrubutor, idRepo)
);

GO -- Separate batches

-- Add the foreign key constraints back
ALTER TABLE Contribution
   ADD CONSTRAINT FK_CONTRIBU_ASSOCIATI_CONTRIBU FOREIGN KEY (idContrubutor)
      REFERENCES Contributor (idContrubutor);

GO -- Separate batches

ALTER TABLE Contribution
   ADD CONSTRAINT FK_CONTRIBU_ASSOCIATI_REPOSITO FOREIGN KEY (idRepo)
      REFERENCES Repository (idRepo);

GO -- Separate batches
