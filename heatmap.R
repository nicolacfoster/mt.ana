
#############################################################################
#
# PROJECT: SR1 SYSTEMATIC REVIEW
# AUTHOR: NICOLA FOSTER, LSHTM
# LAST UPDATED: 19 April 2024
#
#############################################################################

install.packages("ggplot2")
install.packages("readxl")

library(ggplot2)
library(readxl)

# https://jcoliver.github.io/learn-r/006-heatmaps.html

# imports dataset in long format
tab1 <- read_excel("~/Desktop/tab1.xlsx", sheet = "v2")
View(tab1)

records <- as.numeric(tab1$records)

sqrt.records <- sqrt(records)

##############################################################
# Do one plot by year and one by country income level and one by DAT type

map.heat1 <- ggplot(data=tab1, mapping = aes(x = Year,
                                        y = Category,
                                        fill = records)) +
  geom_raster() +
  xlab(label = "Year and Country Income Level") +
  ylab(label = "Implementation category") +
  facet_grid(~ Income, switch = "x", scales = "free_x", space = "free_x") +
  scale_fill_gradient(name = "Number of observations",
                      low = "grey",
                      high = "purple")


map.heat1




