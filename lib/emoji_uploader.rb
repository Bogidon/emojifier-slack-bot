require "selenium-webdriver"

class EmojiUploader

	def self.upload_from_path(path, name)
		slack_url = ENV["SLACK_TEAM_URL"]
		google_email = ENV["GOOGLE_ACCOUNT_EMAIL"]
		google_password = ENV["GOOGLE_ACCOUNT_PASSWORD"]

		driver = Selenium::WebDriver.for :firefox
		driver.manage.timeouts.implicit_wait = 3
		driver.navigate.to slack_url

		slack_google_signin = driver.execute_script('return $("a.btn.btn_large")[0]')
		slack_google_signin.click

		email_field = driver.find_element(:name => "Email")
		email_field.send_keys google_email
		email_field.submit

		password_field = driver.find_element(:name => "Passwd")
		password_field.send_keys google_password
		password_field.submit

		wait = Selenium::WebDriver::Wait.new(:timeout => 10)
  		wait.until { 
  			escaped_url = Regexp.escape(slack_url)
  			string = "#{escaped_url}.+"
  			regexp = Regexp.new string
  			next driver.current_url =~ regexp
  		}

		driver.navigate.to "#{slack_url}/customize/emoji"

		emoji_name_field = driver.find_element(:id => "emojiname")
		emoji_name_field.send_keys name

		emoji_upload_field = driver.find_element(:id => "emojiimg")
		emoji_upload_field.send_keys path
		emoji_upload_field.submit

		driver.quit

		return true
	rescue
		return false
	end
end