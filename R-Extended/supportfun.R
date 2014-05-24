# load and modify 'R Extended.tmLanguage'
require(jsonlite)

library(data.table)
library(ggplot2)
filter = function(l){
    ind = grep("^[a-zA-Z\\._]+$", l)
    l[ind]
}
getfuns = function(pkg){
    filter(ls(pattern="*", paste0("package:",pkg)))
}
getregexp = function(pkg){
    s = fromJSON("supportfun.json")
    content = paste0(sub("\\.","\\\\.",getfuns(pkg)),collapse="|")
    s$begin = paste0("\\b(", content, ")\\s*(\\()")
    s
}

packages = c("base", "stats", "methods", "utils", 
    "graphics", "grDevices", "data.table", "ggplot2")

m = fromJSON("R Extended.JSON-tmLanguage")
m$repository$support_function$patterns = lapply(packages, getregexp)
cat(toJSON(m, pretty=T), file="R Extended.JSON-tmLanguage")