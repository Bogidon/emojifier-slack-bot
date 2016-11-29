require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'
require 'colorize'
require 'rspec'

module Emojifier
	class Uploader
		include Capybara::DSL

		def self.upload_from_path(path, name)
			slack_url 		= ENV["SLACK_TEAM_URL"]
			google_email 	= ENV["GOOGLE_ACCOUNT_EMAIL"]
			google_password = ENV["GOOGLE_ACCOUNT_PASSWORD"]
			email 			= ENV["ACCOUNT_EMAIL"]
			password 		= ENV["ACCOUNT_PASSWORD"]

			poltergeist_options = {
				phantomjs_logger: File.open(File::NULL, "w"),
				js_errors: false
			}

			Capybara.reset!
			Capybara.configure do |c|
			  	c.javascript_driver = :poltergeist
			  	c.default_driver = :poltergeist
			  	c.default_max_wait_time = 10
			  	c.register_driver :poltergeist do |app|
				  	Capybara::Poltergeist::Driver.new(app, poltergeist_options)
				end
			end

			# Visiting Site
			puts "ℹ️  Visiting #{slack_url}".light_blue

			s = Capybara.current_session
			s.visit slack_url

			# Authentication
			if google_email && google_password
				s.click_link_or_button "Google"
				
				s.fill_in("Email", :with => google_email)
				s.click_button "next"

				s.fill_in("Passwd", :with => google_password)
				s.click_button "signIn"

				puts "ℹ️  Logged in with Google".light_blue
			else 
				s.fill_in("email", :with => google_email)
				s.fill_in("password", :with => password)

				s.click_link_or_button "signin_btn"

				puts "ℹ️  Logged in with Email and Password".light_blue
			end

			# Uploading emoji
			s.visit "#{slack_url}/customize/emoji"
			
			s.fill_in("emojiname", :with => name)
			s.attach_file("emojiimg", path)

			s.click_link_or_button "Save New Emoji"
			return true
		rescue
			return false
		end
	end
end