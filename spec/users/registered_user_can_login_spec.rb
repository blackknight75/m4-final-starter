require "rails_helper"

describe 'when a registered user visits the root page' do
  it 'they can login with their credentials' do
    User.create(email: "abc@gmail.com", password: "abc")

    visit signup_path

    expect(page).to have_button('Login')
    expect(page).to have_button('Create Account')

    within('#login-form') do
      email = page.find('#user_email')
      email.set("abc@gmail.com")

      password = page.find('#user_password')
      password.set("abc")

      click_on('Login')
    end
    expect(current_path).to eq(links_path)
    expect(page).to_not have_link("Register")
    expect(page).to have_link("Logout")
    expect(page).to have_content("You have successfully logged in!")
  end

  it 'they wrong credentials' do
    User.create(email: "abc@gmail.com", password: "abc")

    visit signup_path

    expect(page).to have_button('Login')
    expect(page).to have_button('Create Account')

    within('#login-form') do
      email = page.find('#user_email')
      email.set("abc@gmail.com")

      password = page.find('#user_password')
      password.set("df")

      click_on('Login')
    end

    expect(current_path).to eq(signup_path)
    expect(page).to have_content("Email or Password is incorrect!")
  end
  it 'they can logout' do
    user = User.create(email: "abc@gmail.com", password: "abc")
    allow_any_instance_of(ApplicationController)
                                .to receive(:current_user)
                                .and_return(user)

    visit root_path

    expect(page).to have_link('Logout')
    expect(page).to_not have_link('Login')
    expect(page).to_not have_link('Register')

    click_on("Logout")

    expect(current_path).to eq(signup_path)
    expect(page).to_not have_link('Logout')
    expect(page).to have_button('Login')
    expect(page).to have_button('Create Account')
  end
end
