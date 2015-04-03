require 'watir-webdriver'
require 'cucumber'

def browser_name
    (ENV['BROWSER'] ||= 'firefox').downcase.to_sym
end

def environment
    (ENV['ENVIRONMENT'] ||= 'prod').downcase.to_sym
end

Before do |scenario|
  p "Starting #{scenario}"
  if environment == :int
    @browser = Watir::Browser.new browser_name
    @browser.goto "http://sandbox.amazon.com"
    @browser.text_field(:id=>'username').set "test"
    @browser.text_field(:id=>'password').set "test1234"
    @browser.button(:id => 'submit').click

  elsif environment == :local
    @browser = Watir::Browser.new browser_name
    @browser.goto "http://localhost/"

elsif environment == :prod
    @browser = Watir::Browser.new browser_name
    @browser.goto "http://www.amazon.com"
  end
end
After do |scenario|
  if scenario.failed?
    Dir::mkdir('screenshots') if not File.directory?('screenshots')
    screenshot = "./screenshots/FAILED_#{scenario.name.gsub(' ','_').gsub(/[^0-9A-Za-z_]/, '')}.png"
    @browser.driver.save_screenshot(screenshot)
    embed screenshot, 'image/png'
  end
  @browser.close
end

