Freelancer Helper is a web app with utilities to **help freelancers get organized, earn more and work less**. This is version 2.0 using **Ruby on Rails**, with a major code refactor and new functionalities. You can check the first version (using Python and Flask) in [this repo](https://github.com/Epersea/freelancerhelperLEGACY).

## KEY POINTS: WHAT I LEARNED
This is a **practice project for learning Ruby on Rails**. These are the main functionalities I have used:
- **Model** creation and validation, including **associations** `has_one, has_many, has_many through` and `belongs_to`, and custom methods for creating and updating Model objects (which make use of the `tap` method). I have also implemented **transactions** and created callbacks with custom methods to ensure database integrity.
- Use of **migrations** to create and update database tables.
- **Controller** creation and routing. Some of my controllers implement the full range of Rails `:resources`, while others only implement a few selected actions depending on functionality requirements. Also, the Project routes implement **shallow nesting** to avoid cumbersome URLs. 
- I have defined **methods and callbacks at the application and controller levels** to restrict functionalities to authorized and logged in users. Controllers also make use of **strong params** for input sanitization.
- **View** creation, including use of ERB logic and refactorization with **partials**. Many views include a notice div at the top to display useful information to users. I also modified the **application layout** to display a sidebar, with different links displayed depending on login status.
- Implementation of **custom code** (RateCalculator class and subclasses), which can be found in `/lib`.
- Use of Rail's **current attributes** to keep current user easily available to the whole application.
- Model **concerns** and test authorization **helpers** to DRY the code.
- **Unit testing** with Rspec
- **Model, controller and system testing** with fixtures, using Minitest and Capybara. 
- Customized **rake** task to run all tests with a single command.

I have also seized the opportunity to learn a bit about **GitHub Actions** and have implemented a job that runs the test on pushes and pull requests.

## THE WHY AND THE HOW

In December 2023, I started studying Ruby on Rails, using mostly the following resources:
- [Rails official guides](https://guides.rubyonrails.org/)
- [Go Rails courses](https://gorails.com/)
- [Agile Development with Rails 7 (book)](https://pragprog.com/titles/rails7/agile-web-development-with-rails-7/)

Of course, theory only goes so far when studying a framework, so I decided to practice by re-doing a small Python/Flask project I had completed as part of HardvardX's [CS50x course](https://pll.harvard.edu/course/cs50-introduction-computer-science). And thus, Freelancer Helper was born.

### PROJECT SCOPE

The first Python/Flask version of this project provided basic login, rate and client registry functionalities. To better understand how the project was structured, feel free to check these diagrams:
- [Main arquitecture](https://docs.google.com/drawings/d/1nIko25347kkcLwLU92kMBPFsx5e0ZW8EgUFST3ifFMs/edit)
- [User login](https://docs.google.com/drawings/d/1PcuCHxusH1pOC_cuX2Jw8syg4l4Onk9l0NLB-suJx7k/edit)
- [Rate calculator](https://docs.google.com/drawings/d/1lDKDnqO1IVDD7xzCaR2aIuvh38-cLiNgl-O-04UjpwY/edit)
- [Client registry](https://docs.google.com/drawings/d/13TjacvDyhXpk6MeBfoCJFR2DT5N0u4bahHVpGZqoKhU/edit)

For this new version in Rails, I wanted to **expand the functionalities** so the user could see information in a per-project basis, not only lumped by client, as well as polish the experience overall. My main focus was on **improving code quality**, applying OOP principles, separation of concerns and thorough testing.

### PROJECT ORGANIZATION

To organize the work, I divided the project into **4 main functionalities or "slices"** that would give me the opportunity to practice creating models, controllers and views for each one of them:
1. Rate Calculator
2. User management
3. Clients
4. Projects


### 1. RATE CALCULATOR

#### DESCRIPTION AND ACCEPTANCE CRITERIA
The rate calculator is the **core functionality of the application**. The user visits a form and fills it with information regarding several aspects of their business, such as their planned expenses, how much they want to work and their desired earnings.

After clicking on "Calculate", the user is redirected to a page where they can see what is the **minimum rate per hour** they should be charging to achieve their goals, as well as an explanation of the calculations. 

The main **acceptance criteria** for this functionality are:
- Users should be able to input information about their long-term, annual and monthly **expenses**
- Users should be able to input information about the number of hours per day and days per week they want to work, as well as planned off days
- Users should be able to input information about their desired **net monthly salary** and **expected taxes**
- Users should see information about their desired **rate per hour** and an explanation of the calculations
- Users should be able to **edit the information provided** and see their adjusted rate
- The rate info should be stored so users can revisit it later
- Users should be able to **delete their rate**

![](/app/assets/images/rate_calculator_show.png)

#### IMPLEMENTATION

#### Models
This functionality relies on two models:
- The **Rate model** handles the information related to a user's final goal rate and the intermediate calculations displayed (total annual expenses, tax percent, net monthly earnings, hours worked per year an so on). It includes methods for both creating a new rate and updating an existing one.
- The **Rate::Input model** is a Rate association that handles the information introduced by a user to calculate a Rate, and is created and updated in tandem with a Rate. This information is organized in three attributes:
  - **Expenses**: data related to long term, annual and monthly expenses.
  - **Hours**: data related to the time the user plans to work, taking into account factors like the number of hours per day / days per week, holidays and training.
  - **Earnings**: data related to the user's earning goals (expected net monthly earnings and taxes).

Tests for the Rate model focus on ensuring that validations work correctly, and that the association with Rate::Input performs as expected.

#### Controllers, routers and views
I have used the standard conventions provided by **resources :rate**. Some things of note:
- The **#new route** takes the user to the Rate Calculator form, which is also divided into Expenses, Hours and Earnings sections. I used parameter naming conventions to structure the params hash to facilitate legibility and aid in further calculations.
- The **#create route** uses a method called `rate_input` that sanitizes the information received using strong parameters for expenses, hours and earnings. Then, this information is sent to the `create_for` method of the Rate model, where the associated input is updated. For both this and the `update_for` methods, I have implemented transactions to ensure database integrity. Then, the input is sent to the **RateCalculator lib class**, which performs the necessary calculations. The resulting information is then stored in the Rate.

I have included both **controller and system tests** for the above routes.

#### RateCalculator class
The RateCalculator class, which resides in /lib, is responsible for **performing the calculations needed to display a rate and assign them to a rate record**.

To do this, it relies on three secondary objects which deal with expenses, hours and earnings. I focused on creating clean, [fractal](https://dev.37signals.com/fractal-journeys/) code with clear names, with **unit testing for public methods** (both at the rate calculator and secondary object levels) using Rspec.

### 2. USER MANAGEMENT

#### DESCRIPTION AND ACCEPTANCE CRITERIA
Since this is a practice project, I decided to try to implement user management functions myself, using the tutorial in Agile Development with Rails 7 as a base, instead of relying on a library.

The **acceptance** criteria for this functionality are:
- Users should be able to **register** a new account
- Users should be able to **edit** their account details
- Users should be able to **delete** their account
- Users should be able to **log in** into their account
- Users should be able to **log out** of their account
- When a logged in user uses the Rate Calculator, their **user id** will be added to their rate
- When a logged in user visits My Summary page, they will view a **summary of their rate results** 
- When a logged out user visits My Summary page, they will be **prompted to log in**
- Log in/ log out users can see different **admin options** in a sidebar

#### IMPLEMENTATION

- I defined the following **relationship between models**:
```
User has_one :rate, dependent: :destroy
Rate belongs_to :user, optional: true
```
- The **User controller** has the standard methods to create, update and delete Users. 
- I created a **Session controller** to manage the login and logout functionalities. When a user is logged in, its `user_id` is added to the `session` object. This provides an easy-to-check property so other controllers/methods can see if an user is logged in and identify them correctly. In this context, "logging out" just means that the `user_id` property of the `session` object is set to `nil`.
- To manage the display of information to logged in users, I create a **MySummary controller** with just an index method. This index displays the rate calculator information associated with the user. If the user is logged out, it redirects them to the login page. If the user is logged in but hasn't provided any Rate information, it prompts them to do so.
- To limit access to logged in users, I have defined a **protected `authorize` method in `application_controller.rb`** as a before_action, which makes use of Current Attributes to keep track of the current user. Some controllers/actions skip this method to allow access to non-logged users.
- I have edited the **Rate controller** to display/edit the associated rate to logged in users and prevent users from creating multiple rates. I make use of **notices** to display useful information to the user, for example, informing them they are attempting a forbbiden action or confirming a successful login/logout.
- To provide easier access to the new functionalities, I have created a **sidebar** that displays the main application links, Register and Login (for logged out users) and My Account and Logout (for logged in users).
- Finally, I have created **tests** for the User model and the User, Session and MySummary controllers, as well as system tests covering the users and sessions functionality.

### 3. CLIENTS

#### DESCRIPTION AND ACCEPTANCE CRITERIA
The third slice of the app covers **client functionality**. A user can add a new client introducing its name. They can also add information about projects completed for this client (see 4 below), that will be used to calculate the total number of hours worked, amount billed and rate per hour. Clients are stored in the database and the user can check them individually or see a summary of all their clients. 

Client information is also displayed at **My Summary** page. If the user has provided information about rates, they will also see a brief message depending on their client rates being above or below their goal rate. 

The **acceptance** criteria for this functionality are:
- Users should be able to **add a new client**
- Users should be able to **edit** an existing client
- Users should be able to **delete** a client
- Only **logged in users** should be able to add/edit/delete clients
- When a logged in user visits My Summary page, they will view a **summary** of their client stats


#### IMPLEMENTATION
- I defined a **Client model**. A client `belongs_to` a user, and a user `has_many` clients. 
- The **Client controller** handles the standard actions. I have included some logic to prevent a user from creating a client with the same name twice.
- I have also created the corresponding **Client views**, with partials for `_client` and `_form`.
- To display client information, I have edited **My Summary controller and view**. Now, the controller fetches the client info to display and determines the message to display based on a rate evaluation.
- I have also created **tests** for Client model validations, Client controller routes (including authorization) and system tests for the client functionality, as well as updating My Summary tests.


### 4. PROJECTS

#### DESCRIPTION AND ACCEPTANCE CRITERIA
The **project functionality** allows the user to create projects for each client, detailing the work completed. For instance, a project may be a logo redesign or a website translation. Projects include information about hours worked, amount billed and start and end dates.

Each project **belongs to a client**, and every time that a project is added, deleted or updated, the corresponding client's information **updates in sync**. The user can also see a list of all the projects belonging to a client or check them individually.

The **acceptance criteria** for this functionality are:
- Users should be able to see a **list of projects with stats** for each client
- Users should be able to **add** a new project
- Projects are **automatically aggregated** into clients
- Users should be able to **edit** a project
- Users should be able to **delete** a project
- When a project is modified/deleted, client is **updated automatically**
- Only **logged in users** should be able to add/edit/delete projects
- Hours worked and amount billed can only be edited through projects


#### IMPLEMENTATION
- I have implemented the project routes with **shallow nesting** to avoid cumbersome URLs and facilitate access to project resources.
- The **Project model** validates the input data, including a custom method to check that the end date is later than the start date. It also calculates the individual project's rate via a `before_save` callback.
- Now Clients are initialized with 0 hours worked and amount billed, and this information is added later through Projects.
- Before saving or destroying a record, the Project model calls the Client model `update_stats` method, so the new project information is incorporated.
- Since both the Project and the Client models have to calculate rates, I have created a **RateSetter concern** that is included in both.
- Finally, I have also updated the User model with a `has_many :through` **association**, which allows the Project controller to access projects directly via Current.user.
- As usual, I have included **tests** for model validations and callbacks and controller actions, as well as system tests.

## PLANNED IMPROVEMENTS
The main functionalities of version 1.0 are completed, but there are many ways I would like to keep growing and developing this application. These are some ideas for the future:
- **Filtering/ordering** clients and projects
- Improved and more detailed **statitics** for MySummary page, possibly including graphics
- **PDF reports** to be downloaded and/or sent to users via email
- Creating an **API** to interface with other applications
- **Internationalization** to display information in both English and Spanish
- **Currency** support
- **Hotwiring** MySummary page so it can load items uploaded in another browser tab
- **Asynchronous** client updating with ActiveJob


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

### Running the tests
- To run the model, controller and system tests: ```rails test:all -v```
- To run the library tests: ```rspec```
- Alternatively, you can run all test with this rake task: ```rake tests:run_all```

### Running the application
To execute the application, run the development server with ```bin/dev```

Visit http://localhost:3000 to access the app. If needed, you can change the default port in the bin/dev file.
