# SurveySpark

## Overview

I built this application to test out different ways to render a web-page and compare the performance. Feel free to use it to investigate any technology you find fascinating.

Trivia: SurveySpark is an application designed to streamline the process of creating and managing surveys. This guide will help you set up, run, and contribute to the project.

## Installation and Running

### Using Docker (preferred)
- docker-compose up --build
- (optional) to add 10 mil records to the database: run `rake import_data:faker_data` from the `surveyspark-web-1` container

### Using Homebrew and rbenv

0. **Ensure you have the following installed on your system**:
    - [Homebrew](https://brew.sh/)
    - [rbenv](https://github.com/rbenv/rbenv#installation)
    - [Yarn](https://classic.yarnpkg.com/lang/en/docs/install)
    - [PostgreSQL](https://www.postgresql.org/download/macosx/)

1. **Install Ruby 3.4.1**:
    ```bash
    rbenv install 3.4.1
    rbenv local 3.4.1
    ruby -v
    ```
   The last line should return the correct ruby version: `ruby 3.4.1`


2. **Setup SurveySpark**:
    ```bash
    ./bin/setup
    ```

3. **Start the server**:
    - Using the `dev` script:
        ```bash
        ./bin/dev
        ```
    - Or by running these commands in three separate terminals:
        ```bash
        rails server
        yarn build --watch
        yarn watch:css
        ```
4. http://localhost:3000/ should now be accessible in your browser.

## Running in Production
1. Install rbenv and Yarn
2. Install Ruby 3.2.0
3. Setup SurveySpark by running `./bin/setup_production`
4. Run `RAILS_ENV=production bin/rails s`
    - If you want to switch to development mode after working in production environment, run `rm -rf .bundle/` and follow the steps from `Installation and Running`

## Running Tests

- **Prerequisites**: we're using `capybara` + `selenium` + `chrome` for feature (integration) testing. Make sure you have `chromedriver` installed:
    ```bash
    brew install chromedriver
    xattr -d com.apple.quarantine /opt/homebrew/bin/chromedriver
    ```
- Run the whole test suite:
    ```bash
    rspec spec/
    ```
- Run only unit tests:
    ```bash
    rspec --exclude-pattern "spec/features/**/*_spec.rb"
    ```
- Run a particular test:
    ```bash
    rspec spec/decorators/survey_decorator_spec.rb
    ```

## Contributing

1. Fork the repository
2. Create a new branch by a pattern `feature/<your-feature-name>` or `fix/<important-bug-name>`
3. Add changes. Make sure you've attached tests that covered your changes
4. Run linter with `pronto run -c main` or `pronto run --unstaged` and fix any found issues
5. Create a pull request to the `main` branch of the repository

## Contact
If you have any questions or need help, feel free to contact me at [dmytro.lomako@gmail.com](mailto:dmytro.lomako@gmail.com)
