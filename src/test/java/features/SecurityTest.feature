@Regression
Feature: API testing for security functions

  Background: Setup test
    Given url BASE_URL
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
    Then print response
    Then status 200
    And assert response.username=="supervisor"

  @US_2
  Scenario Outline: Generate token with Invalid credentials and validate errors
    Given request
      """
      {
        "username": "<username>",
        "password": "<password>"
      }
      """
    When method post
    Then print response
    Then status <statusCode>
    Then assert response.httpStatus == "<httpStatus>"
    Then assert response.errorMessage == "<errorMessage>"
    Examples:
      | username     | password       | statusCode | httpStatus  | errorMessage                |
      | supervisorsx | tek_supervisor | 404        | NOT_FOUND   | User supervisorsx not found |
      | supervisor   | wrong password | 400        | BAD_REQUEST | Password not matched        |