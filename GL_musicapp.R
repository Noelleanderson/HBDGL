# N. Anderson 09/18/17
# Graham's birthday plot!
# Run the application by clicking the 'Run App' button above.
#
install.packages(c("shiny","dplyr","srtreamgraph","randomColor"))

library(shiny)
library(dplyr)
library(streamgraph)
library(randomColor)

gl_music <- read_delim("gl.formatted.tab","\t", escape_double = F, col_names = T,trim_ws = TRUE)
numofartists <- gl_music %>% group_by(artist) %>% tally %>% nrow()
#COLS <- rainbow(numofartists)
c<-randomColor(numofartists)

ui = shinyUI(fillPage(
  h3("The Insane Music Listening History of Graham Larue", style="text-align:center"),
  streamgraphOutput('sg1', height = '625px') 
))

server = function(input, output) {
  
  gl_music %>% 
    select(artist, year) %>% 
    group_by(artist, year) %>%  
    tally %>% 
    streamgraph("artist", "n", "year", interactive=TRUE) %>%  
    sg_axis_x(1) %>%
    sg_fill_manual(c) %>% 
    sg_legend(show=TRUE, label="Artists: ") -> sg
  å
  output$sg1 <- renderStreamgraph(sg)
  
}

shinyApp(ui = ui, server = server)
