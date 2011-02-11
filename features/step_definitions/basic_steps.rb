require 'aruba/api'

Then /^the output should be empty$/ do
  all_output.should match(/^$/)
end

Then /^the output should start with "([^"]*)"$/ do |arg1|
  all_output.should match(/^#{arg1}/)
end

