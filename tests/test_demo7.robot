*** Settings ***
Library         Collections
Library         RequestsLibrary

*** Variables ***
${base_url}     https://rahulshettyacademy.com/
${book_id}
${book_name}    RobotFramework
${author_name}  RahulShetty

*** Test Cases ***
Play around with Dictionary
    [Tags]      API
    &{data}=    Create Dictionary    name=${author_name}   course=${book_name}     website=${base_url}
    Log         ${data}
    Dictionary Should Contain Key    ${data}             name
    Log         ${data}[name]
    ${url}=     Get From Dictionary  ${data}             website
    Log         ${url}

Add Book into Library DataBase
    [Tags]      API
    &{request_body}=    Create Dictionary       name=${book_name}     isbn=6121123     aisle=623762     author=${author_name}
    ${post_response}=    POST    ${base_url}/Library/Addbook.php     json=${request_body}    expected_status=200
    Log    ${post_response.json()}
    Dictionary Should Contain Key        ${post_response.json()}     ID
    ${book_id}=     Get From Dictionary  ${post_response.json()}     ID
    Set Global Variable    ${book_id}
    Log    ${book_id}
    Should Be Equal As Strings     successfully added     ${post_response.json()}[Msg]
    Status Should Be               200                    ${post_response}

Get the Book Details which got added
    [Tags]      API
    ${get_response}=    GET     ${base_url}/Library/GetBook.php     params=ID=${book_id}     expected_status=200
    Log    ${get_response.json()}
    Should Be Equal As Strings     ${book_name}    ${get_response.json()}[0][book_name]

Delete the Book from DataBase
    [Tags]      API
    &{delete_request}=    Create Dictionary       ID=${book_id}
    ${delete_response}=    POST    ${base_url}/Library/DeleteBook.php     json=${delete_request}    expected_status=200
    Log    ${delete_response.json()}
    Should Be Equal As Strings     book is successfully deleted     ${delete_response.json()}[msg]
