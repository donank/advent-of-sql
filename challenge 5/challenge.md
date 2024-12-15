Using the provided schema and data, write a SQL query that analyzes the daily toy production trends for each date in the table, comparing a date to the date before. The query should accomplish the following:

- List each day's production date and the number of toys produced on that day.
- Include the previous day's toy production next to each current day's production.
- Calculate the change in the number of toys produced compared to the previous day.
- Calculate the percentage change in production compared to the previous day.

The result set should display the following columns:

- `production_date`: The current date.
- `toys_produced`: Number of toys produced on the current date.
- `previous_day_production`: Number of toys produced on the previous date.
- `production_change`: Difference in toys produced between the current date and the previous date.
- `production_change_percentage`: Percentage change in production compared to the previous day.

Submit the `date` of the day with the largest daily increase in percentage