USE [master]
GO
/****** Object:  Database [ANALYS_SYSTEM_DB]    Script Date: 07.04.2025 11:22:07 ******/
CREATE DATABASE [ANALYS_SYSTEM_DB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ANALYS_SYSTEM_DB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\ANALYS_SYSTEM_DB.mdf' , SIZE = 69632KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
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
/****** Object:  Table [dbo].[Change_History]    Script Date: 07.04.2025 11:22:07 ******/
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
/****** Object:  Table [dbo].[Data_Source]    Script Date: 07.04.2025 11:22:07 ******/
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
/****** Object:  Table [dbo].[Document]    Script Date: 07.04.2025 11:22:07 ******/
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
	[Provider_ID] [int] NULL,
 CONSTRAINT [PK_Document] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Document_Status]    Script Date: 07.04.2025 11:22:07 ******/
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
/****** Object:  Table [dbo].[Document_Struct]    Script Date: 07.04.2025 11:22:07 ******/
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
/****** Object:  Table [dbo].[Document_Type]    Script Date: 07.04.2025 11:22:07 ******/
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
/****** Object:  Table [dbo].[Load_History]    Script Date: 07.04.2025 11:22:07 ******/
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
/****** Object:  Table [dbo].[Login_History]    Script Date: 07.04.2025 11:22:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Login_History](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NULL,
	[User_ID] [int] NULL,
	[Login_Status_ID] [int] NULL,
 CONSTRAINT [PK_Login_History] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Login_Status]    Script Date: 07.04.2025 11:22:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Login_Status](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
 CONSTRAINT [PK_Login_Status] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[News_Change_History]    Script Date: 07.04.2025 11:22:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[News_Change_History](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[User_ID] [int] NULL,
	[News_ID] [int] NULL,
	[Old_Value] [nvarchar](max) NULL,
	[New_Value] [nvarchar](max) NULL,
	[Date] [datetime] NULL,
 CONSTRAINT [PK_News_Change_History] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Organisation_News]    Script Date: 07.04.2025 11:22:07 ******/
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
/****** Object:  Table [dbo].[Organisation_Type]    Script Date: 07.04.2025 11:22:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Organisation_Type](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
 CONSTRAINT [PK_Organisation_Type] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Provider]    Script Date: 07.04.2025 11:22:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Provider](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](150) NULL,
	[Organisation_Type_ID] [int] NULL,
	[Owner] [nvarchar](150) NULL,
	[Location] [nvarchar](250) NULL,
	[Creation_Date] [date] NULL,
 CONSTRAINT [PK_Provider] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Registration_Request]    Script Date: 07.04.2025 11:22:07 ******/
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
/****** Object:  Table [dbo].[Report]    Script Date: 07.04.2025 11:22:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Report](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Creation_Date] [datetime] NULL,
	[Document_ID] [int] NULL,
	[User_ID] [int] NULL,
 CONSTRAINT [PK_Report] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Request_Decline]    Script Date: 07.04.2025 11:22:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Request_Decline](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Registration_Request_ID] [int] NULL,
	[Decline_Reason] [nvarchar](max) NULL,
	[User_ID] [int] NULL,
 CONSTRAINT [PK_Request_Decline] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Request_Status]    Script Date: 07.04.2025 11:22:07 ******/
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
/****** Object:  Table [dbo].[User]    Script Date: 07.04.2025 11:22:07 ******/
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
/****** Object:  Table [dbo].[User_Role]    Script Date: 07.04.2025 11:22:07 ******/
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
/****** Object:  Table [dbo].[User_Status]    Script Date: 07.04.2025 11:22:07 ******/
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
SET IDENTITY_INSERT [dbo].[Change_History] ON 

INSERT [dbo].[Change_History] ([ID], [Change_Date], [Old_Value], [New_Value], [Reason], [User_ID], [Document_ID]) VALUES (1, CAST(N'2025-04-01T14:16:56.797' AS DateTime), N'Активный', N'Выведен из общего доступа', N'Тестирование функционала изменения статуса документа', 1, 2)
INSERT [dbo].[Change_History] ([ID], [Change_Date], [Old_Value], [New_Value], [Reason], [User_ID], [Document_ID]) VALUES (2, CAST(N'2025-04-01T14:47:27.440' AS DateTime), N'Выведен из общего доступа', N'Требует правок', N'Просто тестирование', 1, 2)
SET IDENTITY_INSERT [dbo].[Change_History] OFF
GO
SET IDENTITY_INSERT [dbo].[Data_Source] ON 

INSERT [dbo].[Data_Source] ([ID], [Name]) VALUES (1, N'Excel')
INSERT [dbo].[Data_Source] ([ID], [Name]) VALUES (2, N'CSV')
SET IDENTITY_INSERT [dbo].[Data_Source] OFF
GO
SET IDENTITY_INSERT [dbo].[Document] ON 

INSERT [dbo].[Document] ([ID], [Date], [Name], [Status_ID], [Type_ID], [Provider_ID]) VALUES (1, CAST(N'2025-03-25T12:05:55.623' AS DateTime), N'users.xlsx', 1, 1, NULL)
INSERT [dbo].[Document] ([ID], [Date], [Name], [Status_ID], [Type_ID], [Provider_ID]) VALUES (2, CAST(N'2025-03-25T14:04:24.817' AS DateTime), N'komus_opt_price_7.csv', 2, 2, NULL)
INSERT [dbo].[Document] ([ID], [Date], [Name], [Status_ID], [Type_ID], [Provider_ID]) VALUES (3, CAST(N'2025-04-01T14:42:38.557' AS DateTime), N'komus_opt_price_7(2).csv', 1, 2, NULL)
INSERT [dbo].[Document] ([ID], [Date], [Name], [Status_ID], [Type_ID], [Provider_ID]) VALUES (4, CAST(N'2025-04-03T12:36:48.183' AS DateTime), N'users(2).xlsx', 1, 1, NULL)
INSERT [dbo].[Document] ([ID], [Date], [Name], [Status_ID], [Type_ID], [Provider_ID]) VALUES (5, CAST(N'2025-04-03T12:57:34.640' AS DateTime), N'test_sheet.xlsx', 1, 3, NULL)
INSERT [dbo].[Document] ([ID], [Date], [Name], [Status_ID], [Type_ID], [Provider_ID]) VALUES (6, CAST(N'2025-04-03T12:58:49.793' AS DateTime), N'test_sheet(2).xlsx', 1, 3, NULL)
SET IDENTITY_INSERT [dbo].[Document] OFF
GO
SET IDENTITY_INSERT [dbo].[Document_Status] ON 

INSERT [dbo].[Document_Status] ([ID], [Name]) VALUES (1, N'Активный')
INSERT [dbo].[Document_Status] ([ID], [Name]) VALUES (2, N'Требует правок')
INSERT [dbo].[Document_Status] ([ID], [Name]) VALUES (3, N'Изменен')
INSERT [dbo].[Document_Status] ([ID], [Name]) VALUES (4, N'Выведен из общего доступа')
SET IDENTITY_INSERT [dbo].[Document_Status] OFF
GO
SET IDENTITY_INSERT [dbo].[Document_Struct] ON 

INSERT [dbo].[Document_Struct] ([ID], [Name], [Description], [Attributes_List], [Creation_Date], [Type_ID]) VALUES (1, N'Содержание файла списка сотрудников', N'Файл должен содержать структуру исключительно личной информации о сотрудниках организации', N'["ФИО", "Телефон", "Адрес", "Серия паспорта", "Номер паспорта"]', CAST(N'2025-03-24T15:07:00.000' AS DateTime), 1)
INSERT [dbo].[Document_Struct] ([ID], [Name], [Description], [Attributes_List], [Creation_Date], [Type_ID]) VALUES (2, N'Содержание файла оптовых закупок komus', N'Файл должен содержать соответствующую информацию', N'["Товарное направление", "Товарная категория", "Товарная группа", "Торговая марка", "Артикул", "Наименование товара", "Доп. информация", "Изображние товара", "Код производителя", "Базовая цена, руб.", "НДС", "Наличие на складе", "Ед.изм", "Схема вложения упаковки", "Оптовая кратн. упаковки", "Тип упаковки", "Статус товара", "Вес, кг", "Объем, л", "Страна-производитель", "Штрих-код", "Ценовой сегмент"]', CAST(N'2025-03-25T12:53:00.000' AS DateTime), 2)
INSERT [dbo].[Document_Struct] ([ID], [Name], [Description], [Attributes_List], [Creation_Date], [Type_ID]) VALUES (3, N'Тестовая структура данных', N'Исключительно тестовая структура для понимания работоспособности функции', N'["Ключ", "Название"]', CAST(N'2025-04-03T12:54:53.493' AS DateTime), 3)
SET IDENTITY_INSERT [dbo].[Document_Struct] OFF
GO
SET IDENTITY_INSERT [dbo].[Document_Type] ON 

INSERT [dbo].[Document_Type] ([ID], [Name]) VALUES (1, N'Список сотрудников')
INSERT [dbo].[Document_Type] ([ID], [Name]) VALUES (2, N'Оптовые закупки komus')
INSERT [dbo].[Document_Type] ([ID], [Name]) VALUES (3, N'Тестовый тип')
SET IDENTITY_INSERT [dbo].[Document_Type] OFF
GO
SET IDENTITY_INSERT [dbo].[Load_History] ON 

INSERT [dbo].[Load_History] ([ID], [Source_File_Name], [Date], [User_ID], [Document_ID], [Data_Source_ID]) VALUES (1, N'C:\Users\kvi\Downloads\users.xlsx', CAST(N'2025-03-25T12:05:55.663' AS DateTime), 2, 1, 1)
INSERT [dbo].[Load_History] ([ID], [Source_File_Name], [Date], [User_ID], [Document_ID], [Data_Source_ID]) VALUES (2, N'C:\Users\kvi\Downloads\komus_opt_price_7.csv', CAST(N'2025-03-25T14:04:24.843' AS DateTime), 2, 2, 2)
INSERT [dbo].[Load_History] ([ID], [Source_File_Name], [Date], [User_ID], [Document_ID], [Data_Source_ID]) VALUES (3, N'C:\Users\kvi\Downloads\komus_opt_price_7(2).csv', CAST(N'2025-04-01T14:42:38.580' AS DateTime), 2, 3, 2)
INSERT [dbo].[Load_History] ([ID], [Source_File_Name], [Date], [User_ID], [Document_ID], [Data_Source_ID]) VALUES (4, N'C:\Users\kvi\Downloads\users(2).xlsx', CAST(N'2025-04-03T12:36:48.197' AS DateTime), 2, 4, 1)
INSERT [dbo].[Load_History] ([ID], [Source_File_Name], [Date], [User_ID], [Document_ID], [Data_Source_ID]) VALUES (5, N'C:\Users\kvi\Downloads\test_sheet.xlsx', CAST(N'2025-04-03T12:57:34.647' AS DateTime), 2, 5, 1)
INSERT [dbo].[Load_History] ([ID], [Source_File_Name], [Date], [User_ID], [Document_ID], [Data_Source_ID]) VALUES (6, N'C:\Users\kvi\Downloads\test_sheet(2).xlsx', CAST(N'2025-04-03T12:58:49.820' AS DateTime), 2, 6, 1)
SET IDENTITY_INSERT [dbo].[Load_History] OFF
GO
SET IDENTITY_INSERT [dbo].[Login_History] ON 

INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (50, CAST(N'2025-03-21T11:51:20.897' AS DateTime), 2, 2)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (51, CAST(N'2025-03-21T11:51:24.323' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (52, CAST(N'2025-03-21T11:51:41.677' AS DateTime), 1, 2)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (53, CAST(N'2025-03-21T11:51:44.507' AS DateTime), 1, 2)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (54, CAST(N'2025-03-21T11:51:49.297' AS DateTime), 1, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (55, CAST(N'2025-03-21T11:52:48.650' AS DateTime), 1, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (56, CAST(N'2025-03-21T11:54:23.860' AS DateTime), 1, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (57, CAST(N'2025-03-21T12:44:23.620' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (58, CAST(N'2025-03-21T13:35:52.003' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (59, CAST(N'2025-03-21T13:36:52.973' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (60, CAST(N'2025-03-21T13:38:43.417' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (61, CAST(N'2025-03-21T13:39:22.637' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (62, CAST(N'2025-03-21T13:40:16.280' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (63, CAST(N'2025-03-21T13:52:10.167' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1047, CAST(N'2025-03-24T11:05:26.640' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1048, CAST(N'2025-03-24T11:09:25.043' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1049, CAST(N'2025-03-24T11:27:48.613' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1050, CAST(N'2025-03-24T11:46:52.317' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1051, CAST(N'2025-03-24T11:49:21.947' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1052, CAST(N'2025-03-24T11:58:23.493' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1053, CAST(N'2025-03-25T10:56:25.800' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1054, CAST(N'2025-03-25T10:57:48.413' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1055, CAST(N'2025-03-25T11:07:49.293' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1056, CAST(N'2025-03-25T11:29:46.937' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1057, CAST(N'2025-03-25T11:43:55.587' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1058, CAST(N'2025-03-25T11:46:15.230' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1059, CAST(N'2025-03-25T11:48:37.590' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1060, CAST(N'2025-03-25T11:49:47.623' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1061, CAST(N'2025-03-25T11:50:25.097' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1062, CAST(N'2025-03-25T11:51:08.967' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1063, CAST(N'2025-03-25T12:05:48.120' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1064, CAST(N'2025-03-25T12:07:34.810' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1065, CAST(N'2025-03-25T12:22:31.247' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1066, CAST(N'2025-03-25T12:44:27.963' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1067, CAST(N'2025-03-25T12:53:47.053' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1068, CAST(N'2025-03-25T12:58:30.873' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1069, CAST(N'2025-03-25T13:04:05.860' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1070, CAST(N'2025-03-25T13:06:19.103' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1071, CAST(N'2025-03-25T13:51:42.887' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1072, CAST(N'2025-03-25T13:56:48.643' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1073, CAST(N'2025-03-25T14:03:41.730' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1074, CAST(N'2025-03-25T14:08:23.450' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1075, CAST(N'2025-03-25T15:05:59.300' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1076, CAST(N'2025-03-25T15:07:33.233' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1077, CAST(N'2025-03-25T15:10:29.287' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1078, CAST(N'2025-03-25T15:18:39.723' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1079, CAST(N'2025-03-25T15:20:04.253' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1080, CAST(N'2025-03-25T15:21:50.767' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1081, CAST(N'2025-03-25T15:23:44.130' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1082, CAST(N'2025-03-25T15:24:24.387' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1083, CAST(N'2025-03-25T15:26:22.530' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1084, CAST(N'2025-03-25T15:27:22.630' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1085, CAST(N'2025-03-25T15:30:40.727' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1086, CAST(N'2025-03-25T15:33:03.567' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1087, CAST(N'2025-03-25T15:36:28.207' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1088, CAST(N'2025-03-25T15:37:09.017' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1089, CAST(N'2025-03-25T15:37:49.510' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1090, CAST(N'2025-03-25T15:40:10.070' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1091, CAST(N'2025-03-25T15:43:36.990' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1092, CAST(N'2025-03-31T10:59:54.767' AS DateTime), 1, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1093, CAST(N'2025-03-31T11:00:27.437' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1094, CAST(N'2025-03-31T11:21:15.140' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1095, CAST(N'2025-03-31T11:36:22.097' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1096, CAST(N'2025-03-31T11:59:10.480' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1097, CAST(N'2025-03-31T12:01:44.053' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1098, CAST(N'2025-03-31T12:13:24.350' AS DateTime), 1, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1099, CAST(N'2025-03-31T14:03:39.120' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1100, CAST(N'2025-03-31T14:05:24.150' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1101, CAST(N'2025-03-31T14:06:27.720' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1102, CAST(N'2025-03-31T14:08:46.683' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1103, CAST(N'2025-03-31T14:11:15.487' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1104, CAST(N'2025-03-31T14:15:53.803' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1105, CAST(N'2025-03-31T14:17:08.843' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1106, CAST(N'2025-03-31T14:20:39.617' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1107, CAST(N'2025-03-31T14:23:19.533' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1108, CAST(N'2025-03-31T14:26:29.790' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1109, CAST(N'2025-03-31T14:29:49.460' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1110, CAST(N'2025-03-31T14:33:08.683' AS DateTime), 2, 2)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1111, CAST(N'2025-03-31T14:33:12.677' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1112, CAST(N'2025-03-31T14:37:26.140' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1113, CAST(N'2025-03-31T14:38:04.680' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1114, CAST(N'2025-03-31T14:41:52.793' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1115, CAST(N'2025-03-31T14:43:53.603' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1116, CAST(N'2025-03-31T14:45:26.463' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1117, CAST(N'2025-03-31T14:47:08.540' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1118, CAST(N'2025-03-31T14:49:45.753' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1119, CAST(N'2025-03-31T14:52:39.657' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1120, CAST(N'2025-03-31T14:55:19.710' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1121, CAST(N'2025-03-31T14:56:23.700' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1122, CAST(N'2025-03-31T15:04:10.240' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1123, CAST(N'2025-03-31T15:04:52.707' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1124, CAST(N'2025-03-31T15:28:46.853' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1125, CAST(N'2025-03-31T15:30:30.537' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1126, CAST(N'2025-03-31T15:34:46.550' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1127, CAST(N'2025-03-31T15:35:44.107' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1128, CAST(N'2025-04-01T11:35:20.773' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1129, CAST(N'2025-04-01T11:43:12.540' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1130, CAST(N'2025-04-01T11:52:13.487' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1131, CAST(N'2025-04-01T11:54:20.587' AS DateTime), 2, 1)
GO
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1132, CAST(N'2025-04-01T11:55:40.190' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1133, CAST(N'2025-04-01T12:00:36.270' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1134, CAST(N'2025-04-01T12:02:27.173' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1135, CAST(N'2025-04-01T12:49:57.080' AS DateTime), 2, 2)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1136, CAST(N'2025-04-01T12:50:00.980' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1137, CAST(N'2025-04-01T12:52:23.840' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1138, CAST(N'2025-04-01T13:53:52.383' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1139, CAST(N'2025-04-01T13:54:09.657' AS DateTime), 1, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1140, CAST(N'2025-04-01T13:55:25.007' AS DateTime), 1, 2)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1141, CAST(N'2025-04-01T13:55:27.020' AS DateTime), 1, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1142, CAST(N'2025-04-01T14:16:23.863' AS DateTime), 1, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1143, CAST(N'2025-04-01T14:18:08.333' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1144, CAST(N'2025-04-01T14:19:35.567' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1145, CAST(N'2025-04-01T14:20:30.370' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1146, CAST(N'2025-04-01T14:25:36.630' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1147, CAST(N'2025-04-01T14:26:56.913' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1148, CAST(N'2025-04-01T14:31:17.687' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1149, CAST(N'2025-04-01T14:32:20.260' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1150, CAST(N'2025-04-01T14:33:28.490' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1151, CAST(N'2025-04-01T14:37:40.650' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1152, CAST(N'2025-04-01T14:38:23.867' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1153, CAST(N'2025-04-01T14:40:50.943' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1154, CAST(N'2025-04-01T14:42:16.773' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1155, CAST(N'2025-04-01T14:43:48.153' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1156, CAST(N'2025-04-01T14:46:13.873' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1157, CAST(N'2025-04-01T14:46:59.467' AS DateTime), 1, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1158, CAST(N'2025-04-01T14:47:46.303' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1159, CAST(N'2025-04-01T15:33:00.443' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1160, CAST(N'2025-04-01T15:33:18.583' AS DateTime), 1, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1161, CAST(N'2025-04-01T15:34:39.100' AS DateTime), 1, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1162, CAST(N'2025-04-01T15:36:34.913' AS DateTime), 1, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1163, CAST(N'2025-04-01T15:37:07.263' AS DateTime), 1002, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1164, CAST(N'2025-04-01T15:45:52.847' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1165, CAST(N'2025-04-01T15:46:15.590' AS DateTime), 1, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1166, CAST(N'2025-04-03T12:24:20.490' AS DateTime), 1, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1167, CAST(N'2025-04-03T12:25:39.697' AS DateTime), 1, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1168, CAST(N'2025-04-03T12:33:48.350' AS DateTime), 1, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1169, CAST(N'2025-04-03T12:34:44.753' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1170, CAST(N'2025-04-03T12:35:42.413' AS DateTime), 1, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1171, CAST(N'2025-04-03T12:36:14.923' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1172, CAST(N'2025-04-03T12:37:32.887' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1173, CAST(N'2025-04-03T12:53:59.443' AS DateTime), 1, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1174, CAST(N'2025-04-03T12:57:23.247' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1175, CAST(N'2025-04-03T12:58:08.103' AS DateTime), 2, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1176, CAST(N'2025-04-03T13:18:20.170' AS DateTime), 1, 1)
INSERT [dbo].[Login_History] ([ID], [Date], [User_ID], [Login_Status_ID]) VALUES (1177, CAST(N'2025-04-03T13:18:55.743' AS DateTime), 1003, 1)
SET IDENTITY_INSERT [dbo].[Login_History] OFF
GO
SET IDENTITY_INSERT [dbo].[Login_Status] ON 

INSERT [dbo].[Login_Status] ([ID], [Name]) VALUES (1, N'Успешно')
INSERT [dbo].[Login_Status] ([ID], [Name]) VALUES (2, N'Неверный логин или пароль')
INSERT [dbo].[Login_Status] ([ID], [Name]) VALUES (3, N'Учетная запись заблокирована')
SET IDENTITY_INSERT [dbo].[Login_Status] OFF
GO
SET IDENTITY_INSERT [dbo].[News_Change_History] ON 

INSERT [dbo].[News_Change_History] ([ID], [User_ID], [News_ID], [Old_Value], [New_Value], [Date]) VALUES (1, 2, 2, N'Требуется проверить возможность автоматического добавления новостей в список, заодно напишу новость подлиннее, чтобы наверняка узнать границы контейнера', N'Требуется проверить возможность автоматического добавления новостей в список, заодно напишу новость подлиннее, чтобы наверняка узнать границы контейнера.', CAST(N'2025-03-24T11:27:56.667' AS DateTime))
INSERT [dbo].[News_Change_History] ([ID], [User_ID], [News_ID], [Old_Value], [New_Value], [Date]) VALUES (2, 2, 2, N'Тестовая новось', N'Тестовая новость', CAST(N'2025-03-24T11:48:01.913' AS DateTime))
INSERT [dbo].[News_Change_History] ([ID], [User_ID], [News_ID], [Old_Value], [New_Value], [Date]) VALUES (3, 2, 1, N'Создание приложения', N'Создание приложения!', CAST(N'2025-03-24T11:48:46.777' AS DateTime))
INSERT [dbo].[News_Change_History] ([ID], [User_ID], [News_ID], [Old_Value], [New_Value], [Date]) VALUES (4, 2, 1, N'Создание приложения!', N'Создание приложения', CAST(N'2025-03-24T11:49:38.000' AS DateTime))
INSERT [dbo].[News_Change_History] ([ID], [User_ID], [News_ID], [Old_Value], [New_Value], [Date]) VALUES (5, 2, 1, N'Добро пожаловать! Это только начало разработки, но уже видны некоторые результаты!', N'Добро пожаловать! Это только начало разработки, но уже видны некоторые результаты.', CAST(N'2025-03-24T11:49:38.037' AS DateTime))
INSERT [dbo].[News_Change_History] ([ID], [User_ID], [News_ID], [Old_Value], [New_Value], [Date]) VALUES (6, 2, 1002, N'Проверяем работоспособность новой функции создания новостей у репортера.', N'Проверяем работоспособность новой функции создания новостей у репортера', CAST(N'2025-03-24T11:59:07.140' AS DateTime))
SET IDENTITY_INSERT [dbo].[News_Change_History] OFF
GO
SET IDENTITY_INSERT [dbo].[Organisation_News] ON 

INSERT [dbo].[Organisation_News] ([ID], [Name], [Description], [Creation_Date], [User_ID]) VALUES (1, N'Создание приложения', N'Добро пожаловать! Это только начало разработки, но уже видны некоторые результаты.', CAST(N'2025-03-18T13:12:53.683' AS DateTime), 1)
INSERT [dbo].[Organisation_News] ([ID], [Name], [Description], [Creation_Date], [User_ID]) VALUES (2, N'Тестовая новость', N'Требуется проверить возможность автоматического добавления новостей в список, заодно напишу новость подлиннее, чтобы наверняка узнать границы контейнера.', CAST(N'2025-03-19T15:00:00.000' AS DateTime), 1)
INSERT [dbo].[Organisation_News] ([ID], [Name], [Description], [Creation_Date], [User_ID]) VALUES (1002, N'Проверка работоспособности', N'Проверяем работоспособность новой функции создания новостей у репортера', CAST(N'2025-03-24T11:58:55.587' AS DateTime), 2)
SET IDENTITY_INSERT [dbo].[Organisation_News] OFF
GO
SET IDENTITY_INSERT [dbo].[Organisation_Type] ON 

INSERT [dbo].[Organisation_Type] ([ID], [Name]) VALUES (1, N'ООО')
INSERT [dbo].[Organisation_Type] ([ID], [Name]) VALUES (2, N'ОАО')
INSERT [dbo].[Organisation_Type] ([ID], [Name]) VALUES (3, N'АО')
INSERT [dbo].[Organisation_Type] ([ID], [Name]) VALUES (4, N'ЗАО')
INSERT [dbo].[Organisation_Type] ([ID], [Name]) VALUES (5, N'ПАО')
INSERT [dbo].[Organisation_Type] ([ID], [Name]) VALUES (6, N'ИП')
INSERT [dbo].[Organisation_Type] ([ID], [Name]) VALUES (7, N'ГБУ')
INSERT [dbo].[Organisation_Type] ([ID], [Name]) VALUES (8, N'ФГУП')
INSERT [dbo].[Organisation_Type] ([ID], [Name]) VALUES (9, N'МУП')
INSERT [dbo].[Organisation_Type] ([ID], [Name]) VALUES (10, N'НКО')
INSERT [dbo].[Organisation_Type] ([ID], [Name]) VALUES (11, N'ТСЖ')
INSERT [dbo].[Organisation_Type] ([ID], [Name]) VALUES (12, N'ПК')
INSERT [dbo].[Organisation_Type] ([ID], [Name]) VALUES (13, N'КФК')
INSERT [dbo].[Organisation_Type] ([ID], [Name]) VALUES (14, N'СНТ')
INSERT [dbo].[Organisation_Type] ([ID], [Name]) VALUES (15, N'ЖСК')
INSERT [dbo].[Organisation_Type] ([ID], [Name]) VALUES (16, N'Потрбительский кооператив')
SET IDENTITY_INSERT [dbo].[Organisation_Type] OFF
GO
SET IDENTITY_INSERT [dbo].[Registration_Request] ON 

INSERT [dbo].[Registration_Request] ([ID], [Name], [Surname], [Lastname], [Login], [Password], [Creation_Date], [Request_Status_ID], [Role_ID], [Birth]) VALUES (1, N'Владислав', N'Кузнецов', N'Игоревич', N'Armoryx', N'S+P4YCWsU/f+Kxf7E3Y73ewZlx/us+2B4wTn7zuz0lQ=', CAST(N'2025-03-18T13:12:53.683' AS DateTime), 3, 1, NULL)
INSERT [dbo].[Registration_Request] ([ID], [Name], [Surname], [Lastname], [Login], [Password], [Creation_Date], [Request_Status_ID], [Role_ID], [Birth]) VALUES (3, N'Антон', N'Антонов', N'Антонович', N'Anton', N'QpcsGz6Fz9CGYo5hd9I6CgVxMvtviX1Y2YeZXUQqzmk=', CAST(N'2025-03-20T12:02:03.683' AS DateTime), 3, 1, CAST(N'1994-06-07' AS Date))
INSERT [dbo].[Registration_Request] ([ID], [Name], [Surname], [Lastname], [Login], [Password], [Creation_Date], [Request_Status_ID], [Role_ID], [Birth]) VALUES (4, N'Дмитрий', N'Дмитриев', N'Дмитриевич', N'Dmitriy', N'z5xeNsrTwk/48GrFLRaKVP7fsc0nIynNXzEszlMeElg=', CAST(N'2025-03-20T12:02:59.647' AS DateTime), 4, 1, CAST(N'1989-12-14' AS Date))
INSERT [dbo].[Registration_Request] ([ID], [Name], [Surname], [Lastname], [Login], [Password], [Creation_Date], [Request_Status_ID], [Role_ID], [Birth]) VALUES (5, N'Батон', N'Батонов', N'Батонович', N'Baton', N'vMcayp3bmqbh7dAHE8kCivJhEwlOvdnkKN7WHqC4DN4=', CAST(N'2025-03-20T13:06:06.273' AS DateTime), 3, 1, CAST(N'1998-06-25' AS Date))
INSERT [dbo].[Registration_Request] ([ID], [Name], [Surname], [Lastname], [Login], [Password], [Creation_Date], [Request_Status_ID], [Role_ID], [Birth]) VALUES (1005, N'Максим', N'Максимов', N'Максимович', N'Maks', N'r/9if043/IPP1Tx/xRDYWN5R4M0BvRnHOTO8OKE29RA=', CAST(N'2025-04-01T15:36:24.437' AS DateTime), 3, 1, CAST(N'2000-07-13' AS Date))
INSERT [dbo].[Registration_Request] ([ID], [Name], [Surname], [Lastname], [Login], [Password], [Creation_Date], [Request_Status_ID], [Role_ID], [Birth]) VALUES (1006, N'Антон', N'Антонов', N'Антонович', N'Anton_', N'0maq0pYFlnnJGCnfYAobKLzVNTc1THffFAEcojsX08Y=', CAST(N'2025-04-03T13:18:11.763' AS DateTime), 3, 1, CAST(N'1990-06-16' AS Date))
SET IDENTITY_INSERT [dbo].[Registration_Request] OFF
GO
SET IDENTITY_INSERT [dbo].[Report] ON 

INSERT [dbo].[Report] ([ID], [Creation_Date], [Document_ID], [User_ID]) VALUES (1, CAST(N'2025-04-01T12:52:41.310' AS DateTime), 2, 2)
SET IDENTITY_INSERT [dbo].[Report] OFF
GO
SET IDENTITY_INSERT [dbo].[Request_Decline] ON 

INSERT [dbo].[Request_Decline] ([ID], [Registration_Request_ID], [Decline_Reason], [User_ID]) VALUES (1, 4, N'Тестовое отклонение заявки', 1)
SET IDENTITY_INSERT [dbo].[Request_Decline] OFF
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
INSERT [dbo].[User] ([ID], [Name], [Surname], [Lastname], [Login], [Password], [Creation_date], [Role_ID], [User_Status_ID], [Birth]) VALUES (2, N'Батончик', N'Батонов', N'Батонович', N'Baton', N'vMcayp3bmqbh7dAHE8kCivJhEwlOvdnkKN7WHqC4DN4=', CAST(N'2025-03-20T13:06:06.273' AS DateTime), 2, 1, CAST(N'1998-06-25' AS Date))
INSERT [dbo].[User] ([ID], [Name], [Surname], [Lastname], [Login], [Password], [Creation_date], [Role_ID], [User_Status_ID], [Birth]) VALUES (1002, N'Максим', N'Максимов', N'Максимович', N'Maks', N'r/9if043/IPP1Tx/xRDYWN5R4M0BvRnHOTO8OKE29RA=', CAST(N'2025-04-01T15:36:24.437' AS DateTime), 1, 1, CAST(N'2000-07-13' AS Date))
INSERT [dbo].[User] ([ID], [Name], [Surname], [Lastname], [Login], [Password], [Creation_date], [Role_ID], [User_Status_ID], [Birth]) VALUES (1003, N'Антон', N'Антонов', N'Антонович', N'Anton_', N'0maq0pYFlnnJGCnfYAobKLzVNTc1THffFAEcojsX08Y=', CAST(N'2025-04-03T13:18:11.763' AS DateTime), 1, 1, CAST(N'1990-06-16' AS Date))
SET IDENTITY_INSERT [dbo].[User] OFF
GO
SET IDENTITY_INSERT [dbo].[User_Role] ON 

INSERT [dbo].[User_Role] ([ID], [Name]) VALUES (1, N'Пользователь')
INSERT [dbo].[User_Role] ([ID], [Name]) VALUES (2, N'Сотрудник')
INSERT [dbo].[User_Role] ([ID], [Name]) VALUES (3, N'Администратор')
INSERT [dbo].[User_Role] ([ID], [Name]) VALUES (4, N'Репортер')
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
ALTER TABLE [dbo].[Document]  WITH CHECK ADD  CONSTRAINT [FK_Document_Provider] FOREIGN KEY([Provider_ID])
REFERENCES [dbo].[Provider] ([ID])
GO
ALTER TABLE [dbo].[Document] CHECK CONSTRAINT [FK_Document_Provider]
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
ALTER TABLE [dbo].[Login_History]  WITH CHECK ADD  CONSTRAINT [FK_Login_History_Login_Status] FOREIGN KEY([Login_Status_ID])
REFERENCES [dbo].[Login_Status] ([ID])
GO
ALTER TABLE [dbo].[Login_History] CHECK CONSTRAINT [FK_Login_History_Login_Status]
GO
ALTER TABLE [dbo].[Login_History]  WITH CHECK ADD  CONSTRAINT [FK_Login_History_User] FOREIGN KEY([User_ID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[Login_History] CHECK CONSTRAINT [FK_Login_History_User]
GO
ALTER TABLE [dbo].[News_Change_History]  WITH CHECK ADD  CONSTRAINT [FK_News_Change_History_Organisation_News] FOREIGN KEY([News_ID])
REFERENCES [dbo].[Organisation_News] ([ID])
GO
ALTER TABLE [dbo].[News_Change_History] CHECK CONSTRAINT [FK_News_Change_History_Organisation_News]
GO
ALTER TABLE [dbo].[News_Change_History]  WITH CHECK ADD  CONSTRAINT [FK_News_Change_History_User] FOREIGN KEY([User_ID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[News_Change_History] CHECK CONSTRAINT [FK_News_Change_History_User]
GO
ALTER TABLE [dbo].[Organisation_News]  WITH CHECK ADD  CONSTRAINT [FK_Organisation_News_User] FOREIGN KEY([User_ID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[Organisation_News] CHECK CONSTRAINT [FK_Organisation_News_User]
GO
ALTER TABLE [dbo].[Provider]  WITH CHECK ADD  CONSTRAINT [FK_Provider_Organisation_Type] FOREIGN KEY([Organisation_Type_ID])
REFERENCES [dbo].[Organisation_Type] ([ID])
GO
ALTER TABLE [dbo].[Provider] CHECK CONSTRAINT [FK_Provider_Organisation_Type]
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
ALTER TABLE [dbo].[Request_Decline]  WITH CHECK ADD  CONSTRAINT [FK_Request_Decline_User] FOREIGN KEY([User_ID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[Request_Decline] CHECK CONSTRAINT [FK_Request_Decline_User]
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
