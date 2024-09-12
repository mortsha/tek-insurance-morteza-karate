@Regression
Feature: Testing Profile

  @Profile
  Scenario Outline: Testing Profile /api/user/profile
    Given url BASE_URL
    Given path "/api/token"
    Given request
      """
      {
        "username": "<Username>",
        "password": "<Password>"
      }
      """
    When method post
    Then print response
    * def validToken = response.token
    Then status 200


    Given path "/api/user/profile"
    Given header Authorization = "Bearer " + validToken
    When method get
    Then print response
    Then status 200
    Then assert response.username == "<ExpectedUsername>"
    Then assert response.accountType == "<accountType>"
    Examples:
      | username          | password       | ExpectedUsername  | accountType |
      | supervisor        | tek_supervisor | SUPERVISOR        | CSR         |
      | operator_readonly | Tek4u2024      | operator_readonly | CSR         |
      | mori12345         | mori1234       | mori12345         | CUSTOMER    |