# FlutterApp
## Flutter App for Internmatch

> Dart Packages used in this project are mentioned in pubspec.yml file:
1. http | http 0.12.0+2

This package contains a set of high-level functions and classes that make it easy to consume HTTP resources. It's platform-independent, and can be used on both the command-line and the browser.

2. sqflite | sqflite 1.1.5

SQLite plugin for Flutter. Supports both iOS and Android.

  * Support transactions and batches
  * Automatic version managment during open
  * Helpers for insert/query/update/delete queries
  * DB operation executed in a background thread on iOS and Android

3. Flutter AppAuth Plugin | flutter_appauth 0.2.1+1

A Flutter bridge for AppAuth (https://appauth.io) used authenticating and authorizing users. Note that AppAuth also supports the PKCE extension that is required some providers so this plugin should work with them.

---
## Continuous Delivery using fastlane with Flutter

### Local setup

1. Install fastlane **sudo gem install fastlane** or __brew cask install fastlane__.

2. Create your Flutter project, and when ready, make sure that your project builds via
  * *Android*: **flutter build apk --release**
  *   *iOS*  : **flutter build ios --release --no-codesign**

3. Initialize the fastlane projects for each platform.
  * *Android*: 'Go to [project]/andorid directory' 
                Run **fastlane init**
  *   *iOS*  : 'Go to [project]/ios directory' 
                Run **fastlane init**

4. Edit the **Appfiles** to ensure they have adequate metadata for your app. 
  * *Android*:  *package_name (e.g. com.example.internmatch)* in [project]/android/Appfile                  matches your package name in AndroidManifest.xml.
  *   *iOS*  : *app_identifier* in [project]/ios/Appfile also matches Info.plist’s bundle                  identifier. Fill in apple_id, itc_team_id, team_id with your respective                    account info.

5. Set up your local login credentials for the stores.
  * *Android*: 
        **Collect your Google credentials.** Follow the steps:
        1. Open the [Google Play Console][https://play.google.com/apps/publish/]
        2. Click the *Settings* menu entry, followed by *API access*
        3. Click the *CREATE SERVICE ACCOUNT* button
        4. Follow the *Google Developers Console* link in the dialog, which opens a new tab/ window:
            * Click the *CREATE SERVICE ACCOUNT* button at the top of the *Google Developers   Console*
            * Provide a 
                > Service account name* 
            * Click *Select a role* and choose *Service Accounts > Service Account User*
            * Check the *Furnish a new private key* 
                > checkbox
            * Make sure *JSON* is selected as the 
                > Key type
            * Click *SAVE* to close the dialog  
            * Make a note of the file name of the JSON file downloaded to your computer
         5. Back on the *Google Play Console*, click *DONE* to close the dialog  
         6. Click on *Grant Access* for the newly added service account  
         7. Choose Release Manager (or alternatively Project Lead) from the Role dropdown.      (Note that choosing Release Manager grants access to the production track and        all other tracks. Choosing Project Lead grants access to update all tracks          except the production track.) 
 


