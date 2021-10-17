library(raster)

my0 = getData("GADM", country = "MYS", level = 0) #country outline
my1 = getData("GADM", country = "MYS", level = 1) #States Included

par(mfrow=c(1,2))
plot(my0, main="Adm. Boundaries Malaysia Level 0")
plot(my1, main="Adm. Boundaries Malaysia Level 1")

## world climate

climate = getData("worldclim", var = "bio", res = 2.5) #res = 2.5 resolution i.e 2.5minutes
#attach(climate)

par(mfrow=c(1,2))
plot(climate$bio1, main = "Annual Mean Temperature")
plot(climate$bio5, main = "Maximum Temperature")
box()


library(rgdal)
library(raster)

#Load raster data
setwd("C:/Users/USER/Desktop/R/SDM")
el1 = raster("srtm_59_12.tif")
el2 = raster("srtm_60_11.tif")

#plot your raster data
par(mfrow = c(1,2))
plot(el1, main = "ELevation Raster 1")
plot(el2, main = "Elevation Raster 2")

#Join elevation raster data together
mosee = mosaic(el1, el2, fun=mean)
plot(mosee, main = "Mosaic Elevation Raster Info")

#save the joined elevation
writeRaster(mosee, "join_60_69.tif")

mosee
na.omit(mosee)

#utm projection for north borneo
ref = "+proj=utm +zone=50 +elleps=GRS80 +datum=NAD83 +units=m +no_defs"

library(raster)

projected.raster = projectRaster(mosee, crs = ref) 
#na.omit(projected.raster)

slp = terrain(projected.raster, opt = "slope", unit = "radians",
              neighbors = 8, filename = "slp2.tif")
plot(slp)

aspect = terrain(projected.raster, opt = "aspect") 

## hillshade obtained from both slope and aspect
hills = hillShade(slp, aspect, angle = 40, direction = 270)
plot(hills)
par(mfrow = c(1,2))
plot(slp, main = "Slope Elevation Raster Info", las = 1)
plot(hills, main = "HillShade Raster Info", las = 1)




