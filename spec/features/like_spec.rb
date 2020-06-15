require 'rails_helper'

RSpec.feature 'Likes', type: :feature do
  feature 'Liking and Disliking Posts' do
    background do
      User.create!(name: 'Greg', email: 'greg@email.com', password: 'password', password_confirmation: 'password')
    end
    scenario 'can like a post' do
      login_user('greg@email.com', 'password')
      create_post("this is a post")
      visit posts_path
      page.first('.like').click

      expect(current_path).to eq('/posts')
      expect(page).to have_content('You liked a post.')
    end

    scenario 'can dislike a post' do
      login_user('greg@email.com', 'password')
      create_post("this is a post")
      visit posts_path
      page.first('.like').click
      page.first('.dislike').click

      expect(current_path).to eq('/posts')
      expect(page).to have_content('You disliked a post.')
    end
  end
end
