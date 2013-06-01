task :default do
  Dir["#{File.dirname(__FILE__)}/**/*"].each do |file|
    next if File.basename(file) == 'Rakefile'
    FileUtils.ln_s file, File.join(ENV['HOME'], ".#{File.basename(file)}"), :force => true
  end
end

