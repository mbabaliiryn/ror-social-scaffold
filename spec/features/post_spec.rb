require 'rails_helper'

RSpec.feature 'Posts', type: :feature do
  feature 'Creating Post' do
    background do
      User.create!(name: 'Greg', email: 'greg@email.com', password: 'password', password_confirmation: 'password')
    end
    scenario 'with valid params' do
      login_user('greg@email.com', 'password')
      create_post('this is a test')

      expect(current_path).to eq('/posts')
      expect(page).to have_content('this is a test')
    end

    scenario 'with invalid params' do
      login_user('greg@email.com', 'password')
      create_post(nil)

      expect(current_path).to eq('/posts')
      expect(page).to have_content("Content can't be blank")
    end
  end
end
