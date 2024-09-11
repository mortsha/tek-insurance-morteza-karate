Feature: Testing get account
  @Get_Account_1
  Scenario: Testing /api/accounts/get-account
    Given url BASE_URL
    * def generateTokenResult = callonce read('GenerateSupervisorToken.feature')
    Then print generateTokenResult
    * def validToken = "Bearer " + generateTokenResult.response.token
    Given path "/api/accounts/get-account"
    Given header Authorization = validToken
    * def accountId = 9479
    Given param primaryPersonId = accountId
    When method get
    Then print response
    Then status 200
    Then assert response.primaryPerson.id == accountId
