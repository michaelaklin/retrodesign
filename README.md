# retrodesign
Implements Gelman and Carlin's (2014) retrodesign function in Stata

## Getting Started

This project allows Stata users to compute Gelman and Carlin's Type-S and Type-M errors in Stata. 

_Addendum_: I found out after writing this ado file that Daniel Klein also created a similar program (which can be obtained with _ssc install rdesigni_). His code allows to run several tests at the same time, which is not feasible with *retrodesign*. 

### Prerequisites

Stata 14 or later; earlier versions should work too, but I haven't tested the program with them. Note that to use an earlier Stata version, you would have to modify the ado file. Replace the line that says:
```
version 14
```

with whatever version you use.

### Installing

1. Download the *retrodesign.ado* and *retrodesign.sthlp* files. 
2. Type *personal* in Stata. You'll see where your personal ado folder is. For instance, it could look like _/Library/Application Support/Stata/ado/personal/_
3. Move the two files to this folder. 

## Running the code

See the help file for more information (_help retrodesign_). 

To give an illustration on how to use the code: assuming a hypothesized effect of 0.1 and a standard error of 3.28 (numbers from Gelman and Carlin's original article), you would type:
```
retrodesign, delta(0.1) s(3.28)
```

Users can change the critical alpha value (which matters a lot; default is 0.05) as well as the number of observations for the simulation (which matters less within reasonable bounds; default is 10,000).

The output generates the test's power, the Type-S error, and the Type-M exaggeration rate. 

## Author

* Michaël Aklin - [GitHub page](https://github.com/michaelaklin)

## Acknowledgments

The code was directly adapted from Gelman and Carlin, but all errors are mine. No warranty that the code will work as intended. 
