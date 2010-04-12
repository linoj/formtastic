# coding: utf-8
require File.dirname(__FILE__) + '/spec_helper'

describe ':structure option for #inputs' do
  
  include FormtasticSpecHelper

  before do
    @output_buffer = ''
    mock_everything
  end
  
  it "is passed to render_field_set" do
    semantic_form_for(@new_post) do |builder|
      builder.should_receive(:render_field_set).with(hash_including(:structure => :foo)).and_return('tags')
      @inputs_output = builder.inputs :structure => :foo do
      end
    end    
  end
  
  it "is passed to render_input" do
    semantic_form_for(@new_post) do |builder|
      builder.should_receive(:render_input).with(hash_including(:structure => :foo)).and_return('tags')
      builder.inputs :structure => :foo do
        concat(builder.input(:title))
      end
    end        
  end
  
  it "overridden by nested inputs" do
    semantic_form_for(@new_post) do |builder|
      builder.should_receive(:render_field_set).with(hash_including(:structure => :foo)).and_return('foo tags')
      builder.inputs :structure => :foo do
        builder.should_receive(:render_field_set).with(hash_including(:structure => :bar)).and_return('bar tags')    
        builder.inputs :structure => :bar do
        end
      end
    end        
  end
  
  it "is used for buttons" do
    semantic_form_for(@new_post) do |builder|
      builder.should_receive(:render_field_set).with(hash_including(:structure => :foo)).twice.and_return('tags')
      builder.inputs :structure => :foo do
        builder.buttons
      end
    end            
  end
  
  it "is used for commit_button" do
    semantic_form_for(@new_post) do |builder|
      builder.should_receive(:render_input).with(hash_including(:structure => :foo)).and_return('tags')
      builder.inputs :structure => :foo do
        builder.commit_button
      end
    end            
  end
  
  it 'inherits current structure through semantic_fields_for'
  
end
