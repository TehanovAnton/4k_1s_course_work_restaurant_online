# frozen-string_literal:true

class ReferrersPolicy < ApplicationPolicy
  def self.referred_model
    self::REFERRED_MODEL
  end

  private

  # should be depenedent from record
  def reffered_record
    # record.order
    raise NotImplementedError, 'define referred record from authorizing record/'
  end

  # should be depenedent from signed in user
  def user_referred_filter
    # { user_id: user.id }
    raise NotImplementedError, 'define signed in user filter'
  end

  def referred_model
    self.class.referred_model
  end

  def referres_to_reffered_model?
    referred_model.where(user_referred_filter)
                  .ids
                  .include?(reffered_record&.id)
  end
end
