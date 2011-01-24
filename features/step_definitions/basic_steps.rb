require 'aruba/api'

Then /^the output should be empty$/ do
  all_output.should match(/^$/)
end

Then /^the output should start with "([^"]*)"$/ do |arg1|
  all_output.should match(/^#{arg1}/)
end

Then /^the output should contain a hash$/ do
  all_output.should match(/[a-fA-F0-9]{20}/)
end


