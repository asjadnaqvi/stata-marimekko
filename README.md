
![marimekko-1](https://github.com/asjadnaqvi/stata-marimekko/assets/38498046/c71436e5-7f9b-4d04-946b-0afb01f279e2)

![StataMin](https://img.shields.io/badge/stata-2015-blue) ![issues](https://img.shields.io/github/issues/asjadnaqvi/stata-marimekko) ![license](https://img.shields.io/github/license/asjadnaqvi/stata-marimekko) ![Stars](https://img.shields.io/github/stars/asjadnaqvi/stata-marimekko) ![version](https://img.shields.io/github/v/release/asjadnaqvi/stata-marimekko) ![release](https://img.shields.io/github/release-date/asjadnaqvi/stata-marimekko)


# marimekko v1.1
(02 Dec 2023)

This package provides the ability to draw Marimekko graphs in Stata. 


## Installation

The package can be installed via SSC or GitHub (the beta is on GitHub only). The GitHub version, *might* be more recent due to bug fixes, feature updates etc, and *may* contain syntax improvements and changes in *default* values. See version numbers below. Eventually the GitHub version is published on SSC.


Install the package as follows:

SSC (**v1.0**):

```
ssc install marimekko, replace
```


or directly from GitHub (**v1.1**):

```
net install marimekko, from("https://raw.githubusercontent.com/asjadnaqvi/stata-marimekko/main/installation/") replace
```


If you want to make a clean figure, then it is advisable to load a clean scheme. These are several available and I personally use the following:

```
ssc install schemepack, replace
set scheme white_tableau  
```


I also prefer narrow fonts in figures with long labels. You can change this as follows:

```
graph set window fontface "Arial Narrow"
```


## Syntax

The syntax for the latest version is as follows:

```stata
marikmekko y x [if] [in], label(varname) [ sort(varname) reverse colorp(str) colorn(str)
                lcolor(str) lwidth(num) mlabsize(num) mlabangle(num) mlabgap(num)
                mlabcolor(num) xline(num) yline(num) xlabel(str) xtitle(str) ytitle(str)           
                title(str) subtitle(str) note(str) ysize(num) xsize(num) scheme(str)
                ]
```

See the help file `help marimekko` for details.

The basic use is as follows:

```
marimekko y x, label(variable)
```

The `y` and `x` variables need to be unique across the `label()` variable. If not, then the program will throw a warning and average the values across the `label()` variable. In summary, the data should be prepared in advance for the graph.


## Examples

Set up the data:

```stata
clear
set scheme white_tableau
graph set window fontface "Arial Narrow"

use "https://github.com/asjadnaqvi/stata-marimekko/blob/main/data/demo_r_pjangrp3_pop_change.dta?raw=true", clear

drop NUTS_ID

replace pop = pop / 1000000

ren xvar regions


lab de regions 	1 "Berlin" 2 "Hamburg" 3 "Bayern" 4 "Brandenburg" 5 "Baden-Württemberg" 6 "Hessen" 7 "Schleswig-Holstein" 8 "Rheinland-Pfalz" 9 "Niedersachsen" ///
				10 "Bremen" 11 "Nordrhein-Westfalen" 12 "Mecklenburg-Vorpommern" 13 "Sachsen" 14 "Saarland" 15 "Thüringen" 16 "Sachsen-Anhalt", replace

lab val regions regions
```


### Examples


```stata
marimekko change pop, label(regions)
```

<img src="/figures/marimekko1.png" height="600">

```stata
marimekko change pop, label(regions) sort(change) reverse	
```

<img src="/figures/marimekko1_1.png" height="600">


```
marimekko change pop, label(regions) sort(pop) 	
```

<img src="/figures/marimekko1_2.png" height="600">

```
marimekko change pop, label(regions) sort(pop) reverse	
```

<img src="/figures/marimekko1_3.png" height="600">


Sort by names:

```
decode regions, gen(names)

marimekko change pop, label(names) sort(names)	
```

<img src="/figures/marimekko1_5.png" height="600">


```
marimekko change pop, label(regions) sort(change) ylabel(-4(1)4) ytitle("% change in population") xtitle("Population (m)") 
```

<img src="/figures/marimekko2.png" height="600">


```
marimekko change pop, label(regions) ylabel(-4(1)4) ytitle("% change in population") xtitle("Population (m)") colorp(green) colorn(purple)
```

<img src="/figures/marimekko3.png" height="600">


```
marimekko change pop, label(regions) ///
	colorp(green) colorn(purple) lc(black) lw(0.2) ///
	ylabel(-4(1)4) ytitle("% change in population") xtitle("Population (m)") 
```

<img src="/figures/marimekko4.png" height="600">


```
marimekko change pop, label(regions) ///
	colorp(yellow) colorn(lime) lc(black) lw(0.2) mlabs(2) mlaba(45) mlabg(0.1) mlabc(blue) ///
	ylabel(-4(1)4) ytitle("% change in population") xtitle("Population (m)") 
```

<img src="/figures/marimekko5.png" height="600">


```
colorpalette w3, nograph	
	
marimekko change pop, label(regions) ///
	colorp("`r(p2)'%50") colorn("`r(p7)'%50") lc(black) lw(0.2) mlabs(2) mlaba(45) mlabg(0.1) mlabc(blue) ///
	ylabel(-4(1)4) ytitle("% change in population") xtitle("Population (m)") ///
	xsize(2) ysize(1)
```

<img src="/figures/marimekko6.png" width="900">


```
marimekko change pop, label(regions) ///
	 colorp("%50") colorn("%50") lc(black) lw(0.2) mlabs(2) mlaba(45) mlabg(0.1) mlabc(blue) ///
	ylabel(-4(1)4) ytitle("% change in population") xtitle("Population (m)") yline(1) ///
	xsize(2) ysize(1)
```

<img src="/figures/marimekko7.png" width="900">


## Acknowlegments

The package was inspired by [Ansgar Wolsing](https://twitter.com/_ansgar)'s [Twitter post](https://twitter.com/_ansgar/status/1540986424530554880), and [Maarten Lambrechts](https://twitter.com/maartenzam)'s [Twitter post](https://twitter.com/maartenzam/status/1537705354372558848). 

Additionally, there is a lack of general-purpose Stata package for Marimekko charts. I have also discussed this in my article on [Mosaic plots](https://medium.com/the-stata-guide/stata-graphs-mosaic-marimekko-plots-49caa27c5554) on the [Stata Guide](https://medium.com/the-stata-guide) on Medium.

## Feedback

Please open an [issue](https://github.com/asjadnaqvi/stata-marimekko/issues) to report errors, feature enhancements, and/or other requests. 


## Versions

**v1.1 (02 Dec 2023)**
- Additional options, such as `yline()`, `xline()` added.
- Code cleanup.

**v1.0 (28 Jun 2022)**
- Beta version.





