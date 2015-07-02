RSpec::Matchers.define :be_named do |expected| 
  match do |actual|
    actual.full_name.eql? expected
  end 

  description do 
    'return a full name as a string'
  end

  failure_message do |actual|
    "expected full_name to return #{expected}, not #{actual.full_name}"
  end

end
