# LCMSdemo

Demo for the EBI metabolomics course. The package is designed to provide an interactive (and gentle) introduction to xcms. The majority of the demos is provided in form of `shiny` web applications, which rely on `plotly` to perform interactive plotting.


## Installation

* Depends on
```
xcms,CAMERA, ptw, scales, ggplot2, shiny, ggplot2, plotly, markdown
```

* Install devtools: in the R/RStudio shell type
```
install.packages("devtools")
```

* Install LCMSdemo: In the shell type
```
library(devtools)
install_github("pietrofranceschi/LCMSdemo", dependencies = TRUE) 
```

* Load the package: In shell type
```
library(LCMSdemo)
```
******

# Usage

The demo covers some of the key step in the preprocessing of untargeted metabolomics data by `xcms`.
The demo is not designe to be exhaustive, but it wants to highlight some of the ctucial points, focussing on the impact of some of the tunable parameters on the overall results. Even if it is clearly `xcms` oriented, many of the concepts and ideas are implemented behind the scees of many commercial closed source software solutions. 

The step covered in the demo include:

* Visualization and inspection of the raw LC-MS data
* Peak picking
* Grouping and Retention time alignment


#### Dataset
The data used for the demo are the results of a UPLC-QTOF(-) analysis of a set of apple extracts. The raw data and the description of the samples are availble @Metabolights (MTBLS59). Preprocessed data matrices are also included in the `BioMark` R package available @CRAN


*******

### Viaualization of the Raw Data
Each raw file (cdf,mzXML) contains the data recorded by the mass spectrometer during the analysis of **one** sample. The data are two dimensional in nature and it is always a good idea to get a feeling on their properties looking at them. 

#### Profile Matrix 
The profile matrix gives a two dimensional global overview of the raw data. In `xcms` the profile matrix is constructed by binning the spectrometer data along the m/z dimension. The size of the bins will have a strong impact on dimension of the profile matrix, with possible consequencies on the speed of the overall data preprocessing.
In the RStudio console the specific demo con be run with

```
shinyExample('profmat')
```

To stop the web based demo just close the window.

#### Extracted Ion Traces
As a general rule, the ionization of each metabolite will result in several ions (fragments, isotopes, adducts) and the "chromatographic" profile of each one of them will show a peak in correpondence of the elution time of the metabolite. These ion specific chromatographic profiles are called Extracted Ion Chromatograms/Traces (EIC/EIT) and they play a pivotal role in many preprocessing algorithm. In the ideal case the show a clean gaussian profile in correspondence of the meabolite peaks, but, unfortunately, many real-life profiles are far of being regular. This costitutes a clear challenge for any auomatic data analysis algorithm.

The package contains a shiny damo to visualize and inspect EICs. 

```
shinyExample('eic')
```

To stop the web based demo just close the window.

******

### Peak Picking





