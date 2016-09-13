#Re-shape CAN-US Trade Flows in order to merge onto US-CAN Trade Flows Data Set for Tableau
#Output data is input to Can_Us_Trade_Flows.sas code at line 426 prior to PROC SQL update statement; 

setwd("C:/Users/Voltron/Documents/Git_Staging/Trade Data")
require(XLConnect)
wb <- loadWorkbook("CAN_US_Trade_Flows2.xlsx") #can't read SAS proc export directly with XLConnect package for some reason; re-save as xlsx
Can_US = readWorksheet(wb, sheet = getSheets(wb))

library(reshape2)
Can_US_TF <- Can_US[,c(1,2,4,5,6,7)] #drop frequency count from SAS proc means

#NEED TO SWTICH EXPORTS AND IMPORTS OTHERWISE TRADE FLOWS ARE EXACT SAME AS US --> CANADA; TOTAL TRADE AND VPT ARE DIRECTION AGNOSTIC FLOWS
#Re-name Imports as exports, etc. then re-shuffle for melt
names(Can_US_TF) <- c("Cangeo_name","CBSA_name","Exports_USD_Total","Imports_USD_Total","Trade_USD_Total","Value_Per_Ton")
Can_US_TF <- Can_US_TF [,c(1,2,4,3,5,6)] 

Can_US_Tf2<- melt(Can_US_TF,id=c("Cangeo_name","CBSA_name"),variable.name="metric",value.name="Quant")

######################################################################################
# Don't forget :replace Kitchener-Cambridge-Waterloo level in Excel **** ****Remove apsotrophe from Montreal*****
#####################################################################################

library(xlsx)
write.xlsx(Can_US_Tf2, "C:/Users/Voltron/Documents/Git_Staging/Trade Data/Melted_Trade_Can.xlsx")