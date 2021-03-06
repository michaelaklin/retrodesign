{smcl}
{* *! version 1.2.1  07mar2013}{...}
{findalias asfradohelp}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] help" "help help"}{...}
{viewerjumpto "Syntax" "examplehelpfile##syntax"}{...}
{viewerjumpto "Description" "examplehelpfile##description"}{...}
{viewerjumpto "Options" "examplehelpfile##options"}{...}
{viewerjumpto "Remarks" "examplehelpfile##remarks"}{...}
{viewerjumpto "Examples" "examplehelpfile##examples"}{...}
{title:Title}

{phang}
{bf:retrodesign} {hline 2} Calculate Gelman and Carlin's (2014) type-S errors and type-M exaggeration ratios and other quantities of interest defined in their article


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmdab:retrodesign}
[{cmd:,} {it:options}]

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}
{synopt:{opt delta(#)}}effect size (required){p_end}
{synopt:{opt s(#)}}standard deviation of the effect size (required){p_end}
{synoptline}
{syntab:Optional}
{synopt:{opt alpha(#)}}critical alpha value; default is {cmd:0.05}{p_end}
{synopt:{opt nsim(#)}}number of simulations; default is {cmd:10,000}{p_end}
{synopt:{opt df(#)}}number of degrees of freedom; default is a large value{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}


{marker description}{...}
{title:Description}

{pstd}
{cmd:retrodesign} calculates type-S errors and type-M exaggeration ratios. In addition, it also provides several other quantities of interest, such as the power of a test or the likelihood of obtaining wrong and correct signs. For details, see Gelman, Andrew and John Carlin. 2014. "Beyond Power Calculations: Assessing Type S (Sign) and Type M (Magnitude) Errors" {it:Perspectives on Psychological Science}, Vol. 9(6) 641–651. Note that Stata doesn't have an '{it:inf}' command to mean infinity, like R does. Thus, I used a large number as a placeholder instead. This may explain discrepancies with Gelman and Carlin's results when using their R code.


{marker options}{...}
{title:Options}

{dlgtab:Main}

{phang}
{opt delta(#)} is the hypothesized effect size. This needs to be a real number and is required.

{phang}
{opt s(#)} is the hypothesized standard error of the effect size. This needs to be a real number and is required.

{dlgtab:Optional}

{phang}
{opt alpha(#)} is the critical alpha value. Default is 0.05.

{phang}
{opt nsim(#)} is the number of simulations used to generate the quantities of interest. Default is 10,000. Note that using values that are too small can lead to error messages.

{phang}
{opt df(#)} is the number of degrees of freedom. Default is a large value (Stata does not deal with infinity like R does).



{marker remarks}{...}
{title:Remarks}

{pstd}
The Stata code is adapted from Gelman and Carlin's own R script in the article's appendix. I added a few quantities that may be of interest. Of course, all errors are mine. Please let me know if you find any mistake. 

{pstd}
I hope this code is useful; it is distributed without any warranty. Note that I declared {bf:retrodesign} as a Stata 14 command; I am pretty sure it would work with earlier versions, but I was not able to check. If you run an earlier version, you could modify the ado file (replacing {it:version 14} with whatever version you use).


{title:Author}

{pstd}Michaël Aklin, University of Pittsburgh, michael.aklin@gmail.com


{marker examples}{...}
{title:Examples}

{phang}The original example by Gelman and Carlin (2014, p.645): {p_end}
{phang}{cmd:. retrodesign, delta(0.1) s(3.28)}{p_end}

{phang}Modifying options: {p_end}
{phang}{cmd:. retrodesign, delta(0.1) s(3.28) alpha(0.1) nsim(100000)}{p_end}

{phang}Other example by Gelman and Carlin (2014, p.646): {p_end}
{phang}{cmd:. retrodesign, delta(2) s(8.1)}{p_end}

{marker results}{...}
{title:Stored results}

{pstd}
{cmd:retrodesign} stores the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:r(delta)}}Hypothesized effect{p_end}
{synopt:{cmd:r(s)}}Hypothesized standard error of the effect{p_end}
{synopt:{cmd:r(alpha)}}Alpha significance level{p_end}
{synopt:{cmd:r(nsim)}}Number of simulations{p_end}
{synopt:{cmd:r(df)}}Degrees of freedom{p_end}
{synopt:{cmd:r(phi)}}Pr(Correct sign and statistically significant){p_end}
{synopt:{cmd:r(plo)}}Pr(Wrong sign and statistically significant){p_end}
{synopt:{cmd:r(power)}}power{p_end}
{synopt:{cmd:r(typeS)}}Type-S error (in %), conditional on being significant{p_end}
{synopt:{cmd:r(exaggeration)}}Type-M exaggeration ratio{p_end}
{synopt:{cmd:r(insig_phi)}}Pr(Correct sign and statistically insignificant){p_end}
{synopt:{cmd:r(insig_plo)}}Pr(Wrong sign and statistically insignificant){p_end}
{synopt:{cmd:r(insig_typeS)}}Type-S error (in %), conditional on being insignificant{p_end}
{p2colreset}{...}
