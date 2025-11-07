
# Contemporary Carnivora Mass Calculations

data <- read.csv('~/Dropbox/PostDoc/2024_PredSizeDiet/PredSizeDiet/data/contemp_mammal_mass_smith_2004.csv', header = TRUE)

carnivores <- data[data$order == "Carnivora", ]
mass_g = carnivores$mass_mean_grams
mass_kg = mass_g / 1000
large_mass_kg = mass_kg[which(mass_kg>20)]
mean(large_mass_kg)
10^mean(log10(large_mass_kg)) #geometric mean

overall_mean_mass_carnivores <- mean(carnivores$mass_mean_grams)
print(overall_mean_mass_carnivores)

hist(log10(carnivores$mass_mean_grams))
10^mean(log10(carnivores$mass_mean_grams))

heavy_carnivores <- carnivores[carnivores$mass_mean_grams > 10^4, ]
mean_mass_heavy_carnivores <- mean(heavy_carnivores$mass_mean_grams)
print(mean_mass_heavy_carnivores)


hist(log10(heavy_carnivores$mass_mean_grams))
10^mean(log10(heavy_carnivores$mass_mean_grams)) 



log_mass_values = log10(heavy_carnivores$mass_mean_grams)
density_log_mass <- density(log_mass_values,adjust = 0.5)
peaks <- which(diff(sign(diff(density_log_mass$y))) == -2)
modes_log_mass <- density_log_mass$x[peaks]
modes_mass_grams <- 10^modes_log_mass


# Paleo Carnivora Mass Calculations

# Using MoM data
data <- read.csv('~/Dropbox/PostDoc/2024_PredSizeDiet/PredSizeDiet/data/carnivore_mass_MoM.csv', header = TRUE)

filtered_data <- subset(data, !Family %in% c("Phocidae", "Otariidae", "Odobenidae"))

mass_g = filtered_data$Mass_g;
mass_g = mass_g[which(mass_g>0)]

mass_kg = mass_g/1000;

hist(log10(mass_kg))

#Greater than 20 kg
large_mass_kg = mass_kg[which(mass_kg>=20)]
mean(large_mass_kg)
10^mean(log10(large_mass_kg)) #geometric mean

# No Bears, No Aquatic
filtered_data_nobears <- subset(data, !Family %in% c("Phocidae", "Otariidae", "Odobenidae","Ursidae"))
mass_g_nb = filtered_data_nobears$Mass_g;
mass_g_nb = mass_g_nb[which(mass_g_nb>0)]

mass_kg_nb = mass_g_nb/1000;

#Greater than 20 kg
large_mass_kg_nb = mass_kg_nb[which(mass_kg_nb>=20)]
mean(large_mass_kg_nb)
10^mean(log10(large_mass_kg_nb)) #geometric mean
