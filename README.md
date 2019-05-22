# FlutterApp for Internmatch
## Contents
* 
#### Dart Packages used in this project are mentioned in pubspec.yml file:
---
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
  * Android: 
#### Collect your Google credentials. Follow the steps:
  * Open the [Google Play Console](https://play.google.com/apps/publish/)

  * Click the **Settings** menu entry, followed by **API access**

  * Click the **CREATE SERVICE ACCOUNT** button

  * Follow the **Google Developers Console** link in the dialog, which opens a new tab/window:
      * Click the **CREATE SERVICE ACCOUNT** button at the top of the **Google Developers   Console**
      * Provide a 
        > Service account name 
      * Click **Select a role** and choose **Service Accounts > Service Account User**
      * Check the **Furnish a new private key** 
        > checkbox
      * Make sure **JSON** is selected as the 
        > Key type
      * Click **SAVE** to close the dialog  
      * Make a note of the file name of the JSON file downloaded to your computer

  * Back on the **Google Play Console**, click *DONE* to close the dialog 

  * Click on **Grant Access** for the newly added service account  

  * Choose Release Manager (or alternatively Project Lead) from the Role dropdown.           (Note that choosing Release Manager grants access to the production track and              all other tracks. Choosing Project Lead grants access to update all tracks                 except the production track.) 

  * Click **ADD USER** to close the dialog

#### Configure supply

Edit your fastlane/Appfile and change the json_key_file line to have the path to your credentials file:

`json_key_file` "/path/to/your/downloaded/key.json"

#### Fetch your app metadata

If your app has been created on the Google Play developer console, you're ready to start using supply to manage it! Run:

`fastlane supply init`

 * iOS: Your iTunes Connect username is already in your **Appfile**’s **apple_id** field.           Set the **FASTLANE_PASSWORD** shell environment variable with your iTunes Connect           password. Otherwise, you’ll be prompted when uploading to iTunes/TestFlight.

6. Set up code signing.
  * Android: There are two signing keys: deployment and upload.
        * The end-users download the .apk signed with the ‘deployment key’.
        * An ‘upload key’ is used to authenticate the .apk uploaded by developers onto the     Play Store and is re-signed with the deployment key once in the Play Store.
        * To generate key automatically follow [key generation steps](https://developer.android.com/studio/publish/app-signing#sign-apk)
        * Configure gradle to use your upload key when building your app in release mode by    editing **android.buildTypes.release** in `[project]/android/app/build.gradle`.

  *  iOS : Create and sign using a distribution certificate instead of a development                  certificate when you’re ready to test and deploy using TestFlight or App Store. 
      * Create and download a distribution certificate in your [Apple Developer Account Console](https://idmsa.apple.com/IDMSWebAuth/signin?appIdKey=891bd3417a7776362562d2197f89480a8547b108fd934911bcbea0110d07f757&path=%2Faccount%2Fios%2Fcertificate%2F&rv=1)
      * **open [project]/ios/Runner.xcworkspace/** and select the distribution certificate in your target’s settings pane.

7. Create a **Fastfile** script for each platform.
    * Android: Follow the [fastlane Android beta deployment guide](https://docs.fastlane.tools/getting-started/android/beta-deployment/). Your edit could be as simple as adding a **lane** that calls **upload_to_play_store**. Set the **apk** argument to **../build/app/outputs/apk/release/app-release.apk** to use the apk **flutter build** already built.

    *   iOS : Follow the [fastlane iOS beta deployment guide] (https://docs.fastlane.tools/getting-started/ios/beta-deployment/). Your edit could be as simple as adding a **lane** that calls **build_ios_app** with **export_method: 'app-store'** and **upload_to_testflight.** On iOS an extra build is required since **flutter build** builds an .app rather than archiving .ipas for release.

        



