
require 'watir'
require 'webdrivers'

# Configure Capybara to use Selenium WebDriver
# Capybara.default_driver = :selenium

# Define a method to perform web automation
def perform_web_automation
  # Visit a webpage
  # visit 'https://web.airdroid.com/'

  browser = Watir::Browser.new
  browser.goto ("wikipedia.org")

  # Fill in a form and submit it
  # fill_in 'username', with: 'user123'
  # fill_in 'password', with: 'password123'
  # click_button 'Submit'
end

# Call the method to perform web automation
# perform_we  b_automation if __FILE__ == $0
