Feature: Testing Plan code section

  @Plans_1
  Scenario: Testing endpoint /api/plans/get-all-plan-code
    Given url BASE_URL
    Given path '/api/token'
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
    Given path "/api/plans/get-all-plan-code"
    Given header Authorization = "Bearer " + token
    When method get
    Then print response
    Then status 200
    Then assert response[0].planExpired == false
    Then assert response[0].planType == "MOTORCYCLE"
    Then assert response[1].planExpired == false
    Then assert response[1].planType == "BOAT"
    Then assert response[2].planExpired == false
    Then assert response[2].planType == "RENTERS"
    Then assert response[3].planExpired == false
    Then assert response[3].planType == "AUTO"
