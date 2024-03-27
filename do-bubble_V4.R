
#############################################################################
#
# PROJECT: SR1 SYSTEMATIC REVIEW
# AUTHOR: NICOLA FOSTER, LSHTM
# LAST UPDATED: 27 MARCH 2024
#
#############################################################################


packages_to_be_installed <- c("ggplot2",
                              "tidyverse",
                              "dplyr",
                              "viridis",
                              "hrbrthemes",
                              "haven")
package.check <- lapply(
  packages_to_be_installed,
  FUN = function(x) {
    if (!require(x, character.only = TRUE)) {
      install.packages(x, dependencies = TRUE)
    } })
all_there <- lapply(packages_to_be_installed, require, # checks all required packages installed
                    character.only = TRUE, quietly=T)
all_there # shows TRUE if installed, else FALSE

data <- read_dta("data.dta")
data2 <-  data %>% filter(C3measure=="dose-day")

# Convert to factor variables to show legend
DATtype <- as.factor(data2$DATtype)
countryincome <- as.factor(data2$countryincome)
value <- as.factor(data2$value)


# Estimating the weighted mean value for the point estimate
data3 <-  data %>% filter(C3measure=="dose-day", DATtype=="99DOTS")
aa <- sum(data3$value)
a <- weighted.mean(data3$value, data3$samplesize/aa, na.rm=TRUE)

data4 <-  data %>% filter(C3measure=="dose-day", DATtype=="IngestionSensors")
bb <- sum(data4$value)
b <- weighted.mean(data4$value, data4$samplesize/bb, na.rm=TRUE)

data5 <-  data %>% filter(C3measure=="dose-day", DATtype=="Phone")
cc <- sum(data5$value)
c <- weighted.mean(data5$value, data5$samplesize/cc, na.rm=FALSE)

data6 <-  data %>% filter(C3measure=="dose-day", DATtype=="Pillbox")
dd <- sum(data6$value)
d <- weighted.mean(data6$value, data6$samplesize/dd, na.rm=FALSE)

data7 <-  data %>% filter(C3measure=="dose-day", DATtype=="SMS")
ee <- sum(data7$value)
e <- weighted.mean(data7$value, data7$samplesize/ee, na.rm=FALSE)

data8 <-  data %>% filter(C3measure=="dose-day", DATtype=="VST")
ff <- sum(data8$value)
f <- weighted.mean(data8$value, data8$samplesize/ff, na.rm=FALSE)

data9 <-  data %>% filter(C3measure=="dose-day", DATtype=="Web")
gg <- sum(data9$value)
g <- weighted.mean(data9$value, data9$samplesize/ff, na.rm=TRUE)



# Bubble plot1
ggplot(data = data2, 
       aes(x=DATtype, y=value, size=samplesize, color=countryincome)) +
  geom_point(alpha=0.7) +
  theme(legend.position = "bottom") +
  scale_size(range = c(.1, 24), breaks = c(50, 350, 650, 950), name="Patients, number of") +
  scale_color_viridis(discrete=TRUE, option="D", name="Country income level") +
  xlab("Type of Digital Adherence Technology used") +
  ylab("Percentage DAT engagement over total dose-days") +
  theme(legend.position = "botttom") +
  guides(fill = guide_legend(order=1), size = guide_legend(order=2)) +
  expand_limits(y=c(0, 100)) +
  theme_bw() +
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) +
  geom_segment(aes(x=0.8, y=a, xend=1.2, yend=a), color="red", inherit.aes=FALSE, linetype="dashed") +
  geom_segment(aes(x=1.8, y=b, xend=2.2, yend=b), color="red", inherit.aes=FALSE, linetype="dashed") +
  geom_segment(aes(x=2.8, y=c, xend=3.2, yend=c), color="red", inherit.aes=FALSE, linetype="dashed") +
  geom_segment(aes(x=3.8, y=d, xend=4.2, yend=d), color="red", inherit.aes=FALSE, linetype="dashed") +
  geom_segment(aes(x=4.8, y=e, xend=5.2, yend=e), color="red", inherit.aes=FALSE, linetype="dashed") +
  geom_segment(aes(x=5.8, y=f, xend=6.2, yend=f), color="red", inherit.aes = FALSE, linetype="dashed") +
  geom_segment(aes(x=6.8, y=g, xend=7.2, yend=g), color="red", inherit.aes = FALSE, linetype="dashed") +
  labs(caption="1 - Where the red dotted line represents the weighted mean of percentage engagement with each DATtype") +
  theme(plot.caption = element_text(hjust=0)) +
  theme(plot.caption = element_text(size=5))

# Outputs the weighted average values for inclusion in the text
a #99DOTS
b #IngesionSensors
c #Phone
d #Pillbox
e #SMS
f #VST
g #Web






  










