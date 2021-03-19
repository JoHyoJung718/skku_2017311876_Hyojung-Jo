library(plyr)
library(stringr)

setwd("C://Temp")
txt <- readLines("미스터보스.txt")
txt

#감성분석 
#긍정어 부정어 가져오기
positive <- readLines("positive.txt", encoding = "UTF-8")
positive = positive[-1]

negative <- readLines("negative.txt", encoding = "UTF-8")
negative = negative[-1]

#긍 / 부정어 비교 함수

sentimental = function(sentences, positive, negative){
  scores = sapply(sentences, function(sentence, positive, negative){
    
    sentence = gsub('[[:punct:]]', '', sentence) #문장부호 제거
    sentence = gsub('[[:cntrl:]]', '', sentence)  #특수문자 제거
    sentence = gsub('\\d+', '', sentence)        #숫자 제거
    
    word.list = str_split(sentence, '\\s+') #공백을 기준으로 단어 생성
    words = unlist(word.list)
    
    pos.matches = match(words, positive)
    neg.matches = match(words, negative)
    
    pos.matches = !is.na(pos.matches)      #NA제거, 위치 추출
    neg.matches = !is.na(neg.matches)
    
    score = sum(pos.matches) - sum(neg.matches)
    return(score)
    
  }, positive, negative)
  
  scores.df = data.frame(score=scores, text=sentences)
  return(scores.df)
}


result$score
result = sentimental(txt, positive, negative)

result$remark[result$score >=1] = "긍정"
result$remark[result$score ==0] = "중립"
result$remark[result$score <0]  = "부정"

result$remark

final<-table(result$remark)

#리뷰점수 계산
(final[1]/sum(final)-final[2]/sum(final))*100
