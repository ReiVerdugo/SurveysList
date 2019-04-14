# SurveysList
A native iOS application on Swift to display a list of surveys

## Implementation
For the list of surveys the UI structure chosen to use was a **UIPageViewController**, since it provides the functionality of scrolling vertically using a full view, and it also helps updating the number of the current survey in the indicator list (bullets)

### Page Control
The Page Control can be limited by providing the size limit (maximum number of bullets to be displayed in the indicator list) in the Constanst file. 
If the numer of surveys is greater than the limit, the index of the bullet will be calculated by dividing the current index by the number of items that can be displayed by bullet.
Otherwise, if the number of surveys is lower than the limit, no calculations are done and the values are asigned as is.


## Project structure

The project is structed by features, with each feature having its own subgroup including **Controllers**, **API**, **Views** and **Models**

## UI tests
For the UI tests, the following test cases were considered:
* The current page on page indicator is updated when scrolling
* When tapping a survey, the right detail is displayed
* When reaching the bottom of the list, the pagination request works as expected
* When pressing refresh, the surveys are updated as expected

## Unit tests
For the unit tests, the following code was tested:
* Initialization of the model
* Initialization of the view model
* Initialization of the view controller, as well as the data source and page control values


## API Requests
There are only two API requests included:
* `renewToken` 
* `getSurveys`. It can use paginated requests given the proper parameters 
