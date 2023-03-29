# frozen_string_literal: true

namespace :notifications do
  namespace :orders do
    desc 'create order notification job'
    task :notify, [:order_id] => :environment do |_, args|
      order_id = args[:order_id]
      p "You have order in 2 hours! #{order_id}"
    end
  end
end
