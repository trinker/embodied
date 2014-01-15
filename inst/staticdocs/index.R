library(staticdocs)
list(
  index = list(
    sd_section("Video Manipulation",
      "Functions to manipulate/convert mp4 videos to .mp4 videos/.png images.",  
      c(
      	"convert_to_mp4",
      	"mp4_duration", 
      	"mp4_interval",
        "mp4_to_png"
      )
    ),
    sd_section("Image Preparation",
      "Functions to prepare png images for coding.",  
      c(
        "grid_calc",
        "gridify",
        "plot_grid"
      )
    ),         
    sd_section("Data Handling",
      "Functions to aid recording, managing, and reshaping spatial data.",
      c(
      )
    ),
    sd_section("Plotting",
      "Functions to plot spatial data.",
      c(
      )
    ),
    sd_section("embodied Tools",
      "Generic Tools (Functions) Used Within the embodied Package.",
      c(
      )
    )  	
))

