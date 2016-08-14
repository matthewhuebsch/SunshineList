library(XML)
########## IMPORTER FUNCTIONS ##########
Importer2012to2013 = function(sector_import, year_import, total_pages){
  for (i in 1:total_pages){
    theurl <- paste0("http://www.fin.gov.on.ca/en/publications/salarydisclosure/pssd/orgs.php?year=", year_import, "&organization=", sector_import, "&page=", i)
    print(theurl)
    tables <- readHTMLTable(theurl)
    n.rows <- unlist(lapply(tables, function(t) dim(t)[1]))
    tables[[which.max(n.rows)]]
    names(tables[[1]]) = c("Employer", "Last.name", "First.name", "Job.title", "Salary.Paid", "Taxable.Benefits")
    tables[[1]]$Calendar.Year = year_import
    tables[[1]]$Sector = sector_import
    if(!dir.exists(file.path(getwd(), "Inputs", "Salary Disclosure by year", year_import, sector_import))){
     dir.create(file.path(getwd(), "Inputs", "Salary Disclosure by year", year_import, sector_import)) 
    }
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
  if(sector_import == "Electricity"){
    short_sector_import = "electric"
  }
  if(sector_import == "Ministries"){
    short_sector_import = "ministries"
  }
  if(sector_import == "Legislative"){
    short_sector_import = "legassembly"
  }
  if(sector_import == "Judiciary"){
    short_sector_import = "judiciary"
  }
  if(sector_import == "Crown"){
    short_sector_import = "crown"
  }
  if(sector_import == "Municipalities"){
    short_sector_import = "munic"
  }
  if(sector_import == "SchoolBoards"){
    short_sector_import = "schbd"
  }
  if(sector_import == "Colleges"){
    short_sector_import = "colleg"
  }
  if(sector_import == "Hospitals"){
    short_sector_import = "hospit"
  }
  if(sector_import == "Other"){
    short_sector_import = "otherp"
  }
  if(sector_import == "OntarioPublicService"){
    short_sector_import = "ontpub"
  }
  for (i in 1:total_pages){
    if(total_pages == 1){
      theurl <- paste0("http://www.fin.gov.on.ca/en/publications/salarydisclosure/", year_import_link, "/", short_sector_import, short_year_link, ".html")
    }
    if(total_pages > 1){  
      theurl <- paste0("http://www.fin.gov.on.ca/en/publications/salarydisclosure/", year_import_link, "/", short_sector_import, short_year_link, v[i], ".html")
    }
    print(theurl)
    tables <- readHTMLTable(theurl)
    n.rows <- unlist(lapply(tables, function(t) dim(t)[1]))
    tables[[which.max(n.rows)]]
    names(tables[[1]]) = c("Employer", "Last.name", "First.name", "Job.title", "Salary.Paid", "Taxable.Benefits")
    tables[[1]]$Calendar.Year = year_import
    tables[[1]]$Sector = sector_import
    tables[[1]] = subset(tables[[1]], select=c("Employer", "Last.name", "First.name", "Job.title", "Salary.Paid", "Taxable.Benefits", "Calendar.Year", "Sector"))
    if(!dir.exists(file.path(getwd(), "Inputs", "Salary Disclosure by year", year_import, sector_import))){
      dir.create(file.path(getwd(), "Inputs", "Salary Disclosure by year", year_import, sector_import)) 
    }
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
Importer2012to2013(sector_import = "Crown", year_import = 2013, total_pages = 4)
Importer2012to2013(sector_import = "Colleges", year_import = 2013, total_pages = 5)
Importer2012to2013(sector_import = "Other", year_import = 2013, total_pages = 5)
Importer2012to2013(sector_import = "Ministries", year_import = 2013, total_pages = 11)
Importer2012to2013(sector_import = "Legislative", year_import = 2013, total_pages = 1)
Importer2012to2013(sector_import = "Electricity", year_import = 2013, total_pages = 12)
Importer2012to2013(sector_import = "Judiciary", year_import = 2013, total_pages = 1)
Importer2012to2013(sector_import = "Municipalities", year_import = 2013, total_pages = 26)
Importer2012to2013(sector_import = "SchoolBoards", year_import = 2013, total_pages = 13)


########## DOWNLOAD FILES - 2012 #######
Importer2012to2013(sector_import = "Universities", year_import = 2012, total_pages = 15)
Importer2012to2013(sector_import = "Hospitals", year_import = 2012, total_pages = 9)
Importer2012to2013(sector_import = "Crown", year_import = 2012, total_pages = 4)
Importer2012to2013(sector_import = "Colleges", year_import = 2012, total_pages = 5)
Importer2012to2013(sector_import = "Other", year_import = 2012, total_pages = 4)
Importer2012to2013(sector_import = "Ministries", year_import = 2012, total_pages = 11)
Importer2012to2013(sector_import = "Legislative", year_import = 2012, total_pages = 1)
Importer2012to2013(sector_import = "Electricity", year_import = 2012, total_pages = 12)
Importer2012to2013(sector_import = "Judiciary", year_import = 2012, total_pages = 1)
Importer2012to2013(sector_import = "Municipalities", year_import = 2012, total_pages = 20)
Importer2012to2013(sector_import = "SchoolBoards", year_import = 2012, total_pages = 13)


########## DOWNLOAD FILES - 2011 #######
Importer2009to2011(sector_import = "Universities", year_import = 2011, total_pages = 12)
Importer2009to2011(sector_import = "Hospitals", year_import = 2011, total_pages = 6)
Importer2009to2011(sector_import = "Crown", year_import = 2011, total_pages = 2)
Importer2009to2011(sector_import = "Colleges", year_import = 2011, total_pages = 3)
Importer2009to2011(sector_import = "Other", year_import = 2011, total_pages = 2)
Importer2009to2011(sector_import = "Ministries", year_import = 2011, total_pages = 9)
Importer2009to2011(sector_import = "Legislative", year_import = 2011, total_pages = 1)
Importer2009to2011(sector_import = "Electricity", year_import = 2011, total_pages = 9)
Importer2009to2011(sector_import = "Judiciary", year_import = 2011, total_pages = 1)
Importer2009to2011(sector_import = "Municipalities", year_import = 2011, total_pages = 9)
Importer2009to2011(sector_import = "SchoolBoards", year_import = 2011, total_pages = 6)


########## DOWNLOAD FILES - 2010 #######
Importer2009to2011(sector_import = "Universities", year_import = 2010, total_pages = 2)
Importer2009to2011(sector_import = "Hospitals", year_import = 2010, total_pages = 1)
Importer2009to2011(sector_import = "Crown", year_import = 2010, total_pages = 1)
Importer2009to2011(sector_import = "Colleges", year_import = 2010, total_pages = 1)
Importer2009to2011(sector_import = "Other", year_import = 2010, total_pages = 1)
Importer2009to2011(sector_import = "Ministries", year_import = 2010, total_pages = 1)
Importer2009to2011(sector_import = "Legislative", year_import = 2010, total_pages = 1)
Importer2009to2011(sector_import = "Electricity", year_import = 2010, total_pages = 1)
Importer2009to2011(sector_import = "Judiciary", year_import = 2010, total_pages = 1)
Importer2009to2011(sector_import = "Municipalities", year_import = 2010, total_pages = 2)
Importer2009to2011(sector_import = "SchoolBoards", year_import = 2010, total_pages = 1)


########## DOWNLOAD FILES - 2009 #######
Importer2009to2011(sector_import = "Universities", year_import = 2009, total_pages = 2)
Importer2009to2011(sector_import = "Hospitals", year_import = 2009, total_pages = 1)
Importer2009to2011(sector_import = "Crown", year_import = 2009, total_pages = 1)
Importer2009to2011(sector_import = "Colleges", year_import = 2009, total_pages = 1)
Importer2009to2011(sector_import = "Other", year_import = 2009, total_pages = 1)
Importer2009to2011(sector_import = "Ministries", year_import = 2009, total_pages = 1)
Importer2009to2011(sector_import = "Legislative", year_import = 2009, total_pages = 1)
Importer2009to2011(sector_import = "Electricity", year_import = 2009, total_pages = 1)
Importer2009to2011(sector_import = "Judiciary", year_import = 2009, total_pages = 1)
Importer2009to2011(sector_import = "Municipalities", year_import = 2009, total_pages = 2)
Importer2009to2011(sector_import = "SchoolBoards", year_import = 2009, total_pages = 1)

########## DOWNLOAD FILES - 2008 #######
Importer2009to2011(sector_import = "Universities", year_import = 2008, total_pages = 1)
Importer2009to2011(sector_import = "Hospitals", year_import = 2008, total_pages = 1)
Importer2009to2011(sector_import = "Crown", year_import = 2008, total_pages = 1)
Importer2009to2011(sector_import = "Colleges", year_import = 2008, total_pages = 1)
Importer2009to2011(sector_import = "Other", year_import = 2008, total_pages = 1)
Importer2009to2011(sector_import = "Ministries", year_import = 2008, total_pages = 1)
Importer2009to2011(sector_import = "Legislative", year_import = 2008, total_pages = 1)
Importer2009to2011(sector_import = "Electricity", year_import = 2008, total_pages = 1)
Importer2009to2011(sector_import = "Judiciary", year_import = 2008, total_pages = 1)
Importer2009to2011(sector_import = "Municipalities", year_import = 2008, total_pages = 1)
Importer2009to2011(sector_import = "SchoolBoards", year_import = 2008, total_pages = 1)

########## DOWNLOAD FILES - 2007 #######
Importer2009to2011(sector_import = "Universities", year_import = 2007, total_pages = 1)
Importer2009to2011(sector_import = "Hospitals", year_import = 2007, total_pages = 1)
Importer2009to2011(sector_import = "Crown", year_import = 2007, total_pages = 1)
Importer2009to2011(sector_import = "Colleges", year_import = 2007, total_pages = 1)
Importer2009to2011(sector_import = "Other", year_import = 2007, total_pages = 1)
Importer2009to2011(sector_import = "Ministries", year_import = 2007, total_pages = 1)
Importer2009to2011(sector_import = "Legislative", year_import = 2007, total_pages = 1)
Importer2009to2011(sector_import = "Electricity", year_import = 2007, total_pages = 1)
Importer2009to2011(sector_import = "Judiciary", year_import = 2007, total_pages = 1)
Importer2009to2011(sector_import = "Municipalities", year_import = 2007, total_pages = 1)
Importer2009to2011(sector_import = "SchoolBoards", year_import = 2007, total_pages = 1)

########## DOWNLOAD FILES - 2006 #######
Importer2009to2011(sector_import = "Universities", year_import = 2006, total_pages = 1)
Importer2009to2011(sector_import = "Hospitals", year_import = 2006, total_pages = 1)
Importer2009to2011(sector_import = "Crown", year_import = 2006, total_pages = 1)
Importer2009to2011(sector_import = "Colleges", year_import = 2006, total_pages = 1)
Importer2009to2011(sector_import = "Other", year_import = 2006, total_pages = 1)
Importer2009to2011(sector_import = "Ministries", year_import = 2006, total_pages = 1)
Importer2009to2011(sector_import = "Legislative", year_import = 2006, total_pages = 1)
Importer2009to2011(sector_import = "Electricity", year_import = 2006, total_pages = 1)
Importer2009to2011(sector_import = "Judiciary", year_import = 2006, total_pages = 1)
Importer2009to2011(sector_import = "Municipalities", year_import = 2006, total_pages = 1)
Importer2009to2011(sector_import = "SchoolBoards", year_import = 2006, total_pages = 1)

########## DOWNLOAD FILES - 2005 #######
Importer2009to2011(sector_import = "Universities", year_import = 2005, total_pages = 1)
Importer2009to2011(sector_import = "Hospitals", year_import = 2005, total_pages = 1)
Importer2009to2011(sector_import = "Crown", year_import = 2005, total_pages = 1)
Importer2009to2011(sector_import = "Colleges", year_import = 2005, total_pages = 1)
Importer2009to2011(sector_import = "Other", year_import = 2005, total_pages = 1)
Importer2009to2011(sector_import = "Ministries", year_import = 2005, total_pages = 1)
Importer2009to2011(sector_import = "Legislative", year_import = 2005, total_pages = 1)
Importer2009to2011(sector_import = "Electricity", year_import = 2005, total_pages = 1)
Importer2009to2011(sector_import = "Judiciary", year_import = 2005, total_pages = 1)
Importer2009to2011(sector_import = "Municipalities", year_import = 2005, total_pages = 1)
Importer2009to2011(sector_import = "SchoolBoards", year_import = 2005, total_pages = 1)


########## DOWNLOAD FILES - 2004 #######
Importer2009to2011(sector_import = "Universities", year_import = 2004, total_pages = 1)
Importer2009to2011(sector_import = "Hospitals", year_import = 2004, total_pages = 1)
Importer2009to2011(sector_import = "Crown", year_import = 2004, total_pages = 1)
Importer2009to2011(sector_import = "Colleges", year_import = 2004, total_pages = 1)
Importer2009to2011(sector_import = "Other", year_import = 2004, total_pages = 1)
Importer2009to2011(sector_import = "Ministries", year_import = 2004, total_pages = 1)
Importer2009to2011(sector_import = "Legislative", year_import = 2004, total_pages = 1)
Importer2009to2011(sector_import = "Electricity", year_import = 2004, total_pages = 1)
Importer2009to2011(sector_import = "Judiciary", year_import = 2004, total_pages = 1)
Importer2009to2011(sector_import = "Municipalities", year_import = 2004, total_pages = 1)
Importer2009to2011(sector_import = "SchoolBoards", year_import = 2004, total_pages = 1)

########## DOWNLOAD FILES - 2003 #######
Importer2009to2011(sector_import = "Universities", year_import = 2003, total_pages = 1)
Importer2009to2011(sector_import = "Hospitals", year_import = 2003, total_pages = 1)
Importer2009to2011(sector_import = "Crown", year_import = 2003, total_pages = 1)
Importer2009to2011(sector_import = "Colleges", year_import = 2003, total_pages = 1)
Importer2009to2011(sector_import = "Other", year_import = 2003, total_pages = 1)
Importer2009to2011(sector_import = "Ministries", year_import = 2003, total_pages = 1)
Importer2009to2011(sector_import = "Legislative", year_import = 2003, total_pages = 1)
Importer2009to2011(sector_import = "Electricity", year_import = 2003, total_pages = 1)
Importer2009to2011(sector_import = "Judiciary", year_import = 2003, total_pages = 1)
Importer2009to2011(sector_import = "Municipalities", year_import = 2003, total_pages = 1)
Importer2009to2011(sector_import = "SchoolBoards", year_import = 2003, total_pages = 1)

########## DOWNLOAD FILES - 2002 #######
Importer2009to2011(sector_import = "Universities", year_import = 2002, total_pages = 1)
Importer2009to2011(sector_import = "Hospitals", year_import = 2002, total_pages = 1)
Importer2009to2011(sector_import = "Crown", year_import = 2002, total_pages = 1)
Importer2009to2011(sector_import = "Colleges", year_import = 2002, total_pages = 1)
Importer2009to2011(sector_import = "Other", year_import = 2002, total_pages = 1)
Importer2009to2011(sector_import = "OntarioPublicService", year_import = 2002, total_pages = 1)
Importer2009to2011(sector_import = "Electricity", year_import = 2002, total_pages = 1)
Importer2009to2011(sector_import = "Municipalities", year_import = 2002, total_pages = 1)
Importer2009to2011(sector_import = "SchoolBoards", year_import = 2002, total_pages = 1)

########## DOWNLOAD FILES - 2001 #######
Importer2009to2011(sector_import = "Universities", year_import = 2001, total_pages = 1)
Importer2009to2011(sector_import = "Hospitals", year_import = 2001, total_pages = 1)
Importer2009to2011(sector_import = "Crown", year_import = 2001, total_pages = 1)
Importer2009to2011(sector_import = "Colleges", year_import = 2001, total_pages = 1)
Importer2009to2011(sector_import = "Other", year_import = 2001, total_pages = 1)
Importer2009to2011(sector_import = "OntarioPublicService", year_import = 2001, total_pages = 1)
Importer2009to2011(sector_import = "Electricity", year_import = 2001, total_pages = 1)
Importer2009to2011(sector_import = "Municipalities", year_import = 2001, total_pages = 1)
Importer2009to2011(sector_import = "SchoolBoards", year_import = 2001, total_pages = 1)



########## BIND THEM ALL TOGETHER ###########
years = seq(2001, 2015, by=1)
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