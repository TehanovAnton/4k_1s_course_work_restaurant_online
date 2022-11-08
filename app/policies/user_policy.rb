class UserPolicy < ApplicationPolicy
  def update?
    binding.pry
    user.email != 'tehanovanton@gmail.com'
  end
end
