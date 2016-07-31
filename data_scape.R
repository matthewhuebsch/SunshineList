library(XML)

# for 2013
for (i in 1:16){
  theurl <- paste0("http://www.fin.gov.on.ca/en/publications/salarydisclosure/pssd/orgs.php?year=2013&organization=universities&page=", i)
  tables <- readHTMLTable(theurl)
  n.rows <- unlist(lapply(tables, function(t) dim(t)[1]))
  tables[[which.max(n.rows)]]
  names(tables[[1]]) = c("Employer", "Last.name", "First.name", "Job.title", "Salary.Paid", "Taxable.Benefits")
  tables[[1]]$Calendar.Year = 2013
  tables[[1]]$Sector = "Universities"
  write.csv(x = tables[[1]], file = file.path(getwd(), "Inputs", "Salary Disclosure by year", "2013", paste0("page ", i, ".csv")))
}

filenames = list.files(file.path(getwd(), "Inputs", "Salary Disclosure by year", "2013"), full.names = TRUE)
bound_file = do.call("rbind", lapply(filenames, read.csv, header=TRUE))
write.csv(x = bound_file, file = file.path(getwd(), "Inputs", "Salary Disclosure by year", "Curated Data", "2013", "merged_file.csv"))

# for 2012
for (i in 1:15){
  theurl <- paste0("http://www.fin.gov.on.ca/en/publications/salarydisclosure/pssd/orgs.php?year=2012&organization=universities&page=", i)
  tables <- readHTMLTable(theurl)
  n.rows <- unlist(lapply(tables, function(t) dim(t)[1]))
  tables[[which.max(n.rows)]]
  names(tables[[1]]) = c("Employer", "Last.name", "First.name", "Job.title", "Salary.Paid", "Taxable.Benefits")
  tables[[1]]$Calendar.Year = 2012
  tables[[1]]$Sector = "Universities"
  write.csv(x = tables[[1]], file = file.path(getwd(), "Inputs", "Salary Disclosure by year", "2012", paste0("page ", i, ".csv")))
}

filenames = list.files(file.path(getwd(), "Inputs", "Salary Disclosure by year", "2012"), full.names = TRUE)
bound_file = do.call("rbind", lapply(filenames, read.csv, header=TRUE))
write.csv(x = bound_file, file = file.path(getwd(), "Inputs", "Salary Disclosure by year", "Curated Data", "2012", "merged_file.csv"))



# for 2011
v = c("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l")

for (i in 1:12){
  theurl <- paste0("http://www.fin.gov.on.ca/en/publications/salarydisclosure/2012/univer12", v[i], ".html")
  tables <- readHTMLTable(theurl)
  n.rows <- unlist(lapply(tables, function(t) dim(t)[1]))
  tables[[which.max(n.rows)]]
  names(tables[[1]]) = c("Employer", "Last.name", "First.name", "Job.title", "Salary.Paid", "Taxable.Benefits")
  tables[[1]]$Calendar.Year = 2011
  tables[[1]]$Sector = "Universities"
  write.csv(x = tables[[1]], file = file.path(getwd(), "Inputs", "Salary Disclosure by year", "2011", paste0("page ", i, ".csv")))
}

filenames = list.files(file.path(getwd(), "Inputs", "Salary Disclosure by year", "2011"), full.names = TRUE)
bound_file = do.call("rbind", lapply(filenames, read.csv, header=TRUE))
write.csv(x = bound_file, file = file.path(getwd(), "Inputs", "Salary Disclosure by year", "Curated Data", "2011", "merged_file.csv"))



# for 2010
v = c("a", "b")

for (i in 1:2){
  theurl <- paste0("http://www.fin.gov.on.ca/en/publications/salarydisclosure/2011/univer11", v[i], ".html")
  tables <- readHTMLTable(theurl)
  n.rows <- unlist(lapply(tables, function(t) dim(t)[1]))
  tables[[which.max(n.rows)]]
  names(tables[[1]]) = c("Employer", "Last.name", "First.name", "Job.title", "Salary.Paid", "Taxable.Benefits")
  tables[[1]]$Calendar.Year = 2010
  tables[[1]]$Sector = "Universities"
  write.csv(x = tables[[1]], file = file.path(getwd(), "Inputs", "Salary Disclosure by year", "2010", paste0("page ", i, ".csv")))
}

filenames = list.files(file.path(getwd(), "Inputs", "Salary Disclosure by year", "2010"), full.names = TRUE)
bound_file = do.call("rbind", lapply(filenames, read.csv, header=TRUE))
write.csv(x = bound_file, file = file.path(getwd(), "Inputs", "Salary Disclosure by year", "Curated Data", "2010", "merged_file.csv"))





# for 2009
v = c("a", "b")

for (i in 1:2){
  theurl <- paste0("http://www.fin.gov.on.ca/en/publications/salarydisclosure/2010/univer10", v[i], ".html")
  tables <- readHTMLTable(theurl)
  n.rows <- unlist(lapply(tables, function(t) dim(t)[1]))
  tables[[which.max(n.rows)]]
  names(tables[[1]]) = c("Employer", "Last.name", "First.name", "Job.title", "Salary.Paid", "Taxable.Benefits")
  tables[[1]]$Calendar.Year = 2009
  tables[[1]]$Sector = "Universities"
  write.csv(x = tables[[1]], file = file.path(getwd(), "Inputs", "Salary Disclosure by year", "2009", paste0("page ", i, ".csv")))
}

filenames = list.files(file.path(getwd(), "Inputs", "Salary Disclosure by year", "2009"), full.names = TRUE)
bound_file = do.call("rbind", lapply(filenames, read.csv, header=TRUE))
write.csv(x = bound_file, file = file.path(getwd(), "Inputs", "Salary Disclosure by year", "Curated Data", "2009", "merged_file.csv"))



