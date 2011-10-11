guard 'coffeescript', :output => 'spec/compiled' do
  watch(%r{app/assets/.+\.js\.coffee})
  watch(%r{app/assets/.+/.+\.js\.coffee})
end

guard 'coffeescript', :output => 'spec/javascripts' do
  watch(%r{spec/coffeescripts/.+\.coffee})
end

#guard 'coffeescript', :input => 'app/assets/javascripts'

guard 'livereload', :api_version => '1.6' do
  watch(%r{(public/|app/assets).+\.(css|js|html)})
  watch(%r{(app/assets/.+\.css)\.s[ac]ss}) { |m| '' }
  watch(%r{(app/assets/.+\.js)\.coffee}) { |m| 'jasmine' }
  watch(%r{spec/javascripts})
end
