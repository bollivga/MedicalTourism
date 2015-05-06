USE [master]
GO

/****** Object:  Database [MedicalTourism]    Script Date: 5/6/2015 7:04:40 PM ******/
CREATE DATABASE [MedicalTourism]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MedicalTourism', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.TITAN\MSSQL\DATA\MedicalTourism.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
( NAME = N'MedicalTourism_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.TITAN\MSSQL\DATA\MedicalTourism_log.ldf' , SIZE = 1280KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

ALTER DATABASE [MedicalTourism] SET COMPATIBILITY_LEVEL = 110
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MedicalTourism].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [MedicalTourism] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [MedicalTourism] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [MedicalTourism] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [MedicalTourism] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [MedicalTourism] SET ARITHABORT OFF 
GO

ALTER DATABASE [MedicalTourism] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [MedicalTourism] SET AUTO_CREATE_STATISTICS ON 
GO

ALTER DATABASE [MedicalTourism] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [MedicalTourism] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [MedicalTourism] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [MedicalTourism] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [MedicalTourism] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [MedicalTourism] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [MedicalTourism] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [MedicalTourism] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [MedicalTourism] SET  DISABLE_BROKER 
GO

ALTER DATABASE [MedicalTourism] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [MedicalTourism] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [MedicalTourism] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [MedicalTourism] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [MedicalTourism] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [MedicalTourism] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [MedicalTourism] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [MedicalTourism] SET RECOVERY FULL 
GO

ALTER DATABASE [MedicalTourism] SET  MULTI_USER 
GO

ALTER DATABASE [MedicalTourism] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [MedicalTourism] SET DB_CHAINING OFF 
GO

ALTER DATABASE [MedicalTourism] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [MedicalTourism] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO

ALTER DATABASE [MedicalTourism] SET  READ_WRITE 
GO

