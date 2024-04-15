Freelancer Helper is a web app with utilities to help freelancers get organized, earn more and work less. This is version 2.0 using Ruby on Rails, with a major code refactor and new functionalities. You can check the first version (using Python and Flask) in [this repo](https://github.com/Epersea/freelancerhelperLEGACY).

Currently, this a work in progress. Please check [this presentation](https://docs.google.com/presentation/d/1JbWWOwOo35lFC8JhxrZ8EUhQx-9nscmbsC73P5WCXT0) for more details about the scope of the project and planned improvements over the legacy version.

## KEY POINTS: WHAT I LEARNED
This is a **practice project for learning Ruby on Rails**. These are the main functionalities I have used:
- **Model** creation and validation, including **associations** (`Rate` and `Rate::Input`), `has_one, has_many` and `belongs_to` **relationships**, and custom methods for creating and updating Model objects (which make use of the `tap` method). I have also implemented **transactions** to ensure database integrity.
- Use of **migrations** to create and update database tables.
- **Controller** creation and routing. Some of my controllers implement the full range of Rails `:resources`, while others only implement a few selected actions depending on functionality requirements. I have defined **methods and callbacks at the application and controller levels**, for instance, to restrict functionalities to authorized and logged in users. Controllers also make use of **strong params** for input sanitization.
- **View** creation, including use of ERB logic and refactorization with **partials**. Many views include a notice div at the top to display useful information to users. I also modified the application layout to display a sidebar, with different links displayed depending on login status.
- Implementation of **custom code** (RateCalculator class and subclasses), which can be found in `/lib`.
- Use of Rail's **current attributes** to keep current user easily available to the whole application.
- **Unit testing** with Rspec
- **Model, controller and system testing** with fixtures using Minitest and Capybara. I also defined **helpers** for authorization methods to be shared among tests

## THE WHY AND THE HOW

In December 2023, I started studying Ruby on Rails, using mostly the following resources:
- [Rails official guides](https://guides.rubyonrails.org/)
- [Go Rails courses](https://gorails.com/)
- [Agile Development with Rails 7 (book)](https://pragprog.com/titles/rails7/agile-web-development-with-rails-7/)

Of course, theory only goes so far when studying a framework, so I decided to practice by re-doing a small Python/Flask project I had completed as part of HardvardX's [CS50x course](https://pll.harvard.edu/course/cs50-introduction-computer-science). And thus, Freelancer Helper was born.

To organize the work, I divided the project into **4 main functionalities or "slices"** that would give me the opportunity to practice creating models, controllers and views for each one of them:
1. Rate Calculator
2. User management
3. Clients
4. Projects

A rough blueprint of the functionalities can be found [in this document](https://docs.google.com/document/d/1wpJ2rE1mnw8bWZ_sl8J0sQqP_ie4fbU_BSkfsvhLAso/edit).

### 1. RATE CALCULATOR
The rate calculator is the **core functionality of the application**. The user visits a form and fills it with information regarding several aspects of their business, such as their planned expenses, how many hours a day and days a week they want to work and their desired earnings.

After clicking on "Calculate", the user is redirected to a page where they can see what is the minimum rate per hour they should be charging in order to achieve their goals, as well as an explanation of the calculations. They can easily edit their input information to play with the variables, for example, what would happen if they decide to work 4 days a week instead of 5.

![](/app/assets/images/rate_calculator_show.png)

### Models
This functionality relies on two models:
- The **Rate model** handles the information related to a user's final goal rate and the intermediate calculations displayed (total annual expenses, tax percent, net monthly earnings, hours worked per year an so on). It includes methods for both creating a new rate and updating an existing one.
- The **Rate::Input model** is a Rate association that handles the information introduced by a user in order to calculate a Rate, and is created and updated in tandem with a Rate. This information is organized in three rows, that respond to a conceptual division that we will see repeated through the different layers of the application:
  - **Expenses**: data related to planned expenses, be it long term, annual or monthly.
  - **Hours**: data related to the time the user plans to work, taking into account factors like the number of hours per day / days per week, holidays and training.
  - **Earnings**: data related to the user's earning goals (expected net monthly earnings and taxes).

Tests for the Rate model focus on ensuring that validations work correctly, and that the association with Rate::Input perfoms as expected (rate inputs and rates are created and updated in tandem).

### Controllers, routers and views
I have used the standard conventions provided by **resources :rate**. Some things of note:
- The **#new route** takes the user to the Rate Calculator form, which is also divided into Expenses, Hours and Earnings sections. I used parameter naming conventions to structure the params hash to facilitate legibility and aid in further calculations.
- The **#create route** uses a method called rate_input that sanitizes the information received using strong parameters for expenses, hours and earnings. Then, this information is sent to the create_for method of the Rate model, where the associated input is updated. For both this and the update_for methods, I have implemented transactions to ensure database integrity. Then, the input is sent to the **RateCalculator lib class**, which performs the necessary calculations. The resulting information is then stored in the Rate.

I have included both **controller and system tests** for the above routes, which were a great opportunity to get familiar with the Minitest and Capybara suites and Rails fixtures.

### RateCalculator class
The RateCalculator class, which resides in /lib, is responsible for **performing the calculations needed to display a rate and assign them to a rate record**.

To do this, it relies on three secondary objects which deal with expenses, hours and earnings. I focused on creating clean, [fractal](https://dev.37signals.com/fractal-journeys/) code with clear names, with unit testing for public methods (both at the rate calculator and secondary object levels) using Rspec. These tests can be executed locally with the command `bundle exec rspec`.

### 2. USER MANAGEMENT
Since this is a practice project, I decided to try to implement user management functions myself, using the tutorial in Agile Development with Rails 7 as a base, instead of relying on a library.

This "slice" includes the following functionalities:
- **Registering** new user accounts
- **Login** into and out of an account
- When a logged in user uses the Rate Calculator, their **rate information** will be stored for later retrieval
- A logged in user can see a **summary** of their information

To achieve this, I first focused on the **User scaffolding**. I added a foreign key called `user_id` to the Rates table, and defined the following **relationship between models**:
```
User has_one :rate, dependent: :destroy
Rate belongs_to :user, optional: true
```
The **User controller** has the standard methods to create, update and delete Users. 

I also created a **Session controller** to manage the login and logout functionalities. When a user is logged in, its `user_id` is added to the `session` object. This provides an easy-to-check property so other controllers/methods can easily see if an user is logged in and identify them correctly. In this context, "logging out" just means that the `user_id` property of the `session` object is set to `nil`.

To manage the display of information to logged in users, I create a **MySummary controller** with just an index method. This index displays the rate calculator information associated with the user. If the user is logged out, it redirects them to the login page. If the user is logged in but hasn't provided any Rate information, it prompts them to do so.

To limit access to logged in users, I have defined a **protected `authorize` method in `application_controller.rb`** as a before_action, which makes use of Current Attributes to keep track of the current user. Some controllers/actions skip this method to allow access to non-logged users.

I have also edited the Rate controller to display/edit the associated rate to logged in users and prevent users from creating multiple rates. I make use of **notices** to display useful information to the user, for example, informing them they are attempting a forbbiden action or confirming a successful login/logout.

To provide easier access to the new functionalities, I have created a **sidebar** that displays the main application links, Register and Login (for logged out users) and My Account and Logout (for logged in users).

Finally, I have created **tests** for the User model and the User, Session and MySummary controllers, as well as system tests covering the users and sessions functionality.

### 3. CLIENTS
The third slice of the app covers **client functionality**. A user can add information about a client (name, hours worked and amount billed) and the app will calculate the rate per hour for that particular client. Clients are stored in the database and the user can check them individually or see a summary of all their clients. 

Client information is also displayed at **My Summary** page. If the user has provided information about rates, they will also see a brief message depending on their client rates being above or below their goal rate. 

Some areas of note about this functionality:
- I defined a **Client model**. A client `belongs_to` a user, and a user `has_many` clients. As in the case of Rate models, we have to perform a rate calculation, which is handled with a `before_save` callback.
- The **Client controller** handles the standard actions. I have included some logic to prevent a user from creating a client with the same name twice.
- I have also created the corresponding **Client views**, with partials for `_client` and `_form`.
- In order to display client information, I have edited **My Summary controller and view**. Now, the controller fetches the client info to display and determines the message to display based on a rate evaluation.
- I have also created **tests** for Client model validations, Client controller routes (including authorization) and system tests for the client functionality, as well as updating My Summary tests.

At this point in the development process, I also spend some time **refactoring the app**, including:
- Unifying redirections between different controllers so the app behaves in a consistent way.
- Making use of Current Attributes.
- Creating an AuthenticationHelper for controller and system tests.


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
