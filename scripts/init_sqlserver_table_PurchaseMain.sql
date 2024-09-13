CREATE DATABASE JKOPay;
GO

USE JKOPay;
GO

CREATE TABLE [dbo].[PurchaseMain](
	[ID] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[PurchaseNo] [nvarchar](50) NULL,
	[PurchaseType] [int] NOT NULL,
	[PayType] [int] NOT NULL,
	[BaseAmount] [decimal](18, 2) NULL,
	[TotalAmount] [decimal](18, 2) NOT NULL,
	[NoneDiscount] [decimal](18, 2) NULL,
	[PayAmount] [decimal](18, 2) NOT NULL,
	[PurchaseStatus] [int] NOT NULL,
	[PayCode] [nvarchar](21) NULL,
	[CoinRate] [int] NULL,
	[Redeem] [int] NULL,
	[BenefitRedeem] [int] NULL,
	[PayBack] [decimal](18, 2) NOT NULL,
	[StandingPayBack] [decimal](18, 2) NULL,
	[BenefitPayBack] [decimal](18, 2) NOT NULL,
	[CashBackAmount] [decimal](18, 2) NOT NULL,
	[UnRedeem] [decimal](18, 2) NOT NULL,
	[PayRate] [decimal](18, 2) NULL,
	[FeeRate] [decimal](18, 2) NULL,
	[MealRate] [decimal](18, 2) NULL,
	[EventRedeemRate] [decimal](18, 2) NULL,
	[JKOSCoinRate] [decimal](18, 2) NULL,
	[DeliveryRate] [decimal](18, 2) NULL,
	[CreateTime] [datetime] NOT NULL,
	[StoreID] [bigint] NULL,
	[ReimburseStatus] [int] NOT NULL,
	[AccountID] [bigint] NOT NULL,
	[JKOSID] [varchar](36) NULL,
	[TargetTitle] [nvarchar](100) NOT NULL,
	[MemberPhone] [nvarchar](15) NULL,
	[PurchaseID] [bigint] NULL,
	[RowVersion] [bigint] NOT NULL,
	[EventRedeem] [int] NULL,
	[EventID] [bigint] NULL,
	[TeamNo] [nvarchar](100) NULL,
	[PartnerType] [int] NOT NULL,
	[PartnerKey] [nvarchar](256) NULL,
	[DeliveryFee] [int] NOT NULL,
	[PaybackPrefer] [int] NULL,
	[PayAccount] [varchar](50) NULL,
	[ReceiptAccount] [varchar](50) NULL,
	[Currency] [int] NOT NULL,
	[TransactionSeq] [nvarchar](20) NOT NULL,
	[TransactionTime] [datetime] NULL,
	[ReimburseID] [bigint] NULL,
	[RedeemReimburseID] [bigint] NULL,
	[IsSpecificPayment] [bit] NOT NULL,
	[IsJKOSReimburse] [bit] NOT NULL,
	[ESunBankOrderNo] [nvarchar](64) NULL,
	[ESunReceiveTime] [nvarchar](19) NULL,
	[PaybackPercent] [int] NULL,
	[PayRateType] [int] NOT NULL,
	[PayingAmount] [decimal](18, 2) NULL,
	[DepositAmount] [decimal](18, 2) NULL,
	[UpdateTime] [datetime] NOT NULL,
	[UnPayBack] [decimal](18, 2) NOT NULL
);
GO

EXEC sys.sp_cdc_enable_db;

EXEC sys.sp_cdc_enable_table
@source_schema = N'dbo',
@source_name   = N'PurchaseMain',
@role_name     = NULL;
GO


BULK INSERT dbo.PurchaseMain
FROM '/var/opt/mssql-files/staging-data/PurchaseMain.csv'
WITH (
    DATAFILETYPE = 'widechar',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);
GO
