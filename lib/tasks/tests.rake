namespace :tests do
  desc "Run all tests"
  task :run_all do
    puts "Running model tests..."
    system("rails test:models -v")
    puts "Running controller tests..."
    system("rails test:controllers -v")
    puts "Running system tests..."
    system("rails test:system -v")
    puts "Running library tests..."
    system("rspec")
  end
end
