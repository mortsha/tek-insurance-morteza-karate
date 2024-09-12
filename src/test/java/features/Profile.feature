@Regression
Feature: Testing Profile

  @Profile
  Scenario Outline: Testing Profile /api/user/profile
    Given url BASE_URL
    Given path "/api/token"
    Given request
      """
      {
        "username": "<username>",
        "password": "<password>"
      }
      """
    When method post
    Then print response
    Then status 200

    Given path "/api/user/profile"
    Given header Authorization = "Bearer " +  response.token
    When method get
    Then print response
    Then status 200
    Then assert response.username == "<ExpectedUsername>"
Examples:
  | username|password | ExpectedUsername|
  | supervisor|tek_supervisor |SUPERVISOR|
  | operator_readonly|Tek4u2024 |operator_readonly|