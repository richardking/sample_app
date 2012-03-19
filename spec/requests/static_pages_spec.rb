require 'spec_helper'

describe "Static pages" do

  let(:base_title) { "Ruby on Rails Tutorial Sample App" }
  
  subject {page}
  
  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_selector('title', text: full_title(title)) }
  end

  describe "Home page" do
    before { visit root_path }
    
    let(:heading) { 'Sample App' }
    let(:title) { '' }
    
    it_should_behave_like "all static pages"
    
    
    
    # it { should have_selector('h1', text: 'Sample App')}
    #   
    #   it { should have_selector('title', text: full_title('')) }
    #   
    #   it { should_not have_selector('title', text: '| Home') }
    #   
    #   
    #   it "should have the h1 'Sample App'" do
    #     page.should have_selector('h1', :text => 'Sample App')
    #   end
    # 
    #   it "should have the content 'Home'" do
    #     page.should have_selector('title', :text => "#{base_title}")
    #   end
    #   
    #   it "should not have a custom page title" do
    #     page.should_not have_selector('title', :text => '| Home')
    #   end
        
  end
  
  describe "Contact page" do
    before { visit contact_path }
    
    let(:heading) { 'Contact' }
    let(:title) { 'Contact' }
    
    it_should_behave_like "all static pages"
    
    
    # it { should have_selector('h1', text: 'Contact') }
    # 
    # it { should have_selector('title', text: full_title('Contact')) }
    # 
    # it "should have the content 'Contact Us'" do
    #   page.should have_selector('h1', :text => 'Contact')
    # end
    # 
    # it "should have the content 'Contact Us'" do
    #   page.should have_selector('title', :text => ' | Contact')
    # end
    # 
  end 
  
  describe "Help page" do
    before { visit help_path }
    
    let(:heading) { 'Help' }
    let(:title) { 'Help' }
     
    it_should_behave_like "all static pages"
    
    
    
    # it "should have the content 'Help'" do
    #   visit help_path
    #   page.should have_selector('h1', :text => 'Help')
    # end
    # 
    # it "should have the content 'Help'" do
    #   visit help_path
    #   page.should have_selector('title', :text => ' | Help')
    # end
    
    
  end
  
  describe "About page" do
    before {visit about_path}
    
    let(:heading) {'About Us'}
    let(:title) {'About Us'}
    
    it_should_behave_like "all static pages"
    
    # it "should have the content 'About Us'" do
    #   visit about_path
    #   page.should have_selector('h1', :text => 'About Us')
    # end
    # 
    # it "should have the content 'About'" do
    #   visit about_path
    #   page.should have_selector('title', :text => ' | About Us')
    # end
    
  end
  
  
  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    page.should have_selector 'title', text: full_title('About Us')
    click_link "Help"
    page.should have_selector 'title', text: full_title('Help')
    click_link "Contact"
    page.should have_selector 'title', text: full_title('Contact')
    click_link "Home"
    page.should have_selector 'title', text: full_title('')
    click_link "Sign up now!"
    page.should have_selector 'title', text: full_title('Sign up')
  end
  
end
