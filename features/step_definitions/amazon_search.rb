
Given(/^a user goes to Amazon$/) do
  @browser.goto "http://www.amazon.com"
end

When(/^they search for "([^"]*)"$/) do |arg|
 # @browser.text_field(:id => "twotabsearchtextbox").click
  @browser.text_field(:id => "twotabsearchtextbox").set "#{arg}"
  @browser.send_keys :return
end

Then(/^amazon should return results for "([^"]*)"$/) do |arg|
  @browser.div(:id => "result_2").wait_until_present
  page_output = @browser.div(:id => "resultsCol").text.include? "#{arg}"
  assert (page_output == true)
  @browser.close
end

When(/^the user looks for (.*)$/) do |query|
  @browser.text_field(:id => "twotabsearchtextbox").set "#{query}"
  @browser.send_keys :return
end

Then(/^the results returned will display (.*)$/) do |query|
  @browser.li(:id => "result_2").wait_until_present
  page_output = @browser.div(:id => "resultsCol").text.include? "#{query}"
  assert (page_output == true)
end