*! marimekko v1.2 (11 Nov 2024)
*! Asjad Naqvi (asjadnaqvi@gmail.com)

* v1.2 (11 Nov 2024): major package rework. see v1.2 rows below for the new options.
* v1.1 (02 Dec 2023): Added additional options
* v1.0 (28 Jun 2022): First release


cap program drop marimekko

program marimekko, // sortpreserve

version 15
 
	syntax varlist(min=2 max=2 numeric) [if] [in] [aw fw pw iw/], by(varname)  ///
				[ sort(varname) reverse palette(string) LColor(string) LWidth(string) ] ///
				[ LABSize(string) LABAngle(string) LABGap(string) LABColor(string) LABPosition(string)   ] ///
				[ over(varname) stat(string) xshare XPERCENTage yshare YPERCENTage legend(string) wrap(numlist max=1 >0)  ] ///  // v1.2 options
				[ LEGPOSition(real 6) LEGROWs(real 1) LEGSize(string) offset(real 0) SHOWTOTal format(string) LABCONDition(real 0) labprop labscale(real 0.3333) * ] // v1.2 options
		
	
	marksample touse, strok


	cap findfile labmask.ado
		if _rc != 0 quietly ssc install labutil, replace
	
	cap findfile labsplit.ado
		if _rc != 0 quietly ssc install graphfunctions, replace		
		
	// check dependencies
	cap findfile colorpalette.ado
	if _rc != 0 {
		display as error "The palettes package is missing. Please install the {stata ssc install palettes, replace:palettes} and {stata ssc install colrspace, replace:colrspace} packages."
		exit
	}		
	
	if "`stat'" != "" & !inlist("`stat'", "mean", "sum") {
		display as error "Valid options are {bf:stat(mean)} [default] or {bf:stat(sum)}."
		exit
	}		
	
	if "`xshare'"!="" & "`xpercentage'"!= "" {
		display as error "Only one off {it:xshare} or {it:xpercent} can be specified."
		exit
	}
	
	if "`yshare'"!="" & "`ypercentage'"!= "" {
		display as error "Only one off {it:yshare} or {it:ypercent} can be specified."
		exit
	}
		
	

quietly {
	preserve	
	
	keep if `touse'
		
	tokenize `varlist'
	gen double _yvar = `1'
	gen double _xvar = `2'
	
	local xvar _xvar
	local yvar _yvar
	
	
	
	keep `xvar' `yvar' `by' `over' `exp' `sort'
	
	drop if missing(`by')
	drop if missing(`over')

	
	if "`over'"=="" {
		gen _over = 1
		local over _over
		local ovrskip 1
	}
	else {
		local ovrskip 0
	}
	
	if "`sort'" == "" {
		bysort `by': egen _mysort = sum(`xvar')
	}
	else {
		gen _mysort = `sort'
	}
	
	local sort _mysort
	
	
	if "`stat'" == "" local stat sum
	if "`weight'" != "" local myweight  [`weight' = `exp']
	
	collapse (`stat') `xvar' `yvar' (mean) `sort' `myweight' , by(`by' `over')	
		
	
	sort `by' `over'
	
	
	
	
	*by `by': egen _sort = sum(`sort')
	by `by': gen double _ysum = sum(`yvar')  
	by `by': egen double _xtotal = sum(`xvar')
	by `by': egen double _ytotal = sum(`yvar')
	
	
	if "`sort'" != "" {
		if "`reverse'" != "" {
			sort 	`sort' 
		}
		else {
			gsort -`sort'
		}
	}
	
	
	
	// deal with the variable type
	
	gen id = _n
	

	
	// x categories
	egen _grp1 = tag(`by')  
	replace _grp1 = sum(_grp1)
	
	
	cap confirm numeric var `by' 
	
	if _rc!=0 {   
		labmask _grp1, val(`by')
	}
	else {
		decode `by', gen(_name)
		labmask _grp1, val(_name)
		drop _name
	}

	
	// y categories
	
	
	egen _grp2 = group(`over') 
	
	cap confirm numeric var `over'
	
	if _rc!=0 {		// if string
		labmask _grp2, values(`over')
	}
	else {			// if numeric 
		if "`: value label `over''" != "" { // with value label
			decode `over', gen(_name)
			labmask _grp2, val(_name)
			drop _name
		}
	}
	
	
	sort `sort' `by' `over'

	// rectangles
	
	tempvar xe xs ye ys
	

	levelsof _grp1, local(lvls)
	
	gen double _xs = .
	gen double _xe = .
	
	local xstart = 0
	local xend = 0
	
	foreach x of local lvls {
		
		local xstart = `xend'
		
		summ _xvar if _grp1==`x', meanonly
		local xend = `r(sum)' + `xend'
		
		replace _xs = `xstart' 	if _grp1==`x'
		replace _xe = `xend' 	if _grp1==`x'
	}
	
	
	gen double _ye = _ysum
	gen double _ys = _ye[_n-1]
	replace    _ys = 0 if _grp2==1
	
	
	
	// share or percentage
	
	if "`yshare'" != "" {
		replace _ys = _ys / _ytotal
		replace _ye = _ye / _ytotal
	}
	
	if "`ypercentage'" != "" {
		replace _ys = (_ys / _ytotal) * 100
		replace _ye = (_ye / _ytotal) * 100
	}	
	
	if "`xshare'" != "" {
		summ _xe, meanonly
		replace _xs = _xs / `r(max)'
		replace _xe = _xe / `r(max)'
	}
	
	if "`xpercentage'" != "" {
		summ _xe, meanonly
		replace _xs = (_xs / `r(max)') * 100
		replace _xe = (_xe / `r(max)') * 100
	}		
	
	
	levelsof _grp2, local(lvl2)
	
	foreach x of local lvl2 {
		
		count if _grp2==`x' 
		local targetobs = `r(N)' * 6
		if _N < `targetobs'		set obs `targetobs'		
		
		gen int 	_id`x' 	= .
		gen double 	 _x`x' 	= .
		gen double 	 _y`x' 	= .
		
		levelsof _grp1 if _grp2==`x', local(lvl1)
		

		foreach y of local lvl1 {
		
			local i = (`y'- 1) * 6 
			
			replace _id`x' = `y' in `=`i'+1'/`=`i'+6'
			
			// x
			summ _xs if _grp2==`x' & _grp1==`y', meanonly
			replace _x`x' = r(mean) in `=`i'+1'
			replace _x`x' = r(mean) in `=`i'+2'
			replace _x`x' = r(mean) in `=`i'+5'
		
			summ _xe if _grp2==`x' & _grp1==`y', meanonly
			replace _x`x' = r(mean) in `=`i'+3'
			replace _x`x' = r(mean) in `=`i'+4'
		
			// y
			summ _ys if _grp2==`x' & _grp1==`y', meanonly
			replace _y`x' = r(mean) in `=`i'+1'
			replace _y`x' = r(mean) in `=`i'+4'
			replace _y`x' = r(mean) in `=`i'+5'
		
			summ _ye if _grp2==`x' & _grp1==`y', meanonly
			replace _y`x' = r(mean) in `=`i'+2'
			replace _y`x' = r(mean) in `=`i'+3'		
			
		}
		
	}
	
	
	// fix labels
	


	levelsof _grp1, local(lvls)
	
	gen double _labx = .
	gen double _laby = .
	gen double _labval = .
	gen _labname = ""
	
	local x0 = 0
	
	foreach x of local lvls {
			
			// y
			summ _ye if _grp1==`x', meanonly
			replace _laby = r(max) * (1 + (`offset' / 100)) in `x'

			// x
			summ _xe if _grp1==`x', meanonly
			local x1 = r(max)
			replace _labx = (`x0' + `x1') / 2 in `x'
			local x0 = `x1'
			
			// value
			summ _xtotal if _grp1==`x', meanonly
			replace _labval = r(max) in `x'
			
			// label
			local t : label _grp1 `x' 
			replace _labname = "`t'" in `x'
	}		
		
		
	*** define format options
	if "`format'" == "" {
		if "`shares'"!="" | "`percent'"!="" {
			local format "%4.2f"	
		}
		else {
			local format "%12.2fc"	
		}
	}			
		
		if "`showtotal'" !="" {
			if "`xshare'" != "" {
				summ _labval, meanonly
				replace _labval = _labval / r(sum)
				replace _labname = _labname + " (" + string(_labval, "`format'") + ")" if !missing(_labname) 
			}
			else if "`xpercentage'"!= "" {
				summ _labval, meanonly
				replace _labval = (_labval / r(sum)) * 100
				replace _labname = _labname + " (" + string(_labval, "`format'") + "%)" if !missing(_labname)			
			}
			else {
				replace _labname = _labname + " (" + string(_labval, "`format'") + ")" if !missing(_labname) 
			}
		}
		
		replace _labname = "" if _labval < `labcondition'
		
		
		if "`wrap'" != "" {
			ren _labname _labname_old
			labsplit _labname_old, wrap(`wrap') gen(_labname)
			drop _labname_old
		}	
		
		
		// locals here
		
		if "`lwidth'" == "" local lwidth 0.1
		if "`lcolor'" == "" local lcolor white
		
		if "`palette'" == "" {
			local palette tableau
		}
		else {
			tokenize "`palette'", p(",")
			local palette  `1'
			local poptions `3'
		}		
		
		
		// draw here

		if "`labgap'"   == "" local labgap 0
		if "`labsize'"  == "" local labsize  2
		if "`labangle'" == "" local labangle 0
		if "`labcolor'" == "" local labcolor black
		if "`labposition'" == "" local labposition 12		
		
		
		
		if "`labprop'"== ""  {
			local labels (scatter _laby _labx, mlab(_labname) mc(none) mlabangle(`labangle') mlabposition(`labposition') mlabcolor(`labcolor') mlabsize(`labsize')) 
		}		
		
		levelsof _grp2, local(lvls)
		local items = r(r)

		foreach x of local lvls {
			colorpalette `palette', nograph `poptions' // n(`items')
			local bars `bars' (area _y`x' _x`x', cmissing(n) nodropbase fc("`r(p`x')'") fi(100) lc(`lcolor') lw(`lwidth')) 
			
		}

		
		if "`labprop'"== ""  {
			local labels (scatter _laby _labx, mlab(_labname) mc(none) mlabangle(`labangle') mlabposition(`labposition') mlabcolor(`labcolor') mlabsize(`labsize')) 
		}
		else {
			summ _labval, meanonly
			local height = r(sum)
				
			levelsof _grp1, local(lvls)	
				
			foreach x of local lvls {	
				summ _labval in `x' , meanonly
				local labwgt = `labsize' * (r(max) / `height')^`labscale' 
				
				local labels `labels'  (scatter _laby _labx in `x', mlab(_labname) mc(none) mlabangle(`labangle') mlabposition(`labposition') mlabcolor(`labcolor') mlabsize(`labwgt')) 
			}	
			
		}
		
		
		// fix legend
		
		if "`legsize'" == "" local legsize 2.5
		
		if `ovrskip' == 1 {	// skip legend if no over defined.
			local legend legend(off)
		}
		else {
			
			if "`legend'" == "" {
			
				levelsof _grp2, local(lvls)
				
				foreach x of local lvls {
					local t : label _grp2 `x' 
					lab var _y`x' "`t'"
					local entries `" `entries' `x'  "`t'"  "'
				}
				
				local legend legend(order("`entries'") position(`legposition') size(`legsize') rows(`legrows')) 
			}
		}
		

	
		// put it together
		

		twoway ///
			`bars' ///			
			`labels' ///
				, ///
				 `legend' `options'
				 
				
*/			

	restore
}		
		
end



*********************************
******** END OF PROGRAM *********
*********************************
