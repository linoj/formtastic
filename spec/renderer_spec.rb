# coding: utf-8
require File.dirname(__FILE__) + '/spec_helper'

describe 'renderer' do
  
  include FormtasticSpecHelper

  before do
    @output_buffer = ''
    mock_everything
  end
  
  it 'can be configured to use custom renderer' do
    semantic_form_for(@new_post) do |builder|
      builder.should be_kind_of(::Formtastic::ClassicFormtasticRenderer)
    end

    # change it
    ::Formtastic::SemanticFormBuilder.renderer = ::Formtastic::ErbRenderer
    ::Formtastic::SemanticFormBuilder.renderer.should == ::Formtastic::ErbRenderer
    
    semantic_form_for(@new_post) do |builder|
      builder.should be_kind_of(::Formtastic::ErbRenderer)
    end
    
    # reset it
    ::Formtastic::SemanticFormBuilder.renderer = ::Formtastic::ClassicFormtasticRenderer
    ::Formtastic::SemanticFormBuilder.renderer.should == ::Formtastic::ClassicFormtasticRenderer
  end
  
  it 'can use renderer given as option' do
    semantic_form_for(@new_post, :renderer => :erb) do |builder|
      builder.should be_kind_of(::Formtastic::ErbRenderer)
    end    
  end

end
