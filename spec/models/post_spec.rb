require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:content) }
    it {
      should validate_length_of(:content)
        .is_at_most(1000)
        .with_message('1000 characters in post is the maximum allowed.')
    }
  end

  describe 'Associations' do
    it { should belong_to(:user) }
    it { should have_many(:likes).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
  end

  describe 'Scope' do
    it 'applies a :ordered_by_most_recent scope to posts by datetime created descending' do
      expect(Post.all.ordered_by_most_recent.to_sql).to eq Post.all.order(created_at: :desc).to_sql
    end
  end
end
