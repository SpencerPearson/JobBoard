/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2016 (13.0.5026)
    Source Database Engine Edition : Microsoft SQL Server Express Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2017
    Target Database Engine Edition : Microsoft SQL Server Standard Edition
    Target Database Engine Type : Standalone SQL Server
*/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserDetails]') AND type in (N'U'))
ALTER TABLE [dbo].[UserDetails] DROP CONSTRAINT IF EXISTS [FK_UserDetails_AspNetUsers]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OpenPositions]') AND type in (N'U'))
ALTER TABLE [dbo].[OpenPositions] DROP CONSTRAINT IF EXISTS [FK_OpenPositions_Positions]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OpenPositions]') AND type in (N'U'))
ALTER TABLE [dbo].[OpenPositions] DROP CONSTRAINT IF EXISTS [FK_OpenPositions_Locations]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Locations]') AND type in (N'U'))
ALTER TABLE [dbo].[Locations] DROP CONSTRAINT IF EXISTS [FK_Locations_UserDetails]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserRoles]') AND type in (N'U'))
ALTER TABLE [dbo].[AspNetUserRoles] DROP CONSTRAINT IF EXISTS [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserRoles]') AND type in (N'U'))
ALTER TABLE [dbo].[AspNetUserRoles] DROP CONSTRAINT IF EXISTS [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserLogins]') AND type in (N'U'))
ALTER TABLE [dbo].[AspNetUserLogins] DROP CONSTRAINT IF EXISTS [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserClaims]') AND type in (N'U'))
ALTER TABLE [dbo].[AspNetUserClaims] DROP CONSTRAINT IF EXISTS [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Applications]') AND type in (N'U'))
ALTER TABLE [dbo].[Applications] DROP CONSTRAINT IF EXISTS [FK_Applications_UserDetails]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Applications]') AND type in (N'U'))
ALTER TABLE [dbo].[Applications] DROP CONSTRAINT IF EXISTS [FK_Applications_OpenPositions]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Applications]') AND type in (N'U'))
ALTER TABLE [dbo].[Applications] DROP CONSTRAINT IF EXISTS [FK_Applications_ApplicationStatus]
GO
/****** Object:  Table [dbo].[UserDetails]    Script Date: 2/3/2021 9:21:41 AM ******/
DROP TABLE IF EXISTS [dbo].[UserDetails]
GO
/****** Object:  Table [dbo].[Positions]    Script Date: 2/3/2021 9:21:41 AM ******/
DROP TABLE IF EXISTS [dbo].[Positions]
GO
/****** Object:  Table [dbo].[OpenPositions]    Script Date: 2/3/2021 9:21:41 AM ******/
DROP TABLE IF EXISTS [dbo].[OpenPositions]
GO
/****** Object:  Table [dbo].[Locations]    Script Date: 2/3/2021 9:21:41 AM ******/
DROP TABLE IF EXISTS [dbo].[Locations]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 2/3/2021 9:21:41 AM ******/
DROP TABLE IF EXISTS [dbo].[AspNetUsers]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 2/3/2021 9:21:41 AM ******/
DROP TABLE IF EXISTS [dbo].[AspNetUserRoles]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 2/3/2021 9:21:41 AM ******/
DROP TABLE IF EXISTS [dbo].[AspNetUserLogins]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 2/3/2021 9:21:41 AM ******/
DROP TABLE IF EXISTS [dbo].[AspNetUserClaims]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 2/3/2021 9:21:41 AM ******/
DROP TABLE IF EXISTS [dbo].[AspNetRoles]
GO
/****** Object:  Table [dbo].[ApplicationStatuses]    Script Date: 2/3/2021 9:21:41 AM ******/
DROP TABLE IF EXISTS [dbo].[ApplicationStatuses]
GO
/****** Object:  Table [dbo].[Applications]    Script Date: 2/3/2021 9:21:41 AM ******/
DROP TABLE IF EXISTS [dbo].[Applications]
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 2/3/2021 9:21:41 AM ******/
DROP TABLE IF EXISTS [dbo].[__MigrationHistory]
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 2/3/2021 9:21:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[__MigrationHistory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Applications]    Script Date: 2/3/2021 9:21:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Applications]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Applications](
	[ApplicationId] [int] IDENTITY(1,1) NOT NULL,
	[OpenPositionId] [int] NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ApplicationDate] [date] NOT NULL,
	[ManagerNotes] [varchar](2000) NULL,
	[ApplicationStatus] [int] NOT NULL,
	[ResumeFilename] [varchar](75) NOT NULL,
 CONSTRAINT [PK_Applications] PRIMARY KEY CLUSTERED 
(
	[ApplicationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ApplicationStatuses]    Script Date: 2/3/2021 9:21:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ApplicationStatuses]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ApplicationStatuses](
	[ApplicationStatusId] [int] IDENTITY(1,1) NOT NULL,
	[StatusName] [varchar](50) NOT NULL,
	[StatusDescription] [varchar](250) NULL,
 CONSTRAINT [PK_ApplicationStatus] PRIMARY KEY CLUSTERED 
(
	[ApplicationStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 2/3/2021 9:21:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetRoles]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 2/3/2021 9:21:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserClaims]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 2/3/2021 9:21:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserLogins]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 2/3/2021 9:21:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserRoles]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 2/3/2021 9:21:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUsers]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Locations]    Script Date: 2/3/2021 9:21:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Locations]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Locations](
	[LocationId] [int] IDENTITY(1,1) NOT NULL,
	[StoreNumber] [varchar](10) NOT NULL,
	[City] [varchar](50) NOT NULL,
	[State] [char](2) NOT NULL,
	[ManagerId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_Locations] PRIMARY KEY CLUSTERED 
(
	[LocationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[OpenPositions]    Script Date: 2/3/2021 9:21:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OpenPositions]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[OpenPositions](
	[OpenPositionId] [int] IDENTITY(1,1) NOT NULL,
	[PositionId] [int] NOT NULL,
	[LocationId] [int] NOT NULL,
 CONSTRAINT [PK_OpenPositions] PRIMARY KEY CLUSTERED 
(
	[OpenPositionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Positions]    Script Date: 2/3/2021 9:21:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Positions]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Positions](
	[PositionId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[JobDescription] [varchar](max) NULL,
 CONSTRAINT [PK_Positions] PRIMARY KEY CLUSTERED 
(
	[PositionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[UserDetails]    Script Date: 2/3/2021 9:21:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserDetails]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[UserDetails](
	[UserId] [nvarchar](128) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[ResumeFileName] [varchar](75) NULL,
 CONSTRAINT [PK_UserDetails] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
INSERT [dbo].[__MigrationHistory] ([MigrationId], [ContextKey], [Model], [ProductVersion]) VALUES (N'202101252138535_InitialCreate', N'JobBoard.UI.MVC.Models.ApplicationDbContext', 0x1F8B0800000000000400DD5CDB6EE338127D5F60FF41D0D3EE2263E532DDE80DEC19A49D6426BB9D0BDA4963DF1AB4443B424BA446A2320916F365FB309F34BFB0458992255E74B115DB1934D0B0C8E2A962B148168BC5FCF1BFDFC73F3E8781F584E3C4A764621F8D0E6D0B13977A3E594EEC942DBEFB60FFF8C35FFF32BEF0C267EB4B4177C2E9A0254926F62363D1A9E324EE230E51320A7D37A6095DB0914B430779D4393E3CFCA77374E46080B001CBB2C69F53C2FC10671FF039A5C4C5114B51704D3D1C24A21C6A6619AA7583429C44C8C513FB5F74FE91A2D81B3D5C8DAEBF4C47790BDB3A0B7C04D2CC70B0B02D4408658881ACA70F099EB19892E52C820214DCBF4418E8162848B0E8C3E98ABC6B770E8F79779C55C302CA4D1346C39E804727423F8EDC7C2D2DDBA5FE408317A069F6C27B9D6971625F79382BFA4C035080CCF0741AC49C78625F972CCE92E806B351D17094435EC600F72B8DBF8DAA880756E77607A53D1D8F0EF9BF036B9A062C8DF184E094C52838B0EED279E0BBFFC62FF7F41B269393A3F9E2E4C3BBF7C83B79FF3D3E7957ED29F415E86A05507417D308C7201B5E94FDB72DA7DECE911B96CD2A6D72AD802DC1D4B0AD6BF4FC0993257B844973FCC1B62EFD67EC1525C2B81E880F33091AB13885CF9B3408D03CC065BDD3C893FFDFC0F5F8DDFB41B8DEA0277F990DBDC41F264E0CF3EA330EB2DAE4D18FF2E9551BEFAF82EC32A621FFAEDB575EFB7546D3D8E59DA146927B142F31AB4B377656C6DBC9A439D4F0665DA0EEBF69734955F3D692F20EAD33130A16DB9E0D85BCAFCBB7B3C59D45110C5E665A5C234D06A7DFB04612C28125D1AD4CE8A8AB0911E8DA9F7945BC08911F0CB02476E0021EC9C28F435CF6F223050344A4B7CC7728496045F07E46C96383E8F07300D167D84D6330D4194361F4EADCEE1E29C1376938E7F6BF3D5E830DCDFDAFF412B98CC61784B7DA18EF1375BFD1945D10EF1C31FCC0DC02907FDEFB61778041C439735D9C249760CCD89B5270B80BC02BC24E8E7BC3F1456AD72EC934407EA8F749A4E5F46B41BAF24BF4148A6F6220D3F9274DA27EA24B9F7413B520358B9A53B48A2AC8FA8ACAC1BA492A28CD826604AD72E65483797CD9080DEFF265B0FBEFF36DB6799BD6828A1A67B042E29F30C1312C63DE1D620CC76435025DD68D5D380BD9F071A6AFBE37659CBEA0201D9AD55AB3215B04869F0D19ECFECF864C4C287EF23DEE9574380815C400DF895E7FC66A9F739264DB9E0EB56E6E9BF976D600D374394B12EAFAD92CD084C04400A32E3FF870567B3423EF8D1C11818E81A1FB7CCB8312E89B2D1BD52D39C70166D83A73F310E114252EF254354287BC1E82153BAA46B05564A42EDC3F149E60E938E68D103F042530537DC2D469E113D78F50D0AA25A965C72D8CF7BDE421D79CE30813CEB055135D98EB03215C80928F34286D1A1A3B158B6B364483D76A1AF336177635EE4A7C622B36D9E23B1BEC52F86FAF6298CD1ADB827136ABA48B00C6A0DE2E0C549C55BA1A807C70D93703954E4C0603152ED5560CB4AEB11D18685D256FCE40F3236AD7F197CEABFB669EF583F2F6B7F54675EDC0366BFAD833D3CC7D4F68C3A0058E55F33C9FF34AFCCC34873390539CCF12E1EACA26C2C16798D543362B7F57EB873ACD20B2113501AE0CAD05545C072A40CA84EA215C11CB6B944E78113D608BB85B23AC58FB25D88A0DA8D8D56BD10AA1F9F25436CE4EA78FB267A5352846DEE9B050C1D11884BC78D53BDE4129A6B8ACAA982EBE701F6FB8D23131180D0A6AF15C0D4A2A3A33B8960AD36CD792CE21EBE3926DA425C97D3268A9E8CCE05A1236DAAE248D53D0C32DD84845F52D7CA0C956443ACADDA6AC1B3B79C69428183B86D4AAF1358A229F2C2BA956A2C49AE57956D3EF66FD938FC21CC371134D0E52296DC989D1182DB1540BAC41D24B3F4ED83962688E789C67EA850A99766F352CFF05CBEAF6A90E62B10F14D4FC77DEC270895FDB6F558744E05C422F43EED564A1748D0DE89B5B3CFD0D0528D644EFA73448436276B2CCADF33BBC6AFBBC4445183B92FC8A13A5684C7175EBEAEF3438EAC41870A04A3F66FDC1324398545E78A155A59B3C53334A11A8AAA29882573B1B3C9343D37BC0647FB1FF78B522BCCEFC12492A550051D413A392E7A08055EABAA3D65351AA98F59AEE8852BE491552AAEA216535ABA42664B5622D3C8346F514DD39A879245574B5B63BB226A3A40AADA95E035B23B35CD71D5593745205D65477C75E65A0C80BE91EEF60C653CC465B587ED8DD6C0F3360BCCEAA38CC1658B9D3AF02558A7B62895B7B054C94EFA545194F7C1B59541EE7D8CCA20C18E615A876235E5F801AAFF1CD98B56BEEDA22DF74CD6FC6EB67B7AF6A1DCAA14F2629B997873FE990371607AEF64736CA092C27B1AD428DB0C1BF240C87234E309AFD124C031FF3E5BC20B846C45FE084E5A91DF6F1E1D1B1F446677FDECB3849E2059A03ABE9D14C7DCCB690A5459E50EC3EA258CD99D8E04DC90A5409475F110F3F4FECFF66AD4EB3C806FF95151F5857C903F17F49A1E23E4EB1F59B9A033A4C8E7D87571DA5A0BFBD89E712DD557EF59FAF79D303EB3686E9746A1D4A8A5E67F8EB8F287A499337DD409AB59F56BCDDD9567BAFA0459566CBFACF13E63E1BE4694221E5DF42F4FCF7BEA2699F1F6C84A879623014DE202A343D215807CBF87CC0834F963D1FE8D759FD73827544333E25F0497F30F92141F765A868B9C37D487368DAC69294E9B935117BA3ACCC5DEF4D4ABEF646135DCDC9EE013768DEF5662ECA1BCB671E6CEBD4A42B0F86BD4BBB7FF51CE57D494B5E39EDBBCD46DE660272C3E5D29F2AEF780F32E534993FBBCF2EDEB6AD99A2C07B9EA2D92F8778CF8C4D6CF3BBCF14DEB6B19902C47B6E6CBDF281F7CCD676B57FEED8D23A6FA13BCFEE5513950CB739BA28725BF66E1E7287E3FF9C8211E41E65FEE8529F2ED694EADAC2704562666ACE5393192B1347E1AB5034B3EDD757B1E1377656D034B335647736F116EB7F236F41D3CCDB9033B98BBC636DD6A22E17BC651D6B4AA57A4B79C6B59EB4A4B5B7F9AC8D57F36F29AD7810A5D4668FE176F9ED64110FA29221A74E8FAC61F5A218F6CECADF6C84FD3BF1972B08FE171C09766BBB6649734516B4D8BC25890A122942738D19F2604B3D8B99BF402E836A1E80CE5E8D67413D7E0D32C7DE15B94D599432E8320EE7412DE0C59D8026FE596A745DE6F16DC4BF9221BA0062FA3C707F4B3EA67EE095725F6A62420608EE5D88702F1F4BC6C3BECB9712E986928E40427DA553748FC32800B0E496CCD0135E473630BF4F7889DC975504D004D23E1075B58FCF7DB48C5198088C557BF8041BF6C2E71FFE0F3D7264D2BA540000, N'6.2.0-61023')
SET IDENTITY_INSERT [dbo].[Applications] ON 

INSERT [dbo].[Applications] ([ApplicationId], [OpenPositionId], [UserId], [ApplicationDate], [ManagerNotes], [ApplicationStatus], [ResumeFilename]) VALUES (1, 1, N'05908a14-6794-442c-b412-067c9adec1bc', CAST(N'2021-01-31' AS Date), N'Testing on some notes here.', 3, N'5cbf2963-bed3-4248-a60e-790d8d7b7577.pdf')
INSERT [dbo].[Applications] ([ApplicationId], [OpenPositionId], [UserId], [ApplicationDate], [ManagerNotes], [ApplicationStatus], [ResumeFilename]) VALUES (2, 2, N'05908a14-6794-442c-b412-067c9adec1bc', CAST(N'2021-02-01' AS Date), N'Application received on 02/01/2021, please respond by 02/06/2021.', 1, N'07f0e372-9ab7-4214-b568-22d86b6d1c59.pdf')
INSERT [dbo].[Applications] ([ApplicationId], [OpenPositionId], [UserId], [ApplicationDate], [ManagerNotes], [ApplicationStatus], [ResumeFilename]) VALUES (3, 4, N'05908a14-6794-442c-b412-067c9adec1bc', CAST(N'2021-02-01' AS Date), N'Application received on 02/01/2021, please respond by 02/06/2021.', 1, N'07f0e372-9ab7-4214-b568-22d86b6d1c59.pdf')
INSERT [dbo].[Applications] ([ApplicationId], [OpenPositionId], [UserId], [ApplicationDate], [ManagerNotes], [ApplicationStatus], [ResumeFilename]) VALUES (4, 7, N'05908a14-6794-442c-b412-067c9adec1bc', CAST(N'2021-02-01' AS Date), N'Application received on 02/01/2021, please respond by 02/06/2021.', 1, N'07f0e372-9ab7-4214-b568-22d86b6d1c59.pdf')
INSERT [dbo].[Applications] ([ApplicationId], [OpenPositionId], [UserId], [ApplicationDate], [ManagerNotes], [ApplicationStatus], [ResumeFilename]) VALUES (5, 10, N'05908a14-6794-442c-b412-067c9adec1bc', CAST(N'2021-02-01' AS Date), N'Application received on 02/01/2021, please respond by 02/06/2021.', 1, N'07f0e372-9ab7-4214-b568-22d86b6d1c59.pdf')
INSERT [dbo].[Applications] ([ApplicationId], [OpenPositionId], [UserId], [ApplicationDate], [ManagerNotes], [ApplicationStatus], [ResumeFilename]) VALUES (6, 12, N'05908a14-6794-442c-b412-067c9adec1bc', CAST(N'2021-02-01' AS Date), N'Application received on 02/01/2021, please respond by 02/06/2021.', 1, N'07f0e372-9ab7-4214-b568-22d86b6d1c59.pdf')
INSERT [dbo].[Applications] ([ApplicationId], [OpenPositionId], [UserId], [ApplicationDate], [ManagerNotes], [ApplicationStatus], [ResumeFilename]) VALUES (7, 1, N'025bbda5-d5f6-44c7-ae12-c576c3646fef', CAST(N'2021-02-02' AS Date), N'Received application. Looks like a good candidate. Application accepted, setting up interview dates for next week.', 3, N'55d377be-ec05-4870-a8c0-01d8a75de77f.pdf')
SET IDENTITY_INSERT [dbo].[Applications] OFF
SET IDENTITY_INSERT [dbo].[ApplicationStatuses] ON 

INSERT [dbo].[ApplicationStatuses] ([ApplicationStatusId], [StatusName], [StatusDescription]) VALUES (1, N'Pending', N'The application has been sent. You will be notified when a manager receives your application.')
INSERT [dbo].[ApplicationStatuses] ([ApplicationStatusId], [StatusName], [StatusDescription]) VALUES (2, N'Received', N'Your application has been received. Please allow 3 business days for your application to be processed.')
INSERT [dbo].[ApplicationStatuses] ([ApplicationStatusId], [StatusName], [StatusDescription]) VALUES (3, N'Accepted', N'Congratulations! Your application has been accepted. You should contact the hiring manager to set up an interview.')
INSERT [dbo].[ApplicationStatuses] ([ApplicationStatusId], [StatusName], [StatusDescription]) VALUES (4, N'Rejected', N'Our hiring manager has reviewed your application and determined it does not meet the criteria we need to fill this position.')
SET IDENTITY_INSERT [dbo].[ApplicationStatuses] OFF
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'ab3b2f24-22d4-417a-a07d-c31bb08b9413', N'Admin')
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'a642a344-603b-4491-af27-01affbe6158a', N'Applicant')
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'd4dca6ba-6d56-40df-a5f4-1f60634687df', N'Manager')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'025bbda5-d5f6-44c7-ae12-c576c3646fef', N'a642a344-603b-4491-af27-01affbe6158a')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'05908a14-6794-442c-b412-067c9adec1bc', N'a642a344-603b-4491-af27-01affbe6158a')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'1ef966af-46d1-4add-b62e-d7a51efa33e0', N'ab3b2f24-22d4-417a-a07d-c31bb08b9413')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'73aa0606-c5d7-43ad-b426-182d4ee6eb9a', N'd4dca6ba-6d56-40df-a5f4-1f60634687df')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'81b2d29c-ca33-4d6b-8a1d-2c3ca61e87b0', N'd4dca6ba-6d56-40df-a5f4-1f60634687df')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'94146a05-afc5-4f6b-b8df-d490cf7bf0ca', N'd4dca6ba-6d56-40df-a5f4-1f60634687df')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'a38b0cbe-bf43-406f-be9d-d2703f71be0a', N'd4dca6ba-6d56-40df-a5f4-1f60634687df')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'abcb9bc0-7d24-4427-9d2f-d5e45cb4e0c5', N'd4dca6ba-6d56-40df-a5f4-1f60634687df')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'c1b720a6-c3c8-4426-992e-2e9679636ccc', N'd4dca6ba-6d56-40df-a5f4-1f60634687df')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'febf179e-6a67-414f-8d74-92fdd369d7f5', N'd4dca6ba-6d56-40df-a5f4-1f60634687df')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'025bbda5-d5f6-44c7-ae12-c576c3646fef', N'tigerspence2012@gmail.com', 1, N'AAbrphyXS6YVl9kcL4Soz3eQdjHq3o5cgQVTWef9SkcLKunqs8nOJ2T9Dk+Bi2I6rA==', N'9121155f-049a-4fe5-bfb3-b46177551a6b', NULL, 0, 0, NULL, 1, 0, N'tigerspence2012@gmail.com')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'05908a14-6794-442c-b412-067c9adec1bc', N'applicant@example.com', 0, N'AGVYxoc6SPhNqS5TSlzVoa9u97irrhIbN8R8BkERxlv9L/x5+o9aDiFTeWhPq57MPg==', N'b7a2b9c1-7d42-4723-8a13-969eec2c4937', NULL, 0, 0, NULL, 1, 0, N'applicant@example.com')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'1ef966af-46d1-4add-b62e-d7a51efa33e0', N'spencer@spencerpearson.net', 0, N'ANvxDMRvfBh8z12vYmtThEmcTcaqueu9gnIAZZpodlwJUkqIPICsJgjwlgsqTCG1iQ==', N'b687db3a-5388-444d-8214-06fac21e4307', NULL, 0, 0, NULL, 1, 0, N'spencer@spencerpearson.net')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'73aa0606-c5d7-43ad-b426-182d4ee6eb9a', N'columbiayoung@fakemail.com', 0, N'ADxuPV1XOw2bjmyfiZ63XB5kwr8HQqc4DTRySSSUgV8P2LL6MRwlgd27eOQ6k3sg2g==', N'2af310b3-55b6-4da2-b148-55a01f2df8cb', NULL, 0, 0, NULL, 1, 0, N'columbiayoung@fakemail.com')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'81b2d29c-ca33-4d6b-8a1d-2c3ca61e87b0', N'louiswilliams@fakemail.com', 1, N'AP5XF2gMtvlRDNiSnCf26IS8SBSdQIHlWlbVyUDpNx0N+giX5okkL2o6c2XALkGpgQ==', N'41696b0d-d14f-476a-9a1d-3f62a03f061c', NULL, 0, 0, NULL, 1, 0, N'louiswilliams@fakemail.com')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'94146a05-afc5-4f6b-b8df-d490cf7bf0ca', N'desmondjones@fakemail.com', 1, N'ANLAFzdswiouVKq+U5KIB/WSdndNXmAdey3bRwLZQ8+oH4AnuuvjRekd+wJp1lYwoQ==', N'fddc9ab6-6eb1-4e47-aaa5-ba2e1f11050f', NULL, 0, 0, NULL, 1, 0, N'desmondjones@fakemail.com')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'a38b0cbe-bf43-406f-be9d-d2703f71be0a', N'manager@example.com', 0, N'ALx9MPdixy5wCAEZCHBM8zgrKITDKlqcEb5kkXUfS5UUZqzksg2s7RTVQWac4uD5JQ==', N'46c201ec-91a0-40cc-8c3f-f572f3b39494', NULL, 0, 0, NULL, 1, 0, N'manager@example.com')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'abcb9bc0-7d24-4427-9d2f-d5e45cb4e0c5', N'amyomaha@fakemail.com', 1, N'ANSAo3PThweqYbuBbRZvl3EVcdfLJN+SG28C/c1g66gQJ96nlgpW6NAjAFOrJHzS7g==', N'db81c967-39e0-453a-af5f-17aab56b4581', NULL, 0, 0, NULL, 1, 0, N'amyomaha@fakemail.com')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'c1b720a6-c3c8-4426-992e-2e9679636ccc', N'kcsunshine@gmail.com', 0, N'AIgMURtXoB8r2NMG1G2BLcimiS0yXDNKDpjvPNsUPLFwoZPTLwB9WeZeTWoIyAqX/A==', N'cfa59edc-c488-4bd7-b0b6-a9f0828908f5', NULL, 0, 0, NULL, 1, 0, N'kcsunshine@gmail.com')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'febf179e-6a67-414f-8d74-92fdd369d7f5', N'lawrencejenkins@fakemail.com', 1, N'AAUPLl9YiGpK4rzjQ4TG+O3iZqMEPmiBZCeI1wekw5p4jriO8sn41CGbeyhjOVvZHQ==', N'7776fbe6-81ed-4df2-93dd-f25a5a246444', NULL, 0, 0, NULL, 1, 0, N'lawrencejenkins@fakemail.com')
SET IDENTITY_INSERT [dbo].[Locations] ON 

INSERT [dbo].[Locations] ([LocationId], [StoreNumber], [City], [State], [ManagerId]) VALUES (4, N'HQ01', N'Kansas City', N'MO', N'a38b0cbe-bf43-406f-be9d-d2703f71be0a')
INSERT [dbo].[Locations] ([LocationId], [StoreNumber], [City], [State], [ManagerId]) VALUES (5, N'CAFE01', N'Kansas City', N'MO', N'c1b720a6-c3c8-4426-992e-2e9679636ccc')
INSERT [dbo].[Locations] ([LocationId], [StoreNumber], [City], [State], [ManagerId]) VALUES (6, N'CAFE02', N'Lawrence', N'KS', N'febf179e-6a67-414f-8d74-92fdd369d7f5')
INSERT [dbo].[Locations] ([LocationId], [StoreNumber], [City], [State], [ManagerId]) VALUES (7, N'CAFE03', N'Omaha', N'NE', N'abcb9bc0-7d24-4427-9d2f-d5e45cb4e0c5')
INSERT [dbo].[Locations] ([LocationId], [StoreNumber], [City], [State], [ManagerId]) VALUES (8, N'CAFE04', N'Columbia', N'MO', N'73aa0606-c5d7-43ad-b426-182d4ee6eb9a')
INSERT [dbo].[Locations] ([LocationId], [StoreNumber], [City], [State], [ManagerId]) VALUES (9, N'CAFE05', N'St. Louis', N'MO', N'81b2d29c-ca33-4d6b-8a1d-2c3ca61e87b0')
INSERT [dbo].[Locations] ([LocationId], [StoreNumber], [City], [State], [ManagerId]) VALUES (10, N'CAFE06', N'Des Moines', N'IA', N'94146a05-afc5-4f6b-b8df-d490cf7bf0ca')
SET IDENTITY_INSERT [dbo].[Locations] OFF
SET IDENTITY_INSERT [dbo].[OpenPositions] ON 

INSERT [dbo].[OpenPositions] ([OpenPositionId], [PositionId], [LocationId]) VALUES (1, 1, 5)
INSERT [dbo].[OpenPositions] ([OpenPositionId], [PositionId], [LocationId]) VALUES (2, 1, 6)
INSERT [dbo].[OpenPositions] ([OpenPositionId], [PositionId], [LocationId]) VALUES (3, 1, 7)
INSERT [dbo].[OpenPositions] ([OpenPositionId], [PositionId], [LocationId]) VALUES (4, 1, 8)
INSERT [dbo].[OpenPositions] ([OpenPositionId], [PositionId], [LocationId]) VALUES (5, 1, 9)
INSERT [dbo].[OpenPositions] ([OpenPositionId], [PositionId], [LocationId]) VALUES (6, 1, 10)
INSERT [dbo].[OpenPositions] ([OpenPositionId], [PositionId], [LocationId]) VALUES (7, 4, 4)
INSERT [dbo].[OpenPositions] ([OpenPositionId], [PositionId], [LocationId]) VALUES (8, 5, 4)
INSERT [dbo].[OpenPositions] ([OpenPositionId], [PositionId], [LocationId]) VALUES (9, 1, 4)
INSERT [dbo].[OpenPositions] ([OpenPositionId], [PositionId], [LocationId]) VALUES (10, 2, 4)
INSERT [dbo].[OpenPositions] ([OpenPositionId], [PositionId], [LocationId]) VALUES (11, 2, 6)
INSERT [dbo].[OpenPositions] ([OpenPositionId], [PositionId], [LocationId]) VALUES (12, 2, 9)
INSERT [dbo].[OpenPositions] ([OpenPositionId], [PositionId], [LocationId]) VALUES (13, 2, 10)
INSERT [dbo].[OpenPositions] ([OpenPositionId], [PositionId], [LocationId]) VALUES (14, 8, 4)
INSERT [dbo].[OpenPositions] ([OpenPositionId], [PositionId], [LocationId]) VALUES (15, 7, 4)
SET IDENTITY_INSERT [dbo].[OpenPositions] OFF
SET IDENTITY_INSERT [dbo].[Positions] ON 

INSERT [dbo].[Positions] ([PositionId], [Title], [JobDescription]) VALUES (1, N'Barista', N'Our baristas are dedicated workers with a passion for coffee and working within a team structure. Prior coffee knowledge and experience is always usefu, but not required as we provide extensive in-house training to all new hires regardless of experience level. Duties include taking orders, running our in-house POS system, making drinks, preparing simple food items, gaining knowledge about the company''s history, our product line and our roasting process.')
INSERT [dbo].[Positions] ([PositionId], [Title], [JobDescription]) VALUES (2, N'Shift Lead', N'Baristas who have honed their skills and shown promising leadership traits are encouraged to apply for the shift lead position. We do sometimes hire baristas with management experience from outside the company, but generally this is a role we like to hire for from within as a Shift Lead is expected to know a great deal about our unique history, products and roasting techniques. In addition to the normal barista duties, a shift lead is in charge of scheduling for their shifts, tracking inventory, placing inventory orders, resolving conflicts and handling customer complaints.')
INSERT [dbo].[Positions] ([PositionId], [Title], [JobDescription]) VALUES (3, N'Roaster', N'Roasters are in charge of roasting green coffee for all our various product lines. Duties include daily planning of roast batch sizes, forecasting our daily need, operating the roasters, and participating in cuppings with quality control.')
INSERT [dbo].[Positions] ([PositionId], [Title], [JobDescription]) VALUES (4, N'Customer Service', N'Customer Service Representatives are the first point of contact for customers who call our headquarters with questions, complaints or comments. Previous customer service experience is preferred but not required. Duties include answering incoming calls, forwarding customers to appropriate departments, taking phone orders, and handling customer complaints in a friendly manner.')
INSERT [dbo].[Positions] ([PositionId], [Title], [JobDescription]) VALUES (5, N'Production Asst.', N'Production assistants are trained on a variety of different equipment on the production floor. Duties may include operating the weighing machine, the coffee bag sealer, or the flavoring equipment. All production assistants are responsible for producing and sorting the daily orders to prepare for shipment.')
INSERT [dbo].[Positions] ([PositionId], [Title], [JobDescription]) VALUES (6, N'Shipping', N'Shipping department hires must demonstrate a knack for speed, safety and organization. You will be working in our warehouse, tracking customer and client orders and ensuring all those orders arrive undamaged and in a timely manner. Duties include sorting inventory, pulling items for orders, boxing orders and tracking all orders to their destination, solving any shippment issues that might occur.')
INSERT [dbo].[Positions] ([PositionId], [Title], [JobDescription]) VALUES (7, N'Delivery Driver', N'Drivers will be delivering orders to our regular clients throughout the week on preplanned routes throughout the city. Duties include aiding the shipping department in loading the route, planning a safe and efficient route each day, lifting up to 80 lbs, maintaining and fueling your vehicle, and tracking miles and fuel use. Class B CDL required.')
INSERT [dbo].[Positions] ([PositionId], [Title], [JobDescription]) VALUES (8, N'Tour Guide', N'Tour Guides, along side Baristas, are the most public-facing positions at the company. Tour guides are trained on the history of our company and the history of coffee worldwide. Our tours last around 45 minutes and end with a brewing demonstration and samples of some of our product line. Previous experience guiding tours or working in a coffee industry postition is preferred but not required. Duties include playing an introductory video, leading tour takers through a tour of our production factory, executing the brewing demo and answering lots and lots of questions!')
SET IDENTITY_INSERT [dbo].[Positions] OFF
INSERT [dbo].[UserDetails] ([UserId], [FirstName], [LastName], [ResumeFileName]) VALUES (N'025bbda5-d5f6-44c7-ae12-c576c3646fef', N'Tiger', N'Testington', N'55d377be-ec05-4870-a8c0-01d8a75de77f.pdf')
INSERT [dbo].[UserDetails] ([UserId], [FirstName], [LastName], [ResumeFileName]) VALUES (N'05908a14-6794-442c-b412-067c9adec1bc', N'Andy', N'Anderson', N'07f0e372-9ab7-4214-b568-22d86b6d1c59.pdf')
INSERT [dbo].[UserDetails] ([UserId], [FirstName], [LastName], [ResumeFileName]) VALUES (N'1ef966af-46d1-4add-b62e-d7a51efa33e0', N'Spencer', N'Pearson', N'NoResume.pdf')
INSERT [dbo].[UserDetails] ([UserId], [FirstName], [LastName], [ResumeFileName]) VALUES (N'73aa0606-c5d7-43ad-b426-182d4ee6eb9a', N'Columbia', N'Young', N'NoResume.pdf')
INSERT [dbo].[UserDetails] ([UserId], [FirstName], [LastName], [ResumeFileName]) VALUES (N'81b2d29c-ca33-4d6b-8a1d-2c3ca61e87b0', N'Louis', N'Williams', N'NoResume.pdf')
INSERT [dbo].[UserDetails] ([UserId], [FirstName], [LastName], [ResumeFileName]) VALUES (N'94146a05-afc5-4f6b-b8df-d490cf7bf0ca', N'Desmond', N'Jones', N'NoResume.pdf')
INSERT [dbo].[UserDetails] ([UserId], [FirstName], [LastName], [ResumeFileName]) VALUES (N'a38b0cbe-bf43-406f-be9d-d2703f71be0a', N'Manager', N'Meyers', N'NoResume.pdf')
INSERT [dbo].[UserDetails] ([UserId], [FirstName], [LastName], [ResumeFileName]) VALUES (N'abcb9bc0-7d24-4427-9d2f-d5e45cb4e0c5', N'Amy', N'Omaha', N'NoResume.pdf')
INSERT [dbo].[UserDetails] ([UserId], [FirstName], [LastName], [ResumeFileName]) VALUES (N'c1b720a6-c3c8-4426-992e-2e9679636ccc', N'KC', N'Sunshine', N'9c529e18-5102-4c31-aeef-2068af04e35c.pdf')
INSERT [dbo].[UserDetails] ([UserId], [FirstName], [LastName], [ResumeFileName]) VALUES (N'febf179e-6a67-414f-8d74-92fdd369d7f5', N'Lawrence', N'Jenkins', N'NoResume.pdf')
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Applications_ApplicationStatus]') AND parent_object_id = OBJECT_ID(N'[dbo].[Applications]'))
ALTER TABLE [dbo].[Applications]  WITH CHECK ADD  CONSTRAINT [FK_Applications_ApplicationStatus] FOREIGN KEY([ApplicationStatus])
REFERENCES [dbo].[ApplicationStatuses] ([ApplicationStatusId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Applications_ApplicationStatus]') AND parent_object_id = OBJECT_ID(N'[dbo].[Applications]'))
ALTER TABLE [dbo].[Applications] CHECK CONSTRAINT [FK_Applications_ApplicationStatus]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Applications_OpenPositions]') AND parent_object_id = OBJECT_ID(N'[dbo].[Applications]'))
ALTER TABLE [dbo].[Applications]  WITH CHECK ADD  CONSTRAINT [FK_Applications_OpenPositions] FOREIGN KEY([OpenPositionId])
REFERENCES [dbo].[OpenPositions] ([OpenPositionId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Applications_OpenPositions]') AND parent_object_id = OBJECT_ID(N'[dbo].[Applications]'))
ALTER TABLE [dbo].[Applications] CHECK CONSTRAINT [FK_Applications_OpenPositions]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Applications_UserDetails]') AND parent_object_id = OBJECT_ID(N'[dbo].[Applications]'))
ALTER TABLE [dbo].[Applications]  WITH CHECK ADD  CONSTRAINT [FK_Applications_UserDetails] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserDetails] ([UserId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Applications_UserDetails]') AND parent_object_id = OBJECT_ID(N'[dbo].[Applications]'))
ALTER TABLE [dbo].[Applications] CHECK CONSTRAINT [FK_Applications_UserDetails]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]') AND parent_object_id = OBJECT_ID(N'[dbo].[AspNetUserClaims]'))
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]') AND parent_object_id = OBJECT_ID(N'[dbo].[AspNetUserClaims]'))
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]') AND parent_object_id = OBJECT_ID(N'[dbo].[AspNetUserLogins]'))
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]') AND parent_object_id = OBJECT_ID(N'[dbo].[AspNetUserLogins]'))
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]') AND parent_object_id = OBJECT_ID(N'[dbo].[AspNetUserRoles]'))
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]') AND parent_object_id = OBJECT_ID(N'[dbo].[AspNetUserRoles]'))
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]') AND parent_object_id = OBJECT_ID(N'[dbo].[AspNetUserRoles]'))
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]') AND parent_object_id = OBJECT_ID(N'[dbo].[AspNetUserRoles]'))
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Locations_UserDetails]') AND parent_object_id = OBJECT_ID(N'[dbo].[Locations]'))
ALTER TABLE [dbo].[Locations]  WITH CHECK ADD  CONSTRAINT [FK_Locations_UserDetails] FOREIGN KEY([ManagerId])
REFERENCES [dbo].[UserDetails] ([UserId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Locations_UserDetails]') AND parent_object_id = OBJECT_ID(N'[dbo].[Locations]'))
ALTER TABLE [dbo].[Locations] CHECK CONSTRAINT [FK_Locations_UserDetails]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OpenPositions_Locations]') AND parent_object_id = OBJECT_ID(N'[dbo].[OpenPositions]'))
ALTER TABLE [dbo].[OpenPositions]  WITH CHECK ADD  CONSTRAINT [FK_OpenPositions_Locations] FOREIGN KEY([LocationId])
REFERENCES [dbo].[Locations] ([LocationId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OpenPositions_Locations]') AND parent_object_id = OBJECT_ID(N'[dbo].[OpenPositions]'))
ALTER TABLE [dbo].[OpenPositions] CHECK CONSTRAINT [FK_OpenPositions_Locations]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OpenPositions_Positions]') AND parent_object_id = OBJECT_ID(N'[dbo].[OpenPositions]'))
ALTER TABLE [dbo].[OpenPositions]  WITH CHECK ADD  CONSTRAINT [FK_OpenPositions_Positions] FOREIGN KEY([PositionId])
REFERENCES [dbo].[Positions] ([PositionId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OpenPositions_Positions]') AND parent_object_id = OBJECT_ID(N'[dbo].[OpenPositions]'))
ALTER TABLE [dbo].[OpenPositions] CHECK CONSTRAINT [FK_OpenPositions_Positions]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserDetails_AspNetUsers]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserDetails]'))
ALTER TABLE [dbo].[UserDetails]  WITH CHECK ADD  CONSTRAINT [FK_UserDetails_AspNetUsers] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserDetails_AspNetUsers]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserDetails]'))
ALTER TABLE [dbo].[UserDetails] CHECK CONSTRAINT [FK_UserDetails_AspNetUsers]
GO
