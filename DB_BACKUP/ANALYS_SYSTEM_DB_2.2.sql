USE [master]
GO
/****** Object:  Database [ANALYS_SYSTEM_DB]    Script Date: 20.03.2025 12:10:06 ******/
CREATE DATABASE [ANALYS_SYSTEM_DB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ANALYS_SYSTEM_DB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\ANALYS_SYSTEM_DB.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ANALYS_SYSTEM_DB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\ANALYS_SYSTEM_DB_log.ldf' , SIZE = 23552KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [ANALYS_SYSTEM_DB] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ANALYS_SYSTEM_DB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ANALYS_SYSTEM_DB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ANALYS_SYSTEM_DB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ANALYS_SYSTEM_DB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ANALYS_SYSTEM_DB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ANALYS_SYSTEM_DB] SET ARITHABORT OFF 
GO
ALTER DATABASE [ANALYS_SYSTEM_DB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ANALYS_SYSTEM_DB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ANALYS_SYSTEM_DB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ANALYS_SYSTEM_DB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ANALYS_SYSTEM_DB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ANALYS_SYSTEM_DB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ANALYS_SYSTEM_DB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ANALYS_SYSTEM_DB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ANALYS_SYSTEM_DB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ANALYS_SYSTEM_DB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ANALYS_SYSTEM_DB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ANALYS_SYSTEM_DB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ANALYS_SYSTEM_DB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ANALYS_SYSTEM_DB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ANALYS_SYSTEM_DB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ANALYS_SYSTEM_DB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ANALYS_SYSTEM_DB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ANALYS_SYSTEM_DB] SET RECOVERY FULL 
GO
ALTER DATABASE [ANALYS_SYSTEM_DB] SET  MULTI_USER 
GO
ALTER DATABASE [ANALYS_SYSTEM_DB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ANALYS_SYSTEM_DB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ANALYS_SYSTEM_DB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ANALYS_SYSTEM_DB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ANALYS_SYSTEM_DB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'ANALYS_SYSTEM_DB', N'ON'
GO
ALTER DATABASE [ANALYS_SYSTEM_DB] SET QUERY_STORE = OFF
GO
USE [ANALYS_SYSTEM_DB]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [ANALYS_SYSTEM_DB]
GO
/****** Object:  Table [dbo].[Change_History]    Script Date: 20.03.2025 12:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Change_History](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Change_Date] [datetime] NULL,
	[Old_Value] [nvarchar](max) NULL,
	[New_Value] [nvarchar](max) NULL,
	[Reason] [nvarchar](255) NULL,
	[User_ID] [int] NULL,
	[Document_ID] [int] NULL,
 CONSTRAINT [PK_Change_History] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Data_Source]    Script Date: 20.03.2025 12:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Data_Source](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
 CONSTRAINT [PK_Data_Source] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Document]    Script Date: 20.03.2025 12:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Document](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NULL,
	[Name] [nvarchar](100) NULL,
	[Status_ID] [int] NULL,
	[Type_ID] [int] NULL,
 CONSTRAINT [PK_Document] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Document_Status]    Script Date: 20.03.2025 12:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Document_Status](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
 CONSTRAINT [PK_Document_Status] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Document_Struct]    Script Date: 20.03.2025 12:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Document_Struct](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Description] [nvarchar](255) NULL,
	[Attributes_List] [nvarchar](max) NULL,
	[Creation_Date] [datetime] NULL,
	[Type_ID] [int] NULL,
 CONSTRAINT [PK_Document_Struct] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Document_Type]    Script Date: 20.03.2025 12:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Document_Type](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
 CONSTRAINT [PK_Document_Type] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Load_History]    Script Date: 20.03.2025 12:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Load_History](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Source_File_Name] [nvarchar](255) NULL,
	[Date] [datetime] NULL,
	[User_ID] [int] NULL,
	[Document_ID] [int] NULL,
	[Data_Source_ID] [int] NULL,
 CONSTRAINT [PK_Load_History] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Login_History]    Script Date: 20.03.2025 12:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Login_History](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NULL,
	[User_ID] [int] NULL,
 CONSTRAINT [PK_Login_History] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Organisation_News]    Script Date: 20.03.2025 12:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Organisation_News](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NULL,
	[Description] [nvarchar](max) NULL,
	[Creation_Date] [datetime] NULL,
	[User_ID] [int] NULL,
 CONSTRAINT [PK_Organisation_News] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Registration_Request]    Script Date: 20.03.2025 12:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Registration_Request](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Surname] [nvarchar](100) NULL,
	[Lastname] [nvarchar](100) NULL,
	[Login] [nvarchar](100) NULL,
	[Password] [nvarchar](255) NULL,
	[Creation_Date] [datetime] NULL,
	[Request_Status_ID] [int] NULL,
	[Role_ID] [int] NULL,
	[Birth] [date] NULL,
 CONSTRAINT [PK_Registration_Request] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Report]    Script Date: 20.03.2025 12:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Report](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Creation_Date] [datetime] NULL,
	[Repoort_Type_ID] [int] NULL,
	[Document_ID] [int] NULL,
	[User_ID] [int] NULL,
 CONSTRAINT [PK_Report] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Report_Type]    Script Date: 20.03.2025 12:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Report_Type](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
 CONSTRAINT [PK_Report_Type] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Request_Decline]    Script Date: 20.03.2025 12:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Request_Decline](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Registration_Request_ID] [int] NULL,
	[Decline_Reason] [nvarchar](max) NULL,
 CONSTRAINT [PK_Request_Decline] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Request_Status]    Script Date: 20.03.2025 12:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Request_Status](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
 CONSTRAINT [PK_Request_Status] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 20.03.2025 12:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Surname] [nvarchar](100) NULL,
	[Lastname] [nvarchar](100) NULL,
	[Login] [nvarchar](50) NULL,
	[Password] [nvarchar](255) NULL,
	[Creation_date] [datetime] NULL,
	[Role_ID] [int] NULL,
	[User_Status_ID] [int] NULL,
	[Birth] [date] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User_Role]    Script Date: 20.03.2025 12:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User_Role](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
 CONSTRAINT [PK_User_Role] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User_Status]    Script Date: 20.03.2025 12:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User_Status](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
 CONSTRAINT [PK_User_Status] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Login_History] ON 

INSERT [dbo].[Login_History] ([ID], [Date], [User_ID]) VALUES (1, CAST(N'2025-03-18T15:59:56.590' AS DateTime), 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID]) VALUES (2, CAST(N'2025-03-19T10:55:00.993' AS DateTime), 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID]) VALUES (3, CAST(N'2025-03-19T14:23:20.957' AS DateTime), 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID]) VALUES (4, CAST(N'2025-03-19T14:24:02.980' AS DateTime), 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID]) VALUES (5, CAST(N'2025-03-19T14:24:52.583' AS DateTime), 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID]) VALUES (6, CAST(N'2025-03-19T14:27:56.157' AS DateTime), 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID]) VALUES (7, CAST(N'2025-03-19T14:28:52.620' AS DateTime), 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID]) VALUES (8, CAST(N'2025-03-19T14:47:52.493' AS DateTime), 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID]) VALUES (9, CAST(N'2025-03-19T14:48:40.440' AS DateTime), 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID]) VALUES (10, CAST(N'2025-03-19T14:49:37.587' AS DateTime), 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID]) VALUES (11, CAST(N'2025-03-19T14:53:11.663' AS DateTime), 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID]) VALUES (12, CAST(N'2025-03-19T14:54:22.043' AS DateTime), 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID]) VALUES (13, CAST(N'2025-03-19T14:56:36.920' AS DateTime), 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID]) VALUES (14, CAST(N'2025-03-19T14:57:59.493' AS DateTime), 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID]) VALUES (15, CAST(N'2025-03-19T14:58:30.667' AS DateTime), 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID]) VALUES (16, CAST(N'2025-03-19T15:00:08.440' AS DateTime), 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID]) VALUES (17, CAST(N'2025-03-19T15:22:39.573' AS DateTime), 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID]) VALUES (18, CAST(N'2025-03-20T10:56:22.673' AS DateTime), 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID]) VALUES (19, CAST(N'2025-03-20T11:15:18.523' AS DateTime), 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID]) VALUES (20, CAST(N'2025-03-20T11:35:53.580' AS DateTime), 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID]) VALUES (21, CAST(N'2025-03-20T11:37:31.507' AS DateTime), 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID]) VALUES (22, CAST(N'2025-03-20T11:55:47.370' AS DateTime), 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID]) VALUES (23, CAST(N'2025-03-20T11:57:32.077' AS DateTime), 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID]) VALUES (24, CAST(N'2025-03-20T11:58:46.003' AS DateTime), 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID]) VALUES (25, CAST(N'2025-03-20T12:00:04.173' AS DateTime), 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID]) VALUES (26, CAST(N'2025-03-20T12:03:15.463' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Login_History] OFF
GO
SET IDENTITY_INSERT [dbo].[Organisation_News] ON 

INSERT [dbo].[Organisation_News] ([ID], [Name], [Description], [Creation_Date], [User_ID]) VALUES (1, N'Создание приложения', N'Добро пожаловать! Это только начало разработки, но уже видны некоторые результаты!', CAST(N'2025-03-18T13:12:53.683' AS DateTime), 1)
INSERT [dbo].[Organisation_News] ([ID], [Name], [Description], [Creation_Date], [User_ID]) VALUES (2, N'Тестовая новось', N'Требуется проверить возможность автоматического добавления новостей в список, заодно напишу новость подлиннее, чтобы наверняка узнать границы контейнера', CAST(N'2025-03-19T15:00:00.000' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Organisation_News] OFF
GO
SET IDENTITY_INSERT [dbo].[Registration_Request] ON 

INSERT [dbo].[Registration_Request] ([ID], [Name], [Surname], [Lastname], [Login], [Password], [Creation_Date], [Request_Status_ID], [Role_ID], [Birth]) VALUES (1, N'Владислав', N'Кузнецов', N'Игоревич', N'Armoryx', N'S+P4YCWsU/f+Kxf7E3Y73ewZlx/us+2B4wTn7zuz0lQ=', CAST(N'2025-03-18T13:12:53.683' AS DateTime), 3, 1, NULL)
INSERT [dbo].[Registration_Request] ([ID], [Name], [Surname], [Lastname], [Login], [Password], [Creation_Date], [Request_Status_ID], [Role_ID], [Birth]) VALUES (3, N'Антон', N'Антонов', N'Антонович', N'Anton', N'QpcsGz6Fz9CGYo5hd9I6CgVxMvtviX1Y2YeZXUQqzmk=', CAST(N'2025-03-20T12:02:03.683' AS DateTime), 1, 1, CAST(N'1994-06-07' AS Date))
INSERT [dbo].[Registration_Request] ([ID], [Name], [Surname], [Lastname], [Login], [Password], [Creation_Date], [Request_Status_ID], [Role_ID], [Birth]) VALUES (4, N'Дмитрий', N'Дмитриев', N'Дмитриевич', N'Dmitriy', N'z5xeNsrTwk/48GrFLRaKVP7fsc0nIynNXzEszlMeElg=', CAST(N'2025-03-20T12:02:59.647' AS DateTime), 1, 1, CAST(N'1989-12-14' AS Date))
SET IDENTITY_INSERT [dbo].[Registration_Request] OFF
GO
SET IDENTITY_INSERT [dbo].[Request_Status] ON 

INSERT [dbo].[Request_Status] ([ID], [Name]) VALUES (1, N'Новая')
INSERT [dbo].[Request_Status] ([ID], [Name]) VALUES (2, N'На рассмотрении')
INSERT [dbo].[Request_Status] ([ID], [Name]) VALUES (3, N'Одобрена')
INSERT [dbo].[Request_Status] ([ID], [Name]) VALUES (4, N'Отклонена')
SET IDENTITY_INSERT [dbo].[Request_Status] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([ID], [Name], [Surname], [Lastname], [Login], [Password], [Creation_date], [Role_ID], [User_Status_ID], [Birth]) VALUES (1, N'Владислав', N'Кузнецов', N'Игоревич', N'Armoryx', N'S+P4YCWsU/f+Kxf7E3Y73ewZlx/us+2B4wTn7zuz0lQ=', CAST(N'2025-03-18T13:12:53.683' AS DateTime), 3, 1, CAST(N'2005-01-20' AS Date))
SET IDENTITY_INSERT [dbo].[User] OFF
GO
SET IDENTITY_INSERT [dbo].[User_Role] ON 

INSERT [dbo].[User_Role] ([ID], [Name]) VALUES (1, N'Пользователь')
INSERT [dbo].[User_Role] ([ID], [Name]) VALUES (2, N'Сотрудник')
INSERT [dbo].[User_Role] ([ID], [Name]) VALUES (3, N'Администратор')
SET IDENTITY_INSERT [dbo].[User_Role] OFF
GO
SET IDENTITY_INSERT [dbo].[User_Status] ON 

INSERT [dbo].[User_Status] ([ID], [Name]) VALUES (1, N'Активный')
INSERT [dbo].[User_Status] ([ID], [Name]) VALUES (2, N'Бездействующий')
INSERT [dbo].[User_Status] ([ID], [Name]) VALUES (3, N'Заблокированный')
SET IDENTITY_INSERT [dbo].[User_Status] OFF
GO
ALTER TABLE [dbo].[Change_History]  WITH CHECK ADD  CONSTRAINT [FK_Change_History_Document] FOREIGN KEY([Document_ID])
REFERENCES [dbo].[Document] ([ID])
GO
ALTER TABLE [dbo].[Change_History] CHECK CONSTRAINT [FK_Change_History_Document]
GO
ALTER TABLE [dbo].[Change_History]  WITH CHECK ADD  CONSTRAINT [FK_Change_History_User] FOREIGN KEY([User_ID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[Change_History] CHECK CONSTRAINT [FK_Change_History_User]
GO
ALTER TABLE [dbo].[Document]  WITH CHECK ADD  CONSTRAINT [FK_Document_Document_Status] FOREIGN KEY([Status_ID])
REFERENCES [dbo].[Document_Status] ([ID])
GO
ALTER TABLE [dbo].[Document] CHECK CONSTRAINT [FK_Document_Document_Status]
GO
ALTER TABLE [dbo].[Document]  WITH CHECK ADD  CONSTRAINT [FK_Document_Document_Type] FOREIGN KEY([Type_ID])
REFERENCES [dbo].[Document_Type] ([ID])
GO
ALTER TABLE [dbo].[Document] CHECK CONSTRAINT [FK_Document_Document_Type]
GO
ALTER TABLE [dbo].[Document_Struct]  WITH CHECK ADD  CONSTRAINT [FK_Document_Struct_Document_Type] FOREIGN KEY([Type_ID])
REFERENCES [dbo].[Document_Type] ([ID])
GO
ALTER TABLE [dbo].[Document_Struct] CHECK CONSTRAINT [FK_Document_Struct_Document_Type]
GO
ALTER TABLE [dbo].[Load_History]  WITH CHECK ADD  CONSTRAINT [FK_Load_History_Data_Source] FOREIGN KEY([Data_Source_ID])
REFERENCES [dbo].[Data_Source] ([ID])
GO
ALTER TABLE [dbo].[Load_History] CHECK CONSTRAINT [FK_Load_History_Data_Source]
GO
ALTER TABLE [dbo].[Load_History]  WITH CHECK ADD  CONSTRAINT [FK_Load_History_Document] FOREIGN KEY([Document_ID])
REFERENCES [dbo].[Document] ([ID])
GO
ALTER TABLE [dbo].[Load_History] CHECK CONSTRAINT [FK_Load_History_Document]
GO
ALTER TABLE [dbo].[Load_History]  WITH CHECK ADD  CONSTRAINT [FK_Load_History_User] FOREIGN KEY([User_ID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[Load_History] CHECK CONSTRAINT [FK_Load_History_User]
GO
ALTER TABLE [dbo].[Login_History]  WITH CHECK ADD  CONSTRAINT [FK_Login_History_User] FOREIGN KEY([User_ID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[Login_History] CHECK CONSTRAINT [FK_Login_History_User]
GO
ALTER TABLE [dbo].[Organisation_News]  WITH CHECK ADD  CONSTRAINT [FK_Organisation_News_User] FOREIGN KEY([User_ID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[Organisation_News] CHECK CONSTRAINT [FK_Organisation_News_User]
GO
ALTER TABLE [dbo].[Registration_Request]  WITH CHECK ADD  CONSTRAINT [FK_Registration_Request_Request_Status] FOREIGN KEY([Request_Status_ID])
REFERENCES [dbo].[Request_Status] ([ID])
GO
ALTER TABLE [dbo].[Registration_Request] CHECK CONSTRAINT [FK_Registration_Request_Request_Status]
GO
ALTER TABLE [dbo].[Registration_Request]  WITH CHECK ADD  CONSTRAINT [FK_Registration_Request_User_Role] FOREIGN KEY([Role_ID])
REFERENCES [dbo].[User_Role] ([ID])
GO
ALTER TABLE [dbo].[Registration_Request] CHECK CONSTRAINT [FK_Registration_Request_User_Role]
GO
ALTER TABLE [dbo].[Report]  WITH CHECK ADD  CONSTRAINT [FK_Report_Report_Type] FOREIGN KEY([Repoort_Type_ID])
REFERENCES [dbo].[Report_Type] ([ID])
GO
ALTER TABLE [dbo].[Report] CHECK CONSTRAINT [FK_Report_Report_Type]
GO
ALTER TABLE [dbo].[Report]  WITH CHECK ADD  CONSTRAINT [FK_Report_User] FOREIGN KEY([User_ID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[Report] CHECK CONSTRAINT [FK_Report_User]
GO
ALTER TABLE [dbo].[Request_Decline]  WITH CHECK ADD  CONSTRAINT [FK_Request_Decline_Registration_Request] FOREIGN KEY([Registration_Request_ID])
REFERENCES [dbo].[Registration_Request] ([ID])
GO
ALTER TABLE [dbo].[Request_Decline] CHECK CONSTRAINT [FK_Request_Decline_Registration_Request]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_User_Role] FOREIGN KEY([Role_ID])
REFERENCES [dbo].[User_Role] ([ID])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_User_Role]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_User_Status] FOREIGN KEY([User_Status_ID])
REFERENCES [dbo].[User_Status] ([ID])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_User_Status]
GO
USE [master]
GO
ALTER DATABASE [ANALYS_SYSTEM_DB] SET  READ_WRITE 
GO
