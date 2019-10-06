import ballerina/io;
import ballerina/config;
import ballerina/http;
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

# URL of the stackoverflow account.
string stackoverflowId = config:getAsString("STACKOVERFLOW_ID");

# Variable to store the top left cell.
string topCell = "A2";

# Variable to store the bottom right cell (leave empty to self adjust based on the number of elements). 
string bottomCell = "";

# Google Sheets client endpoint declaration.
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

# Stackoverflow client endpoint declaration with http client configuration.
http:Client stackoverflowClient = new("http://api.stackexchange.com/2.2");

public function main(string... args) {
    var response = spreadsheetClient->openSpreadsheetById(spreadsheetId);
    if (response is gsheets4:Spreadsheet) {
        io:println("\n----------------------------------------------------------------------------------------------------------------");
        io:println("| Stackoverflow-Spreadsheet Integration -> Adding asked questions along with few more details to a spreadsheet |");
        io:println("----------------------------------------------------------------------------------------------------------------\n");
        getStackoverflowData();
        io:println("\n-----------------------------------------------------------------------------------------------------------------\n");
    } else {
        io:println("Error: ", response);
    }
}

# Function to retrieve data from stackoverflow.
public function getStackoverflowData() {
    // 2D array to store the retrieved data.
    string[][] values = [];
    var count = 0;

    var response = stackoverflowClient->get("/users/" + stackoverflowId + "/questions?order=desc&sort=activity&site=stackoverflow");
    
    if (response is http:Response) {
        var msg = response.getJsonPayload();
        if (msg is json) {
            json[] questions = <json[]>msg.items;
            foreach var temp in questions {
                string title = <string>temp.title;
                string link = <string>temp.link;
                string view_count = temp.view_count.toString();
                string answer_count =  temp.answer_count.toString();
                string score = temp.score.toString();
                values[count] = [title, link, view_count, answer_count, score];
                count = count + 1;
            }
            io:println("Successfully retrieved the stackoverflow data");
            setSpreadsheetValues(values); // Method to add the retrieved data to the spreadsheet
        } else {
            io:println("Invalid payload received:" , msg.reason());
        }
    } else {
        io:println("Error when calling the backend: ", response.reason());
    }
}

# Function to set collected data to the spreadsheet.
public function setSpreadsheetValues(string[][] values) {
    var response = spreadsheetClient->setSheetValues(spreadsheetId, sheetName, values, topCell, bottomCell);
    if (response is boolean) {
        io:println("Status : ", response);
        io:println("Successfully added the data to the spreadsheet");
    } else {
        io:println("Error: ", response);
    }
}