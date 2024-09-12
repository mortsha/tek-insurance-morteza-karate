@Regression
Feature: Create New Account Functionality

  @CreateAccount
  Scenario: Create a new account
    Given url BASE_URL
    * def generateValidToken = callonce read('GenerateSupervisorToken.feature')
    Then print generateValidToken
    * def validToken = "Bearer " + generateValidToken.response.token

    Given path '/api/accounts/add-primary-account'
    Given header Authorization = validToken
    * def email = "happy8001234@gmail.com"
    Given request
      """
      {
        "email": "#(email)",
        "firstName": "happy",
        "lastName": "thor",
        "title": "Mr.",
        "gender": "Male",
        "maritalStatus": "Single",
        "employmentStatus": "nothing",
        "dateOfBirth": "2000-09-10"
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.email == email
    * def accountId = response.id

    * def tokenGenerationResult = callonce read('GenerateSupervisorToken.feature')
    * def validToken = "Bearer " + tokenGenerationResult.response.token
    Given path "/api/accounts/delete-account"
    Given param primaryPersonId = accountId
    Given header Authorization = validToken
    When method delete
    Then print response
    Then status 202
    Then assert response.message == "Account Successfully deleted"
