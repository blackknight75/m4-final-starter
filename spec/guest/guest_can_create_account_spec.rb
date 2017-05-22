require 'rails_helper'

describe 'when a guest  visits the root' do
  it 'they are redirected to signup page if not logged in' do

    visit root_path

    expect(current_path).to eq(signup_path)
    expect(page).to have_button('Create Account')
    expect(page).to have_button('Login')
  end

  it 'they fill in user form and create account' do
    visit '/signup'

  within('#signup-form') do
    email = page.find('#user_email')
    email.set("abc@gmail.com")

    password = page.find('#user_password')
    password.set("abc")

    password_confirmation = page.find('#user_password_confirmation')
    password_confirmation.set("abc")

    click_on "Create Account"
  end

    expect(current_path).to eq(links_path)
    expect(page).to_not have_link("Sign Up")
    expect(page).to_not have_link("Login")
    expect(page).to have_link("Logout")
  end

  it 'they enter an email that is already registered' do
    User.create(email: "abc@gmail.com", password: "abc")
    visit signup_path

    within('#signup-form') do
      email = page.find('#user_email')
      email.set("abc@gmail.com")

      password = page.find('#user_password')
      password.set("abc")

      password_confirmation = page.find('#user_password_confirmation')
      password_confirmation.set("abc")
    end

    click_on "Create Account"

    expect(current_path).to eq(signup_path)
    expect(page).to have_content("Sorry, but that email has already been taken.")
  end
end
