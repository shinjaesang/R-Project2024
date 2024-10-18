install.packages("ggplot2")
install.packages("gganimate")
install.packages("readxl")
install.packages("dplyr")
install.packages("tidyr")

library(dplyr)
library(ggplot2)
library(gganimate)
library(readxl)
library(tidyr)

# 엑셀 파일 불러오기
data <- read_excel("C:/Users/AI509-18/Downloads/주.xls", sheet = 1)

head(data)

# 데이터 전처리: 긴 형식으로 변환
data_long <- data %>%
  pivot_longer(cols = -지역, names_to = "날짜", values_to = "미세먼지농도") %>%
  mutate(미세먼지농도 = as.numeric(미세먼지농도),
         날짜 = as.Date(날짜))


# 애니메이션 생성
animation <- ggplot(data_long, aes(x = 날짜, y = 미세먼지농도, color = 지역, group = 지역)) +
  geom_line(linewidth = 1) +
  geom_point(size = 2) +
  labs(title = '지역별 미세먼지 농도', x = '날짜', y = '미세먼지 농도') +
  theme_minimal() +
  transition_reveal(날짜) +
  ease_aes('linear')

# 애니메이션 출력
animate(animation, nframes = 100, fps = 10)

# 애니메이션을 파일로 저장
anim_save("미세먼지_농도_애니메이션.gif", path = "D:/RScripts2024-2")