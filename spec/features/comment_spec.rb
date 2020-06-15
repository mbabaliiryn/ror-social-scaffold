require 'rails_helper'

RSpec.feature 'Comments', type: :feature do
  feature 'Creating Comment' do
    background do
      User.create!(name: 'Greg', email: 'greg@email.com', password: 'password', password_confirmation: 'password')
    end

    scenario 'with valid content' do
      login_user('greg@email.com', 'password')
      create_post('this is a post')
      visit posts_path
      page.first('#comment_content').set('this is a test comment')
      page.first('.btn-secondary').click

      expect(current_path).to eq('/posts')
      expect(page).to have_content('this is a test comment')
    end

    scenario 'with invalid content' do
      login_user('greg@email.com', 'password')
      create_post('this is a post')
      visit posts_path
      page.first('#comment_content').set(nil)
      page.first('.btn-secondary').click

      expect(current_path).to eq('/posts')
      expect(page).to have_content("Content can't be blank")
    end
  end
end
