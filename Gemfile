source "http://rubygems.org"

platforms :ruby_19 do
  gem "httpi", "~> 1.1.0"
end
gem "savon", "~>1.2.0"

group :development do
  platforms :ruby_18 do
    gem "ruby-debug"
  end
  platforms :ruby_19 do
    gem 'ruby-debug-base19', "0.11.24"
    gem 'ruby-debug19', "0.11.6"
  end
  gem "rspec", "~> 2.4.0"
  gem "bundler"
  gem "jeweler"
  #gem "rcov"
end


