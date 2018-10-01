Workout 1 - Data Wrangling and Visualization
================
Ariel Yue
September 27, 2018

read\_csv(nba2018.csv)

experience\["R"\] &lt;- 0 experience &lt;- as.integer(experience)

salary &lt;- salary/1000000

position &lt;- factor(c('center', 'power\_fwd', 'point\_guard', 'small\_fwd', 'shoot\_guard'))
