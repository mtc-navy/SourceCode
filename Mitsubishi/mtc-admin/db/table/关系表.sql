DROP SEQUENCE "MTC_OMMP_SEQ";
CREATE SEQUENCE "MTC_OMMP_SEQ" START WITH 1;

DROP TABLE "MTC_OMMP";
CREATE TABLE "MTC_OMMP" 
(
   "ID" INTEGER COMMENT 'ID',
   "CfgDocEntry" INTEGER COMMENT '配置表单号',
   "ORDREntry" INTEGER COMMENT 'SAP销售单号',
   "ODLNEntry" INTEGER COMMENT 'SAP交货单号',
   "OINVEntry" INTEGER COMMENT 'SAP应收发票单号',
   "LogID" INTEGER COMMENT '日志ID'
) COMMENT '关系映射表';


DROP SEQUENCE "MTC_OLOG_SEQ";
CREATE SEQUENCE "MTC_OLOG_SEQ" START WITH 1;
DROP TABLE "MTC_OLOG";
CREATE TABLE "MTC_OLOG"
(
   "ID" INTEGER COMMENT 'ID',
   "Message" NVARCHAR(1000) COMMENT 'Message',
   "CreateTime" NVARCHAR(20) COMMENT '创建时间',
   "Creator" NVARCHAR(20) COMMENT '创建人'
) COMMENT '日志表';