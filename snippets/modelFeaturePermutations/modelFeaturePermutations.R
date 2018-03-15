library(gtools)

# Here, list the targets and potential features of your model as characters
target = "Survived"
features = c("Age", "Sex", "SibSp", "Parch",
             "Pclass", "travellingAlone", "familySize", 
             "fareBucket", "ageBucket", "hasBracket",
             "hasNickname", "Embarked")

len = length(features)
combos = list() #Combos will be used to store the different combinations from gtools combinations()
formulaString = list() # This list will store the formula components glued together in a string

# This is where the magic happens. Probably not the most efficient but process only takes a second so not too bothered.
for (i in 1:len) {
  combos[[i]] = combinations(n = len, r = i, v = features)
  for (j in 1:nrow(combos[[i]])) {
    if(j == 1){
      formulaString[[i]] = paste(combos[[i]][j,],collapse=" + ")
    }else{
      formulaString[[i]][j] = paste(combos[[i]][j,],collapse=" + ")
    }
  }
  for (j in 1:nrow(combos[[i]])) {
      formulaString[[i]][j] = paste(target," ~ ",formulaString[[i]][j], sep = "")
  }
}

# The formulas list will hold the formatted formulas
formulas = vector(mode="list",length=1)

k = 1
for (i in 1:len) {
  for (j in 1:nrow(combos[[i]])) {
    formulas[[k]] = as.formula(formulaString[[i]][j])
    k = k + 1
  }
}

# Remove the unneeded variables from the R environment to prevent clashes
rm(len, combos, formulaString, target, features, i, j, k)