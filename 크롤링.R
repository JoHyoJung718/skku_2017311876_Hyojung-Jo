install.packages("XML", "stringr")
library(XML)
library(stringr)

all_reviews <- NULL
url_base <- "https://movie.naver.com/movie/bi/mi/pointWriteFormList.nhn?code=200180&type=after&onlyActualPointYn=N&onlySpoilerPointYn=N&order=newest&page="

#페이지 읽기
for(i in 8:18){
  newr <- NULL
  url <-paste(url_base, i ,sep='')
  txt <- readLines(url, encoding="UTF-8")
  
  reviews <- txt[which(str_detect(txt, "id=\"_filtered_ment"))+4]
  reviews <- gsub("<.+?>|\t","",reviews)
  
  newr <- cbind(reviews)
  all_reviews <- rbind(all_reviews, newr)
}

write.table(all_reviews, "C:\\Temp\\movie_review1.txt")
