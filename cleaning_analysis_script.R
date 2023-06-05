library(tidyverse)
library(lubridate)
library(ggplot2)
library(stringr)
library(forcats)

# Read in the data into their variables
trip_202205 <- read_csv("202205-divvy-tripdata.csv")
trip_202206 <- read_csv("202206-divvy-tripdata.csv")
trip_202207 <- read_csv("202207-divvy-tripdata.csv")
trip_202208 <- read_csv("202208-divvy-tripdata.csv")
trip_202209 <- read_csv("202209-divvy-tripdata.csv")
trip_202210 <- read_csv("202210-divvy-tripdata.csv")
trip_202211 <- read_csv("202211-divvy-tripdata.csv")
trip_202212 <- read_csv("202212-divvy-tripdata.csv")
trip_202301 <- read_csv("202301-divvy-tripdata.csv")
trip_202302 <- read_csv("202302-divvy-tripdata.csv")
trip_202303 <- read_csv("202303-divvy-tripdata.csv")
trip_202304 <- read_csv("202304-divvy-tripdata.csv")

# Compare each of the column names, they need to be the same
colnames(trip_202205)
colnames(trip_202206)
colnames(trip_202207)
colnames(trip_202208)
colnames(trip_202209)
colnames(trip_202210)
colnames(trip_202211)
colnames(trip_202212)
colnames(trip_202301)
colnames(trip_202302)
colnames(trip_202303)
colnames(trip_202304)

# Inspecting the data frames for incongruities
str(trip_202205)
str(trip_202206)
str(trip_202207)
str(trip_202208)
str(trip_202209)
str(trip_202210)
str(trip_202211)
str(trip_202212)
str(trip_202301)
str(trip_202302)
str(trip_202303)
str(trip_202304)

# Stack all the months into one big data frame
all_trips <- bind_rows(trip_202205, trip_202206, trip_202207, trip_202208, trip_202209, trip_202210, trip_202211, trip_202212, trip_202301, trip_202302, trip_202303, trip_202304)

# Remove the variables from the environment to clean up unused memory
rm(trip_202205)
rm(trip_202206)
rm(trip_202207)
rm(trip_202208)
rm(trip_202209)
rm(trip_202210)
rm(trip_202211)
rm(trip_202212)
rm(trip_202301)
rm(trip_202302)
rm(trip_202303)
rm(trip_202304)

# Inspect the new table
# Listing the column names
colnames(all_trips)
# How many observations (rows) in the data frame
nrow(all_trips)
# What's the dimensions of the data frame
dim(all_trips)
# See the first 6 rows of the data frame 
head(all_trips)
# See the last 6 rows of the data frame
tail(all_trips)
# See list of columns and data types 
str(all_trips)
# Get a statistical summary of the data
summary(all_trips)

# Add columns that lists the date, month, day and year of each ride
all_trips$date <- as.Date(all_trips$started_at)
all_trips$month <- format(as.Date(all_trips$date), "%m")
all_trips$day <- format(as.Date(all_trips$date), "%d")
all_trips$year <- format(as.Date(all_trips$date), "%Y")
# Convert day of the week to actual day not numeric type
all_trips$day_of_week <- format(as.Date(all_trips$date), "%A") 

# Add a ride length calculation to the data frame (in seconds)
all_trips$ride_length <- difftime(all_trips$ended_at, all_trips$started_at, units = "mins")

# Convert the ride_length from difftime to numeric so calculations can be done
all_trips$ride_length <- as.numeric(as.character(all_trips$ride_length))
is.numeric(all_trips$ride_length)

# Inspect the data frame
str(all_trips)

# Remove anything that has a negative ride length or 0 ride length or that are from head quarter or that are NA
all_trips <- all_trips[!(all_trips$ride_length <= 0 | is.na(all_trips$ride_length)),]
# Remove unnecessary columns from the data frame
all_trips <- all_trips[, -c(1, 6:13)]
# Remove outliers from the data based on +- 1.5 * IQR but first calculate the min/max iqr lower and iqr upper
alltrips_quartiles <- quantile(all_trips$ride_length, probs = c(.25, .75), na.rm = FALSE)
alltrips_IQR <- IQR(all_trips$ride_length)
alltrips_lower <- alltrips_quartiles[1] - 1.5 * alltrips_IQR
alltrips_upper <- alltrips_quartiles[2] + 1.5 * alltrips_IQR

all_trips <- subset(all_trips, all_trips$ride_length > alltrips_lower & all_trips$ride_length < alltrips_upper)

# Descriptive analysis on ride_length (all figures in minutes)
sum_ride_length <- summary(all_trips$ride_length)
# Descriptive analysis on day_of_week
day_of_week_mode <- mode(all_trips$day_of_week)
sum_day_of_week <- summary(all_trips$day_of_week)

# Order the days of the weeks
all_trips$day_of_week <- ordered(all_trips$day_of_week, levels=c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"))
# Let's look at the ride time for each day by member types
aggregate(all_trips$ride_length ~ all_trips$member_casual + all_trips$day_of_week, FUN=mean)

# Create some graphs
boxplot(all_trips$ride_length, horizontal = TRUE, main = "Summary of Ride Duration", xlab = "Ride Duration (in minutes)", col = "#D55E00", border =  "#0072B2")

all_trips %>%
  mutate(weekday = wday(started_at, label = TRUE)) %>%
  group_by(member_casual, weekday) %>%
  summarize(number_of_rides = n(), average_duration = mean(ride_length)) %>%
  arrange(member_casual, weekday)

all_trips %>%
  mutate(weekday = wday(started_at, label = TRUE)) %>%
  group_by(member_casual, weekday) %>%
  summarize(number_of_rides = n(), average_duration = mean(ride_length)) %>%
  arrange(member_casual, weekday) %>%
  ggplot(aes(x=weekday, y=number_of_rides, fill = member_casual)) +
  geom_col(position = "dodge") +
  scale_fill_manual(values = c("#D55E00", "#0072B2")) +
  scale_y_continuous(labels = scales::label_comma(), breaks = seq(0, 800000, 100000)) +
  labs(title = "Number of Rides by Rider Types", x = "Weekdays", y = "Number of Rides") +
  theme(plot.title = element_text(hjust = 0.5)) +
  guides(fill=guide_legend(title="Rider Types"))

all_trips %>%
  mutate(weekday = wday(started_at, label = TRUE)) %>%
  group_by(member_casual, weekday) %>%
  summarize(number_of_rides = n(), average_duration = mean(ride_length)) %>%
  arrange(member_casual, weekday) %>%
  ggplot(aes(x = weekday, y = average_duration, fill = member_casual)) +
  geom_col(position = "dodge") +
  scale_fill_manual(values = c("#D55E00", "#0072B2")) +
  scale_y_continuous(labels = scales::label_comma()) +
  labs(title = "Average Ride Duration by Rider Types", x = "Weekdays", y = "Average Ride Duration (in minutes)") +
  theme(plot.title = element_text(hjust = 0.5)) +
  guides(fill=guide_legend(title="Rider Types"))

all_trips %>%
  mutate(weekday = wday(started_at, label = TRUE)) %>%
  group_by(member_casual, weekday) %>%
  summarise(number_of_rides = n(), average_duration = mean(ride_length)) %>%
  arrange(member_casual, weekday) %>%
  ggplot(aes(x = average_duration, y = fct_rev(member_casual), fill = member_casual)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_fill_manual(values = c("#D55E00", "#0072B2")) +
  labs(title = "Average Ride Duration by Rider Types", x = "Average Duration (in minutes)", y = "Rider Types") +
  theme(plot.title = element_text(hjust = 0.5)) +
  guides(fill=guide_legend(title="Rider Types"))

count_data <- table(all_trips$member_casual)
count_df <- data.frame(Member_Casual = names(count_data), Count = as.numeric(count_data))

ggplot(count_df, aes(x = Member_Casual, y = Count, fill = Member_Casual)) +
  geom_bar(stat = "identity") +
  labs(title = "Counts of Member vs Casual Riders", x = "Rider Type", y = "Count") +
  scale_fill_manual(values = c("#D55E00", "#0072B2")) +
  scale_y_continuous(labels = scales::label_comma()) +
  theme(plot.title = element_text(hjust = 0.5)) +
  guides(fill = guide_legend(title = "Rider Types"))
  
ggplot(count_df, aes(x = "", y = Count, fill = Member_Casual)) +
  geom_bar(stat = "identity", width = 1) +
  geom_text(aes(label = Count), position = position_stack(vjust = 0.5)) +
  coord_polar(theta = "y") +
  labs(title = "Counts of Member vs Casual Riders", fill = "Rider Type", y = "Count") +
  scale_fill_manual(values = c("#D55E00", "#0072B2")) +
  guides(fill = guide_legend(title = "Rider Types")) +
  theme(axis.text = element_blank(),
        axis.ticks.y = element_blank(),
        axis.title = element_blank(),
        plot.title = element_text(hjust = 0.5))

