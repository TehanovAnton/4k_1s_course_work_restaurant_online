# frozen_string_literal: true

namespace :notifications do
  namespace :orders do
    desc 'create orders notifications jobs'
    task notify: :environment do
      two_hours_from_now = Time.now + 2.hours
      resrvations = Reservation.where(start_at: two_hours_from_now..(two_hours_from_now + 15.minutes))
                               .select(:order_id)

      resrvations.each do |reservation|
        order = Order.find(reservation.order_id)
        Order::NOTIFIER_CLASS.new(order).notify
      end
    end
  end
end
