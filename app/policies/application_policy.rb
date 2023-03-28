# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope

    def super_admin?
      user.is_a? SuperAdmin
    end
  end

  private

  def super_admin?
    user.is_a? SuperAdmin
  end

  def customer?
    user.is_a? Customer
  end

  def cook?
    user.is_a? Cook
  end
end
