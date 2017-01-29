### Retention time correction
Time warping is a possible alternative to perform retention time correction. The major difference with the "density based" approach is that the best correction is found taking into account the overall profile of the signal instead of a limited number of hook groups. The implementation of the idea is, as usual, not obvious. Here we are processing 52 LC-MS TICs.

Some question to orient your discussion ...

* What is the meaning of the plot?
* What is the effect of increasing the flexibility of the algorithm? Is the situation always improving?
* LC-MS data are indeed two dimensional so what should one warp? The TIC? The EICs? The overall 2D matrix?
