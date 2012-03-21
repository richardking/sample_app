require 'spec_helper'

describe User do
  
  before { @user = User.new(name: "Example User", email: "user@example.com", password:"foobar", password_confirmation: "foobar") }
  
  subject { @user }
  
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest)}
  it { should respond_to(:password)}
  it { should respond_to(:password_confirmation)}
  it { should respond_to(:authenticate)}
  
  
  it { should be_valid }
  
  describe "when username is not present" do
    before { @user.name = "" }
    
    it {should_not be_valid}
  end
  
  describe "when email is not present" do
    before { @user.email = "" }
    
    it {should_not be_valid}
  end
  
  describe "when username is too long" do
    before { @user.name = "a" * 51 }
    
    it {should_not be_valid}
  end
  
  describe "when email is not valid" do
    invalid_emails = %w[user@foo,com user_at_foo.org example.user@foo.]
    invalid_emails.each do |e|
      before {@user.email = e}
      it {should_not be_valid}
    end
  end
  
  describe "when email is valid" do
    valid_emails = %w[user@foo.com A_USER@f.b.org frst.lst@foo.jp a+b@baz.cn]
    valid_emails.each do |e|
      before {@user.email = e}
      it {should be_valid}
    end
  end
  
  describe "when email is not unique" do
    before do
      duplicate_email = @user.dup
      duplicate_email.email = @user.email.upcase
      duplicate_email.save
    end
    
    it { should_not be_valid}
  end
  
  describe "when password is blank" do
    before {@user.password = @user.password_confirmation = " "}
    
    it { should_not be_valid}
  end
  
  describe "when passwords do not match" do
    before {@user.password_confirmation = "mismatch"}
    
    it {should_not be_valid}
  end
  
  describe "when password is nil" do
    before {@user.password = nil}
    
    it {should_not be_valid}
  end
  
  describe "when password is too short" do
    before {@user.password = "a" * 5}
    
    it {should_not be_valid}
  end
  
  describe "return value of authentication method" do
    before {@user.save}
    let (:found_user) {User.find_by_email(@user.email)}
    
    describe "with valid password" do
      it { should == found_user.authenticate(@user.password)}
    end
    
    
    describe "with invalid password" do
      let(:user_for_invalid_password) {found_user.authenticate("invalid")}
      
      it { should_not == user_for_invalid_password}
      specify {user_for_invalid_password.should be_false}
    end
  end
  
end
# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

