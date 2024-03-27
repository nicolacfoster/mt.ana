

cd "/Users/"
	local suffix: display %tdCCYY-NN-DD =daily("`c(current_date)'", "DMY")
	log using "log/log-`suffix'.smcl", replace

* Loads data
import excel using "/Users/XXX.xlsx", sheet("XXX") firstrow
	save "/Users/XXX.dta", replace
	clear


* Generates an author-year
gen b1 = "("
	gen b2 = ")"
	egen authoryear = concat(author2 b1 year b2)
	drop b1 b2
	tab authoryear if inter == .
	
		
gen num1 = round(num) if num != . & den != . & num != den
gen den1 = round(den) if num != . & den != . & den != num


* Defines the meta-analysis dataset
meta esize num1 den1


* Setting up the labels of the figures
lab var den1 "N"
lab var num1 "n"
lab var authoryear "Author (year)"
lab var inter "DAT type"
lab var bin "Engagement level"


* PLOT C1
metan num1 den1 if C1eng=="eng" & C4timepoint==., pro by(bin2b) random forestplot(xlab(0.2 0.4 0.6 0.8 1.0) textsize(90) xtitle(Engagement with a digital adherence technology by levels of engagement,size(2)) scheme(s1mono)) lcols(authoryear num1 den1) nooverall nobox citype(exact) sortby(year) boxscale(0) extraline(yes)


* PLOT C2
metan num1 den1 if inter==1 & C1eng=="eng" & C4timepoint==., proportion by(bin2) fixed forestplot(xlab(0.2 0.4 0.6 0.8 1.0) xtitle(Engagement with a SMS DAT by levels of engagement,size(3)) scheme(s1mono)) lcols(authoryear num1 den1) citype(exact) nooverall textsize(109) nobox 

metan num1 den1 if inter==2 & C1eng=="eng" & C4timepoint==., proportion by(bin2) fixed forestplot(xlab(0.2 0.4 0.6 0.8 1.0) xtitle(Engagement with a Pillbox DAT by levels of engagement,size(3)) scheme(s1mono)) lcols(authoryear num1 den1) citype(exact) nooverall textsize(109) nobox 

metan num1 den1 if inter==3 & C1eng=="eng" & C4timepoint==., proportion by(bin2) fixed forestplot(xlab(0.2 0.4 0.6 0.8 1.0) xtitle(Engagement with a 99DOTS DAT by levels of engagement,size(3)) scheme(s1mono)) lcols(authoryear num1 den1) citype(exact) nooverall textsize(109) nobox 

metan num1 den1 if inter==4 & C1eng=="eng" & C4timepoint==., proportion by(bin2) fixed forestplot(xlab(0.2 0.4 0.6 0.8 1.0) xtitle(Engagement with a VST DAT by levels of engagement,size(3)) scheme(s1mono)) lcols(authoryear num1 den1) citype(exact) nooverall textsize(109) nobox 

metan num1 den1 if inter==5 & C1eng=="eng" & C4timepoint==., proportion by(bin2) fixed forestplot(xlab(0.2 0.4 0.6 0.8 1.0) xtitle(Engagement with a Phone DAT by levels of engagement,size(3)) scheme(s1mono)) lcols(authoryear num1 den1) citype(exact) nooverall textsize(109) nobox 

metan num1 den1 if inter==6 & C1eng=="eng" & C4timepoint==., proportion by(bin2) fixed forestplot(xlab(0.2 0.4 0.6 0.8 1.0) xtitle(Engagement with a Ingestion Sensor DAT by levels of engagement,size(3)) scheme(s1mono)) lcols(authoryear num1 den1) citype(exact) nooverall textsize(109) nobox 

metan num1 den1 if inter==7 & C1eng=="eng" & C4timepoint==., proportion by(bin2) fixed forestplot(xlab(0.2 0.4 0.6 0.8 1.0) xtitle(Engagement with a Web DAT by levels of engagement,size(3)) scheme(s1mono)) lcols(authoryear num1 den1) citype(exact) textsize(109) nooverall nobox 



* PLOT C4
metan num1 den1 if C4timepoint !=., proportion by(C4time_cat) fixed forestplot(xlab(0.2 0.4 0.6 0.8 1.0) xtitle(Engagement with a Digital Adherence Technology (DAT) by timepoint,size(2)) scheme(s1mono)) lcols(authoryear num1 den1) citype(exact) aspect(.6) nooverall nobox textsize(109)

* DOI plot to assess assymmetry in effect size estimates (logit transformed)
gen _ES_logit = invlogit(_ES)
doiplot _ES_logit _seES, dp



save "/Users/XXX.dta", replace

*******************************************************************************

















