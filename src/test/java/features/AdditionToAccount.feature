@Regression
Feature: Addition information to account

  @Addition_Account
  Scenario: Add car and phone to account
    Given url BASE_URL
    * def createAccount = callonce read('CreateAccountWithRandomEmail.feature')
    * def newAccountId = createAccount.response.id

    * def supervisorResult = callonce read('GenerateSupervisorToken.feature')
    * def supervisorToken = "Bearer " + supervisorResult.response.token

    Given path "/api/accounts/add-account-phone"
    Given header Authorization = supervisorToken
    Given param primaryPersonId = newAccountId
    * def mobile = "2269872365"
    Given request
    """
    {
      "phoneNumber": "#(mobile)",
      "phoneExtension": "202",
      "phoneTime": "Morning",
      "phoneType": "Mobile"
    }
    """
    When method post
    Then print response
    Then status 201
    Then assert response.phoneNumber == mobile


    Given path "/api/accounts/add-account-car"
    Given header Authorization = supervisorToken
    Given param primaryPersonId = newAccountId
    * def lisencePlate = "LTGY 876"
    Given request
      """
      {
        "make": "Dodge",
        "model": "Rona",
        "year": "2024",
        "licensePlate": "#(lisencePlate)"
      }
      """
    When method post
    Then print response
    Then status 201
    Then assert response.licensePlate == lisencePlate


    Given path "/api/accounts/add-account-address"
    Given header Authorization = supervisorToken
    Given param primaryPersonId = newAccountId
    * def addressLine = "8760 Law St"
    Given request
      """
      {
        "addressType": "House",
        "addressLine1": "#(addressLine)",
        "city": "Richmond",
        "state": "Virginia",
        "postalCode": "98765",
      }
      """
    When method post
    Then print response
    Then status 201
    Then assert response.addressLine1 == addressLine