
*	************************************************************************
* 	File-Name: 	retrodesign.ado
*	Log-file:	na
*	Date:  		09/11/2018
*	Author: 	Michaël Aklin
*	Purpose:   	Stata .ado file to implement Gelman and Carlin's Type S
*				and Type M errors. 
*				See:
*				Gelman, Andrew and John Carlin. 2014. "Beyond Power 
*				Calculations: Assessing Type S (Sign) and Type M (Magnitude) 
*				Errors" Perspectives on Psychological Science, Vol. 9(6) 641–651
*				
*	Example:
*				retrodesign, delta(0.1) s(3.28) alpha(0.05) nsim(10000)
*	************************************************************************


*! version 0.1  11sep2018  Michaël Aklin

clear all
capture program drop retrodesign

program define retrodesign
version 14
syntax, delta(real) s(real) [alpha(real 0.05) nsim(integer 10000)]

* Preserve and drop all (needed to expand the number of obs)
preserve
drop _all

* Run the function. Note that Stata doesn't have an 'inf' to mean infinity. 
* Thus, I used a large number instead. This may explain discrepancies with 
* the R version of this code.
local z = invttail(999999,`alpha'/2)
local phi = ttail(999999,`z'-`delta'/`s')
local plo = 1-ttail(999999,-`z'-`delta'/`s')
local power = `phi' + `plo'
local typeS = 100*`plo'/`power'

* Simulations
quiet set obs `nsim'
quiet gen estimate = `delta'+`s'*rt(999999)
quiet gen significant = 1 if abs(estimate)>`s'*`z'
quiet gen absestimate = abs(estimate) if significant==1
quiet sum absestimate
local exaggeration = `r(mean)'/`delta' 

* Display the results
display ""
display "       INPUT"
display "delta:        " %6.3f `delta'
display "S.d.:         " %6.3f `s'
display "alpha:        " %6.2f `alpha'
display "Simulations:  " %6.0f `nsim'
display ""
display "       OUTPUT"
display "Power:             " %6.3f `power'
display "Type (S) (%):      " %6.2f `typeS'
display "Exaggeration (M):  " %6.2f `exaggeration'

restore
end
