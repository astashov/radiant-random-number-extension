require File.dirname(__FILE__) + '/../spec_helper'

describe RandomNumberTags do
  
  before do
    @page = Page.create!(
      :title => 'New Page',
      :slug => 'page',
      :breadcrumb => 'New Page',
      :status_id => '100'
    )
  end
  
  it "should show random number" do
    @page.update_attributes!(:parts => [{:name => "body", :content => "<r:random_number min='20' max='40' />"}])
    output = @page.reload.render.to_i
    (output >= 20).should be_true
    (output <= 40).should be_true
  end
  
  it "should show number with incorrect tag attributes" do
    @page.should render("<r:random_number min='10' max='5' />").as('0')
    @page.should render("<r:random_number min='10' max='sdfsad' />").as('0')
    
    @page.update_attributes!(:parts => [{:name => "body", :content => "<r:random_number min='asdf' max='40' />"}])
    output = @page.reload.render.to_i
    (output >= 0).should be_true
    (output <= 40).should be_true
    
    @page.update_attributes!(:parts => [{:name => "body", :content => "<r:random_number min='asdf' max='10' />"}])
    output = @page.reload.render.to_i
    (output >= 0).should be_true
    (output <= 10).should be_true
  end
  
end