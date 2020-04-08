## after https://www.rpubs.com/spoonerf/countrymapggplot2

library(maptools)
library(raster)
library(ggplot2)
library(rgdal)
library(plyr)

## download UK shapefile data

unitedkingdom<-getData("GADM",country="GB",level=0)

## make base map

uk<-ggplot()+geom_polygon(data=unitedkingdom,aes(x=long,y=lat,group=group))+coord_fixed(1.3)

## input of dataset with Arabidopsis 1001 genome accession details

ecotypes_all<-read.csv('LHY_SNP_WRLD_dataset.csv', header=TRUE)

## obtaining the UK specific accessions from dataset

UKdata<-ecotypes_all[which(ecotypes_all$country.x=="UK"),]

## cast ecotype locations as lat long coordinates on base map

uk+theme_dark() +
  geom_point(data=UKdata,aes(x=long,y=lat,color=factor(genotype_comp)),size=1.7,alpha=0.7) +
  labs(x="longitude", y="latitude",col="haplotype") +
  scale_color_manual(values=c("dodgerblue1","firebrick1","lightgoldenrod2")) +
  theme(legend.background = element_rect(fill="gray 90"),legend.title=element_blank()) +
  theme(legend.justification = c(0,1),legend.position = c(0,1)) +
  theme(legend.background = element_rect(colour="black",size=0.25))

ggsave('UK_map_LHY_haplotype.png')
