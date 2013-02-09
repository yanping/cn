# cntrade R语言版 
# 作者：陈堰平（新华指数有限责任公司，chen@yanping.me） 
# 使用网易股票数据接口 原stata版的作者为：
#   李春涛（中南财经政法大学，chtl@znufe.edu.cn） 
#   张璇（中南财经政法大学，zhangx@znufe.edu.cn） 
# example: 
#   cntrade(c('600000', '000008'), path ='D:/stockprice', start = '20010104', end = '20120124')

cntrade <- function(tickers, path = "", start = "19910101", end = "") {
  
  address <- "http://quotes.money.163.com/service/chddata.html"
  field <- "&fields=TCLOSE;HIGH;LOW;TOPEN;LCLOSE;CHG;PCHG;TURNOVER;VOTURNOVER;VATURNOVER;TCAP;MCAP"
  
  if (path == "") {
    path <- getwd()
  }
  
  if (!file.exists(path)) {
    dir.create(path)
  }
  
  if (substr(path, nchar(path), nchar(path)) != "/") {
    path <- paste(path, "/", sep = "")
  }
  
  if (end == "") {
    year <- substr(Sys.time(), 1, 4)
    month <- substr(Sys.time(), 6, 7)
    day <- substr(Sys.time(), 9, 10)
    end <- paste(year, month, day, sep = "")
  }
  
  count <- 0
  for (name in tickers) {
    while (nchar(name) < 6) {
      name <- paste("0", name, sep = "")
    }
    
    if (nchar(name) > 6) {
      warning(paste("invalid stock code: ", name, sep = ""))
      next
    }
    
    if (as.numeric(name) > 600000) {
      url <- paste(address, "?code=0", name, "&start=", start, "&end=", end, field, sep = "")
    } else {
      url <- paste(address, "?code=1", name, "&start=", start, "&end=", end, field, sep = "")
    }
    destfile <- paste(path, name, ".csv", sep = "")
    download.file(url, destfile, quiet = TRUE)
    count <- count + 1
  }
  
  if (count == 0) {
    cat("一个数据文件都没下载下来！\n")
  } else {
    cat("数据下载完成！\n")
    cat(paste("共下载", count, "个文件\n", sep = ""))
  }
} 
