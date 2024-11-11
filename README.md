
![StataMin](https://img.shields.io/badge/stata-2015-blue) ![issues](https://img.shields.io/github/issues/asjadnaqvi/stata-marimekko) ![license](https://img.shields.io/github/license/asjadnaqvi/stata-marimekko) ![Stars](https://img.shields.io/github/stars/asjadnaqvi/stata-marimekko) ![version](https://img.shields.io/github/v/release/asjadnaqvi/stata-marimekko) ![release](https://img.shields.io/github/release-date/asjadnaqvi/stata-marimekko)

[Installation](#Installation) | [Syntax](#Syntax) | [Examples](#Examples) | [Feedback](#Feedback) | [Change log](#Change-log)

---

![marimekko_banner](https://github.com/user-attachments/assets/158e9eb6-cb7f-491f-b884-29ae9182bd0f)



# marimekko v1.2
(11 Nov 2024)

This package provides the ability to draw Marimekko graphs in Stata. 


## Installation

The package can be installed via SSC or GitHub (the beta is on GitHub only). The GitHub version, *might* be more recent due to bug fixes, feature updates etc, and *may* contain syntax improvements and changes in *default* values. See version numbers below. Eventually the GitHub version is published on SSC.


Install the package as follows:

SSC (**v1.1**):

```
ssc install marimekko, replace
```


or directly from GitHub (**v1.2**):

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
marikmekko y x [if] [in] [weight], by(varname) 
      [ over(varname) sort(varname) reverse palette(str) xshare xpercentage yshare ypercentage wrap(num) stat(mean|sum)
        lcolor(str) lwidth(str) labsize(str) labangle(str) labgap(str) labposition(str) labcolor(num) showtotal
        labcondition(num) labprop labscale(num) legposition(num) legrows(num) legsize(num) offset(num) * ]

```

See the help file `help marimekko` for details.


## Examples


```
sysuse voter.dta, clear
```


```stata
marimekko pfrac pop, by(inc) 
```

<img src="/figures/marimekko1.png" width="100%">

```stata
marimekko pfrac pop, by(inc) sort(inc) 	
```

<img src="/figures/marimekko2.png" width="100%">


```
marimekko pfrac pop, by(inc) over(candidat)
```

<img src="/figures/marimekko3.png" width="100%">

```
marimekko pfrac pop, by(inc) over(candidat) showtotal
```

<img src="/figures/marimekko4.png" width="100%">



```
marimekko pfrac pop, by(inc) over(candidat) showtotal labprop labsize(3)
```

<img src="/figures/marimekko5.png" width="100%">


```
marimekko pfrac pop, by(inc) over(candidat) showtotal yshare
```

<img src="/figures/marimekko6.png" width="100%">


```
marimekko pfrac pop, by(inc) over(candidat) showtotal ypercent
```

<img src="/figures/marimekko7.png" width="100%">


```
marimekko pfrac pop, by(inc) over(candidat) showtotal ypercent xpercent
```

<img src="/figures/marimekko8.png" width="100%">


```
marimekko pfrac pop, by(inc) over(candidat) sort(inc) showtotal ypercent xpercent
```

<img src="/figures/marimekko9.png" width="100%">


```
marimekko pfrac pop, by(inc) over(candidat) sort(inc) showtotal ypercent xpercent palette(sb colorblind6) lw(0.2) legsize(4)
```

<img src="/figures/marimekko10.png" width="100%">




## Feedback

Please open an [issue](https://github.com/asjadnaqvi/stata-marimekko/issues) to report errors, feature enhancements, and/or other requests. 


## Change log

**v1.2 (11 Nov 2024)**

Complete package redesign with the following major changes:

- Minimum syntax is now `marimekko y x, by()`, where `by()` defines the x-axis categories.
- Y-axis categories are defined by `over()` variable.
- Both axes can be scaled using `xshare`, `xpercent` and `yshare`, `ypercent` options. These are for (0,1) or (0,100) scaling.
- All possible options added to control the labels. This also includes `labprop` and its controls, and `labcond()` to conditionally drop labels.
- The option `showtotal` shows x-axis `by()` category totals with the labels.
- Option `wrap()` allows label wrapping.
- Weights are allowed.
- Redesign of the underlying functions to generate boxes makes the command much faster than the previous versions.
- `legend()` options are restricted to a limited set of predefined options which should be sufficient for most cases. These can be overwritten but avoid this.
- Previous version had options to also show negative boxes. Currently these haven't been fully implemented and tested for this version.


**v1.1 (02 Dec 2023)**
- Additional options, such as `yline()`, `xline()` added.
- Code cleanup.

**v1.0 (28 Jun 2022)**
- Beta version.





