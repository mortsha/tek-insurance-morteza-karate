Feature: Create New Account Functionality

  @CreateAccount
  Scenario: Create a new account
    Given url BASE_URL
    Given path "/api/token"
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
    * def token = response.token

    Given url BASE_URL
    Given path '/api/accounts/add-primary-account'
    Given header Authorization = "Bearer " + token
    Given request
    """
    {
      "email": "happy8001@gmail.com",
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
    And assert response.email == "happy800@gmail.com"
