
install.packages("stringr")
install.packages("utils")

library(stringr)
library(utils)

Amazon = function(url,        # first click on show all or top review
                    n )       # Number of pages to extarct
  
{           
  
  text_page=character(0)   # define blank file
  
  #pb <- txtProgressBar()    # define progress bar
  
  for(i in 1:n){           # loop for url
    
    text = readLines(as.character(paste(url,i,sep="")))     # Read URL       
    
    text_start = grep("a-size-base review-text",text)   # review start marker
    
    text_stop = grep("a-row a-expander-container a-expander-inline-container", text)  # review end marker
    
    
    #setTxtProgressBar(pb, i)             # print progress bar
    
    if (length(text_start) == 0) break    # check for loop termination, i.e valid page found      
    
    for(j in 1:length(text_start))        # Consolidate all reviews     
    {
      text_temp = paste(paste(text[(text_start[j]+1):(text_stop[j])]),collapse=" ")
      text_page = c(text_page,text_temp)
    }
    #Sys.sleep(1)
  }
  
  text_page =gsub("<.*?>", "", text_page)       # regex for Removing HTML character 
  text_page = gsub("^\\s+|\\s+$", "", text_page) # regex for removing leading and trailing white space
  return(text_page)       # return reviews
}

url = "http://www.amazon.in/Apple-MMGF2HN-13-3-inch-Integrated-Graphics/product-reviews/B01FUK9TKG/ref=cm_cr_arp_d_paging_btm_2?showViewpoints=1&pageNumber="
Hp = Amazon (url,5)
length(Hp)
getwd()
Hp1 <- as.data.frame(Hp)
Hp2 <- write.table(Hp, 'iphone.txt')
write.csv(Hp,"Hp.csv")
getwd()

# Sample urls 
# url  = http://www.amazon.in/product-reviews/B01LXMHNMQ/ref=cm_cr_getr_d_paging_btm_4?ie=UTF8&reviewerType=all_reviews&showViewpoints=1&sortBy=recent&pageNumber=1
# url = http://www.amazon.in/Moto-G5-GB-Fine-Gold/product-reviews/B01N7JUH7P/ref=cm_cr_getr_d_paging_btm_3?showViewpoints=1&pageNumber=1
# url = http://www.amazon.in/Honor-6X-Grey-32GB/product-reviews/B01FM7JGT6/ref=cm_cr_arp_d_paging_btm_3?showViewpoints=1&pageNumber=1