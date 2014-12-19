require 'spec_helper'

describe User do
  let(:valid_attributes) {
    {
      first_name: "Erin",
      last_name: "Hinson",
      email: "erin@email.com",
      password: "treehouse1234",
      password_confirmation: "treehouse1234"
    }
  }
  context "validations" do
    let(:user) { User.new(valid_attributes) }

    before do
      User.create(valid_attributes)
    end

    it "requires an email" do 
      expect(user).to validate_presence_of(:email)
    end

    it "requires a unique email" do
      expect(user).to validate_uniqueness_of(:email)
    end

    it "requires a unique email (case insensitive)" do
      user.email = "ERIN@EMAIL.COM"
      expect(user).to validate_uniqueness_of(:email)
    end

    it "requires the email address to look like an email" do
      user.email = "erin"
      expect(user).to_not be_valid
    end
    
  end

  describe "#downcase_email" do
    it "makes the email attribute lower case" do
      user = User.new(valid_attributes.merge(email: "ERIN@EMAIL.COM"))
      expect{ user.downcase_email }.to change{ user.email }.
        from("ERIN@EMAIL.COM").
        to("erin@email.com")
    end

    it "downcases an email before saving" do
      user = User.new(valid_attributes)
      user.email = "MIKE@TEAMTREEHOUSE.COM"
      expect(user.save).to be_true
      expect(user.email).to eq("mike@teamtreehouse.com")
    end
  end
end
