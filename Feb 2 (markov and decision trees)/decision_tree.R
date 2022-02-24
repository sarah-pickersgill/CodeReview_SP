
# from: https://www.datacamp.com/community/tutorials/decision-trees-R

library(ISLR)
library(tree)
data(package="ISLR")
carseats<-Carseats
names(carseats)

hist(carseats$Sales)
High = ifelse(carseats$Sales<=8, "No", "Yes")
carseats = data.frame(carseats, High)

require(tree)
tree.carseats = tree(High~.-Sales, data=carseats)
summary(tree.carseats)

plot(tree.carseats)
text(tree.carseats, pretty = 0)

## prune the tree and train the model on a subset of data
## 250 training samples an 150 test samples

set.seed(101)
train=sample(1:nrow(carseats), 250)

tree.carseats = tree(High~.-Sales, carseats, subset=train)
plot(tree.carseats)
text(tree.carseats, pretty=0)

#test
tree.pred = predict(tree.carseats, carseats[-train,], type="class")

#compare results -- diagonals (No/No and Yes/Yes) are correct predictions
err<-with(carseats[-train,], table(tree.pred, High))

#so our accuracy is:
(74 + 39) / 150

(err[1]+err[4])/sum(err)



