# 从大连商品交易所网站抓取价格数据 数据源
# http://www.dce.com.cn/PublicWeb/MainServlet?action=Pu00011_search
# Pu00011_Input.trade_date ： 查询的日期 
# Pu00011_Input.trade_type ： 行情类别   0为期货，1为期权（未开通） 
# Pu00011_Input.variety ：期货品种代码，各代码表示的期货品种： 
#  all : 全部 a ： 豆一 b ： 豆二 c ： 玉米 j ：焦炭 l： 聚乙烯 
#  m ： 豆粕 p ： 棕榈油 v ： 聚氯乙烯 y ： 豆油 s ： 大豆


getDceData <- function(dates, contracts, keep.dataFile = T) {  
  dceDatabase <- data.frame()  
  for (date in dates) {
    for (type in contracts) {
      
      str1 <- "http://www.dce.com.cn/PublicWeb/MainServlet?Pu00011_Input.trade_date="
      str2 <- "&Pu00011_Input.trade_type=0&Pu00011_Input.variety="
      str3 <- "&action=Pu00012_download"
      
      url <- paste(str1, date, str2, type, str3, sep = "")
      fileName <- paste("dce.", type, date, ".txt", sep = "")
      lines <- readLines(url)
      # 如果使用的是linux系统，就转换lines的编码
      if (sessionInfo()$R.version$os == "linux-gnu") {
        lines <- iconv(lines, from = "gb2312", to = "UTF-8")
      }
      # 当输入的日期不是交易日或数据文件里合约数据为空时跳过本次循环
      if (any(lines == "<html>") | length(lines) == 5) {
        next
      } else {
        content <- lines[4:(length(lines) - 2)]
        writeLines(content, fileName)
        data <- read.table(fileName, header = T, na.strings = "-")
        if (!keep.dataFile) {
          file.remove(fileName)
        }
        data$date <- date 
        dceDatabase <- rbind(dceDatabase, data)
      }
    }
  }
  return(dceDatabase)
}
 
