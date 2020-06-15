require 'rails_helper'
# rubocop:disable Metrics/BlockLength
RSpec.feature 'Users', type: :feature do
  feature 'Signing Up' do
    scenario 'with invalid params' do
      create_user(nil, nil, nil, nil)
      expect(page).to have_content("Name can't be blank")
    end
    scenario 'with valid params' do
      user1 = build(:user)
      create_user(user1.name, user1.email, user1.password, user1.password_confirmation)
      expect(page).to have_content('You have signed up successfully')
    end
  end
  feature 'Signing In' do
    background do
      User.create!(name: 'Greg', email: 'greg@email.com', password: 'password', password_confirmation: 'password')
    end
    scenario 'with correct credentials' do
      login_user('greg@email.com', 'password')
      expect(current_path).to eq('/')
      expect(page).to have_content('Signed in successfully.')
    end
    scenario 'without correct credentials' do
      login_user('gregz@email.com', 'pasword')
      expect(current_path).to eq('/users/sign_in')
      expect(page).to have_content('Invalid Email or password.')
    end
  end
  feature 'Sending Friend Requests' do
    background do
      User.create!(name: 'Greg', email: 'greg@email.com', password: 'password', password_confirmation: 'password')
      User.create!(name: 'Paul', email: 'paul@email.com', password: 'password', password_confirmation: 'password')
    end
    scenario 'can invite another user to frienship' do
      login_user('greg@email.com', 'password')
      visit users_path
      page.first('.invite').click
      expect(current_path).to eq('/users')
      expect(page).to have_content('Request Sent!')
    end
  end
  feature 'Accepting Pending Friend Requests' do
    background do
      User.create!(name: 'Greg', email: 'greg@email.com', password: 'password', password_confirmation: 'password')
      User.create!(name: 'Paul', email: 'paul@email.com', password: 'password', password_confirmation: 'password')
    end
    scenario 'can accept a pending frienship request from another user' do
      login_user('greg@email.com', 'password')
      visit users_path
      page.first('.invite').click
      logout_user
      login_user('paul@email.com', 'password')
      visit users_path
      page.first('.accept').click
      expect(page).to have_content('Friend Successfully Accepted!')
    end
  end

  feature 'Rejecting Pending Friend Requests' do
    background do
      User.create!(name: 'Greg', email: 'greg@email.com', password: 'password', password_confirmation: 'password')
      User.create!(name: 'Paul', email: 'paul@email.com', password: 'password', password_confirmation: 'password')
    end
    scenario 'can reject a pending frienship request from another user' do
      login_user('greg@email.com', 'password')
      visit users_path
      page.first('.invite').click
      logout_user
      login_user('paul@email.com', 'password')
      visit users_path
      page.first('.reject').click
      expect(page).to have_content('Removed!')
    end
  end
end
# rubocop:enable Metrics/BlockLength
