When /^the following (.+) records?:$/ do |factory, table|
  table.hashes.each do |hash|
    Factory(factory, hash)
  end
end

When /^I send an? (?:valid|invalid) (POST|GET|PUT|DELETE) request (?:for|to) "([^"]*)" (?:with the (?:following|default)) (.+) data:?$/ do |*args|
  
  request_type, path, factory, table = args
  if request_type == 'POST' || request_type == 'PUT'
    
    if not table
      body = Factory.attributes_for(factory).to_json 
    else
      #only 1 post at a time
      #check if valid request
      table.hashes.each do |hash|
        body = Factory.attributes_for(factory, hash).to_json
      end
    end
        
    page.driver.send(request_type.downcase.to_sym, path, body)
    
  else
      page.driver.send(request_type.downcase.to_sym, path)
  end
end

#^I send an? (?:valid|invalid) (POST|GET|PUTS|DELETE) request (?:for|to) "([^"]*)" (?:with the (?:following|default)) (.+) data:?$

