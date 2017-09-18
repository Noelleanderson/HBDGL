# Run before GL_musicapp.R

install.packages(c("shiny","dplyr","srtreamgraph","randomColor"))

library(shiny)
library(dplyr)
library(streamgraph)
library(randomColor)

gl_music <- read_delim("gl.formatted.tab","\t", escape_double = F, col_names = T,trim_ws = TRUE)
numofartists <- gl_music %>% group_by(artist) %>% tally %>% nrow()
#COLS <- rainbow(numofartists)
c<-randomColor(numofartists)
