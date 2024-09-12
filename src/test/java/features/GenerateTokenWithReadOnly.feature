@Regression
Feature: Generating Token with Supervisor User

  @Token
  Scenario: Generate valid token
    Given url BASE_URL
    Given path "/api/token"
    Given request
      """
      {
        "username": "operator_readonly",
        "password": "Tek4u2024"
      }
      """
    When method post
    Then print response
    Then status 200