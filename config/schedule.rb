# frozen_string_literal: true

set :output, 'log/output.log'

every 1.minute do
  rake 'notifications:orders:notify'
end
