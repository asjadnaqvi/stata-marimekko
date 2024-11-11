{smcl}
{* 11Nov2024}{...}
{hi:help marikmekko}{...}
{right:{browse "https://github.com/asjadnaqvi/stata-marimekko":marimekko v1.2 (GitHub)}}

{hline}

{title:marikmekko}: A Stata package for Marikmekko charts. 



{marker syntax}{title:Syntax}
{p 8 15 2}

{cmd:marikmekko} {it:y x} {ifin} {weight}, {cmd:by}({it:varname}) 
      {cmd:[} {cmd:over}({it:varname}) {cmd:sort}({it:varname}) {cmd:reverse} {cmd:palette}({it:str}) {cmd:xshare} {cmdab:xpercent:age} {cmd:yshare} {cmdab:ypercent:age} {cmd:wrap}({it:num}) {cmd:stat}({it:mean}|{it:sum})
        {cmdab:lc:olor}({it:str}) {cmdab:lw:idth}({it:str}) {cmdab:labs:ize}({it:str}) {cmdab:laba:ngle}({it:str}) {cmdab:labg:ap}({it:str}) {cmdab:labpos:ition}({it:str}) {cmdab:labc:olor}({it:num}) {cmdab:showtot:al}
        {cmdab:labcond:ition}({it:num}) {cmd:labprop} {cmd:labscale}({it:num}) {cmdab:legpos:ition}({it:num}) {cmdab:legrow:s}({it:num}) {cmdab:legs:ize}({it:num}) {cmdab:offset}({it:num}) {cmd:*} {cmd:]}


{p 4 4 2}
The options are described as follows:

{synoptset 36 tabbed}{...}
{synopthdr}
{synoptline}

{p2coldent : {opt marikmekko y x}}The command requires a numeric {it:y} variable and a numeric {it:x} variable.{p_end}

{p2coldent : {opt by(variable)}}Define the x-axis categories.{p_end}

{p2coldent : {opt over(variable)}}Define the y-axis categories. These categories are shown in the legend.{p_end}

{p2coldent : {opt sort(variable)}}Define the sort order.{p_end}

{p2coldent : {opt reverse}}Reverse the {opt sort()}.{p_end}

{p2coldent : {opt xshare}}Show the x-axis as shares of total.{p_end}

{p2coldent : {opt xpercent:age}}Show the x-axis as percentage of total.{p_end}

{p2coldent : {opt yshare}}Show the y-axis as shares of total.{p_end}

{p2coldent : {opt ypercent:age}}Show the y-axis as percentage of total.{p_end}

{p2coldent : {opt format()}}Format the values. Defaults are {opt format(%12.2fc)} for standard numbers and {opt format(%4.2f)} for shares and percentages.{p_end}

{p2coldent : {opt stat(mean|sum)}}If there are multiple observations per {opt by()} and {opt over()}, then by default the program will take the mean by triggering {opt stat(sum)}.
Weights are allowed here. As a note of caution, it is highly recommended to prepare the data before using this command.{p_end}


   {ul:Colors}

{p2coldent : {opt palette(name)}}Color name is any named scheme defined in the {stata help colorpalette:colorpalette} package. Default is {stata colorpalette tableau:{it:tableau}}.{p_end}

{p2coldent : {opt lc:olor(color)}}Outline color of the boxes. The default is {opt lc(white)}.{p_end}

{p2coldent : {opt lw:idth(color)}}Outline width of the boxes. The default is {opt lw(0.1)}.{p_end}


   {ul:Labels}

{p2coldent : {opt wrap(num)}}Wrap the labels after a specific number of characters. Word boundaries are respected.
Requires the latest {stata help graphfunctions:graphfunctions} package.{p_end}

{p2coldent : {opt showtot:al}}Show the sum of the horizontal axis.{p_end}

{p2coldent : {opt labcond:ition(num)}}The label condition can be used to limit the number of labels shown. 
For example, {opt labcond(100)} will only shows labels where the last data point value is greater than 100. Default is {opt labcond(0)}.{p_end}

{p2coldent : {opt offset}}Offset the labels in the north direction. Values are a percentage of total height. Default is {opt offset(0)}.{p_end}

{p2coldent : {opt labs:ize(str)}}Size of the labels. The default is {opt labs(2)}.{p_end}

{p2coldent : {opt laba:ngle(str)}}Angle of the labels. The default is {opt laba(0)} or horizontal.{p_end}

{p2coldent : {opt labc:olor(str)}}Angle of the labels. The default is {opt labc(black)}.{p_end}

{p2coldent : {opt labg:ap(str)}}Gap of the labels from the boxes. The default is {opt labg(0)}.{p_end}

{p2coldent : {opt labprop}}Scale the bar labels based on the relative sizes.{p_end}

{p2coldent : {opt labscale(num)}}Scale factor of {opt labprop}. Default value is {opt labscale(0.3333)}. Values closer to zero result in more exponential scaling, while values closer
to one are almost linear scaling. This is an advanced option so use carefully.{p_end}

   {ul:Legend}

{p2coldent : {opt legpos:ition(num)}}Clock position of the legend. Default is {opt legpos(6)}.{p_end}

{p2coldent : {opt legcol:umns(num)}}Number of legend columns. Default is {opt legcol(3)}.{p_end}

{p2coldent : {opt legs:ize(num)}}Size of legend entries. Default is {opt legs(2.5)}.{p_end}


{p2coldent : {opt *}}All other standard twoway options.{p_end}

{synoptline}
{p2colreset}{...}


{title:Dependencies}

{stata ssc install palettes, replace}
{stata ssc install colrspace, replace}
{stata ssc install graphfunctions, replace}


{title:Examples}

See {browse "https://github.com/asjadnaqvi/markmekko":GitHub}.


{title:Feedback}

Please submit bugs, errors, feature requests on {browse "https://github.com/asjadnaqvi/stata-marimekko/issues":GitHub} by opening a new issue.


{title:Citation guidelines}

Suggested citation for this package:

Naqvi, A. (2024). Stata package "marimekko" version 1.2. Release date 11 November 2024. https://github.com/asjadnaqvi/stata-marimekko.

@software{spider,
   author = {Naqvi, Asjad},
   title = {Stata package ``marimekko''},
   url = {https://github.com/asjadnaqvi/stata-spider},
   version = {1.2},
   date = {2024-11-11}
}


{title:Package details}

Version      : {bf:marimekko} v1.2
This release : 11 Nov 2024
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
    {helpb arcplot}, {helpb alluvial}, {helpb bimap}, {helpb bumparea}, {helpb bumpline}, {helpb circlebar}, {helpb circlepack}, {helpb clipgeo}, {helpb delaunay}, {helpb graphfunctions}, {helpb joyplot}, 
	{helpb marimekko}, {helpb polarspike}, {helpb sankey}, {helpb schemepack}, {helpb spider}, {helpb splinefit}, {helpb streamplot}, {helpb sunburst}, {helpb ternary}, {helpb treecluster}, {helpb treemap}, {helpb trimap}, {helpb waffle}

or visit {browse "https://github.com/asjadnaqvi":GitHub}.




