cap clear matrix
clear
cap log close
set more off

cd "/Users/stanley/Dropbox (Dartmouth College)/22W/dali data challenge"
log using ddc.log, replace


// converting a hand-made additional na_id_world xlsx to .dta for merge
// corrects for some countries which go by different names than the idfile
import excel using "DALI na_id_world mod.xlsx", firstrow
save my-na_id_world-mod, replace
clear

// creating a WIID .dta file
import delimited using "wiid.csv"
save wiid, replace
clear



// adding na_id_world to our data, a variable that we need for spmap
import delimited using collapsed.csv
rename country ADMIN

merge 1:m ADMIN using "idfile.dta", nogenerate keepusing(na_id_world)

rename ADMIN SOVEREIGNT
merge 1:m SOVEREIGNT using "my-na_id_world-mod.dta", nogenerate keepusing(na_id_world) update replace

rename SOVEREIGNT country

drop if gini_reported==. & mean==. & median==. & exchangerate==. & mean_usd==. & median_usd==. & population==. & gdp_ppp_pc_usd2011 ==.

save collapsed, replace





use collapsed.dta, clear

// making sure all na_id_world possibilities are present
forval i=1/240 {
	count if na_id_world == `i'
	if r(N) == 0 {
		set obs `=_N + 1'
		replace na_id_world = `i' in L
	}
}



// map of latest GINI report
// creating map using gini_latest to color, na_id_world to place on map
// fcolor sets color scheme, for all possible schemes see:
// http://fmwww.bc.edu/repec/bocode/s/spmap.html#:~:text=the%20master%20dataset.-,Color%20lists,-Some%20spmap%20options
spmap gini_reported using "coord_mercator_world.dta", ///
id(na_id_world) fcolor(Heat) ndfcolor(gray) ndlabel("No Data") ///
clmethod(custom) clbreaks(0 20 25 30 35 40 45 50 55 60 65 70) ///
title("Reported GINI Coefficient (%)")
graph export "gini.png", replace



// map of gdp ppp pc 2011
spmap gdp_ppp_pc_usd2011 using "coord_mercator_world.dta", ///
id(na_id_world) fcolor(Blues2) ndfcolor(gray) ndlabel("No Data") ///
clmethod(e) clnumber(5) ///
title("GDP PPP PC (2011 USD)")
graph export "gdppppc.png", replace



// combined maps of mean and median incomes
replace mean_usd = mean / exchangerate if currency != "US$2011PPP"
spmap mean_usd using "coord_mercator_world.dta", ///
id(na_id_world) fcolor(Greens2) ndfcolor(gray) ndlabel("No Data") ///
clmethod(c) clbreaks(0, 10000, 20000, 25000, 30000, 35000, 40000, 100000) ///
title("Mean Income (USD)")
graph save mean.gph, replace

replace median_usd = median / exchangerate if currency != "US$2011PPP"
spmap median_usd using "coord_mercator_world.dta", ///
id(na_id_world) fcolor(Greens2) ndfcolor(gray) ndlabel("No Data") ///
clmethod(c) clbreaks(0, 10000, 20000, 25000, 30000, 35000, 40000, 100000) ///
title("Median Income (USD)")
graph save median.gph, replace 

graph combine mean.gph median.gph, title("Mean and Median Incomes (USD)")
gr export mean_median.png, replace as(png)



// running a regression to see if OECD impacts GDP PPP PC 2011 USD
use wiid.dta, clear

gen oecd_dum = 0 if oecd == "Non-OECD"
replace oecd_dum = 1 if oecd == "OECD"

reg gdp_ppp oecd_dum
twoway (scatter gdp_ppp_pc_usd2011 oecd_dum) (lfit gdp_ppp_pc_usd2011 oecd_dum), ///
title("GDP PPP PC on OCED Status")
gr export oced.png, replace as(png)



cap log close
