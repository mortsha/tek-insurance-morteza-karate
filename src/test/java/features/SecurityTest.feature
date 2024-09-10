@Regression
Feature: API testing for security functions

  Background: Setup test
    Given url 'https://dev.insurance-api.tekschool-students.com'
    Given path '/api/token'

  @US_1
  Scenario: Generate token with valid credentials
    Given request
      """
      {
        "username": "supervisor",
        "password": "tek_supervisor"
      }
      """
    When method post
    Then status 200
    And print response

  @US_2
  Scenario Outline: Generate token with Invalid credentials
    Given request
      """
      {
        "username": "<username>",
        "password": "<password>"
      }
      """
    When method post
    Then status <statusCode>
    Then print response
    Examples:
      | username     | password       | statusCode |
      | supervisorsx | tek_supervisor | 404        |
      | supervisor   | wrong password | 400        |