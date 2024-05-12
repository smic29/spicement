# Development Notes
With this project, I chose to work my way up from the database schema up to the views and implementing tests along the way to emulate the best practice of test-driven development.

## Objective
The goal is to be able to implement a booking management system that would display a user's quotations, bookings, billings, and maybe their contacts. These would be the main pages of the application and I plan to implement turbo frames on each one and see where I can go from there. 

## Schema
I based most of the tables around the spreadsheets commonly used by my wife. I started building tables from Users all the way down to the billings table. It took 2 days to build the base schema which looks like this:
![Initial Schema](app/assets/images/Schema_051324.jpg)

This is just the base I'm working with, which means its likely to change. The current associations are also not set in stone and would be updated as needed.