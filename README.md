# Emojifier Slack bot ![](public/hat.png)

Emojify your Slack with a bot.

## How it works

In Slack: `@emojifier add <emoji name> <image url>`

- downloads image and resizes it to aspect fit within 128px x 128px.
- navigates Slack with the [Selenium WebDriver](http://www.seleniumhq.org/projects/webdriver/) (because the Slack API doesn't allow for Emoji modification)
- signs into Slack using Google Account (if you're using two step verification, [use an application specific password](https://support.google.com/accounts/answer/185833))


## Dependencies

- ImageMagick
- Firefox

## Running

`bundle install`

The following environment variables are required:

- `SLACK_API_TOKEN`
- `SLACK_TEAM_URL`
- `GOOGLE_ACCOUNT_EMAIL`
- `GOOGLE_ACCOUNT_PASSWORD`

you can put them in a `.env` file and run

`dotenv bundle exec rackup`

or otherwise just

`bundle exec rackup`

## Running headless

> This bot won't work by default on screenless servers (AWS, DigitalOcean, etc). You'll need to use a virtual screen of sorts.

[Here's a great tutorial](http://elementalselenium.com/tips/38-headless). Options #1 and #2 don't require modifiying source code. This is what option #2 would look like:

`xvfb-run dotenv bundle exec rackup`
