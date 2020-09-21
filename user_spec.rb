require_relative 'user'
require_relative 'cat'
require_relative 'owner'
require 'minitest/autorun'
require 'pry'

describe User do
  let(:owner) { Owner.new('Riddle Paul') }

  describe '#name' do
    let(:user) { User.new(name: nil, number: 'ABC', owner: owner) }

    it 'must be present' do
      expect(user.valid?).must_equal false
      user.name = 'Paul Riddle'
      expect(user.valid?).must_equal true
    end
  end

  describe '#number' do
    let(:user) { User.new(name: 'Paul Riddle', number: '123', owner: owner) }

    it 'must have a certain format' do
      expect(user.valid?).must_equal false
      user.number = 'ABC'
      expect(user.valid?).must_equal true
    end
  end

  describe '#type' do
    let(:cat) { Cat.new('Simba') }
    let(:user) { User.new(name: 'Paul Riddle', number: 'ABC', owner: cat) }

    it 'must be Owner' do
      expect(user.valid?).must_equal false
      user.owner = owner
      expect(user.valid?).must_equal true
    end
  end
end
