require 'spec_helper'

describe 'User Pages' do

  subject { page } 

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }
    
    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end


  describe "signup page" do

    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "Should not create a user" do
        # runs User.count before and after the block { } and sees if they eq
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do 
        fill_in "Name", with: "Example User"
        fill_in "Email", with: "user@example.com"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end  

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end  

      describe "after saving user" do
        before {click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_link('Sign out') }
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
    end  

    describe "with invalid information" do
      before { click_button submit } 

      it { should have_title('Sign up') }
      it { should have_content('error') }
    end

    describe "with blank email" do
      before do
        fill_in "Email", with: " "
        click_button submit
      end

      it { should have_content("Email can't be blank")}
    end

    describe "with password too short" do
      before do
        fill_in "Password", with: "foo"
        click_button submit
      end

      it { should have_content "too short"}
    end

  end
end

