require 'aruba/api'

Then /^the output should contain (a|\d+) hash(?:es)?$/ do |count|
  count = 1 if count == 'a'
  count = count.to_i

  lines = all_output.split("\n")
  match_count = 0
  lines.each { |line| match_count += 1 if line.match(/[a-f0-9]{40}/) }
  match_count.should == count
end

Then /^the output should not contain a hash$/ do
  all_output.split('\n').each { |l| l.should_not match(/[a-f0-9]{40}/) }
end
