# ======================================
# Title: Preparing NBA Teams 2018 Data
# Description: 
#   This script performs cleaning tasks and transformations on various columns of the raw data file.
# Input(s): data file 'nba2018.csv' 
# Output(s): data file 'nba2018-teams.csv'
#=======================================

#packages
library(dplyr)
library(readr)

#import data
dat <- read_csv('../data/nba2018.csv')

#A bit of preprocessing
dat$experience[dat$experience == "R"] <- 0
dat$experience <- as.integer(dat$experience)

dat$salary <- dat$salary/1000000

levels(dat$position) <- factor(c('C' = 'center', 'PF' = 'power_fwd', 'PG' = 'point_guard', 'SF' = 'small_fwd', 'SG' = 'shoot_guard'))

#Adding new variables
dat2 <- mutate(dat, 
       missed_fg = field_goals_atts - field_goals, 
       missed_ft = points1_atts - points1, 
       rebounds = off_rebounds + def_rebounds, 
       efficiency = (points + rebounds + assists + steals + blocks - missed_fg - missed_ft - turnovers) / games
)

sink(file = '../output/efficiency-summary.txt')
summary(dat2[ ,'efficiency'])
sink()

#Creating nba2018-teams.csv
teams <- dat2 %>%
  group_by(team) %>%
  summarise(experience = sum(experience), salary = sum(salary), points3 = sum(points3), points2 = sum(points2), points1 = sum(points1), points = sum(points), off_rebounds = sum(off_rebounds), def_rebounds = sum(def_rebounds), assists = sum(assists), steals = sum(assists), blocks = sum(blocks), turnovers = sum(turnovers), fouls = sum(fouls), efficiency = sum(efficiency))

sink(file = '../output/teams-summary.txt')
summary(teams)
sink()

write.csv(teams, file = "../data/nba2018-teams.csv", row.names = FALSE)

