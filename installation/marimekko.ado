*! marimekko v1.0 (28 Jun 2022). First release
*! Asjad Naqvi (asjadnaqvi@gmail.com)


cap program drop marimekko


program marimekko, sortpreserve

version 15
 
	syntax varlist(min=2 max=2 numeric) [if] [in], label(varname)  ///
				[ sort(varname) reverse colorp(string) colorn(string) LColor(string) LWidth(real 0.1) ] ///
				[ MLABSize(real 1.6) MLABAngle(string) MLABGap(real 0.05) MLABColor(string)   ] ///
				[ xlabel(passthru) ylabel(passthru) xtitle(passthru) ytitle(passthru) ///
				  title(passthru) subtitle(passthru) note(passthru) scheme(passthru) name(passthru) xsize(passthru) ysize(passthru) ] 
		
		
	
	marksample touse, strok
	gettoken yvar xvar : varlist 	

	local dups 0
	qui levelsof `label'
	if _N > r(r) {
		di in yellow "{bf:Warning}: There are duplicates in the {it:`label'} variable. The program will take the mean of the variables."
		local dups 1
	}


qui {
	preserve	
	
	
	keep if `touse'
	
	if `dups' == 1 collapse (mean) `yvar' `xvar', by(`label')
	
	
	if "`sort'" != "" {
		if "`reverse'" != "" {
			sort `sort'
		}
		else {
			gsort - `sort'
		}
	}
	
	if _N < 5 {
		set obs 5  
	}
	
	
	// deal with the variable type
	cap confirm numeric var `label' 
	
	if _rc!=0 {   
		gen id = _n
		gen name = `label'
		local label id
	}
	else {
		if "`: value label `label''" == "" { 
			gen id = _n
			gen name = `label'
			local label id
		}
		else {
			gen id = _n
			decode `label', gen(name)
			local label id
		}
	}

	
	// rectangles
	
	tempvar xe xs ye ys
	
	gen double `xe' = sum(`xvar')
	gen double `xs' = `xe'[_n-1]
	replace    `xs' = 0 in 1

	gen double `ye' = `yvar'
	gen double `ys' = 0
	
		levelsof `label' , local(lvls)

		foreach x of local lvls {
			
			
			cap gen double x`x' = .	
			cap gen double y`x' = .	
			
	
			// bottom left
			replace x`x' = `xs'[`x'] in 1
			replace y`x' = `ys'[`x'] in 1
			
			// top left
			replace x`x' = `xs'[`x'] in 2
			replace y`x' = `ye'[`x'] in 2
			
			// top right
			replace x`x' = `xe'[`x'] in 3
			replace y`x' = `ye'[`x'] in 3	
			
			// bottom right
			replace x`x' = `xe'[`x'] in 4
			replace y`x' = `ys'[`x'] in 4		

			// bottom left
			replace x`x' = `xs'[`x'] in 5
			replace y`x' = `ys'[`x'] in 5	
			
			gen double xmid`x' = (`xs'[`x'] + `xe'[`x']) / 2 in 1
			gen double ymid`x' = `yvar'[`x'] + cond(`yvar'[`x'] >= 0, `mlabgap', -1 * `mlabgap') in 1
			
			
			gen label`x' = name[`x'] in 1
			
		}

		
		// locals here
		
		if "`colorp'" == "" local colorp "31 119 180"
		if "`colorn'" == "" local colorn "255 127 14"
		if "`lcolor'" == "" local lcolor "white"
		
		
		// draw here

		levelsof `label' if `yvar' >= 0, local(lvls)

		foreach x of local lvls {
			
			local bars1 `bars1' (area y`x' x`x', nodropbase fc("`colorp'") fi(100) lc(`lcolor') lw(`lwidth')) ||
			
			local labels1 `labels1' (scatter ymid`x' xmid`x', mlab(label`x') mc(none) mlabangle(`mlabangle') mlabpos(1) mlabc(`mlabcolor') mlabsize(`mlabsize')) ||
			
		}
	
	
		levelsof `label' if `yvar' < 0, local(lvls)

		foreach x of local lvls {	
			
			local bars2 `bars2' (area y`x' x`x' , nodropbase fc("`colorn'") fi(100) lc(`lcolor') lw(`lwidth')) ||
			
			local labels2 `labels2' (scatter ymid`x' xmid`x', mlab(label`x') mc(none) mlabangle(`mlabangle') mlabpos(7) mlabc(`mlabcolor') mlabsize(`mlabsize')) ||
			
		}

	
		// put it together
		
		twoway ///
			`bars1' ///
			`bars2' ///
			`labels1' ///
			`labels2' ///
				, ///
				legend(off)  ///
				`xlabel' `ylabel' ///
				`xtitle' `ytitle' ///
				`title' `subtitle' `note' ///
				`scheme' `xsize' `ysize' `name'
			

	restore
}		
		
end



*********************************
******** END OF PROGRAM *********
*********************************
