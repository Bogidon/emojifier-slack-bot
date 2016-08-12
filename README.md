# Emojifier Slack bot

Emojify your Slack with a bot.

## Running

The following environment variables are required:

- `SLACK_API_TOKEN`
- `SLACK_TEAM_URL`
- `GOOGLE_ACCOUNT_EMAIL`
- `GOOGLE_ACCOUNT_PASSWORD`

then run 

`bundle exec rackup`

## Running Locally

Put your environment variables in a `.env` file. Then run

`dotenv bundle exec rackup`