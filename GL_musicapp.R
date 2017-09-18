# N. Anderson 09/18/17
# Graham's birthday plot!
# Run GL_musicapp.setup.R first
# Run this application by clicking the 'Run App' button or runApp('GL_musicapp.R')
#

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
  
  output$sg1 <- renderStreamgraph(sg)
  
}

shinyApp(ui = ui, server = server)
