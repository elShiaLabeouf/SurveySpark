# SurveySpark
Ruby 3.2.0

## Installation and running

### Using [homebrew](https://brew.sh/) and [rbenv](https://github.com/rbenv/rbenv#installation)

Prerequisites:
1. Make sure you have `rbenv` and `yarn` installed:

    ```bash
    brew install rbenv
    brew install yarn
    ```

2. Install Ruby 3.2.0:

    ```bash
    rbenv install 3.2.0
    rbenv local 3.2.0
    ruby -v
    ```
   the last line should return `ruby 3.2.0 (2022-12-25 revision a528908271) [arm64-darwin22]`

3. Setup SurveySpark

    ```bash
    ./bin/setup
    ```
   
4. Start the server
   - Either by using the `dev` script:
       ```bash
       ./bin/dev
       ```
   - Or using 3 separate bash terminals:
       ```bash
       rails server
       yarn build --watch
       yarn watch:css
       ```

### Using Docker

- Coming soon!

## Running tests

- Prerequisites: we're using `capybara` with `selenium` for feature (integration) testing. Make sure you have `chromedriver` installed:
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
4. Run linter with `pronto run -c main` and fix any found issues
5. Create a pull request to the `main` branch of the repository
