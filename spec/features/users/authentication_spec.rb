require "spec_helper"

describe "Logging In" do
  it "logs the user in and goes to the todo lists" do
    User.create(first_name: "Erin", last_name: "Hinson", email: "erin@email.com", password: "treehouse1", password_confirmation: "treehouse1")
    visit new_user_session_path
    fill_in "Email Address", with: "erin@email.com"
    fill_in "Password", with: "treehouse1"
    click_button "Log In"
    
    expect(page).to have_content("Todo Lists")
    expect(page).to have_content("Thanks for logging in!")
  end

  it "diplays the email address in the event of a failed login" do
    visit new_user_session_path
    fill_in "Email Address", with: "erin@email.com"
    fill_in "Password", with: "incorrect"
    click_button "Log In"

    expect(page).to have_content("Please check your email and password")
    expect(page).to have_field("Email Address", with: "erin@email.com")
  end
end