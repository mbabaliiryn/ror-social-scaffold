require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'Validations' do
  	it {should validate_uniqueness_of(:user_id).scoped_to(:post_id)}
  end

  describe 'Associations' do
  	it {should belong_to(:user)}
  	it {should belong_to(:post)}
  end
end
