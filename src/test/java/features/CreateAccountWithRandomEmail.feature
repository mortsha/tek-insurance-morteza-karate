Feature: Create new account with random email

  Background:Setup Test
    Given url BASE_URL

  @CreateAccountEmail_1
  Scenario: Create account using Java nd random email
    * def dataGenerator = Java.type('data.GenerateData')
    * def email = dataGenerator.getEmail()
    Given path "/api/accounts/add-primary-account"
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
