require 'database_cleaner/active_record'

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:all) do
    DatabaseCleaner.start
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning { example.run }
  end

  config.after(:all) do
    DatabaseCleaner.clean
  end
end
