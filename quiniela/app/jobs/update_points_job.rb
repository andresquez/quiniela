require 'rake'
Rake.application.load_rakefile

class UpdatePointsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Rake::Task['update_points:update_points'].invoke
  end
end
