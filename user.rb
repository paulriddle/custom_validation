require_relative 'custom_validation'
require_relative 'owner'

class User
  include CustomValidation

  attr_accessor :name, :number, :owner

  validate :name, presence: true
  validate :number, format: /\A[A-Z]{1,3}\z/
  validate :owner, type: Owner

  def initialize(name: nil, number: nil, owner: nil)
    @name = name
    @number = number
    @owner = owner
  end
end
