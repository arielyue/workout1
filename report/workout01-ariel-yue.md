Workout 1 - Data Wrangling and Visualization
================
Ariel Yue
September 27, 2018

``` r
library(readr)
library(ggplot2)
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
teams <- read_csv('../data/nba2018-teams.csv')
```

    ## Warning: Missing column names filled in: 'X1' [1]

    ## Parsed with column specification:
    ## cols(
    ##   X1 = col_integer(),
    ##   team = col_character(),
    ##   experience = col_integer(),
    ##   salary = col_double(),
    ##   points3 = col_integer(),
    ##   points2 = col_integer(),
    ##   points1 = col_integer(),
    ##   points = col_integer(),
    ##   off_rebounds = col_integer(),
    ##   def_rebounds = col_integer(),
    ##   assists = col_integer(),
    ##   steals = col_integer(),
    ##   blocks = col_integer(),
    ##   turnovers = col_integer(),
    ##   fouls = col_integer(),
    ##   efficiency = col_double()
    ## )

5) Ranking of Teams
-------------------

#### Basic Rankings

``` r
ggplot(data = teams, aes(x = reorder(team, salary), y = salary)) +
    geom_bar(stat = 'identity', fill = 'grey') +
    geom_hline(aes(yintercept = mean(salary), col = 'red', linetype = 'solid', lwd = 1)) +
  coord_flip() +
  theme_minimal() +
  labs(title = "NBA Teams ranked by Total Salary", y = "Salary (in millions)", x = "Team" )
```

![](workout01-ariel-yue_files/figure-markdown_github/bar%20chart%20teams%20salary%20rank-1.png)

``` r
ggplot(data = teams, aes(x = reorder(team, points), y = points)) +
    geom_bar(stat = 'identity', fill = 'grey') +
    geom_hline(aes(yintercept = mean(points), col = 'red', linetype = 'solid', lwd = 1)) +
  coord_flip() +
  theme_minimal() +
  labs(title = "NBA Teams ranked by Total Points", y = "Points", x = "Team" )
```

![](workout01-ariel-yue_files/figure-markdown_github/bar%20chart%20teams%20points%20rank-1.png)

``` r
ggplot(data = teams, aes(x = reorder(team, efficiency), y = efficiency)) +
    geom_bar(stat = 'identity', fill = 'grey') +
    geom_hline(aes(yintercept = mean(efficiency), col = 'red', linetype = 'solid', lwd = 1)) +
  coord_flip() +
  theme_minimal() +
  labs(title = "NBA Teams ranked by Total Efficiency", y = "Efficiency", x = "Team" )
```

![](workout01-ariel-yue_files/figure-markdown_github/bar%20chart%20teams%20efficiency%20rank-1.png)

``` r
dat3 <- mutate(teams, def_strength =  steals + blocks) 
teams2 <- dat3 %>%
  group_by(team) %>%
  summarise(experience = sum(experience), salary = sum(salary), points3 = sum(points3), points2 = sum(points2), points1 = sum(points1), points = sum(points), off_rebounds = sum(off_rebounds), def_rebounds = sum(def_rebounds), assists = sum(assists), steals = sum(assists), blocks = sum(blocks), turnovers = sum(turnovers), fouls = sum(fouls), efficiency = sum(efficiency), def_strength = sum(def_strength))
```

``` r
ggplot(data = teams2, aes(x = reorder(team, def_strength), y = def_strength)) +
    geom_bar(stat = 'identity', fill = 'grey') +
    geom_hline(aes(yintercept = mean(def_strength), col = 'red', linetype = 'solid', lwd = 1)) +
  coord_flip() +
  theme_minimal() +
  labs(title = "NBA Teams ranked by Total Defense Strength", y = "Defense Strength", x = "Team" )
```

![](workout01-ariel-yue_files/figure-markdown_github/bar%20chart%20teams%20defense%20strength%20rank-1.png)

I created the index "*Defense Strength*", which measures the strength of each team's defense. I calculated this by adding *steals* and *blocks* to get the strength of each team's defense, since steals and blocks are both categories of defense. This allows you to rank teams based on their defense.

Comments and Reflections
------------------------

This was my first time working on a project with this file structure. Overall, I like the organization and I think that working with this file structure is useful for bigger projects. This was not my first time using relative paths, but they are important for reproducibility purposes because not everyone has the same home directory or direct paths, but people have similar relative paths. This was my first time using an R script. I think that just writing code without markdown syntax is very convenient because you don't need to create code chunks, but it is not as organized.

Something that was hard even though I saw them in class/lab was creating the ggplot barcharts because there are many different variables that I could change from size, color, theme, etc. Something that was easy even though we haven't done it in class/lab was creating the data dictionary. No one helped me complete this assignement and it took me 5-6 hours to complete this assignement. The most time consuming part was creating the **nba2018-teams.csv** because I had to update the data frame and do some data aggregation. Lastly, I thought that creating my own index was very interesting , because it gave me a new perspective on how to organize/ manipulate data.
