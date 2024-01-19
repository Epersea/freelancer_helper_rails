Freelancer Helper is a web app with utilities to help freelancers get organized, earn more and work less. This is version 2.0 using Ruby on Rails, with a major code refactor and new functionalities. You can check the first version in [this repo](https://github.com/Epersea/freelancerhelperLEGACY)

Currently, this a work in progress. Please check [this presentation](https://docs.google.com/presentation/d/1JbWWOwOo35lFC8JhxrZ8EUhQx-9nscmbsC73P5WCXT0) for more details about the scope of the project and planned improvements over the legacy version.

### HOW TO RUN THE APPLICATION

#### Prerequisites
Before you begin, ensure you have the following installed:
- Ruby 3.2 or higher
- Rails 7.1 or higher

#### Installing
Follow these steps to get your development environment set up:
1. Clone the repository
```git clone https://github.com/Epersea/freelancer_helper_rails.git```
2. Change into the project directory
```cd your-repo```
3. Install dependencies: ```bundle install```
4. Update database by running migrations: ```rails db:migrate```

#### Running the application
To execute the application, run the development server with ```bin/dev```

Visit http://localhost:3000 to access the app. If needed, you can change the default port in the bin/dev file.

### UPDATES
- 13-Jan-23: first working version of Rate Calculator completed.
- 19-Jan-23: Rate Calculator update and delete routes completed + validations and testing.