{smcl}
{* 02Dec2023}{...}
{hi:help marikmekko}{...}
{right:{browse "https://github.com/asjadnaqvi/stata-marimekko":marimekko v1.1 (GitHub)}}

{hline}

{title:marikmekko}: A Stata package for marikmekko charts. 



{marker syntax}{title:Syntax}
{p 8 15 2}

{cmd:marikmekko} {it:y x} {ifin}, {cmd:label}({it:varname}) {cmd:[} {cmd:sort}({it:varname}) reverse {cmd:colorp}({it:str}) {cmd:colorn}({it:str})
		{cmdab:lc:olor}({it:str}) {cmdab:lw:idth}({it:num}) {cmdab:mlabs:ize}({it:num}) {cmdab:mlaba:ngle}({it:num}) {cmdab:mlabg:ap}({it:num})
		{cmdab:mlabc:olor}({it:num}) {cmd:xline}({it:num}) {cmd:yline}({it:num}) {cmd:xlabel}({it:str}) {cmd:xtitle}({it:str}) {cmd:ytitle}({it:str}) 		
		{cmd:title}({it:str}) {cmd:subtitle}({it:str}) {cmd:note}({it:str}) {cmd:ysize}({it:num}) {cmd:xsize}({it:num}) {cmd:scheme}({it:str})
		{cmd:]}


{p 4 4 2}
The options are described as follows:

{synoptset 36 tabbed}{...}
{synopthdr}
{synoptline}

{p2coldent : {opt marikmekko y x}}The command requires a numeric {it:y} variable and a numeric {it:x} variable.{p_end}

{p2coldent : {opt label(variable)}}This variable defines the labels.{p_end}

{p2coldent : {opt sort(variable)}}This variable defines the sort order.{p_end}

{p2coldent : {opt reverse}}If this option is specified after {cmd:sort()}, the sort is reversed.{p_end}

{p2coldent : {opt colorp(color)}}The fill color for positive boxes. It should be either a named color or an RGB value given in quotes, e.g. "255 255 0". {p_end}

{p2coldent : {opt colorn(color)}}The fill color for negative boxes. It should be either a named color or an RGB value given in quotes, e.g. "255 255 0". {p_end}

{p2coldent : {opt lc:olor(color)}}Outline color of the boxes. The default is {it:white}.{p_end}

{p2coldent : {opt lw:idth(color)}}Outline width of the boxes. The default is {it:0.1}.{p_end}

{p2coldent : {opt mlabs:ize(value)}}Size of the labels. The default is {it:1.6}.{p_end}

{p2coldent : {opt mlaba:ngle(value)}}Angle of the labels. The default is {it:0} or horizontal.{p_end}

{p2coldent : {opt mlabc:olor(value)}}Angle of the labels. The default is scheme default.{p_end}

{p2coldent : {opt mlabg:ap(value)}}Gap of the labels from the boxes. The default is {it:0.5}.{p_end}

{p2coldent : {opt xlabel ylabel}}These are standard twoway graph options. {p_end}

{p2coldent : {opt xtitle, ytitle, xsize, ysize}}These are standard twoway graph options.{p_end}

{p2coldent : {opt xline()}, {opt yline()}}These are standard twoway graph options.{p_end}

{p2coldent : {opt title, subtitle, note, name}}These are standard twoway graph options.{p_end}

{p2coldent : {opt scheme(string)}}Load the custom scheme. Above options can be used to fine tune individual elements.{p_end}

{synoptline}
{p2colreset}{...}


{title:Dependencies}

The {browse "http://repec.sowi.unibe.ch/stata/palettes/index.html":palette} package (Jann 2018, 2022) is required:

{stata ssc install palettes, replace}
{stata ssc install colrspace, replace}


{title:Examples}

See {browse "https://github.com/asjadnaqvi/markmekko":GitHub}.

{hline}


{title:Package details}

Version      : {bf:marimekko} v1.1
This release : 02 Dec 2023
First release: 28 Jun 2022
Repository   : {browse "https://github.com/asjadnaqvi/markmekko":GitHub}
Keywords     : Stata, graph, marimekko
License      : {browse "https://opensource.org/licenses/MIT":MIT}

Author       : {browse "https://github.com/asjadnaqvi":Asjad Naqvi}
E-mail       : asjadnaqvi@gmail.com
Twitter      : {browse "https://twitter.com/AsjadNaqvi":@AsjadNaqvi}



{title:References}

{p 4 8 2}Jann, B. (2018). {browse "https://www.stata-journal.com/article.html?article=gr0075":Color palettes for Stata graphics}. The Stata Journal 18(4): 765-785.

{p 4 8 2}Jann, B. (2022). {browse "https://ideas.repec.org/p/bss/wpaper/43.html":Color palettes for Stata graphics: An update}. University of Bern Social Sciences Working Papers No. 43. 


{title:Other visualization packages}

{psee}
    {helpb arcplot}, {helpb alluvial}, {helpb bimap}, {helpb bumparea}, {helpb bumpline}, {helpb circlebar}, {helpb circlepack}, {helpb clipgeo}, {helpb delaunay}, {helpb joyplot}, 
	{helpb marimekko}, {helpb sankey}, {helpb schemepack}, {helpb spider}, {helpb streamplot}, {helpb sunburst}, {helpb treecluster}, {helpb treemap}




