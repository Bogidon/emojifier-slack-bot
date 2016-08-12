# Emojifier Slack bot

Emojify your Slack with a bot.

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

Here's a great tutorial. Options 1 and 2 do not require modifiying source code.

This is what option 2 would look like:

`xvfb-run dotenv bundle exec rackup`