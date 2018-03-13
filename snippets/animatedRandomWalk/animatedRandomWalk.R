walkMe = function(nsteps, # How many steps for the random walk to take
                  interval = 0.2, # The time (in seconds) between each step
                  stepSize = 0, # The distance travelled in each step.
                  # Default is a random value between 10 and 100
                  snake = FALSE, # By default all points are drawn.
                  # If snake is TRUE, only the last x points will be drawn
                  snakeLength = 2, # Number of points to draw when snake is TRUE
                  # Plot Styling:
                  lineType = 'o',
                  lineWidth = 2,
                  lineColor = "black") {
  
  # Create a random vector which informs which direction the walk will take
  angle = floor(runif(nsteps, min = 0, max = 360))
  
  # If stepSize is 0 (default), then a random vector of values between 10 and 100 is created.
  if (stepSize == 0){
    stepSize = floor(runif(nsteps, min = 10, max = 100))
  }else{ # Else, all steps will take uniform steps of the value provided.
    stepSize = rep(stepSize,nsteps)
  }

  df = data.frame(angle = angle, stepSize = stepSize)
  
  # Calculate which trigonometric quadrant the direction of each step is in.
  df$firstQuadrant = ifelse(df$angle >= 0 & df$angle <= 90, 1, 0)
  df$secondQuadrant = ifelse(df$angle > 90 & df$angle <= 180, 1, 0)
  df$thirdQuadrant = ifelse(df$angle > 180 & df$angle <= 270, 1, 0)
  df$fourthQuadrant = ifelse(df$angle > 270 & df$angle <= 360, 1, 0)
  
  # Use the sin and cosine rules to calculate the x,y magnitudes for the steps
  df[df$firstQuadrant == 1, "x"] = df[df$firstQuadrant == 1, "stepSize"] *
    cos(df[df$firstQuadrant == 1, "angle"])
  df[df$firstQuadrant == 1, "y"] = df[df$firstQuadrant == 1, "stepSize"] *
    sin(df[df$firstQuadrant == 1, "angle"])
  
  df[df$secondQuadrant == 1, "x"] = -df[df$secondQuadrant == 1, "stepSize"] *
    cos(180 - df[df$secondQuadrant == 1, "angle"])
  df[df$secondQuadrant == 1, "y"] = df[df$secondQuadrant == 1, "stepSize"] *
    sin(180 - df[df$secondQuadrant == 1, "angle"])
  
  df[df$thirdQuadrant == 1, "x"] = -df[df$thirdQuadrant == 1, "stepSize"] *
    cos(270 - df[df$thirdQuadrant == 1, "angle"])
  df[df$thirdQuadrant == 1, "y"] = -df[df$thirdQuadrant == 1, "stepSize"] *
    sin(270 - df[df$thirdQuadrant == 1, "angle"])
  
  df[df$fourthQuadrant == 1, "x"] = df[df$fourthQuadrant == 1, "stepSize"] *
    cos(360 - df[df$fourthQuadrant == 1, "angle"])
  df[df$fourthQuadrant == 1, "y"] = -df[df$fourthQuadrant == 1, "stepSize"] *
    sin(360 - df[df$fourthQuadrant == 1, "angle"])
  
  # For each step, add on the x,y step magnitude, to find the new co-ordinates of the plot (or snake head)
  for (i in 1:nsteps) {
    if (i == 1) {
      df[i, "XCum"] = df[i, "x"]
      df[i, "YCum"] = df[i, "y"]
    } else{
      df[i, "XCum"] = df[(i - 1), "XCum"] + df[i, "x"]
      df[i, "YCum"] = df[(i - 1), "YCum"] + df[i, "y"]
    }
  }
  
  # Load the animation library to draw the animation
  library(animation)
  ani.record(reset = TRUE)  # clear history before recording
  
  # If the snake is TRUE, need the first 'snakeLength' number of points drawn with different plot inputs
  for (i in 1:nsteps) {
    if (snake == TRUE & i <= snakeLength) {
      plot(
        df[1:i, "XCum"],
        df[1:i, "YCum"],
        type = lineType,
        xlim = c(min(df$XCum), max(df$XCum)),
        ylim = c(min(df$YCum), max(df$YCum)),
        xlab = "",
        ylab = "",
        main = "Random Walk by Kevin",
        xaxt = 'n',
        yaxt = 'n',
        lwd = lineWidth,
        col = lineColor
      )
    } else if (snake == TRUE & i > snakeLength) { # Drawing the remaining snake points
      plot(
        df[(i + 1 - snakeLength):i, "XCum"],
        df[(i + 1 - snakeLength):i, "YCum"],
        type = lineType,
        xlim = c(min(df$XCum), max(df$XCum)),
        ylim = c(min(df$YCum), max(df$YCum)),
        xlab = "",
        ylab = "",
        main = "Random Walk by Kevin",
        xaxt = 'n',
        yaxt = 'n',
        lwd = lineWidth,
        col = lineColor
      )
    } else{ # if snake is FALSE (default), then draw all points in each frame
      plot(
        df[1:i, "XCum"],
        df[1:i, "YCum"],
        type = lineType,
        xlim = c(min(df$XCum), max(df$XCum)),
        ylim = c(min(df$YCum), max(df$YCum)),
        xlab = "",
        ylab = "",
        main = "Random Walk by Kevin",
        xaxt = 'n',
        yaxt = 'n',
        lwd = lineWidth,
        col = lineColor
      )
    }
    ani.record() # records the current plot frame
    print(paste((i / nsteps) * 100, "% Complete", sep = "")) # prints progress
    
  }
  
  oopts = ani.options(interval = interval) # Sets interval value for animation
  saveHTML(ani.replay(), img.name = "record_plot") # outputs animation and opens in web browser
  # This part can take a long time for large values of 'nsteps'.
  
}

walkMe(
  100,
  interval = 0.01,
  stepSize = 2,
  snake = FALSE,
  lineType = 'l',
  lineWidth = 1,
  lineColor = c("royalblue1", "royalblue2","royalblue3")
)



