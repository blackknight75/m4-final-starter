require 'rails_helper'

describe 'when a user visits the links index page' do
  it 'they see a list of their own links that they created' do
    user = User.create(email: "abc@gmail.com", password: "abc")
    allow_any_instance_of(ApplicationController)
                                .to receive(:current_user)
                                .and_return(user)
    link = user.links.create(title: "IGN", url: "http://ign.com")

    visit links_path

    expect(page).to have_content("IGN")
    expect(page).to have_content("http://ign.com")
    expect(page).to have_content("false")
  end

  it 'they cannot see links made by other users' do
    user = User.create(email: "abc@gmail.com", password: "abc")
    user2 = User.create(email: "cba@gmail.com", password: "cba")
    allow_any_instance_of(ApplicationController)
                                .to receive(:current_user)
                                .and_return(user)
    link = user.links.create(title: "IGN", url: "http://ign.com")
    link2 = user2.links.create(title: "Google", url: "http://google.com")

    visit links_path

    expect(page).to have_content("IGN")
    expect(page).to have_content("http://ign.com")
    expect(page).to have_content("false")
    expect(page).to_not have_content("Google")
    expect(page).to_not have_content("http://google.com")
  end
end
