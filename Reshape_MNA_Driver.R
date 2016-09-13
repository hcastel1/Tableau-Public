#Re-shape US_CAN Trade data in order to build a dynamics visualization in Tableau; 

setwd("C:/Users/Voltron/Documents/Git_Staging/Trade Data")
require(XLConnect)
wb <- loadWorkbook("Master_USCAN.xlsx") 
lst = readWorksheet(wb, sheet = getSheets(wb))

tr.tot <- lst[,1:15] #remove total trade variables

#install.packages("dplyr")
library(dplyr)
library(reshape2)

zero.tp<-lst[,c(1,16:21)]
first.tp<-select(lst, matches("1_TP"))
second.tp<-select(lst, matches("2_TP"))
third.tp<-select(lst, matches("3_TP"))
fourth.tp<-select(lst, matches("4_TP"))
fifth.tp<-select(lst, matches("5_TP"))
sixth.tp<-select(lst, matches("6_TP"))
seventh.tp<-select(lst, matches("7_TP"))
eigth.tp<-select(lst, matches("8_TP"))
ninth.tp<-select(lst, matches("9_TP"))

#add CBSA ID column to other trade partner rank data frames
CBSA_name<- zero.tp[,2]
CBSA <- lst[,1]
tp1<-cbind(CBSA,CBSA_name,first.tp)
names(tp1) <- c("CBSA","CBSA_name","Cangeo_name","Imports_USD_Total","Exports_USD_Total","Trade_USD_Total","Value_Per_Ton")
tp2<-cbind(CBSA,CBSA_name,second.tp)
names(tp2) <- c("CBSA","CBSA_name","Cangeo_name","Imports_USD_Total","Exports_USD_Total","Trade_USD_Total","Value_Per_Ton")
tp3<-cbind(CBSA,CBSA_name,third.tp)
names(tp3) <- c("CBSA","CBSA_name","Cangeo_name","Imports_USD_Total","Exports_USD_Total","Trade_USD_Total","Value_Per_Ton")
tp4<-cbind(CBSA,CBSA_name,fourth.tp)
names(tp4) <- c("CBSA","CBSA_name","Cangeo_name","Imports_USD_Total","Exports_USD_Total","Trade_USD_Total","Value_Per_Ton")
tp5<-cbind(CBSA,CBSA_name,fifth.tp)
names(tp5) <- c("CBSA","CBSA_name","Cangeo_name","Imports_USD_Total","Exports_USD_Total","Trade_USD_Total","Value_Per_Ton")
tp6<-cbind(CBSA,CBSA_name,sixth.tp)
names(tp6) <- c("CBSA","CBSA_name","Cangeo_name","Imports_USD_Total","Exports_USD_Total","Trade_USD_Total","Value_Per_Ton")
tp7<-cbind(CBSA,CBSA_name,seventh.tp)
names(tp7) <- c("CBSA","CBSA_name","Cangeo_name","Imports_USD_Total","Exports_USD_Total","Trade_USD_Total","Value_Per_Ton")
tp8<-cbind(CBSA,CBSA_name,eigth.tp)
names(tp8) <- c("CBSA","CBSA_name","Cangeo_name","Imports_USD_Total","Exports_USD_Total","Trade_USD_Total","Value_Per_Ton")
tp9<-cbind(CBSA,CBSA_name,ninth.tp)
names(tp9) <- c("CBSA","CBSA_name","Cangeo_name","Imports_USD_Total","Exports_USD_Total","Trade_USD_Total","Value_Per_Ton")

#extra steps because of akward naming conventions per SAS macro script in original data for TOP TP
zero.tp$CBSA_name <- zero.tp[,2]
zero.tp<- zero.tp[,c(-2)]
zero.tp <-zero.tp[,c(1,7,2,3,4,5,6)]

#drop canadian metro area and melt separately -- will need to have separate dimension for filter in Tableau - do 1st TP
zero.tp.i<-zero.tp[,-3]

zero.tp.ii <- zero.tp[,1:3]
zero.tp.1<-melt(zero.tp.i,id=c("CBSA","CBSA_name"),variable.name="metric",value.name="Quant")
zero.tp.12<- melt(zero.tp.ii,id=c("CBSA","CBSA_name"),variable.name="tp_rank",value.name="Metro_Area")
#replicate rows with CA metro name and rank
zero.tp.13<-rbind(zero.tp.12,zero.tp.12,zero.tp.12,zero.tp.12)
#Merge for final df
zero.tp.fin<-cbind(zero.tp.1,zero.tp.13)
#reset values for tp_rank -- do this later
zero.tp.fin$tp_rank<-c("1st")
#drop extra id columns after match check
zero.tp.fin<- zero.tp.fin[,-c(5,6)]
levels(zero.tp.fin$metric) <- list(Imports_USD_Total="imports_usd_total_TP",Exports_USD_Total= "exports_usd_total_TP", 
                                    Trade_USD_Total="trade_usd_total_TP",Value_Per_Ton="value_per_ton_TP")

#zero.tp.fin$Metro_Area <- as.factor(zero.tp.fin$Metro_Area)
#class(zero.tp.fin$Metro_Area)
#levels(zero.tp.fin$Metro_Area) <- list("Toronto,Canada"="Toronto", "Calgary,Canada" = "Calgary", "Montréal,Canada" = "Montréal",
#                                       "Edmonton,Canada" = "Edmonton", "Saint John,Canada" = "Saint John", 
#                                       "Windsor,Canada"="Windsor", "Kitchener,Canada" = "KitchenerCambridgeWaterloo",
#                                       "London,Canada" = "London")

tp.fin.shell<- zero.tp.fin #top trading partner data frame acts as shell

dflist <- list(tp1,tp2,tp3,tp4,tp5,tp6,tp7,tp8,tp9) #create list object for loop below

  for (i in dflist){
  #drop canadian metro area and melt separately -- will need to have separate dimension for filter in Tableau - do top 10 TP
  tp.i<-i[,-3]
  tp.ii <- i[,1:3]
  tp.1<-melt(tp.i,id=c("CBSA","CBSA_name"),variable.name="metric",value.name="Quant")
  tp.12<- melt(tp.ii,id=c("CBSA","CBSA_name"),variable.name="tp_rank",value.name="Metro_Area")
  #replicate rows with CA metro name and rank
  tp.13<-rbind(tp.12,tp.12,tp.12,tp.12)
  #Merge for final df
  tp.fin<-cbind(tp.1,tp.13)
  #drop extra id columns after match check
  tp.fin<- tp.fin[,-c(5,6)]
  #class(tp.fin$metric)
  #levels(tp.fin$metric) <- list(Imports_USD_Total="imports_usd_total_1_TP",Exports_USD_Total= "exports_usd_total_1_TP", 
                                #Trade_USD_Total="trade_usd_total_1_TP",Value_Per_Ton="value_per_ton_1_TP")
  tp.fin.shell<-rbind(tp.fin.shell,tp.fin)
}

rlist <- list(c("2nd"),c("3rd"),c("4th"),c("5th"),c("6th"),c("7th"),c("8th"),c("9th"),c("10th"))
rank <- rep_len(c("1st"), length.out=400)
for (i in rlist) {
  r1 <- rep_len(c(i), length.out=400)
  rank<- cbind(rank,r1)
}
rankid <- as.numeric(1:400)
rank <-cbind(rankid,rank)
rank.1 <- melt(rank,id="rankid")
rank.2 <- data.frame(rank.1[401:4400,3])
names(rank.2) <- c("tp_rank")

#re-name and drop extra generated data from nested for loop
Trade <- cbind(tp.fin.shell[1:4000,-5],rank.2)
Trade <- Trade[,c(1,2,3,4,6,5)]


#create StateID for geocoding US Metro Area
state <- character(length=100)

state<- c("OH","NY","NM","PA","GA","GA","TX","CA","MD","LA","AL","ID","MA","CT","NY","FL","SC","NC","TN","IL",
          "OH","OH","CO","SC","OH","TX","OH","CO","IA","MI","TX","CA","MI","NC","SC","PA","CT","HI","TX","IN",
          "MS","FL","MO","TN","FL","CA","NV","AR","CA","KY","WI","TX","TN","FL","WI","MN","CA","TN","CT","LA",
          "NY","UT","OK","NE","FL","CA","FL","PA","AZ","PA","OR","NY","RI","UT","NC","VA","CA","NY","CA","MO",
          "UT","TX","CA","CA","CA","FL","PA","WA","IL","CA","NY","PA","OH","AZ","OK","VA","DC","KS","MA","OH")

state<-rep_len(state, length.out=4000)

Trade$Metro_Area <- as.factor(Trade$Metro_Area)
class(Trade$Metro_Area)
#Change Canadian Metro Area string to work with geocoding engine
levels(Trade$Metro_Area) <- list("Toronto,Canada"="Toronto", "Calgary,Canada" = "Calgary", "Montreal,Canada" = "Montr?al",
                                       "Edmonton,Canada" = "Edmonton", "Saint John,Canada" = "Saint John", 
                                       "Windsor,Canada"="Windsor", "Kitchener,Canada" = "KitchenerCambridgeWaterloo",
                                       "London,Canada" = "London","Vancouver,Canada" = "Vancouver", "Winnipeg,Canada" ="Winnipeg",
                                 "Sudbury,Canada" = "Greater Sudbury", "St Johns,Canada" = "St Johns", "Oshawa,Canada" = "Oshawa",
                                 "Ottawa,Canada" = "OttawaGatineau", "Hamilton,Canada" = "Hamilton" ,"Quebec,Canada" = "Qu?bec",
                                 "Halifax,Canada" = "Halifax","St Catharines,Canada" = "St CatharinesNiagara")

#re-cast as character vector for geocoding Canadian metro areas
Trade$Metro_Area <- as.character(Trade$Metro_Area)
Trade2<-Trade[1:6] #create duplicate Trade data set before geocoding

#install.packages("ggmap")
library(ggmap)

Trade.geo <- Trade[1:2500,]
Trade.geo2 <- Trade[2501:4000,]

geocode(Trade.geo$Metro_Area, output = c("latlona"),
        source = c("dsk"), messaging = FALSE, sensor = FALSE,
        override_limit = FALSE, client = "", signature = "",
        nameType = c("short"), Trade.geo)

geocode(Trade.geo2$Metro_Area, output = c("latlona"),
        source = c("dsk"), messaging = FALSE, sensor = FALSE,
        override_limit = FALSE, client = "", signature = "",
        nameType = c("short"), Trade.geo2)

#re-stack geocoded data sets into one data frame
Trade <- rbind(Trade.geo,Trade.geo2)
Trade$Quant <- NA
Trade$Country <- "Canada"
ID <- as.numeric(1:4000)
Trade <- cbind(Trade,ID) #create row id to group by after stack

cangeo_name <- data.frame(do.call('cbind', strsplit(as.character(Trade$address),',',fixed=TRUE)))
cangeo_name <- cangeo_name[1,]
cangeo_name2<-t(cangeo_name)
cangeo_name2 <- as.data.frame(cangeo_name2[,1])
names(cangeo_name2) <- "cangeo_name"
Trade<-cbind(Trade,cangeo_name2)

#install.packages("xlsx")
#library(xlsx)
#write.xlsx(Trade, "C:/Users/Voltron/Documents/Git_Staging/Trade Data/Trade_Canada.xlsx")
write.csv(Trade,"C:/Users/Voltron/Documents/Git_Staging/Trade Data/Trade_Canada2.csv")

###############################################################################################################################
###############################################################################################################################
###############################################################################################################################
                           #The above output csv is input data starting at line 379 of CAN_Us_Trade_Flows.sas
###############################################################################################################################
###############################################################################################################################
###############################################################################################################################


#read back in Trade data with updated Quant values for Can-US Trade Flows
Trade_Canada_updated <- read.csv("~/Git_Staging/Trade Data/Trade_Canada_updated2.csv")
Trade <- Trade_Canada_updated[,2:12] #return to Trade data frame before export to SAS
#Trade$tp_rank <- NA #Can -> US Trade Flows are not ranked by trading partner the way US -> Can are

#geocode US metro areas - need to drop outlying areas that make up CBSA for main metro area

foo <- data.frame(do.call('cbind', strsplit(as.character(Trade2$CBSA_name),'-',fixed=TRUE)))
foo <- foo[1,]
foo2<-t(foo)
foo2 <- as.data.frame(foo2[,1])
names(foo2) <- "CBSA_name2"
Trade2<-cbind(Trade2,foo2)

class(Trade2$CBSA_name2)
Trade2$CBSA_name2 <- as.character(Trade2$CBSA_name2)
Trade2$Country <- "United States"
Trade2$CBSA_name2 <- paste(Trade2$CBSA_name2,state,Trade2$Country,sep=",")

Trade2.geo <- Trade2[1:2500,]
Trade2.geo2 <- Trade2[2501:4000,]


geocode(Trade2.geo$CBSA_name2, output = c("latlona"),
               source = c("dsk"), messaging = FALSE, sensor = FALSE,
               override_limit = FALSE, client = "", signature = "",
               nameType = c("short"), Trade2.geo)

geocode(Trade2.geo2$CBSA_name2, output = c("latlona"),
        source = c("dsk"), messaging = FALSE, sensor = FALSE,
        override_limit = FALSE, client = "", signature = "",
        nameType = c("short"), Trade2.geo2)

#re-stack geocoded data frames
Trade2<- rbind(Trade2.geo,Trade2.geo2)

Trade2<-Trade2[,-7] #drop parsed CBSA_name field created for geocoding and keep original
ID <- as.numeric(1:4000)
Trade2 <- cbind(Trade2,ID) #create row id to group by after stack
Trade3<- Trade2[,c(1,2,3,4,5,6,8,9,10,7,11)] #need to re-order columns for rbind

#stack to begin create trade-pairs
Trade.pairs <- rbind(Trade,Trade3)
Trade.pairs<-arrange(Trade.pairs, ID)

#Finally, create path ID and Path Order variables with group_by method from Dplyr

Trade.pairs$address <- as.character(Trade.pairs$address)
Fill <- Trade.pairs[1,]
Fill$Path_ID <- character(length=1)
Fill$Path_ID_Tableau <- character(length=1)
#Fill$Path_Order <-numeric(length=1)

Trade.pairsx <-Trade.pairs
#Trade.pairsx$Path_order <- rep_len(as.numeric(1:2), length.out=1200)

for (i in 1:4000){
  Trade.pairsx <- Trade.pairs #re-initialize every loop
  Trade.pairsx1<-group_by(Trade.pairsx,ID,add=FALSE) 
  Trade.pairsx1<-filter(Trade.pairsx1,ID==i) 
  Trade.pairsx1$Path_ID<- paste(nth(Trade.pairsx1$address,2),nth(Trade.pairsx1$address,1),sep="-")
  Trade.pairsx1$Path_ID_Tableau<- paste(nth(Trade.pairsx1$address,1),nth(Trade.pairsx1$address,2),sep="-")
  Trade.pairsx1[2,13] <- paste(nth(Trade.pairsx1$address,2),nth(Trade.pairsx1$address,1),sep="-")
  Fill <- rbind(Fill,Trade.pairsx1)
}

#Trade.pairsx<-group_by(Trade.pairsx,ID,add=FALSE) 
#Trade.pairsx<-filter(Trade.pairsx,ID==1)
#Trade.pairsx$Path_ID<- paste(nth(Trade.pairsx$address,1),nth(Trade.pairsx$address,2),sep="-")
#Trade.pairsx[2,12] <- paste(nth(Trade.pairsx$address,2),nth(Trade.pairsx$address,1),sep="-")
#Fill <- rbind(Fill,Trade.pairsx)


#Trade.pairsx$Path_ID<- paste(nth(Trade.pairsx2$address,2),nth(Trade.pairsx2$address,1),sep="-")
#Fill <- rbind(Fill,Trade.pairsx2)

Trade.pairsx2<-Fill[2:8001,]
Path_Order<- rep_len(as.numeric(1:2), length.out=4000)
Trade.pairs.fin <- cbind(Trade.pairsx2,Path_Order)

#install.packages("xlsx")
library(xlsx)
write.xlsx(Trade.pairs.fin, "C:/Users/Voltron/Documents/Git_Staging/Trade Data/Trade_Reshape_Tableau_v5.xlsx")



        
        
        
        
        
        