cap clear matrix
clear
cap log close
set more off

cd "/Users/stanley/Dropbox (Dartmouth College)/22W/dali data challenge/Part 2"
log using ddc.log, replace


// creating a WIID .dta file
import delimited using "wiid.csv"
save wiid, replace
clear

use wiid.dta, clear

gen highinc_dum = 1 if incomegroup == "High income"
replace highinc_dum = 0 if incomegroup != "High income"
gen lowermiddleinc_dum = 1 if incomegroup == "Lower middle income"
replace lowermiddleinc_dum = 0 if incomegroup != "Lower middle income"
gen uppermiddleinc_dum = 1 if incomegroup == "Upper middle income"
replace uppermiddleinc_dum = 0 if incomegroup != "Upper middle income"
gen eu_dum = 1 if eu == "EU"
replace eu_dum = 0 if eu != "EU"
gen oecd_dum = 0 if oecd == "Non-OECD"
replace oecd_dum = 1 if oecd == "OECD"

tab year, gen(yrdum)
areg gini_reported highinc_dum lowermiddleinc_dum uppermiddleinc_dum eu_dum oecd_dum exchangerate gdp_ppp population yrdum*, absorb(c3)
outreg2 using results, excel ctitle(Regression) replace

cap log close
