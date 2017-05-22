require 'rails_helper'

describe 'when a guest  visits the root' do
  it 'they are redirected to signup page if not logged in' do

    visit '/'

    expect(current_path).to eq(signup_path)
    expect(page).to have_link('Sign Up')
    expect(page).to have_link('Login')
  end

  xit 'they fill in user form and create account' do
    visit '/'

    click_on "Sign Up"

    email = page.find('#user_email')
    email.set("abc@gmail.com")

    password = page.find('#user_password')
    password.set("abc")

    password_confirmation = page.find('#user_password_confirmation')
    password_confirmation.set("abc")

    click_on "Create Account"

    expect(current_path).to eq(root_path)
    expect(page).to_not have_link("Sign Up")
    expect(page).to have_link("Logout")
    expect(page).to have_content("Welcome abc@gmail.com")
  end

  xit 'they enter an email that is already registered' do
    User.create(email: "abc@gmail.com", password: "abc")
    visit '/'

    click_on "Sign Up"

    email = page.find('#user_email')
    email.set("abc@gmail.com")

    password = page.find('#user_password')
    password.set("abc")

    password_confirmation = page.find('#user_password_confirmation')
    password_confirmation.set("abc")

    click_on "Create Account"

    expect(current_path).to eq(new_user_path)
    expect(page).to have_content("Sorry, but that email has already been taken.")
  end
end
