require 'aruba/api'

Then /^the output should be empty$/ do
  all_output.should match(/^$/)
end

