# frozen_string_literal:true

class OrderState < ApplicationRecord
  belongs_to :order

  include AASM

  aasm whiny_transitions: false do
    state :created, initial: true
    state :in_progress, :ready, :finished

    event :transition_in_progress do
      transitions from: :created, to: :in_progress
    end

    event :transition_ready do
      transitions from: :in_progress, to: :ready
    end

    event :transition_finished do
      transitions from: :ready, to: :finished
    end
  end
end
