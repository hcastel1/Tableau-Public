/* Get Trade Flows for Canadian top trading partners that correspond to US-CAN Trade Flows */

**************************************************************************************
Create data extracts for interactive Metro Profiles for CGI summit, Mexico City 2013 *
by Henry Castellanos                                                                 * 
Sept 17, 2013                                                                        *
*                                                                                    *
**************************************************************************************
**************************************************************************************
  Metro Profile Layout

(All these indicators represent trade between a U.S. metro and Canadian/Mexican/North American metros)

Trade With Canadian Metros
?	Total Trade Value: $X million
?	Total Trade Value Rank: 1-100
?	Total Trade Weight: X tons 
?	Total Trade Weight Rank: 1-100
?	Total Trade Value Per ton: $X/ton 
?	Total Trade Value Per Ton Rank: 1-100
?	Total Exports Value: $X million
?	Total Exports Weight: X tons 
?	Total Exports Value Per ton: $X/ton 
?	Total Imports Value: $X million
?	Total Imports Weight: X tons 
?	Total Imports Value Per ton: $X/ton 


Trade With Mexican Metros
?	Total Trade Value: $X million
?	Total Trade Value Rank: 1-100
?	Total Trade Weight: X tons 
?	Total Trade Weight Rank: 1-100
?	Total Trade Value Per ton: $X/ton 
?	Total Trade Value Per Ton Rank: 1-100
?	Total Exports Value: $X million
?	Total Exports Weight: X tons 
?	Total Exports Value Per ton: $X/ton 
?	Total Imports Value: $X million
?	Total Imports Weight: X tons 
?	Total Imports Value Per ton: $X/ton 


Trade With North American Metros (Mex and Canada combined)
?	Total Trade Value: $X million
?	Total Trade Value Rank: 1-100
?	Total Trade Weight: X tons 
?	Total Trade Weight Rank: 1-100
?	Total Trade Value Per ton: $X/ton 
?	Total Trade Value Per Ton Rank: 1-100
?	Total Exports Value: $X million
?	Total Exports Weight: X tons 
?	Total Exports Value Per ton: $X/ton 
?	Total Imports Value: $X million
?	Total Imports Weight: X tons 
?	Total Imports Value Per ton: $X/ton 

Top Traded Commodity Groups
Commodity 1a. Total Trade Value: $ million
Commodity 1b. Total Trade Weight: $X tons
Commodity 1c. Total Trade Value per ton: $X/ton
Commodity 1d. Total Exports Value: $million
Commodity 1e. Total Imports Value: $million

Commodity 2a. Value: $ million
Commodity 2b. Weight: $X tons
Commodity 2c. Value per ton: $X/ton
Commodity 2d. Total Exports Value: $million
Commodity 2e. Total Imports Value: $million

Commodity 3a. Value: $ million
Commodity 3b. Weight: $X tons
Commodity 3c. Value per ton: $X/ton
Commodity 3d. Total Exports Value: $million
Commodity 3e. Total Imports Value: $million

Commodity 4a. Value: $ million
Commodity 4b. Weight: $X tons
Commodity 4c. Value per ton: $X/ton
Commodity 4d. Total Exports Value: $million
Commodity 4e. Total Imports Value: $million

Commodity 5a. Value: $ million
Commodity 5b. Weight: $X tons
Commodity 5c. Value per ton: $X/ton
Commodity 5d. Total Exports Value: $million
Commodity 5e. Total Imports Value: $million


Top Traded Metropolitan Trade Partners in North America
Metro 1a. Total Trade Value: $x million
Metro 1b. Total Exports Value: $x million
Metro 1c. Total Imports Value: $x million
Metro 1d. Total Trade Value per ton: $x/ton
Metro 2a. Total Trade Value: $x million
Metro 2b. Total Exports Value: $x million
Metro 2c. Total Imports Value: $x million
Metro 2d. Total Trade Value per ton: $x/ton
Metro 3a. Total Trade Value: $x million
Metro 3b. Total Exports Value: $x million
Metro 3c. Total Imports Value: $x million
Metro 3d. Total Trade Value per ton: $x/ton
Metro 4a. Total Trade Value: $x million
Metro 4b. Total Exports Value: $x million
Metro 4c. Total Imports Value: $x million
Metro 4d. Total Trade Value per ton: $x/ton
Metro 5a. Total Trade Value: $x million
Metro 5b. Total Exports Value: $x million
Metro 5c. Total Imports Value: $x million
Metro 5d. Total Trade Value per ton: $x/ton
Metro 6a. Total Trade Value: $x million
Metro 6b. Total Exports Value: $x million
Metro 6c. Total Imports Value: $x million
Metro 6d. Total Trade Value per ton: $x/ton
Metro 7a. Total Trade Value: $x million
Metro 7b. Total Exports Value: $x million
Metro 7c. Total Imports Value: $x million
Metro 7d. Total Trade Value per ton: $x/ton
Metro 8a. Total Trade Value: $x million
Metro 8b. Total Exports Value: $x million
Metro 8c. Total Imports Value: $x million
Metro 8d. Total Trade Value per ton: $x/ton
Metro 9a. Total Trade Value: $x million
Metro 9b. Total Exports Value: $x million
Metro 9c. Total Imports Value: $x million
Metro 9d. Total Trade Value per ton: $x/ton
Metro 10a. Total Trade Value: $x million
Metro 10b. Total Exports Value: $x million
Metro 10c. Total Imports Value: $x million
Metro 10d. Total Trade Value per ton: $x/ton

Advanced Industry Share of Total Trade
Total Advanced Industry Trade: $million
Total Trade: $million
Share of Advanced Industry Trade: x%;

********************************************************************************************************************
*******************************************************************************************************************;

libname MNA "C:\Users\Voltron\Documents\Git_Staging\Trade Data\Base_Data_Stacked\US_Can\";
libname Can 'C:\Users\Voltron\Documents\Git_Staging\Trade Data\Output\Can_US\'; 

/* create commodity name crosswalk*/

	proc format;
	value $SCTGN
	'01_09' = "Agricultural Products"
	'10_14' = "Stones and Ores"
	'15_19' = "Energy Products"
	'20_24' = "Chemicals and Plastics"
	'25_29' = "Wood Products"
	'30,39' = "Textiles and Furniture"
	'31_32' = "Metals"
	'33_34,40' = "Machinery and Tools"
	'35' = "Electronics"
	'36' = "Motor Vehicles and Parts"
	'371_373' = "Other Transportation Equipment including Aircraft"
	'38' = "Precision Instruments";
/*	'39' = "Furniture"*/
	run;

proc format;
value $SCTG
	'01-09' = "Includes various animal products, baked goods, and agricultural crops, ranging from fruits
               and vegetables to nuts and cereal grains. Also includes processed foods, tobacco products, and alcoholic
               beverages" 
	'10-14' = "Includes stone related goods like gravel, a variety of non-metallic minerals like salt, and metal ones
               like iron"
	'15-19' = "Includes coal and its related byproducts, oil products like crude petroleum and gasoline, and other 
               liquified fuels and oils"
	'20-24' = "Includes plastics, fertilizers, rubber, and a host of other organic and inorganic chemicals. Also includes
            pharmaceuticals and chemical mixtures for medical use"
	'25-29' = "Includes Logs, lumber, and other wood products, such as particle board. Also includes numerous
               paper products in the form of pulp, sheets, or printed materials"
	'30' = "Includes fabrics, yarns and similar textiles used for clothing, carpets, and household furnishings.
            Also includes leather used for footwear, luggage, and other apparel"
	'31-32' = "Includes base metals, such as steel, copper, and aluminum, in the form of bars, rods, and wire.
               Also includes ceramics, glass, and other cement mixtures."
	'33-34,40' = "Includes machines, parts, and gears used in a variety of mechanical equipment, such as engines, fans,
                  and refrigerators; metal articles, tools, miscellaneous manufactured products
                  like toys, clocks, and musical instruments"
	'35' = "Includes a range of electrical components and equipment, from circuits and semiconductors to televisions
            and computers. Also includes communications equipment and transmission aparatus"
	'36-37' = "Includes parts and vehicles for automobiles, railroads, aircraft, ships, and other transportation
               equipment"
	'371' = "Railway Equipment"
	'372' = "Aircraft and Spacecraft"
	'373' = "Ships, Boats, and Floating Structures"
	'38' = "Includes medical, scientific, and optical instruments, among other advanced surgical and navigational tools"
	'39' = "Includes household and office furniture, mattresses, medical furniture, and lighting fixtures"
	run;


/* Read in, process data to get Metro to Metro totals*/

**************************************************************************
*                            Canada                                      *
*************************************************************************;

*Read in U.S. exports to Canada;
data US_can_ex;
set MNA.US_Can_Exports;
value_ton_exp = (Exports_USD*1000000)/(Exports_Tons*1000);
UniqueID = CBSA||CanGeo||SCTG;
if CBSA < 90000 then USMetro_D = 1; else USMetro_D = 0;
if GeoType = 'CMA' then CanMetro_D = 1; else CanMetro_D = 0;
if USMetro_D = 1 and CanMetro_D = 1 then MetrotoMetro = 1; else MetrotoMetro = 0;
if MetrotoMetro = 1 and USTop100 = 1 then Top100MetrotoMetro = 1; else Top100MetrotoMetro = 0;
run;

*Read in U.S. imports from Canada;
data US_can_imp;
set MNA.US_Can_Imports;
value_ton_imp = (Imports_USD*1000000)/(Imports_Tons*1000);
UniqueID = CBSA||CanGeo||SCTG;
if CBSA < 90000 then USMetro_D = 1; else USMetro_D = 0;
if GeoType = 'CMA' then CanMetro_D = 1; else CanMetro_D = 0;
if USMetro_D = 1 and CanMetro_D = 1 then MetrotoMetro = 1; else MetrotoMetro = 0;
if MetrotoMetro = 1 and USTop100 = 1 then Top100MetrotoMetro = 1; else Top100MetrotoMetro = 0;
run;

proc sort data = US_can_ex;
by UniqueID;
run;

proc sort data = US_can_imp;
by UniqueID;
run;

*Merge imports and exports for Canada;

data US_can_trade;
merge US_can_imp US_can_ex;
by UniqueID;
if Imports_USD in (0,.) and Exports_USD in (0,.)then delete;
if CBSA < 90000 then USMetro_D = 1; else USMetro_D = 0;
if GeoType = 'CMA' then CanMetro_D = 1; else CanMetro_D = 0;
if USMetro_D = 1 and CanMetro_D = 1 then MetrotoMetro = 1; else MetrotoMetro = 0;
if MetrotoMetro = 1 and USTop100 = 1 then Top100MetrotoMetro = 1; else Top100MetrotoMetro = 0;
run;

*Create total trade variables;

data US_can_trade2;
set US_can_trade;
if Imports_USD = . then Imports_USD = 0;
if Imports_CAD = . then Imports_CAD = 0;
if Imports_Tons = . then Imports_Tons = 0;
if Exports_USD = . then Exports_USD = 0;
if Exports_CAD = . then Exports_CAD = 0;
if Exports_Tons = . then Exports_Tons = 0;
Trade_USD = Imports_USD + Exports_USD;
Trade_CAD = Imports_CAD + Exports_CAD;
Trade_Tons = Imports_Tons + Exports_Tons;
value_ton_trade = (Trade_USD*1000000)/(Trade_Tons*1000);
Cangeo_name2=compress(Cangeo_name,"'");
run;

/* Create Agglomerated Flag and Crosswalk for Commodity Indicator for US and Canada, Mexico*/
data us_can_trade3(drop=SCTG rename=(SCTG2=SCTG));
set  us_can_trade2;
length SCTG2 $20.;
if SCTG in ('01','02','03','04','05','06','07','08','09') or SCTG in ('02_03','04_07','08_09')
then SCTG2 = ('01_09');
if SCTG in ('10','11','12','13','14') or SCTG in ('11-12') or SCTG in ('10_13')
then SCTG2 = ('10_14');
if SCTG in ('15','16','17','18','19') or SCTG in ('16_19')
then SCTG2= ('15_19');
if SCTG in ('20','21','22','23','24')
then SCTG2 = ('20_24');
if SCTG in ('25','26','27','28','29') or SCTG in ('27_28')
then SCTG2 = ('25_29');
if SCTG in ('31','32')
then SCTG2 = ('31_32');
if SCTG in ('33','34','40')
then SCTG2= ('33_34,40');
/*if SCTG in ('36','37')*/
/*then SCTG2 = ('36-37');*/
if SCTG in ('371','372','373') then 
SCTG2 = ('371_373');
if SCTG in ('30','39')
then SCTG2 = ('30,39');
if SCTG2 in (' ') then
SCTG2 = SCTG;
run;


*Create a metro-to-metro total trade dataset across all Metros;

/* get Trade Totals using Proc Means ~ should be the same as sum for totals, with total exports, imports corrected*/
proc means data = us_can_trade3 nway missing noprint;
class cangeo cangeo_name CBSA_name CanMetro_D top100MetrotoMetro SCTG; 
/* leave flags for top Can Metro identify*/
var Imports_USD imports_CAD imports_Tons exports_USD exports_CAD exports_Tons trade_USD trade_CAD trade_Tons;
output out = us_can_trade_total2_1 (drop=_type_ _freq_) 
sum()= imports_usd_total 
       imports_cad_total 
       imports_tons_total 
       exports_usd_total 
       exports_Cad_Total 
       exports_tons_total
       trade_usd_total 
       trade_cad_total 
       trade_tons_total;
run;


/* get Trade Totals by Metro ~ should be total dollars across all US, not just top 100 M:M relationships*/
proc means data = us_can_trade3 nway missing noprint;
class Cangeo Cangeo_name;
var Imports_USD imports_CAD imports_Tons exports_USD exports_CAD exports_Tons trade_USD trade_CAD trade_Tons;
output out = us_can_trade_total (drop=_type_ _freq_) 
sum()= imports_usd_total 
       imports_cad_total 
       imports_tons_total 
       exports_usd_total 
       exports_Cad_Total 
       exports_tons_total
       trade_usd_total 
       trade_cad_total 
       trade_tons_total;
run; 


/* Restrict data to Top 100 US-Canada Metro trade relationships*/
data top33Metro_UsCan;
set us_can_trade_total2_1;
where canmetro_d = 1 and top100MetrotoMetro=1;
/* error ~ was dividing by trade_usd_total * 1000 which simply returns multiple of trade_usd_total and not VPT ; Fixed 10/30/15*/
/*2nd error - can't calculate VPT here and can't calculate with USD*/
run;

data can_us_flows;
set  top33metro_uscan; /*This table comes from running the Metro Profiles SAS program*/
run;

proc means data = can_us_flows nway missing noprint;
class cangeo_name cbsa_name;
var imports_usd_total exports_usd_total trade_usd_total /*value_per_ton*/ trade_tons_total;
output out = sum_us_can_flows (drop=_type_) sum()=;
run;

data can_us_flows2(drop=trade_tons_total);
set sum_us_can_flows;
where cangeo_name in ("Calgary","Toronto","Kitchener-Cambridge-Waterloo","Edmonton","London","Windsor","Montr?al","Saint John",
                       "Greater Sudbury","Halifax","Hamilton","Oshawa","Ottawa-Gatineau","Qu?bec","St. Catharines-Niagara",
						"St. John's","Vancouver","Winnipeg");
Value_per_ton = (trade_usd_total*1000000)/(trade_tons_total*1000);
run;

/*Export and melt data set in R*/
PROC EXPORT DATA= can_us_flows2
OUTFILE= "C:\Users\Voltron\Documents\Git_Staging\Trade Data\CAN_US_Trade_Flows.xlsx" 
DBMS= xlsx REPLACE;
RUN;

/**********************************************************************************************************/
/* Run the section below after running Reshape_vAlienware_Can_US.R                                             
/*
/**********************************************************************************************************/

/*pull in melted can_us_flow data and trade data set for Canadian path order*/

/*PROC IMPORT OUT= Trade */
/*            DATAFILE= "C:\Users\Voltron\Documents\Git_Staging\Trade Data\Trade_Canada" */
/*            DBMS=XLSX REPLACE;*/
/*RUN;*/

/*PROC IMPORT OUT= Trade*/
/*            DATAFILE= "C:\Users\Voltron\Documents\Git_Staging\Trade Data\Trade_Canada.csv"  */
/*            DBMS=dlm REPLACE;*/
/*   delimiter=','; */
/*     GETNAMES=YES;*/
/*     DATAROW=2; */
/*RUN;*/

     data WORK.TRADE    ;
     %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
     infile 'C:\Users\Voltron\Documents\Git_Staging\Trade Data\Trade_Canada2.csv' 
delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 ;
        informat VAR1 $4. ;
        informat CBSA best32. ;
        informat CBSA_name $40. ;
        informat metric $19. ;
        informat Quant 12.2 ;
        informat tp_rank $5. ;
        informat Metro_Area $20. ;
        informat lon best32. ;
        informat lat best32. ;
        informat address $20. ;
        informat Country $8. ;
        informat ID best32. ;
        informat cangeo_name $15. ;
        format VAR1 $4. ;
        format CBSA best12. ;
        format CBSA_name $40. ;
        format metric $19. ;
        format Quant 12.2 ;
        format tp_rank $5. ;
        format Metro_Area $20. ;
        format lon best12. ;
        format lat best12. ;
        format address $20. ;
        format Country $8. ;
        format ID best12. ;
        format cangeo_name $15. ;
     input
                 VAR1 $
                 CBSA
                 CBSA_name $
                 metric $
                 Quant 
                 tp_rank $
                 Metro_Area $
                 lon
                 lat
                 address $
                 Country $
                 ID
                 cangeo_name $
     ;
     if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
     run;


PROC IMPORT OUT= Can_US_Tf2 /*table name for imported data*/
            DATAFILE= "C:\Users\Voltron\Documents\Git_Staging\Trade Data\Melted_Trade_Can2" 
            DBMS=XLSX REPLACE;
RUN;

Proc SQL;
Update Trade as u
    set Quant = (select Quant from Can_US_Tf2 as n
                   where u.CBSA_name = n.CBSA_name and u.metric=n.metric and u.cangeo_name = n.cangeo_name);
Quit;

/*PROC EXPORT DATA= Trade*/
/*OUTFILE= "C:\Users\Voltron\Documents\Git_Staging\Trade Data\Trade_Canada_updated.xlsx" */
/*DBMS= xlsx REPLACE;*/
/*RUN;*/

proc export data= Trade
outfile= "C:\Users\Voltron\Documents\Git_Staging\Trade Data\Trade_Canada_updated2.csv"
dbms=csv replace;
run;
