require 'rails_helper'

RSpec.feature "Likes", type: :feature do
  feature 'Liking and Disliking Posts' do
  	background do
			User.new(name: 'Greg', email: 'gregz@email.com', password: 'password', password_confirmation: 'password')
		end
		scenario 'can like a post' do
			login_user('gregz@email.com', 'password')
			visit posts_path
			page.first('.like').click

			expect(current_path).to eq("/posts")
			expect(page).to have_content("You liked a post.")
		end

		scenario 'can dislike a post' do
			login_user('gregz@email.com', 'password')
			visit posts_path
			page.first('.dislike').click

			expect(current_path).to eq("/posts")
			expect(page).to have_content("You disliked a post.")
		end
	end
end
