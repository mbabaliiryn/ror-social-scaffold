require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
  	it {should validate_presence_of(:name)}
  	it {should validate_length_of(:name).is_at_most(20)}
  end

  describe 'Associations' do
  	it {should have_many(:posts)}
  	it {should have_many(:comments)}
  	it {should have_many(:likes)}
  	it {should have_many(:friendships)}
  	it {should have_many(:friends).class_name('Friendship').with_foreign_key('friend_id')}
  end

  describe 'Instance Methods' do
  	let(:user) {User.new(name: "Tommy")}
  	context '#my_friends' do
  		it 'should return an Array of my friends' do
  			expect(user.my_friends).to be_an Array
  		end
  	end

  	context '#pending_friends' do
  		it 'should return an Array of pending friends' do
  			expect(user.pending_friends).to be_an Array
  		end

  	end

  	context '#friend_requests' do
  		it 'should return an Array of friend requests' do
	  		expect(user.friend_requests).to be_an Array
	  	end
  	end
  end
end
