# Compile and calculate both isotopic and prey weight range overlap for both modern and paleontological sites

# Functions

# Function to calculate the area of a polygon given its coordinates
polygon_area <- function(coords) {
  # Ensure the coordinates are in a matrix format
  coords <- as.matrix(coords)
  
  # Extract x and y coordinates
  x <- coords[, 1]
  y <- coords[, 2]
  
  # Number of vertices
  n <- length(x)
  
  # Shifted coordinates for the summation (wrap around)
  x_shifted <- c(x[-1], x[1])
  y_shifted <- c(y[-1], y[1])
  
  # Apply the shoelace formula
  area <- 0.5 * abs(sum(x * y_shifted - x_shifted * y))
  
  return(area)
}



# Read the CSV data file
# Replace 'path_to_file.csv' with the actual path to your CSV file
isotope_data <- read.csv('~/Dropbox/PostDoc/2024_PredSizeDiet/data/mammalian_isotopes.csv', header = TRUE)

# Get unique combinations of loc and time
loc_time_combinations <- unique(isotope_data[c("loc", "time","habitat")])

# Initialize an empty data frame to store the results
results_df <- data.frame(loc = character(), 
                         time = character(), 
                         carnivore = character(), 
                         herb_range = numeric(), 
                         herb_area = numeric(), 
                         ratio = numeric(), 
                         predmass_min = numeric(), 
                         predmass_max = numeric(), 
                         family = character(),
                         source = character(),
                         habitat = character(),
                         ratiotype = character(),
                         stringsAsFactors = FALSE)

# Loop over each loc and time
for (i in 1:nrow(loc_time_combinations)) {
    loc <- loc_time_combinations$loc[i]
    time <- loc_time_combinations$time[i]
    habitat <- loc_time_combinations$habitat[i]

    #define herbivores

    # Assuming trophic level 2 is for predators and is present 
    current_herbivores <- isotope_data[isotope_data$loc == loc & (isotope_data$time == time | isotope_data$time == "") & isotope_data$trophic == 1,]
    current_predators <- isotope_data[isotope_data$loc == loc & isotope_data$time == time & isotope_data$trophic == 2,]

    # Subset the data for the current loc and time
    # current_herbivores <- herbivores[herbivores$loc == loc & herbivores$time == time, ]
    # current_predators <- predators[predators$loc == loc & predators$time == time, ]

    # Calculate area measures (convex hull) for C3 environments and linear measures for C3C4 environments

    # Linear Range in d13C space for both conditions
    herb_range <- max(current_herbivores$d13c, na.rm = TRUE) - min(current_herbivores$d13c, na.rm = TRUE)

    # If the system is C3 (which has d13C and d15N), then calculate areas
    if (habitat == "C3") {

        # Convex Hull in d13C x d15N space
        herbcoords <- cbind(current_herbivores$d13c,current_herbivores$d15n)
        # Step 1: Get the convex hull indices
        herb_hull_ind <- chull(herbcoords)
        # Step 2: Create a closed polygon by including the first point at the end
        hull_coords <- herbcoords[herb_hull_ind, ]
        hull_coords <- rbind(hull_coords, hull_coords[1, ])  # Close the polygon
        
        # Step 3: Calculate the area using the shoelace formula
        # herb_hull_area <- sum(hull_coords[-1, 1] * hull_coords[-nrow(hull_coords), 2] - hull_coords[-nrow(hull_coords), 1] * hull_coords[-1, 2]) / 2

        # NOTE: Both of these appear to work
        herb_area <- polygon_area(hull_coords)

        # Visual Check - works
        # plot(herbcoords, xlab = "d13C", ylab = "d15N", main = "Convex Hull of Herbivore Data")
        # lines(hull_coords, col = "red", lwd = 2)  # Draw hull in red

        # Check with external package
        # library(sf)
        # hull_polygon <- st_polygon(list(hull_coords))
        # polygon_area <- st_area(hull_polygon)

    }

    



    # Assuming you have a function to create the MixSIAR source/mixture/discrimination data.frames
    # This is where you would call that function
    # source_data <- create_source_data(current_herbivores)
    # mixture_data <- create_mixture_data(current_predators)
    # discrimination_data <- create_discrimination_data()

    # Loop over each carnivore within the current loc/time
    unique_carnivores <- unique(current_predators$species)
    
    for (carnivore in unique_carnivores) {
        
        
        # current_mixture <- mixture_data[mixture_data$species == carnivore, ]
        predspecies = current_predators[current_predators$species == carnivore,]

        # Linear Range in d13C space
        pred_range <- max(predspecies$d13c, na.rm = TRUE) - min(predspecies$d13c, na.rm = TRUE)
        
        if (habitat == "C3C4") {

            # Unitless... either 2D Area/Area or 1D Range/Range won't make a difference
            ratio = pred_range/herb_range

            ratiotype = "range"
        
        } else {

            # Linear Range in d13C space
            pred_range <- max(predspecies$d13c, na.rm = TRUE) - min(predspecies$d13c, na.rm = TRUE)

            # Convex Hull in d13C x d15N space
            predcoords <- cbind(predspecies$d13c,predspecies$d15n)

            # We must have >=3 carnivore data points! Otherwise calculate 1D range
            if (dim(predcoords)[1] >= 3) {

                # Step 1: Get the convex hull indices
                pred_hull_ind <- chull(predcoords)
                
                # Step 2: Create a closed polygon by including the first point at the end
                hull_coords <- predcoords[pred_hull_ind, ]
                hull_coords <- rbind(hull_coords, hull_coords[1, ])  # Close the polygon
                
                # Step 3: Calculate the area using the shoelace formula
                # herb_hull_area <- sum(hull_coords[-1, 1] * hull_coords[-nrow(hull_coords), 2] - hull_coords[-nrow(hull_coords), 1] * hull_coords[-1, 2]) / 2

                # NOTE: Both of these appear to work
                pred_area <- polygon_area(hull_coords)

                # Unitless... either 2D Area/Area or 1D Range/Range won't make a difference
                ratio = pred_area/herb_area

                ratiotype = "area"

            } else {
               
               # Unitless... either 2D Area/Area or 1D Range/Range won't make a difference
                ratio = pred_range/herb_range

                ratiotype = "range"

            }
            
        }
        
        

        predmassmin = mean(predspecies$predmass_min)
        predmassmax = mean(predspecies$predmass_max)

        family = predspecies$family[1]
        source = predspecies$Isotope.Reference[1]

        # Add the results to the data frame
        results_df <- rbind(results_df, data.frame(loc = loc, 
                                                time = time, 
                                                carnivore = carnivore, 
                                                herb_range = herb_range, 
                                                herb_area = herb_area, 
                                                ratio = ratio,
                                                predmassmin = predmassmin,
                                                predmassmax = predmassmax,
                                                family = family,
                                                source = source,
                                                habitat = habitat,
                                                ratiotype = ratiotype))

    }
}




# Remove Paul's data (if we want to)
# remove_conditions <- !(results_df$source == "Koch-unpublished" )
# results_df <- results_df[remove_conditions, ]

write.csv(results_df, '~/Dropbox/PostDoc/2024_PredSizeDiet/data/diet_results_rangearea.csv', row.names = FALSE)


nonfelidresults = results_df[results_df$felid == 0 & results_df$ratio > 0.,]
felidresults = results_df[results_df$felid == 1 & results_df$ratio > 0.,]


plot(rowMeans(cbind(nonfelidresults$predmassmin,nonfelidresults$predmassmax)),nonfelidresults$ratio,log="x")
points(rowMeans(cbind(felidresults$predmassmin,felidresults$predmassmax)),felidresults$ratio,pch=16)





# Sinclair prey overlap data

diet_range = c(495,248,230,99,99,10.5,9.9,2.99,2,1.9)
family = c("F","H","C","F","F","F","F","F","C","C")
pred_massmin = c(126,52,18,30,21,9,8,4,6,7)
pred_massmax = c(189,60,36,72,72,18,19,4,13,15)
herb_range = 500-2
ratio = diet_range/herb_range
location = rep("Serengeti",length(diet_range))
time = rep("Modern",length(diet_range))
predator_name = c("Lion","Hyaena","Wild dog","Leopard","Cheetah","Serval","Caracal","Wild cat","Silver jackal","Goldon jackal")
source = rep("Sinclair",length(diet_range))

results_sinclair <- data.frame(loc=location, 
                         time=time, 
                         carnivore=predator_name, 
                         herb_range=herb_range, 
                         carn_range=diet_range, 
                         ratio=ratio, 
                         predmassmin=pred_massmin, 
                         predmassmax=pred_massmax, 
                         family=family,
                         source=source,
                         stringsAsFactors = FALSE)

write.csv(results_sinclair, '~/Dropbox/PostDoc/2022_PredSizeDiet/data/diet_sinclair_results.csv', row.names = FALSE)
