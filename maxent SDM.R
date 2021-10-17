library(raster)
library(rgdal)
library(dismo)

datafiles = Sys.glob("*.tif") # or whatever idemtifies your files

datafiles #list of predictors
stck = stack() #empty raster stack for storing raster layers
for(i in 1:NROW(datafiles)){
  tempraster = raster(datafiles[i])
  stck = stack(stck, tempraster)
}

stck # raster predictors as a stackplot
plot(stck, 1)

## presence data

horn1
plot(horn1, col = "blue")

group = kfold(horn1, 5) #split the data into 5 portions
#build and test models on all 5 data splits
pres_train = horn1[group !=1, ]
pres_test = horn1[group == 1, ]


######

xm = maxent(stck, pres_train) # implement maxent on the presence-only data
plot(xm)


######
ext
# 1000 background data points
backg = randomPoints(stck, n=1000, ext = ext, extf = 1.25)
colnames(backg)
group = kfold(backg, 5)

#pseudo-abscence for training model performances
backg_train = backg[group != 1, ]
backg_test = backg[group == 1, ]

e = evaluate(pres_test,backg_test, xm, stck)
# presence_test, backgr_test, maxent, stack_raster
e

p = predict(stck, xm, ext=ext, progress="")
#0-1 scale where 1 indicates the most suitable habitat
#and 0 least suitable habitat


par(mfrow=c(1,2))
plot(p, horn1, main="Maxent, raw values")


library(red)

## learn more about your data
map.easy(horn, layers = stck, habitat = NULL, zone = NULL,
         thin = TRUE, error = NULL, move = TRUE, dem = alt, pca = 0,
         filename = NULL, mapoption = NULL, testpercentage = 20, mintest = 20,
         runs = 0, subset = 0)

##maxent 
map.sdm(horn1, stck, error = NULL, categorical = NULL, thres = 0,
        testpercentage = 20, mcp = TRUE, eval = TRUE, runs = 0, subset = 0)

