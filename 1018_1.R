install.packages("leaflet")
library(leaflet)

# leaflet 객체 보여지는 지도 설정과 오픈스트리트맵재단에서 제공하는 지도타일추가
m = leaflet() %>%
  setView(lng=126.996542, lat=37.5290615, zoom = 10) %>%
  addTiles()

m

# 지도 중심에 마커 클럭하는 방법
m = leaflet() %>%
  addTiles() %>%
  addMarkers(lng=126.996542, lat=37.5290615, label = "한국폴리텍대학", popup = "서울정수캠퍼스 인공지능")

m

# 오늘 내가 가볼 곳을 지도에 출력한 후 각 장소를 지도에 출력하고 장소이름을 라벨로 표시하고 전화번호(또는 주소)
# leaflet 객체 보여지는 지도 설정과 오픈스트리트맵재단에서 제공하는 지도타일추가
m = leaflet() %>%
  setView(lng=126.9882266, lat=37.5511694, zoom = 10) %>%
  addTiles()

m

# 지도 중심에 마커 클럭하는 방법
m = leaflet() %>%
  setView(lng=126.996542, lat=37.5290615, zoom = 10) %>%
  addTiles() %>%
  addMarkers(lng=126.9882266, lat=37.5511694, label = "N서울타워", popup = "N서울타워")%>%
  addMarkers(lng=126.9998129, lat=37.5528597, label = "국립극장", popup = "국립극장")

m

quakes

# quakes 데이터셋에 있는 경도, 위도 값을 사용하여 지도타일을 출력
m = leaflet(data=quakes)%>%
  addTiles()%>%
  addCircleMarkers(~long, ~lat, radius = ~mag, stroke = TRUE, weight = 1, color = "lightgray", fillColor = "red", fillOpacity = 0.3)
m

# magnitude(지진규모)의 크기가 6이상이면 반지름을 10으로 설정하고 6미만이면 반지름을 1로 설정한다.
m = leaflet(data=quakes) %>%
  addTiles() %>%
  addCircleMarkers(~long, ~lat, radius = ~ifelse(mag >= 6, 10, 1), stroke = TRUE, weight = 1, color = 'black', fillColor = "red", fillOpacity = 0.3)

m

# mag(지진규모)가 5.5이상이면 반지름을 10, 그렇지 않으면 0
# mag(지진규모)가 5.5이상이면 테두리선의 굵기를 1 그렇지 않으면 0
# mag(지진규모)가 5.5이상이면 불투명도를 0.3 그렇지 않으면 0 

m = leaflet(data=quakes) %>%
  addTiles() %>%
  addCircleMarkers(
    ~long, ~lat, 
    radius = ~ifelse(mag >= 5.5, 10, 0), 
    stroke = TRUE, 
    weight = ~ifelse(mag >= 5.5, 1, 0), 
    color = 'black', 
    fillColor = "lightgreen", 
    fillOpacity = ~ifelse(mag >= 5.5, 0.3, 0)
  )

m

# mag(지진규모)가 6이상이면 반지름을 10, 그렇지 않고 5.5이상이면 5, 그렇지 않으면 0
# mag(지진규모)가 5.5이상이면 테두리선의 굵기를 1 그렇지 않으면 0
# mag(지진규모)가 5.5이상이면 불투명도를 0.3 그렇지 않으면 0
# mag(지진규모)가 6이상이면 배경색을 red, 그렇지 않으면 5.5이상이면 green, 그렇지 않으면 색이없음(NA)
m = leaflet(data=quakes) %>%
  addTiles() %>%
  addCircleMarkers(
    ~long, ~lat, 
    radius = ~ifelse(mag >= 6, 10, ifelse(mag >= 5.5, 5, 0)), 
    stroke = TRUE, 
    weight = ~ifelse(mag >= 5.5, 1, 0), 
    color = 'black', 
    fillColor = ~ifelse(mag >= 6, "red", ifelse(mag >= 5.5, "green", NA)), 
    fillOpacity = ~ifelse(mag >= 5.5, 0.3, 0)
  )

m



# 행정경계 데이터셋을 사용한 지도 시각화
install.packages("ggplot2")
library(ggplot2)
install.packages("sf")
library(sf)

# 행정경계 데이터셋(shape[.shp] 파일) 읽어오기
df_map = st_read("D:/RScripts2024-2/Z_NGII_N3A_G0010000.shp")

ggplot(data = df_map) +
  geom_sf(fill="white", color="black")

# 행정경계의 지도(id)의 배경색을 다르게 지정
#id 설정
if(!"id"%in%names(df_map)){
  df_map$id = 1:nrow(df_map)
}


ggplot(data = df_map) +
  geom_sf(aes(fill=id),alpha=0.3, color="black")+
  theme(legend.position = "none")+
  labs(x="경도", y = "위도")

#지진분포를 지도로 출력
#데이터셋은 엑셀 파일로 읽어와서 사용

install.packages("openxlsx")
library(openxlsx)
df = read.xlsx("D:/RScripts2024-2/국내지진목록.xlsx")
head(df)

#x8 여렝서 북한으로 시작하는 데이터의 행번호 추출

idx = grep("^북한", df$X8)
#북한지역의 x8열의 데이터를 확인
df[idx, 'X8']

#X8열에 북한으로 시작하는 핼 삭제
df = df[-idx]

#데이타셋에 있는 6열과 7열의 데이터 중 N과 E를 삭제하는 방법
df[, 6] = gsub("N", "", df[, 6])
df[, 7] = gsub("E", "", df[, 7])


#6열과 7열의 값을 숫자형으로 변환
df[,6] = as.numeric(df[,6])
df[,7] = as.numeric(df[,7])