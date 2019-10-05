import ballerina/io;
import ballerina/config;
// import ballerina/http;
// import ballerina/log;
import wso2/gsheets4;

# A valid access token with gmail and google sheets access.
string accessToken = config:getAsString("ACCESS_TOKEN");

# The client ID for your application.
string clientId = config:getAsString("CLIENT_ID");

# The client secret for your application.
string clientSecret = config:getAsString("CLIENT_SECRET");

# A valid refreshToken with gmail and google sheets access.
string refreshToken = config:getAsString("REFRESH_TOKEN");

# Spreadsheet id of the reference google sheet.
string spreadsheetId = config:getAsString("SPREADSHEET_ID");

# Sheet name of the reference googlle sheet.
string sheetName = config:getAsString("SHEET_NAME");

string[][] values = [["1", "2", "3"],["4","5","6"]];
string topCell = "B5";
string bottomCell = "D6";

gsheets4:SpreadsheetConfiguration spreadsheetConfig = {
    oAuthClientConfig: {
        accessToken: accessToken,
        refreshConfig: {
            clientId: clientId,
            clientSecret: clientSecret,
            refreshUrl: gsheets4:REFRESH_URL,
            refreshToken: refreshToken
        }
    }
};

gsheets4:Client spreadsheetClient = new (spreadsheetConfig);

public function main(string... args) {
    var response = spreadsheetClient->openSpreadsheetById(spreadsheetId);
    if (response is gsheets4:Spreadsheet) {
        io:println("Spreadsheet Details: ", response);
        setSpreadsheetValues();
    } else {
        io:println("Error: ", response);
    }
}

public function setSpreadsheetValues() {
    var response = spreadsheetClient->setSheetValues(spreadsheetId, sheetName, values, topCell, bottomCell);
    if (response is boolean) {
        io:println("Status : ", response);
    } else {
        io:println("Error: ", response);
    }
}