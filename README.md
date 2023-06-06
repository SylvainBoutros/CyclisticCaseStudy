# Cyclistic - Case Study
A case study done in order to complete the Google Data Analytics Professional Certificate

# Introduction

This project is part of the [Google Data Analytics Professional Certificate](https://www.coursera.org/professional-certificates/google-data-analytics). As a junior data analyst in Cyclistic’s marketing analyst team, I am tasked with analyzing the bike usage patterns of annual members and casual riders. Cyclistic, a bike-share company based in Chicago, launched its program in 2016 and has experience remarkable growth. With a fleet of 5,8214 geotracked bicycles distributed across 692 stations in the city, the program offers riders the flexibility to pick up and return bikes at any station within the system.

The finance analysts at Cyclistic have determined that annual members contribute higher profits compared to casual riders. Recognizing the importance of annual memberships for future growth, the director of marketing has assigned me the responsibility of understanding the differences in how annual members and casual riders utilize the bike-share service. By conducting an in-depth analysis of the historical bike trip data, my goal is to provide a comprehensive summary, including supporting visualizations and key findings, along with my top three recommendations based on the analysis.

This analysis will focus on identifying distinct usage patterns, including ride duration, frequency, popular routes and specific times and days of the week when the service is utilized the most. To align with the marketing strategy development timeline, I will complete this analysis within one week. The outcome of this project will play a crucial role in driving the future success of Cyclistic’s bike-share program.

To complete this project, I followed the six steps of the data analysis process: **ask**, **prepare**, **process**, **analyze**, **share**, and **act**

# Ask

1. **How do annual members and casual riders use Cyclistic bikes differently?**
2. **The key stakeholders are:**
    1. **Lily Moreno:** The director of marketing and my manager
    2. **Cyclistic Executive Team:** The executive team will decide whether to approve the recommended marketing program.


# Prepare

* Obtained the historical trip data from **Cyclistic** for analysis by downloading the previous 12 months of **[Cyclistic trip data](https://divvy-tripdata.s3.amazonaws.com/index.html) (May 2022 to April 2023)**
* The data is organized in a structured way, in **12 different comma-separated value (CSV)** files for each of the months
* There is no issue of bias or credibility. **For the purpose of this case study** the data seem to be **Reliable, Original, Comprehensive, Current, and Cited.**
* The data is made available by **Motivate International Inc.** under the specified **[license](https://ride.divvybikes.com/data-license-agreement)**
* The data does not contain any **personally identifiable information (PII)** of riders
* Data integrity is performed using data cleaning, validation, and verification to ensure accuracy and integrity of the data. These steps may include checking for missing values, outliers, and inconsistencies within the dataset.

**NOTES:**
There are some limitations with the dataset provided such as prices for membership, demographic information about the riders that could help in covering a more in-depth analysis. But as stated prior, for the purpose of this exercise the data is perfectly fine.


# Process

Excel and R were used to process the data. Excel is great at quickly glancing at the individual files before using R. After the initial glance, R was used for cleaning, analyzing, and visualizing the data

## Cleaning

* Removed **missing data** when it could not be added by the lookup of similar data
* Removed **duplicates** from observations
* Removed the following from the dataset: “**start_station_name**”, “**end_station_name**” “**start_lat**”, “**start_lng**”, “**end_lat**”, “**end_lng**”, “**start_station_id**”, and “**end_station_id**”
* Created “**day_of_week**” which represent the day of the week for each observation, “**ride_length**” as the duration (**in minutes**) based on start and end times, and “**date**” as the full date of the observations
* Removed observations that had "**ride_length**" **less than or equal to zero**
* Removed observations that had "**ride_length**" **outliers**
* Formatted "**day_of_week**" and "**ride_length**" as numeric, and later formatted "**day_of_week**" to a string

With these steps we transformed the data from its raw format to a usable format suitable for analysis.

# Analyze

After cleaning the data in R, I ran some descriptive analysis on the it. From May 2022 to April 2023, Cyclistic has serviced over 5, 000, 000 customers. I calculated the count of annual members and casual riders as can be seen in Figure 1. There was a total of 5,322,080 riders that used Cyclistic bike-share. Out of those 2,004,701 were casual riders and 3,317,379 were annual members. The days where we saw most of the activity were on Thursday for annual members and Saturday for casual riders. The average ride duration was approximately 13 minutes for the casual riders and approximately 11 minutes for the annual members.

Process, Analyze, and Sharewere done in R using this [script](cleaning_analysis_script.R)


# Share

## Summary of Ride Duration
![An overall summary of ride duration](https://github.com/SylvainBoutros/CyclisticCaseStudy/blob/main/Visualization/summary_of_ride_duration.png)

## Count of Riders
![A pie chart representing the annual members vs. casual riders over the last 12 months](https://github.com/SylvainBoutros/CyclisticCaseStudy/blob/main/Visualization/Count_Riders.png)

## Average Ride Duration by Rider Types
![A bar chart representing the average ride duration by annual members and casual riders](https://github.com/SylvainBoutros/CyclisticCaseStudy/blob/main/Visualization/average_ride_duration.png)

## Average Ride Duration by Rider Types and Weekdays
![A bar chart representing the average ride duration by annual members and casual riders and weekdays](https://github.com/SylvainBoutros/CyclisticCaseStudy/blob/main/Visualization/average_ride_duration_by_day.png)

## Number of Rides by Rider Types and Weekdays
![A bar chart representing the total number of riders by annual members and casual riders and weekdays](https://github.com/SylvainBoutros/CyclisticCaseStudy/blob/main/Visualization/number_of_rides_by_rider.png)


# Act

## Conclusion
My conclusion is that Cyclistic’s customers used the bike-sharing services differently.  Annual members used the services more frequently than the casual riders over Monday-Saturday and had a peak usage on Thursdays. Casual riders used the services more frequently on Saturday. Based on the average ride duration and consistency of user, we can conclude that annual member commute daily, whilst casual riders use the services for leisure. 

## Recommendations
Creating different memberships to attract casual riders based on their need, such as a weekend membership. Additionally, creating a loyalty program for annual members might help in increasing the numbers. Lastly, expanding the network to covert a bigger territory would help grow the services.  

[Cyclistic Case Study Report](Documentation.pdf)
