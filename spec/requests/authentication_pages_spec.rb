require 'spec_helper'

describe "AuthenticationPages" do
  subject {page}
  
  describe "signin page" do
    before {visit signin_path}
    
    describe "with invalid information" do
      before { click_button "Sign in" }
  
      it { should have_selector('title', text: 'Sign in') }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }
      
      describe "error message persisting too long" do
        before { click_link "Home"}
        
        it { should_not have_selector('div', text: "Invalid username/password combination") }
      end
    end
    
    describe "with valid information" do
      let(:user) {FactoryGirl.create(:user)}
      before {sign_in user}

      it { should have_selector('title', text: user.name) }
      
      it { should have_link('Users', href: users_path)}
      it { should have_link('Profile', href: user_path(user))}
      it { should have_link('Settings', href: edit_user_path(user)) }
      it { should have_link('Sign out', href: signout_path)}
      it { should_not have_link('Sign in', href: signin_path) }
      
      describe "then sign out" do
        before { click_link "Sign out" }
        
        it { should have_link('Sign in', href: signin_path)}
      end
    end
    
  end
  
  describe "authorization" do
    describe "for signed in users" do
      let(:user) {FactoryGirl.create(:user)}
      
      describe "in user controller" do
        describe "visit the edit page" do
          before { visit edit_user_path(user)}
          it { should have_selector('title', text: 'Sign in')}
        end
        
        describe "submitting the update action" do
          before { put user_path(user) }
          specify { response.should redirect_to(signin_path)}
        end
      end
    end
    
    describe "as non-admin user" do
      let(:user) {FactoryGirl.create(:user)}
      let(:non_admin) {FactoryGirl.create(:user)}
      
      before { sign_in non_admin }
      
      describe "submitting a DELETE request to the User#destroy action" do
        before { delete user_path(user)}
        specify {response.should redirect_to(root_path)}
      end
    end
    
    describe "as wrong user" do
      let (:user) {FactoryGirl.create(:user)}
      let (:wrong_user) {FactoryGirl.create(:user, email: 'wrongemail@example.com')}
      before { sign_in user }
      
      describe "visiting user#edit page" do
        before {visit edit_user_path(wrong_user)}
        it { should have_selector('title', text: full_title('') )}
      end
    
      describe "submitting a PUT request to the user#update action" do
        before { put user_path(wrong_user) }
        specify { response.should redirect_to :root}
      end
      
    end
    
    describe "for non-signed-in users" do
      let (:user) {FactoryGirl.create(:user)}
      
      describe "when visiting the user index" do
        before { visit users_path }
        
        it { should have_selector('title', text: 'Sign in')}
      end
      
      describe "when attempting to visit protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email", with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
        end
        
      
        describe "after signing in" do
          it { should have_selector('title', text: 'Edit user')}
        end
      end
    end
  end
end