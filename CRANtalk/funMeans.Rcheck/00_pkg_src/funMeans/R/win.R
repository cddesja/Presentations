win<-function(x,tr=.2){
   y<-sort(x)
   n<-length(x)
   ibot<-floor(tr*n)+1
   itop<-length(x)-ibot+1
   xbot<-y[ibot]
   xtop<-y[itop]
   y<-ifelse(y<=xbot,xbot,y)
   y<-ifelse(y>=xtop,xtop,y)
   win<-mean(y)
   output <- list(samp.size = n, untrimmed = mean(x),
                  adj.mean = win, trim.value = tr)
    class(output) <- "funMeans"
    return(output)
}
