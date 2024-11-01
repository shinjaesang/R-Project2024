library(rvest)

url = "https://www.epeople.go.kr/nep/prpsl/opnPrpl/opnpblPrpslList.npaid"
html = read_html(url)
html

titles = html_nodes(html, ".left") %>%
  html_text()

titles

# 특수 문자를 ""(empty string) 대체
titles = gsub("\r|\n|\t", "", titles)
titles
