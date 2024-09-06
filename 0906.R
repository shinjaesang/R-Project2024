#2차원배열
x=1:10
arr = array(x, dim=c(2,3))
#배열은 설정된 행과 열의 개수로만 저장공간이 제공된다.
arr

#2차원배열 행과 열에 이름 지정
names = list(c("김판석", "이영호", "박나래"), c("수학", "영어"))
scores = c(88, 92, 95, 100, 97, 91)
arr = array(scores, dim = c(3,2), dimnames = names)#열은 3행 2열
arr

#특정 위치에 저장된 값을 변경
arr[3,2] = 100#3행 2열 값을 수정
arr

#1행의 데이터만 출력
arr[1,]

#1열의 데이터만 출력
arr[,1]

#특정 위치의 값만 출력
arr[3,1]

#===================
#행열(martix)
#행의 개수만 설정하면 열의 개수는 자동으로 저장할 데이터 만큼 설정된다.
x = 1:12
mtx = matrix(x, nrow = 3)
mtx

mtx = matrix(x, nrow = 2)
mtx

#행과 열의 이름 지정 데이터가 저장되는 순서를 행 우선으로 설정하는 방법
x = 1:6
names = list(c("김판석", "이영호"), c("수학", "영어", "국어"))
mtx = matrix(x, nrow = 2, dimnames = names)
mtx