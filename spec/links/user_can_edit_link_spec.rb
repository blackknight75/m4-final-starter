require 'rails_helper'

describe "when a user visits the index page" do
  it "they can edit a link with a good url and title" do
    user = User.create(email: "abc@gmail.com", password: "abc")
    allow_any_instance_of(ApplicationController)
                                .to receive(:current_user)
                                .and_return(user)
    link = user.links.create(title: "IGN", url: "http://ign.com")

    visit root_path

    expect(page).to have_content("IGN")
    expect(page).to have_content("http://ign.com")

    click_on('Edit')

    expect(current_path).to eq(edit_link_path(link))

    title = page.find('#link_title')
    title.set("Google")

    url = page.find('#link_url')
    url.set("http://google.com")

    click_on "Edit Link"

    expect(current_path).to eq(links_path)

    expect(page).to_not have_content("IGN")
    expect(page).to_not have_content("http://ign.com")
    expect(page).to have_content("Google")
    expect(page).to have_content("http://google.com")
  end

  it "edit link with invalid title" do
    user = User.create(email: "abc@gmail.com", password: "abc")
    allow_any_instance_of(ApplicationController)
                                .to receive(:current_user)
                                .and_return(user)
    link = user.links.create(title: "IGN", url: "http://ign.com")

    visit edit_link_path(link)

    title = page.find('#link_title')
    title.set("")

    click_on("Edit Link")

    expect(page).to have_content("Sorry, TITLE cannot be blank.")
    expect(Link.last.title).to eq("IGN")
  end

  it "edit link with invalid url" do
    user = User.create(email: "abc@gmail.com", password: "abc")
    allow_any_instance_of(ApplicationController)
                                .to receive(:current_user)
                                .and_return(user)
    link = user.links.create(title: "IGN", url: "http://ign.com")

    visit edit_link_path(link)

    title = page.find('#link_url')
    title.set("")

    click_on("Edit Link")

    expect(page).to have_content("Sorry, that is not a valid URL.")
    expect(Link.last.url).to eq("http://ign.com")
  end
end
