Feature: End 2 End Account Testing

  @End2End
  Scenario: End 2 End Testing
    Given url BASE_URL

    * def createAccount = callonce read('CreateAccountWithRandomEmail.feature')
    * def newAccountId = createAccount.response.id
    * def tokenGenerationResult = callonce read('GenerateSupervisorToken.feature')
    * def validToken = "Bearer " + tokenGenerationResult.response.token

    Given path "/api/accounts/get-account"
    Given header Authorization = validToken
    Given param primaryPersonId = newAccountId
    When method get
    Then print response
    Then status 200
    And assert response.primaryPerson.email == createAccount.response.email
    And assert response.primaryPerson.firstName == createAccount.response.firstName
    And assert response.primaryPerson.gender == createAccount.response.gender


    Given path "/api/accounts/delete-account"
    Given header Authorization = validToken
    Given param primaryPersonId = newAccountId
    When method delete
    Then print response
    Then status 202
    Then assert response.message == "Account Successfully deleted"

    Given path "/api/accounts/delete-account"
    Given header Authorization = validToken
    Given param primaryPersonId = newAccountId
    When method delete
    Then print response
    Then status 404
    Then assert response.errorMessage == "Account with id " + newAccountId + " not exist"




