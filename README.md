# retrodesign

Implements Gelman and Carlin's (2014) retrodesign function in Stata

## Getting Started

This project allows Stata users to compute Gelman and Carlin's Type-S and Type-M errors. 

### Prerequisites

Stata 14 or later; earlier versions should work too, but I haven't tested the program with them. Note that to use an earlier Stata version, you would have to modify the ado file. Replace the line that says:
```
version 14
```

with whatever version you use.

### Installing

1. Type *personal* in Stata. You'll see where your personal ado folder is. For instance, it could look like _/Library/Application Support/Stata/ado/personal/_
2. Save the two files (*retrodesign.ado* and *retrodesign.sthlp*) in this folder. 

## Running the code

See the help file for more information (_help retrodesign_). 

To give an illustration on how to use _retrodesign_: assuming a hypothesized effect of 0.1 and a standard error of 3.28 (numbers from Gelman and Carlin's original article), you would type:
```
retrodesign, delta(0.1) s(3.28)
```

Users can change the critical alpha value (which matters a lot; default is 0.05), the number of observations for the simulation (which matters less within reasonable bounds; default is 10,000), and the number of degrees of freedom (default is a large number).

The output generates the test's power, the likelihood of a Type-S error (in %), the Type-M exaggeration ratio, and a few other quantities of interest (which should be self-explanatory). 

## Author

* Michaël Aklin (michael.aklin@gmail.com) - [GitHub page](https://github.com/michaelaklin)

## Addendum

_Addendum_: there exists another ado file computing Gelman and Carlin's type S and M errors. This ado, written by Daniel Klein, can be obtained with _ssc install rdesigni_. His code allows to run several tests at the same time, which is not feasible with _retrodesign_ (his code is also much more elegant!). However, it does not produce all the quantities of interest mentioned by Gelman and Carlin.

## Acknowledgments

Part of the code was directly adapted from Gelman and Carlin (who wrote it for R), but all errors are mine. No warranty that the code will work as intended. Please let me know if you find errors! 

## Reference

Gelman, Andrew and John Carlin. 2014. "Beyond Power Calculations: Assessing Type S (Sign) and Type M (Magnitude) Errors" _Perspectives on Psychological Science_, Vol. 9(6) 641–651
