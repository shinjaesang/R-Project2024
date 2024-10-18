install.packages("ggplot2")
install.packages("gganimate")
install.packages("readxl")

install.packages("dplyr")

library(dplyr)


library(ggplot2)
library(gganimate)
library(readxl)

# 엑셀 파일 불러오기
data <- read_excel("C:/Users/AI509-18/Downloads/당일.xls", sheet = 1)

head(data)

install.packages("ggplot2") 
library(ggplot2)             

#시간평균
# 필요한 열만 선택
filtered_data <- data %>% select(지역, 시간평균)

# 시간평균을 숫자로 변환 (문자형일 경우 변환)
filtered_data$시간평균 <- as.numeric(filtered_data$시간평균)

# 막대그래프 그리기
ggplot(filtered_data, aes(x = 지역, y = 시간평균)) + 
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "지역별 시간평균", x = "지역", y = "시간평균") +
  theme_minimal()

#일평균
# 필요한 열만 선택
filtered_data2 <- data %>% select(지역, 일평균)

filtered_data2$일평균 <- as.numeric(filtered_data2$일평균)

# 막대그래프 그리기
ggplot(filtered_data2, aes(x = 지역, y = 일평균)) + 
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "지역별 일평균", x = "지역", y = "일평균") +
  theme_minimal()



# 시간평균과 일평균을 포함하는 데이터 프레임 결합
filtered_data <- data %>%
  select(지역, 시간평균) %>%
  mutate(유형 = "시간평균")

filtered_data2 <- data %>%
  select(지역, 일평균) %>%
  mutate(유형 = "일평균")

filtered_data2 <- filtered_data2 %>%
  rename(시간평균 = 일평균)

combined_data <- rbind(filtered_data, filtered_data2)

# 필요한 열의 타입 변환
# 필요한 열의 타입 변환
combined_data$시간평균 <- as.numeric(combined_data$시간평균)

# ggplot을 사용하여 애니메이션 생성
animated_plot <- ggplot(combined_data, aes(x = 지역, y = 시간평균, fill = 유형)) +
  geom_bar(stat = "identity") +
  labs(title = "지역별 시간평균 및 일평균", x = "지역", y = "값") +
  scale_fill_manual(values = c("시간평균" = "steelblue", "일평균" = "orange")) +
  theme_minimal() +
  transition_states(유형, transition_length = 2, state_length = 1) +
  enter_fade() +
  exit_fade() +
  ease_aes('linear')

# 애니메이션 출력
animate(animated_plot, nframes = 30, duration = 6, fps = 10)

# 애니메이션을 파일로 저장
anim_save("지역별_시간평균_일평균 애니메이션.gif", path = "D:/RScripts2024-2")