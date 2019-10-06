# Ballerina-Stackoverflow-Spreadsheet Integration

This is a ballerina project to integrate stackoverflow and google sheets
<!-- 
Stack Exchange API Version V2.2 is used in this project to retrieve questions and its related data of a given user using a GET request through Ballerina. 

The Google Spreadsheet endpoint allows you to access the Google Spreadsheet API Version v4 through Ballerina. This project stores the retrieved stackoverflow data in a spreadsheet.
 -->

> This guide walks you through the process of running this repo which use Stackoverflow and Google Sheets along with Ballerina language.

The following sections provide you with information on how to get started with Stackoverflow Spreadsheet Integration.
- [What you'll build](#what-youll-build)
- [Compatibility](#compatibility)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)

## What you’ll build

To understand how you can use Ballerina API connectors, in this sample we use StackExhchange API to get data from a user account and we use the Spreadsheet connector to store the retrieved data to a Google Sheet.

You can retrieve what ever details you like from a stack exchange account (question details are retrieved in this scenario), then use the Ballerina Google Spreadsheet connector and store that data to a spreadsheet.

## Compatibility

| Ballerina Language Version  | Stack Exchange API Version | Google Spreadsheet API Version |
|:---------------------------:|:------------------------------:|:------------------------------:|
|  1.0.1                     |   V2.2                           |   V4                           |

## Prerequisites
 
- [Ballerina Distribution](https://ballerina.io/learn/getting-started/)
- You can pull the Spreadsheet client from Ballerina Central:
```ballerina
$ ballerina pull wso2/gsheets4
```
- A Text Editor or an IDE 
> **Tip**: For a better development experience, install one of the following Ballerina IDE plugins: [VSCode](https://marketplace.visualstudio.com/items?itemName=ballerina.ballerina), [IntelliJ IDEA](https://plugins.jetbrains.com/plugin/9520-ballerina)

## Getting Started

**Cloning**

Clone this repo to a preferred local directory

```bash
$ git clone https://github.com/ashera96/ballerina-stackoverflow-gsheet.git
```

**Configurations**
- Go through the following steps to obtain credetials and tokens for Google Sheets API.
    1. Visit [Google API Console](https://console.developers.google.com), click **Create Project**, and follow the wizard 
    to create a new project.
    2. Enable both GMail and Google Sheets APIs for the project.
    3. Go to **Credentials -> OAuth consent screen**, enter a product name to be shown to users, and click **Save**.
    4. On the **Credentials** tab, click **Create credentials** and select **OAuth client ID**. 
    5. Select an application type, enter a name for the application, and specify a redirect URI 
    (enter https://developers.google.com/oauthplayground if you want to use 
    [OAuth 2.0 playground](https://developers.google.com/oauthplayground) to receive the authorization code and obtain the 
    access token and refresh token). 
    6. Click **Create**. Your client ID and client secret appear. 
    7. In a separate browser window or tab, visit [OAuth 2.0 playground](https://developers.google.com/oauthplayground), 
    select the required Google Sheets API V4 scopes, and then click **Authorize APIs**.
    8. When you receive your authorization code, click **Exchange authorization code for tokens** to obtain the refresh 
    token and access token. 


- Go through the following steps to obtain credetials for Stack Exchange API.
    1. Get your stackoverflow user id      

- Create a Google Sheet as follows from the same Google account you have obtained the client credentials and tokens.


- Obtain the spreadsheet id by extracting the value between the "/d/" and the "/edit" in the URL of your spreadsheet.

  You must configure the `ballerina.conf` configuration file with the above obtained tokens, credentials and 
  other important parameters as follows.
  ```
  ACCESS_TOKEN="access token"
  CLIENT_ID="client id"
  CLIENT_SECRET="client secret"
  REFRESH_TOKEN="refresh token"
  SPREADSHEET_ID="spreadsheet id you have extracted from the sheet url"
  SHEET_NAME="sheet name of your Goolgle Sheet. For example in above example, SHEET_NAME="StackoverflowQuestions"
  STACKOVERFLOW_ID="stackoverflow id"
  ```

  At the end of this step you should have a `ballerina.conf` configuration file at the same level of `Ballerina.toml` with filled parameters.



**Building**

```bash
$ ballerina build -a
```

After the build is successful, there will be a .jar file inside the target directory. That executable can be executed 
as follows.

**Running**

```bash
$ ballerina run target/bin/stackoverflow_gsheet.jar
```
