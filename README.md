# SurveySpark

## Overview
SurveySpark is a Ruby on Rails application designed to streamline the process of creating and managing surveys. This guide will help you set up, run, and contribute to the project.

## Prerequisites
Ensure you have the following installed on your system:
- [Homebrew](https://brew.sh/)
- [rbenv](https://github.com/rbenv/rbenv#installation)
- [Yarn](https://classic.yarnpkg.com/lang/en/docs/install)

## Installation and Running

### Using Homebrew and rbenv

0. **Install rbenv and Yarn**:
    ```bash
    brew install rbenv
    brew install yarn
    ```
If you have any issues with the steps below, please retry with the following versions: rbenv 1.2.0, yarn 1.22.21

1. **Install Ruby 3.2.0**:
    ```bash
    rbenv install 3.2.0
    rbenv local 3.2.0
    ruby -v
    ```
   The last line should return the correct ruby version: `ruby 3.2.0 (2022-12-25 revision a528908271) [arm64-darwin22]`


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

### Using Docker
- **Coming soon!**

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
If you have any questions or need help, feel free to contact us at [dmytro.lomako@gmail.com](mailto:dmytro.lomako@gmail.com) or [dlomako@griddynamics.com](mailto:dlomako@griddynamics.com)
