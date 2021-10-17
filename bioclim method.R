####### Bioclim climate envelope model
### uses presence only data

###climate change is creating new challenges for biodiversity conservation
## Climate envelope models describe the climate where a species currently lives (its climate envelope)
### map the geographic shift of that envelope under climmate change

library(dismo)
library(rgeos)

horn = read.csv("hornbill_my1.csv")
head(horn)
horn1 = horn[,-1] #first column not needed
horn1

min(horn1)
max(horn1)
names(horn1)

max(horn1$long)
max(horn1$lat)


min(horn1$long)
min(horn1$lat)

#specify long 1, long 2, lat 1, lat2
ext = extent(99, 105, 1.5, 6.7) #geographic extent of Penisular Malaysia
drawExtent()
library(rgdal)

all.worldclim = raster::getData("worldclim", res = 10, var = "bio")
misa.worldclim = crop(all.worldclim, ext)


##  set up the bounding box of your map
#h.extent = extent(min(horn1$long -1),
                  #max(horn1$long +1),
                  #min(horn1$lat -1),
                 # max(horn1$lat +1))

#h.map = gmap(h.extent, type = "satellite", latlon = T)
#plot(h.map)
plot(misa.worldclim)

h.bc = bioclim(misa.worldclim, horn1[,c("long", "lat")])
par(mfrow = c(4,4))
response(h.bc)
par(mfrow = c(1,1))


horn.d = bioclim(misa.worldclim, horn1[,c("long", "lat")])
par(mfrow = c(4,4))
response(horn.d)
par(mfrow = c(1,1))

horn.d.pred = predict(object = horn.d, misa.worldclim)
plot(horn.d.pred, main = "sdm predictions using climate variable")
## add in the same points from above. cex makes the points smaller.
points(horn1, pch = 16, cex = 0.25)


## evaluate model performance
## backgroun data (pseuod -abscences) 
head(horn1)
plot(misa.worldclim)
ext
# background / pseudo-abscence data
backg = randomPoints( misa.worldclim, n=1000, ext = ext, extf = 1.25)


# evaluation req presence, backg, model, predictors
e = evaluate(horn1, backg, horn.d, misa.worldclim)
e
plot(e, "ROC")


