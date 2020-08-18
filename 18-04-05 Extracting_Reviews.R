library(rvest)
library(XML)
library(magrittr)

# Amazon Reviews #############################
aurl <- "https://www.amazon.in/SoundBot-SB571-12W-Bluetooth-Speakers/product-reviews/B00MITLPX2/ref=cm_cr_othr_d_paging_btm_1?showViewpoints=1&pageNumber="
amazon_reviews <- NULL
for (i in 1:30){
  murl <- read_html(as.character(paste(aurl,i,sep="")))
  rev <- murl %>%
    html_nodes(".review-text") %>%
    html_text()
  amazon_reviews <- c(amazon_reviews,rev)
}
write.table(amazon_reviews,"bluetoothspeaker01.txt",row.names=FALSE)


# Snapdeal reviews #############################
surl_1 <- "https://www.snapdeal.com/product/samsung-j7-16gb-espresso-brown/661359071561/reviews?page="
surl_2 <- "&sortBy=HELPFUL#defRevPDP"
snapdeal_reviews <- NULL
for (i in 1:30){
  surl <- read_html(as.character(paste(surl_1,surl_2,sep=as.character(i))))
  srev <- surl %>%
    html_nodes("#defaultReviewsCard p") %>%
    html_text()
  snapdeal_reviews <- c(snapdeal_reviews,srev)
}

write.table(snapdeal_reviews,"samsung01.txt")
getwd()
# Sample urls 
# url  = http://www.amazon.in/product-reviews/B01LXMHNMQ/ref=cm_cr_getr_d_paging_btm_4?ie=UTF8&reviewerType=all_reviews&showViewpoints=1&sortBy=recent&pageNumber=1
# url = http://www.amazon.in/Moto-G5-GB-Fine-Gold/product-reviews/B01N7JUH7P/ref=cm_cr_getr_d_paging_btm_3?showViewpoints=1&pageNumber=1
# url = http://www.amazon.in/Honor-6X-Grey-32GB/product-reviews/B01FM7JGT6/ref=cm_cr_arp_d_paging_btm_3?showViewpoints=1&pageNumber=1

########## Extracting reviews from a travel website ###################
a<-5
rev<-NULL
url1<-"https://www.tripadvisor.in/Hotel_Review-g298570-d1759018-Reviews-or"
url2<-"-DoubleTree_by_Hilton_Hotel_Kuala_Lumpur-Kuala_Lumpur_Wilayah_Persekutuan.html"
for(i in 0:15){
  url<-read_html(as.character(paste(url1,i*a,url2,sep="")))
  ping<-url %>%
    html_nodes(".partial_entry") %>%
    html_text() 
  rev<-c(rev,ping)
}
write.table(rev,"travel18-06-08.txt", row.names = FALSE)
