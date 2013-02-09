# 从复旦人民币汇率指数网站读取数据 http://ifsfd.fudan.edu.cn/fdurmb/indexchart1.jsp
# 更多细节请看 http://cos.name/cn/topic/109132
 
require(RCurl)
require(rjson)
 
fdjson <- getURL("http://ifsfd.fudan.edu.cn/fdurmb/data?type=0%2C1%2C2&df=2012%2F12%2F12&dt=2013%2F02%2F10")
fdlist <- fromJSON(fdjson)
fdm <- matrix(unlist(fdlist),ncol=4,byrow=T)
fddf <- data.frame(fdm, stringsAsFactors = F)
fddf[,2:4] <- sapply(fddf[,2:4],as.numeric)
colnames(fddf) <- c("date","人民币名义有效汇率指数","人民币实际有效汇率指数","人民币盯住一篮子货币模拟汇率指数")
write.csv(fddf,"fudan.csv",row.names = F )

