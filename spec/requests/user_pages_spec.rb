require 'spec_helper'

describe "UserPages" do
  subject {page}
  
  describe "sign up page" do
    before { visit signup_path }
    
    it { should have_selector('h1', text: 'Sign up') }
    it { should have_selector('title', text: full_title('Sign up')) }
  end
  
  describe "profile page" do
    let(:user) {FactoryGirl.create(:user)}
    before {visit user_path(user)}
    
    it { should have_selector('h1', text: user.name)}
    it { should have_selector('title', text: user.name)}
  end
  
  describe "sign up" do
    before {visit signup_path}
    
    describe "with invalid information" do
      it "should not create user account" do
        expect { click_button "Create my account"}.not_to change(User, :count)
      end
    end
    
    describe "with valid information" do
      before do
        fill_in "Name", with: "Example User"
        fill_in "Email", with: "example@railstutorial.org"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end
      
      describe "after saving the user" do
        before { click_button "Create my account" }
        let(:user) {User.find_by_email('example@railstutorial.org')}
        
        it { should have_selector('title', text: user.name)}
        it { should have_selector('div.alert.alert-success', text: 'Welcome')}
        it { should have_link('Sign out', href: signout_path)}
      end
      
      it "should create user account" do
        expect { click_button "Create my account"}.to change(User, :count).by(1)
      end
    end
  end
    
  
end
