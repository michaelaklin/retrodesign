
*   ************************************************************************
*   File-Name:  retrodesign.ado
*   Author:     Michaël Aklin
*   Link:       https://github.com/michaelaklin/retrodesign
*   Purpose:    Stata .ado file to implement Gelman and Carlin's Type S
*               and Type M errors. 
*               See:
*               Gelman, Andrew and John Carlin. 2014. "Beyond Power 
*               Calculations: Assessing Type S (Sign) and Type M (Magnitude) 
*               Errors" Perspectives on Psychological Science, Vol. 9(6) 641–651
*				
*   Example:
*               retrodesign, delta(0.1) s(3.28) alpha(0.05) nsim(10000)
*   ************************************************************************



*!	version 0.2  12sep2018  Michaël Aklin; 
*								retrodesign adds more output;
*								prevents negative standard errors;
*!	version 0.1  11sep2018  Michaël Aklin

capture program drop retrodesign

*	Starting the program
program define retrodesign, rclass
version 14
syntax, delta(real) s(numlist >0 min=1 max=1) [alpha(real 0.05) nsim(integer 10000)]

* Preserve and drop all (needed to expand the number of obs)
preserve
drop _all

* Run the function. Note that Stata doesn't have an 'inf' to mean infinity. 
* Thus, I used a large number instead. This may explain discrepancies with 
* the R version of this code.

* Conditional on being significant
local z = invttail(999999,`alpha'/2)
local phi = ttail(999999,`z'-`delta'/`s')
local plo = 1-ttail(999999,-`z'-`delta'/`s')
local power = `phi' + `plo'
local typeS = 100*`plo'/`power'

* Conditional on being insignificant: take the right (left) side minus the bit
* that is significant 
local insig_phi = ttail(999999,-`delta'/`s')-`phi'
local insig_plo = ttail(999999,`delta'/`s')- `plo'
local insig_typeS = 100*`insig_plo'/(`insig_plo'+`insig_phi')

* Simulations
quiet set obs `nsim'
quiet gen estimate = `delta'+`s'*rt(999999)
quiet gen significant = 1 if abs(estimate)>`s'*`z'
quiet gen absestimate = abs(estimate) if significant==1
quiet sum absestimate
local exaggeration = `r(mean)'/`delta' 

* Display the results
display "________________________________________________"
display "		INPUT"
display ""
display "delta:         " %6.3f `delta'
display "S.d.:          " %6.3f `s'
display "alpha:         " %6.2f `alpha'
display "Simulations:   " %6.0f `nsim'
display ""
display "________________________________________________"
display "		OUTPUT"
display ""
display "Statistically insignificant (at alpha=`alpha' level):"
display ""
display "Pr(Correct sign) and insignificant:    " %6.3f `insig_phi'
display "Pr(Wrong sign) and insignificant:      " %6.3f `insig_plo'
display "Type S (%) (when insignificant):       " %6.2f `insig_typeS'
display ""
display "Statistically significant (at alpha=`alpha' level):"
display ""
display "Pr(Correct sign) and significant:      " %6.3f `phi'
display "Pr(Wrong sign) and significant:        " %6.3f `plo'
display "Power:                                 " %6.3f `power'
display "Type S (%) (when significant):         " %6.2f `typeS'
display "Exaggeration ratio (M):                " %6.2f `exaggeration'
display ""
display "________________________________________________"
display "(See Gelman and Carlin (2014) for details)"

* Saving quantities in r()
return scalar phi = `phi'
return scalar plo = `plo'
return scalar power = `power'
return scalar typeS = `typeS'
return scalar exaggeration = `exaggeration'
return scalar insig_phi = `insig_phi'
return scalar insig_plo = `insig_plo'
return scalar insig_typeS = `insig_typeS'

restore
end
