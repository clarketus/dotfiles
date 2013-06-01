task :default do
  Dir["#{File.dirname(__FILE__)}/**/*"].each do |file|
    FileUtils.ln_s file, File.join(ENV['HOME'], ".#{File.basename(file)}")
  end
end

