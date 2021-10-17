library(spocc)

#get data from GBIF
results = occ(query = "Rhinoplax vigil", from = "gbif")
results
head(results)


#get data from GBIF and ebird
results = occ(query = "Rhinoplax vigil", from = c("ebird","gbif", "ecoengine"))


##get data for multiple species from multiple DBS
spp = c("Rhinoplax vigil", "Buceros rhinoceros", "Anthracoceros malayanus")
summary(results)
head(results$gbif)
dbs = c("gbif", "ecoengine")
res_set = occ(query = spp, from = dbs)
head(res_set)


##make sure we get georef records only
dat = occ(query = spp, from = "gbif", gbifopts = list(hasCoordinate=T), 
          date = c("2011-01-01", "2021-01-01"))
data = occ2df(dat)  ##convert to dataframe
head(data)

names(data)
tail(data)
?occ
dim(data)

save.image("SDMclassprac.RData")
