library(plumber)
library(arules)
library(plyr)
library(dplyr)
tr <- read.transactions('C:/Users/mohamed/Desktop/SWE/Year 4/Graduation Project/market_basket_transactions.csv', format = 'basket', sep=',')
association.rules <- apriori(tr, parameter = list(supp=0.0001, conf=0.008,maxlen=10))
subset.rules <- which(colSums(is.subset(association.rules, association.rules)) > 1)
length(subset.rules)
subset.association.rules. <- association.rules[-subset.rules]
#* @param Product 
#* @param Supp 
#* @param Conf 
#* @post /getAssoc
function(Product,Supp,Conf){
  Rules<-apriori(tr,parameter = list(supp=as.numeric(Supp),conf=as.numeric(Conf)),appearance = list(lhs=Product,default="rhs"))
  inspect(Rules)
}
R<-plumb("MBA.R")
R$run(host = "0.0.0.0",port=8000)

