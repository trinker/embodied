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
        "plot_grid",
      	"resize"
      )
    ),         
    sd_section("Data Handling",
      "Functions to aid recording, managing, and reshaping spatial data.",
      c(
      	"grid_coord",
      	"lookup",
      	"write_embodied"
      )
    ),
    sd_section("Plotting",
      "Functions to plot spatial data.",
      c(
      	"read_png"
      )
    ),
    sd_section("embodied Tools",
      "Generic Tools (Functions) Used Within the embodied Package.",
      c(
      	"command",
      	"dir_png",
      	"sec_to_hms"
      )
    )  	
))

