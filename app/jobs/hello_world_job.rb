class HelloWorldJob < ApplicationJob

  # Create this file using rails g job <job-name>
  # Create a migration using rails delayed_job:active_record
  
  queue_as :default

  def perform(*args)
    # Do something later

    puts "---------------------------"
    puts "Running a super awesome job"
    puts "---------------------------"
    puts "   this one right here     "


  end

end
