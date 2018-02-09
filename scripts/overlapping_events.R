ID = c(1,1,2,2,3)
Date = c(80,85,75,80,90)
Days = c(10,10,20,10,5)
Value = c(30,30,20,20,30)
df1 = data.frame(ID,Days, Date,Value)

ID = c(1,1,2,3,3)
Date = c(1,3,5,1,10)
Days = c(20,10,20,20,10 )
Value =c(30,20,30,10,10)
df2 = data.frame(ID,Days, Date,Value)



library(tidyverse)
df2 <- df2 %>%
  mutate(Date = Date + 90)

# Make a dataframe with complete set of day-ID combinations
df_completed <- df1 %>%
  mutate(day = factor(Date, levels = 1:180)) %>% # set to total day length
  complete(ID, day) %>%
  mutate(daysum = 0) %>%
  select(ID, day, daysum)

# Function to apply to each data frame containing events
# Should take each event and add value to the appropriate days
sum_df_daily <- function(df_complete, df){
  for (i in 1:nrow(df)){
    event_days <- seq(df[i, "Date"], df[i, "Date"] + df[i, "Days"] - 1)
    df_complete <- df_complete %>%
      mutate(
        to_add = case_when(
          ID == df[i, "ID"] & day %in% event_days    ~ df[i, "Value"],
          !(ID == df[i, "ID"] & day %in% event_days) ~ 0
        ),
        daysum = daysum + to_add
      )
  }
  return(df_complete)
}

df_filled <- df_completed %>%
  sum_df_daily(df1) %>%
  sum_df_daily(df2) %>%
  mutate(
    quarter = case_when(
      day %in% 1:90 ~ "q1",
      day %in% 91:180 ~ "q2"
    )
  )

df_filled %>%
  group_by(quarter, ID) %>%
  summarise(maxsum = max(daysum))
