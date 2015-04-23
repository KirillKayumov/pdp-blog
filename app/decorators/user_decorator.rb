class UserDecorator < Draper::Decorator
  delegate :full_name
end
