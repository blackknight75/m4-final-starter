require 'rails_helper'

describe 'when a user visits link index' do
  it 'they fill in a form for creating link, submit and it is created' do
    user = User.create(email: "abc@gmail.com", password: "abc")
    allow_any_instance_of(ApplicationController)
                                .to receive(:current_user)
                                .and_return(user)
    visit links_path

    within('#links-form') do
      title = page.find('#link_title')
      title.set("Google")

      url = page.find('#link_url')
      url.set("http://google.com")

      click_on "Create Link"
    end

      expect(page).to have_content("Google")
      expect(page).to have_content("http://google.com")
      expect(page).to have_content("false")
  end

  it 'user submits invalid url' do
    user = User.create(email: "abc@gmail.com", password: "abc")
    allow_any_instance_of(ApplicationController)
                                .to receive(:current_user)
                                .and_return(user)
    visit links_path

    within('#links-form') do
      title = page.find('#link_title')
      title.set("Google")

      url = page.find('#link_url')
      url.set("adfsd")

      click_on "Create Link"
    end

    expect(current_path).to eq(links_path)
    expect(page).to_not have_content("Google")
    expect(page).to_not have_content("http://google.com")
    expect(page).to_not have_content("false")
  end
end
