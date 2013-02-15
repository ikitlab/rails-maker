@disable-bundler
Feature: Generate new rails-maker app
  In order to start a new project with rails-maker
  As a CLI
  I want to generate a rails3 app with rails-maker

  Scenario: Run rails-maker new my_app
    When I run "rails-maker new my_app"
    Then the output should contain "Building authentication"
    And the output should contain "Building roles"
    And the output should contain "Building admin"
    And the output should contain "The rails-maker just added like 6 hours to your life."

  Scenario: Run rails-maker new my_app --no-auth
    When I run "rails-maker new my_app --no-auth"
    Then the output should not contain "Building authentication"
    And the output should not contain "Building roles"
    And the output should not contain "Building admin"
    And the output should contain "The rails-maker just added like 6 hours to your life."

  Scenario: Run rails-maker new my_app --no-roles
    When I run "rails-maker new my_app --no-roles"
    Then the output should contain "Building authentication"
    And the output should not contain "Building roles"
    And the output should contain "Building admin"
    And the output should contain "The rails-maker just added like 6 hours to your life."

  Scenario: Run rails-maker new my_app --no-admin
    When I run "rails-maker new my_app --no-admin"
    Then the output should contain "Building authentication"
    And the output should contain "Building roles"
    And the output should not contain "Building admin"
    And the output should contain "The rails-maker just added like 6 hours to your life."

  Scenario: Run rails-maker new my_app --no-admin --no-roles
    When I run "rails-maker new my_app --no-admin --no-roles"
    Then the output should contain "Building authentication"
    And the output should not contain "Building roles"
    And the output should not contain "Building admin"
    And the output should contain "The rails-maker just added like 6 hours to your life."