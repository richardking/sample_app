require 'spec_helper'

describe "Static pages" do

  let(:base_title) { "Ruby on Rails Tutorial Sample App" }
  
  subject {page}

  describe "Home page" do
    before { visit root_path }
    
    it { should have_selector('h1', text: 'Sample App')}
    
    it { should have_selector('title', text: full_title('')) }
    
    it { should_not have_selector('title', text: '| Home') }
    
    
    it "should have the h1 'Sample App'" do
      page.should have_selector('h1', :text => 'Sample App')
    end

    it "should have the content 'Home'" do
      page.should have_selector('title', :text => "#{base_title}")
    end
    
    it "should not have a custom page title" do
      page.should_not have_selector('title', :text => '| Home')
    end
        
  end
  
  describe "Contact page" do
    before { visit contact_path }
    
    it { should have_selector('h1', text: 'Contact') }
    
    it { should have_selector('title', text: full_title('Contact')) }
    
    it "should have the content 'Contact Us'" do
      page.should have_selector('h1', :text => 'Contact')
    end
    
    it "should have the content 'Contact Us'" do
      page.should have_selector('title', :text => ' | Contact')
    end
  end 
  
  describe "Help page" do
    
    it "should have the content 'Help'" do
      visit help_path
      page.should have_selector('h1', :text => 'Help')
    end

    it "should have the content 'Help'" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit help_path
      page.should have_selector('title', :text => ' | Help')
    end
  end
  
  describe "About page" do
    
    it "should have the content 'About Us'" do
      visit about_path
      page.should have_selector('h1', :text => 'About Us')
    end
    
    it "should have the content 'About'" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit about_path
      page.should have_selector('title', :text => ' | About Us')
    end
    
  end
  
end
