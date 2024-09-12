Feature: Create and Delete account

  @Delete_Account
  Scenario: delete account with different users
    Given url BASE_URL
    * def createAccount = callonce read('CreateAccountWithRandomEmail.feature')
    * def newAccountId = createAccount.response.id
    * def operatorResult = callonce read('GenerateTokenWithReadOnly.feature')
    * def operatorToken = "Bearer " + operatorResult.response.token
    Given path "/api/accounts/delete-account"
    Given header Authorization = operatorToken
    Given param primaryPersonId = newAccountId
    When method delete
    Then status 403

    * def supervisorResult = callonce read('GenerateSupervisorToken.feature')
    * def supervisorToken = "Bearer " + supervisorResult.response.token
    Given path "/api/accounts/delete-account"
    Given header Authorization = supervisorToken
    Given param primaryPersonId = newAccountId
    When method delete
    Then status 202