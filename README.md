Freelancer Helper is a web app with utilities to help freelancers get organized, earn more and work less. This is version 2.0 using Ruby on Rails, with a major code refactor and new functionalities. You can check the first version in [this repo](https://github.com/Epersea/freelancerhelperLEGACY).

Currently, this a work in progress. Please check [this presentation](https://docs.google.com/presentation/d/1JbWWOwOo35lFC8JhxrZ8EUhQx-9nscmbsC73P5WCXT0) for more details about the scope of the project and planned improvements over the legacy version.

## THE WHY AND THE HOW
In December 2023, I started studying Ruby on Rails, using mostly the following resources:
- [Rails official guides](https://guides.rubyonrails.org/)
- [Go Rails courses](https://gorails.com/)
- [Agile Development with Rails 7 (book)](https://pragprog.com/titles/rails7/agile-web-development-with-rails-7/)

Of course, theory only goes so far when studying a framework, so I decided to practice by re-doing a small Python/Flask project I had completed as part of HardvardX's CS50x course. And thus, Freelancer Helper was born.

To organize the work, I divided the project into 4 main functionalities or "slices", that would give me the opportunity to practice creating models, controllers and views for each one of them:
1. Rate Calculator
2. User management
3. Clients
4. Projects

A rough blueprint of the functionalities can be found [in this document](https://docs.google.com/document/d/1wpJ2rE1mnw8bWZ_sl8J0sQqP_ie4fbU_BSkfsvhLAso/edit).

### RATE CALCULATOR
The rate calculator is the core functionality of the application. The user visits a form and fills it with information regarding several aspects of their business, such as their planned expenses, how many hours a day and days a week they want to work and their desired earnings.

After clicking on "Calculate", the user is redirected to a page where they can see what is the minimum rate per hour they should be charging in order to achieve their goals, as well as an explanation of the calculations. They can easily edit their input information to play with the variables, for example, what would happen if they decide to work 4 days a week instead of 4.

![](/app/assets/images/rate_calculator_show.png)

### Models
This functionality relies on two models:
- The Rate model handles the information related to a user's final goal rate and the intermediate calculations displayed (total annual expenses, tax percent, net monthly earnings, hours worked per year an so on). It includes methods for both creating a new rate and updating an existing one.
- The Rate::Input model is a Rate association that handles the information introduced by a user in order to calculate a Rate, and is created and updated in tandem with a Rate. This information is organized in three rows, that respond to a conceptual division that we will see repeated through the different layers of the application:
  - Expenses: data related to planned expenses, be it long term, annual or monthly.
  - Hours: data related to the time the user plans to work, taking into account factors like the number of hours per day / days per week, holidays and training.
  - Earnings: data related to the user's earning goals (expected net monthly earnings and taxes).

Tests for the Rate model focus on ensuring that validations work correctly, and that the association with Rate::Input perfoms as expected (rate inputs and rates are created and updated in tandem).

### Controllers, routers and views
At this point in the development process, the #index route just displays general information about the project and a link to the Rate Calculator.

The #new route takes the user to the Rate Calculator form, which is also divided into Expenses, Hours and Earnings sections. I used parameter naming conventions to structure the params hash to facilitate legibility and aid in further calculations.

The #create route uses a method called rate_input that sanitizes the information received using strong parameters for expenses, hours and earnings. Then, this information is sent to the create_for method of the Rate model, where the associated input is updated. Then, the input is sent to the RateCalculator lib class, which performs the necessary calculations. The resulting information is then stored in the Rate.

The #show route displays information related to a Rate, including the goal rate per hour and the intermediate calculations, as well as links for editing and deleting information.

In the #edit route, the user accesses a pre-filled form (information is recovered from the Input associated with the Rate to edit). This way, they only have to fill the fields they want to modify.

The #update route relies again on rate_input to sanitize information and sends it to the update method on the model, which updates both rate and input. For both this and the create_for methods, I have implemented transactions to ensure database integrity.

Finally, the #destroy route deletes a rate and its associated input.

I have included both controller and (quite basic) system tests for the above routes, which were a great opportunity to get familiar with the Minitest suite and Rails fixtures.

### RateCalculator class
The RateCalculator class, which resides in /lib, is responsible for performing the calculations needed to display a rate and assign them to a rate record.

To do this, it relies on three secondary objects which deal with expenses, hours and earnings. I focused on creating clean, [fractal](https://dev.37signals.com/fractal-journeys/) code with clear names, with unit testing for public methods (both at the rate calculator and secondary object levels). These tests can be executed locally with the command `bundle exec rspec`.


## HOW TO RUN THE APPLICATION

### Prerequisites
Before you begin, ensure you have the following installed:
- Ruby 3.2 or higher
- Rails 7.1 or higher

### Installing
Follow these steps to get your development environment set up:
1. Clone the repository
```git clone https://github.com/Epersea/freelancer_helper_rails.git```
2. Change into the project directory
```cd your-repo```
3. Install dependencies: ```bundle install```
4. Update database by running migrations: ```rails db:migrate```

### Running the application
To execute the application, run the development server with ```bin/dev```

Visit http://localhost:3000 to access the app. If needed, you can change the default port in the bin/dev file.

## UPDATES
- 13-Jan-23: first working version of Rate Calculator completed.
- 19-Jan-23: Rate Calculator update and delete routes completed + validations and testing.
- 25-Jan-23: Rate Calculator model update and final refactor.