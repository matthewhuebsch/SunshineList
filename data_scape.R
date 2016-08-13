library(XML)
########## IMPORTER FUNCTIONS ##########
Importer2012to2013 = function(sector_import, year_import, total_pages){
  for (i in 1:total_pages){
    theurl <- paste0("http://www.fin.gov.on.ca/en/publications/salarydisclosure/pssd/orgs.php?year=", year_import, "&organization=", sector_import, "&page=", i)
    tables <- readHTMLTable(theurl)
    n.rows <- unlist(lapply(tables, function(t) dim(t)[1]))
    tables[[which.max(n.rows)]]
    names(tables[[1]]) = c("Employer", "Last.name", "First.name", "Job.title", "Salary.Paid", "Taxable.Benefits")
    tables[[1]]$Calendar.Year = year_import
    tables[[1]]$Sector = sector_import
    write.csv(x = tables[[1]], file = file.path(getwd(), "Inputs", "Salary Disclosure by year", year_import, sector_import, paste0("page ", i, ".csv")))
  }
  filenames = list.files(file.path(getwd(), "Inputs", "Salary Disclosure by year", year_import, sector_import), full.names = TRUE)
  bound_file = do.call("rbind", lapply(filenames, read.csv, header=TRUE))
  write.csv(x = bound_file, file = file.path(getwd(), "Inputs", "Salary Disclosure by year", "Curated Data", year_import, paste0(sector_import, "_merged_file.csv")))
}
Importer2009to2011 = function(sector_import, year_import, total_pages){
  v = c("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p")
  year_import_link = year_import + 1  # have to plus one year due to inconsistency in how they reported years pre-2012 (idiots)
  short_year_link = substr(year_import_link, 3, 4)
  if(sector_import == "Universities"){
    short_sector_import = "univer"
  }
  for (i in 1:total_pages){
    theurl <- paste0("http://www.fin.gov.on.ca/en/publications/salarydisclosure/", year_import_link, "/", short_sector_import, short_year_link, v[i], ".html")
    print(theurl)
    tables <- readHTMLTable(theurl)
    n.rows <- unlist(lapply(tables, function(t) dim(t)[1]))
    tables[[which.max(n.rows)]]
    names(tables[[1]]) = c("Employer", "Last.name", "First.name", "Job.title", "Salary.Paid", "Taxable.Benefits")
    tables[[1]]$Calendar.Year = year_import
    tables[[1]]$Sector = sector_import
    write.csv(x = tables[[1]], file = file.path(getwd(), "Inputs", "Salary Disclosure by year", year_import, sector_import, paste0("page ", i, ".csv")))
  }
  
  filenames = list.files(file.path(getwd(), "Inputs", "Salary Disclosure by year", year_import, sector_import), full.names = TRUE)
  bound_file = do.call("rbind", lapply(filenames, read.csv, header=TRUE))
  write.csv(x = bound_file, file = file.path(getwd(), "Inputs", "Salary Disclosure by year", "Curated Data", year_import, paste0(sector_import, "_merged_file.csv")))
  
}

########## CREATE EMPTY FOLDER STRUCTURE ##########
# TODO: fill this in


########## DOWNLOAD FILES - 2013 #######

Importer2012to2013(sector_import = "Universities", year_import = 2013, total_pages = 16)
Importer2012to2013(sector_import = "Hospitals", year_import = 2013, total_pages = 10)

########## DOWNLOAD FILES - 2012 #######
Importer2012to2013(sector_import = "Universities", year_import = 2012, total_pages = 15)
Importer2012to2013(sector_import = "Hospitals", year_import = 2012, total_pages = 9)


########## DOWNLOAD FILES - 2011 #######
Importer2009to2011(sector_import = "Universities", year_import = 2011, total_pages = 12)

########## DOWNLOAD FILES - 2010 #######
Importer2009to2011(sector_import = "Universities", year_import = 2010, total_pages = 2)


########## DOWNLOAD FILES - 2009 #######
Importer2009to2011(sector_import = "Universities", year_import = 2009, total_pages = 2)


########## BIND THEM ALL TOGETHER ###########
years = seq(2009, 2015, by=1)
for(i in 1:length(years)){
  filenames = list.files(file.path(getwd(), "Inputs", "Salary Disclosure by year", "Curated Data", years[i]), full.names = TRUE, pattern = "merged")
  bound_file = do.call("rbind", lapply(filenames, read.csv, header=TRUE))
  write.csv(x = bound_file, file = file.path(getwd(), "Inputs", "Salary Disclosure by year", "Curated Data", years[i], "total_file.csv"))
}


if(F){
# for 2011
v = c("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l")

for (i in 1:12){
  theurl <- paste0("http://www.fin.gov.on.ca/en/publications/salarydisclosure/2012/univer12", v[i], ".html")
  tables <- readHTMLTable(theurl)
  n.rows <- unlist(lapply(tables, function(t) dim(t)[1]))
  tables[[which.max(n.rows)]]
  names(tables[[1]]) = c("Employer", "Last.name", "First.name", "Job.title", "Salary.Paid", "Taxable.Benefits")
  tables[[1]]$Calendar.Year = 2011
  tables[[1]]$Sector = sector_import
  write.csv(x = tables[[1]], file = file.path(getwd(), "Inputs", "Salary Disclosure by year", "2011", paste0("page ", i, ".csv")))
}

filenames = list.files(file.path(getwd(), "Inputs", "Salary Disclosure by year", "2011"), full.names = TRUE)
bound_file = do.call("rbind", lapply(filenames, read.csv, header=TRUE))
write.csv(x = bound_file, file = file.path(getwd(), "Inputs", "Salary Disclosure by year", "Curated Data", "2013", paste0(sector_import, "_merged_file.csv")))



# for 2010
v = c("a", "b")

for (i in 1:2){
  theurl <- paste0("http://www.fin.gov.on.ca/en/publications/salarydisclosure/2011/univer11", v[i], ".html")
  tables <- readHTMLTable(theurl)
  n.rows <- unlist(lapply(tables, function(t) dim(t)[1]))
  tables[[which.max(n.rows)]]
  names(tables[[1]]) = c("Employer", "Last.name", "First.name", "Job.title", "Salary.Paid", "Taxable.Benefits")
  tables[[1]]$Calendar.Year = 2010
  tables[[1]]$Sector = sector_import
  write.csv(x = tables[[1]], file = file.path(getwd(), "Inputs", "Salary Disclosure by year", "2010", paste0("page ", i, ".csv")))
}

filenames = list.files(file.path(getwd(), "Inputs", "Salary Disclosure by year", "2010"), full.names = TRUE)
bound_file = do.call("rbind", lapply(filenames, read.csv, header=TRUE))
write.csv(x = bound_file, file = file.path(getwd(), "Inputs", "Salary Disclosure by year", "Curated Data", "2013", paste0(sector_import, "_merged_file.csv")))




# for 2009
v = c("a", "b")

for (i in 1:2){
  theurl <- paste0("http://www.fin.gov.on.ca/en/publications/salarydisclosure/2010/univer10", v[i], ".html")
  tables <- readHTMLTable(theurl)
  n.rows <- unlist(lapply(tables, function(t) dim(t)[1]))
  tables[[which.max(n.rows)]]
  names(tables[[1]]) = c("Employer", "Last.name", "First.name", "Job.title", "Salary.Paid", "Taxable.Benefits")
  tables[[1]]$Calendar.Year = 2009
  tables[[1]]$Sector = sector_import
  write.csv(x = tables[[1]], file = file.path(getwd(), "Inputs", "Salary Disclosure by year", "2009", paste0("page ", i, ".csv")))
}

filenames = list.files(file.path(getwd(), "Inputs", "Salary Disclosure by year", "2009"), full.names = TRUE)
bound_file = do.call("rbind", lapply(filenames, read.csv, header=TRUE))
write.csv(x = bound_file, file = file.path(getwd(), "Inputs", "Salary Disclosure by year", "Curated Data", "2013", paste0(sector_import, "_merged_file.csv")))

}