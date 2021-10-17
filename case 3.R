library(raster)
library(rgdal)

slope = raster("slp2.tif")
plot(slope)
slope
ref = "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"
project.rasterslp = projectRaster(slope, crs=ref)
project.rasterslp


alt = raster("altitude.tif")
plot(alt)


pm = readOGR(".",  "MYS_adm1.shp")
pm = shapefile("MYS_adm1.shp")
pm
plot(pm, add=T)

altc = crop(alt, pm)
plot(altc, main = "Malaysia Altitude", las = 1)

#resize and resampling data by modifying the spatial resolution
land =raster("landuse1.tif")
land
alt
landC = resample(land, alt, method = "bilinear")
plot(landC, las =1)





