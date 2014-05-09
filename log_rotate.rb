  logs = File.join(Rails.root, 'log', '*.log')
  if Dir[logs].any? {|log| File.size?(log).to_i > ENV['MAX_LOG_SIZE'].megabytes }
    $stdout.puts "Runing rake log:clear"
    `rake log:clear`
  end