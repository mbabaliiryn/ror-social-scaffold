require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:friend).class_name('User') }
  end

  describe 'Class Method ::add_friend' do
    let(:user_id) { 28 }
    let(:friend_id) { 14 }
    let(:state) { 'pending' }
    it 'should return an Array' do
      expect(Friendship.add_friend(user_id, friend_id, state)).to be_an Array
    end

    it 'returned array should contain frienship objects' do
      result = Friendship.add_friend(user_id, friend_id, state)
      expect(result).to include(Friendship)
    end
  end
end
