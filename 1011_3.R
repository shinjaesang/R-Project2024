# 필요한 패키지 설치
install.packages("ggplot2")
install.packages("gganimate")
install.packages("readxl")
install.packages("dplyr")
install.packages("tidyr")

# 패키지 로드
library(dplyr)
library(ggplot2)
library(gganimate)
library(readxl)
library(tidyr)

# 엑셀 파일 불러오기
data <- read_excel("C:/Users/AI509-18/Downloads/기상정보.xls", sheet = 1)

head(data)

# 필요한 데이터 선택 및 전처리
data <- data %>%
  select(지점명, 일시, `기온(°C)`) %>%
  mutate(일시 = as.POSIXct(일시))  


# 꺾은선 그래프 애니메이션 생성
p <- ggplot(data, aes(x = 일시, y = `기온(°C)`, color = 지점명, group = 지점명)) +
  geom_line(size = 1) +   # 꺾은선 그래프
  labs(title = '시간에 따른 기온 변화: {frame_time}', 
       x = '일시', 
       y = '기온(°C)', 
       color = '지역') +
  theme_minimal() +
  transition_reveal(일시)  # 시간이 흐를수록 그래프가 그려지도록 설정

# 애니메이션 출력
animate(p, nframes = 200, fps = 20)

# 애니메이션을 파일로 저장
anim_save("기상정보_애니메이션.gif", path = "D:/RScripts2024-2")