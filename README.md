gcal-tweet
==========

A script that sends tweets for Gmail calendar reminders.

Setup instructions:

The following environment values need to be set accordingly as found on https://apps.twitter.com/app/{your_app_id}/keys

- twitter_api_key
- twitter_api_secret
- twitter_access_token
- twitter_access_token_secret

calendar_id environment variable need to be set to the id of the calendar being accessed (default is 'primary').

gcal-oauth2.json file should contain refresh and access tokens for the calendar API accessed by the app. These settings can be found on https://console.developers.google.com/project/{your_project_id}/apiui/credential
