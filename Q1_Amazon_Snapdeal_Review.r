###Question no 1 - 1) Extract reviews of any product from ecommerce website like snapdeal and amazon
install.packages("rvest")
install.packages("XML")
install.packages("magrittr")
##
library(rvest)
library(XML)
library(magrittr)

###### Amazon Reviews - washing macnine #############################
aurl <- "https://www.amazon.in/Samsung-Fully-Automatic-WA62M4100HY-TL-Imperial/product-reviews/B0747XV38N/ref=cm_cr_othr_d_paging_btm_1?showViewpoints=1&pageNumber="
amazon_reviews <- NULL
for (i in 1:30){
  murl <- read_html(as.character(paste(aurl,i,sep="")))
  rev <- murl %>%
    html_nodes(".review-text") %>%
    html_text()
  amazon_reviews <- c(amazon_reviews,rev)
}
write.table(amazon_reviews,"Samsung_Washing_Machine.txt",row.names=FALSE)
getwd()

# Snapdeal reviews ### WAashing machine cover#### from snap deal
surl_1 <- "https://www.snapdeal.com/product/eretailer-single-pvc-5kg-to/672058046051/reviews?page="
surl_2 <- "&sortBy=HELPFUL#defRevPDP"
snapdeal_reviews <- NULL
for (i in 1:30){
  surl <- read_html(as.character(paste(surl_1,surl_2,sep=as.character(i))))
  srev <- surl %>%
    html_nodes("#defaultReviewsCard p") %>%
    html_text()
  snapdeal_reviews <- c(snapdeal_reviews,srev)
}

write.table(snapdeal_reviews,"Washing_Machine_Cover.txt")
getwd()
