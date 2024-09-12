@Regression
Feature: Testing get all accounts @Get_All_Account

#  Background: Setup test
#    Given url BASE_URL
#    Given path "/api/accounts/get-all-accounts"


  @Get_All_Account_1
  Scenario: Testing /api/accounts/get-all-accounts without authentication
    When method get
    Then status 401

  @Get_All_Account_2
  Scenario: Testing /api/accounts/get-all-accounts with authentication
    Given url BASE_URL
    Given path "/api/accounts/get-all-accounts"
    * def generateTokenResult = callonce read('GenerateSupervisorToken.feature')
    Then print generateTokenResult
    * def validToken = "Bearer " +  generateTokenResult.response.token
    Given header Authorization = validToken
    When method get
    Then print response
    Then status 200