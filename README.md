# LCMSdemo

Demo for the EBI metabolomics course. The package is designed to provide an interactive (and gentle) introduction to xcms. The majority of the demos is provided in form of `shiny` web applications, which rely on `plotly` to perform interactive plotting.


## Installation

* Depends on
```
xcms,CAMERA, ptw, scales, ggplot2, shiny, ggplot2, plotly, markdown
```

* Install devtools
In the R or RStudio shell type
```
install.packages("devtools")
```

* Install 
In the R or RStudio shell type
```
library(devtools)
install_github("pietrofranceschi/LCMSdemo", dependencies = TRUE) 
```

* Load the package 
In the R or RStudio shell type
```
library(LCMSdemo)
```





## Usage

The demo covers some of the key step of the preprocessing of untargeted metabolomics data by xcms.
The demo is not designe to be exhaustive, but it wants to highlight some of the ctucial steps, focussing on the impact of some of the tunable parameters on the overall results. 

The step covered in the demo include:

* Visualization and inspection of the raw LC-MS data
* Peak picking
* Grouping and Retention time alignment


### Dataset
The data used for the demo are the results of a UPLC-QTOF(-) analysis of a set of apple extracts. The raw data and the description of the samples are availble @Metabolights (MTBLS59). Preprocessed data matrices are also included in the `BioMark` R package available @CRAN

## Viaualization of the Raw Data








