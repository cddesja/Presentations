trim <- function(x,tr=.1){
    y=sort(x)
    n=length(x)
    qlow=quantile(y,probs=tr,na.rm=T)
    qhigh=quantile(y,probs=1-tr,na.rm=T)
    y=subset(y,y > qlow & y < qhigh)
    trim=mean(y)
    output <- list(samp.size = n, untrimmed = mean(x), adj.mean = trim, trim.value = tr)
    class(output) <- "funMeans"
    return(output)
} 

summary.funMeans <- function(object, ...){
      cat("\n Adjusted Mean\n")
      print(object$adj.mean)
      cat("\n Trimming Value - ", object$trim.value)
      cat("\n Untrimmed Mean - ", object$untrimmed)
      cat("\n Sample size - ", object$samp.size,"\n")
  }
