library(XML)

# for 2013
for (i in 1:16){
  theurl <- paste0("http://www.fin.gov.on.ca/en/publications/salarydisclosure/pssd/orgs.php?year=2013&organization=universities&page=", i)
  tables <- readHTMLTable(theurl)
  n.rows <- unlist(lapply(tables, function(t) dim(t)[1]))
  tables[[which.max(n.rows)]]
  write.csv(x = tables, file = file.path(getwd(), "Inputs", "Salary Disclosure by year", "2013", paste0("page ", i, ".csv")))
}

# for 2012
for (i in 1:15){
  theurl <- paste0("http://www.fin.gov.on.ca/en/publications/salarydisclosure/pssd/orgs.php?year=2012&organization=universities&page=", i)
  tables <- readHTMLTable(theurl)
  n.rows <- unlist(lapply(tables, function(t) dim(t)[1]))
  tables[[which.max(n.rows)]]
  write.csv(x = tables, file = file.path(getwd(), "Inputs", "Salary Disclosure by year", "2012", paste0("page ", i, ".csv")))
}


# for 2011
v = c("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l")

for (i in 1:12){
  theurl <- paste0("http://www.fin.gov.on.ca/en/publications/salarydisclosure/2012/univer12", v[i], ".html")
  tables <- readHTMLTable(theurl)
  n.rows <- unlist(lapply(tables, function(t) dim(t)[1]))
  tables[[which.max(n.rows)]]
  write.csv(x = tables, file = file.path(getwd(), "Inputs", "Salary Disclosure by year", "2011", paste0("page ", i, ".csv")))
}

# for 2010
v = c("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l")

for (i in 1:2){
  theurl <- paste0("http://www.fin.gov.on.ca/en/publications/salarydisclosure/2011/univer11", v[i], ".html")
  tables <- readHTMLTable(theurl)
  n.rows <- unlist(lapply(tables, function(t) dim(t)[1]))
  tables[[which.max(n.rows)]]
  write.csv(x = tables, file = file.path(getwd(), "Inputs", "Salary Disclosure by year", "2010", paste0("page ", i, ".csv")))
}



# for 2009
v = c("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l")

for (i in 1:2){
  theurl <- paste0("http://www.fin.gov.on.ca/en/publications/salarydisclosure/2010/univer10", v[i], ".html")
  tables <- readHTMLTable(theurl)
  n.rows <- unlist(lapply(tables, function(t) dim(t)[1]))
  tables[[which.max(n.rows)]]
  write.csv(x = tables, file = file.path(getwd(), "Inputs", "Salary Disclosure by year", "2009", paste0("page ", i, ".csv")))
}