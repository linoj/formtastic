# coding: utf-8
require File.dirname(__FILE__) + '/spec_helper'

describe 'ErbRenderer' do
  
  include FormtasticSpecHelper

  before do
    @old_renderer = ::Formtastic::SemanticFormBuilder.renderer
    ::Formtastic::SemanticFormBuilder.renderer = Formtastic::ErbRenderer
    @output_buffer = ''
    mock_everything
  end
  
  after do
    ::Formtastic::SemanticFormBuilder.renderer = @old_renderer
  end
  
  describe "render_input" do
    describe "with :input" do
      before do
        @input ={
          :as             => :string,
          :input          => '<input type="string" />'        
        }
      end
    
      it 'renders partial for the input type (string)' do
        semantic_form_for(@new_post) do |builder|
          builder.template.should_receive(:render).with('string', @input).and_return('tags')
          concat(builder.render_input(@input))
        end
      end
    
      it 'renders partial for input type in formtastic/ directory' do
        semantic_form_for(@new_post) do |builder|
          builder.template.should_receive(:render).with('string', @input).and_raise(ActionView::MissingTemplate.new([], '.'))
          builder.template.should_receive(:render).with('formtastic/string', @input).and_return('tags')
          concat(builder.render_input(@input))
        end
      end
    
      it 'renders partial for general input' do
        semantic_form_for(@new_post) do |builder|
          builder.template.should_receive(:render).with('string', @input).and_raise(ActionView::MissingTemplate.new([], '.'))
          builder.template.should_receive(:render).with('formtastic/string', @input).and_raise(ActionView::MissingTemplate.new([], '.'))
          builder.template.should_receive(:render).with('input', @input).and_return('tags')
          concat(builder.render_input(@input))
        end
      end
    
      it 'renders partial for general input in formtastic/ directory' do 
        semantic_form_for(@new_post) do |builder|
          builder.template.should_receive(:render).with('string', @input).and_raise(ActionView::MissingTemplate.new([], '.'))
          builder.template.should_receive(:render).with('formtastic/string', @input).and_raise(ActionView::MissingTemplate.new([], '.'))
          builder.template.should_receive(:render).with('input', @input).and_raise(ActionView::MissingTemplate.new([], '.'))
          builder.template.should_receive(:render).with('formtastic/input', @input).and_return('tags')
          concat(builder.render_input(@input))
        end    
      end
      
      it "should pass defaults for missing keys so local variables are not undefined" do
        fullinput = {
          :as           => :string,
          :input        => '<input type="string" />',
          :method       => nil,
          :options      => {},
          :label        => nil,
          :hint         => nil,
          :errors       => nil,
          :inline_errors => nil,
          :hidden       => nil,
          :structure    => nil
        }
        semantic_form_for(@new_post) do |builder|
          builder.template.should_receive(:render).with('string', fullinput).and_return('tags')
          concat(builder.render_input(@input))
        end
      end
      
    end

    describe "with :items" do
      before do
        @input ={
          :as             => :radio,
          :items          => ['list', 'of', 'items']        
        }
      end
    
      it 'renders partial for the input type (radio)' do
        semantic_form_for(@new_post) do |builder|
          builder.template.should_receive(:render).with('radio', @input).and_return('tags')
          concat(builder.render_input(@input))
        end
      end
    
      it 'renders partial for input type in formtastic/ directory' do
        semantic_form_for(@new_post) do |builder|
          builder.template.should_receive(:render).with('radio', @input).and_raise(ActionView::MissingTemplate.new([], '.'))
          builder.template.should_receive(:render).with('formtastic/radio', @input).and_return('tags')
          concat(builder.render_input(@input))
        end
      end
    
      it 'renders partial for general items' do
        semantic_form_for(@new_post) do |builder|
          builder.template.should_receive(:render).with('radio', @input).and_raise(ActionView::MissingTemplate.new([], '.'))
          builder.template.should_receive(:render).with('formtastic/radio', @input).and_raise(ActionView::MissingTemplate.new([], '.'))
          builder.template.should_receive(:render).with('items', @input).and_return('tags')
          concat(builder.render_input(@input))
        end
      end
    
      it 'renders partial for general items in formtastic/ directory' do
        semantic_form_for(@new_post) do |builder|
          builder.template.should_receive(:render).with('radio', @input).and_raise(ActionView::MissingTemplate.new([], '.'))
          builder.template.should_receive(:render).with('formtastic/radio', @input).and_raise(ActionView::MissingTemplate.new([], '.'))
          builder.template.should_receive(:render).with('items', @input).and_raise(ActionView::MissingTemplate.new([], '.'))
          builder.template.should_receive(:render).with('formtastic/items', @input).and_return('tags')
          concat(builder.render_input(@input))
        end    
      end
    end

    describe "with :chronos" do
      before do
        @input ={
          :as             => :datetime,
          :chronos        => ['list', 'of', 'chronos']        
        }
      end
    
      it 'renders partial for the input type (datetime)' do
        semantic_form_for(@new_post) do |builder|
          builder.template.should_receive(:render).with('datetime', @input).and_return('tags')
          concat(builder.render_input(@input))
        end
      end
    
      it 'renders partial for input type in formtastic/ directory' do
        semantic_form_for(@new_post) do |builder|
          builder.template.should_receive(:render).with('datetime', @input).and_raise(ActionView::MissingTemplate.new([], '.'))
          builder.template.should_receive(:render).with('formtastic/datetime', @input).and_return('tags')
          concat(builder.render_input(@input))
        end
      end
    
      it 'renders partial for general chronos' do
        semantic_form_for(@new_post) do |builder|
          builder.template.should_receive(:render).with('datetime', @input).and_raise(ActionView::MissingTemplate.new([], '.'))
          builder.template.should_receive(:render).with('formtastic/datetime', @input).and_raise(ActionView::MissingTemplate.new([], '.'))
          builder.template.should_receive(:render).with('chronos', @input).and_return('tags')
          concat(builder.render_input(@input))
        end
      end
    
      it 'renders partial for general chronos in formtastic/ directory' do
        semantic_form_for(@new_post) do |builder|
          builder.template.should_receive(:render).with('datetime', @input).and_raise(ActionView::MissingTemplate.new([], '.'))
          builder.template.should_receive(:render).with('formtastic/datetime', @input).and_raise(ActionView::MissingTemplate.new([], '.'))
          builder.template.should_receive(:render).with('chronos', @input).and_raise(ActionView::MissingTemplate.new([], '.'))
          builder.template.should_receive(:render).with('formtastic/chronos', @input).and_return('tags')
          concat(builder.render_input(@input))
        end    
      end
    end
    
    describe "with :partial option" do
      it 'uses partial specified' do
        @input ={
          :as             => :string,
          :input          => '<input type="string" />',
          :options        => {:partial => 'foobar'}     
        }    
        semantic_form_for(@new_post) do |builder|
          builder.template.should_receive(:render).with('foobar', @input).and_return('tags')
          concat(builder.render_input(@input))
        end
      end
      
      
    end
  
    describe "with :structure as partial prefix" do
      before do
        @input ={
          :as             => :string,
          :input          => '<input type="string" />',
          :structure      => :foo
        }
      end
    
      it 'prefixes structure name to input type partial' do
        semantic_form_for(@new_post) do |builder|
          builder.template.should_receive(:render).with('foo_string', @input).and_return('tags')
          concat(builder.render_input(@input))
        end
      end
    
      it 'prefixes structure name to general input partial' do
        semantic_form_for(@new_post) do |builder|
          builder.template.should_receive(:render).with('foo_string', @input).and_raise(ActionView::MissingTemplate.new([], '.'))
          builder.template.should_receive(:render).with('formtastic/foo_string', @input).and_raise(ActionView::MissingTemplate.new([], '.'))
          builder.template.should_receive(:render).with('foo_input', @input).and_return('tags')
          concat(builder.render_input(@input))
        end
      end    
    end
    
    ### TODO: view specs
  end
  
  describe "render_field_set" do 
    before do
      @fieldset = {
        :legend       => 'title',
        :contents     => 'content tags'        
      }      
    end   
    
    it 'renders fields partial' do
      semantic_form_for(@new_post) do |builder|
        builder.template.should_receive(:render).with('fields', @fieldset).and_return('tags')
        concat(builder.render_field_set(@fieldset))
      end
    end

    it 'renders fields partial in formtastic/ directory' do
      semantic_form_for(@new_post) do |builder|
        builder.template.should_receive(:render).with('fields', @fieldset).and_raise(ActionView::MissingTemplate.new([], '.'))
        builder.template.should_receive(:render).with('formtastic/fields', @fieldset).and_return('tags')
        concat(builder.render_field_set(@fieldset))
      end
    end
    
    it 'prefixes structure name to partial' do
      @fieldset[:structure] = :foo      
      semantic_form_for(@new_post) do |builder|
        builder.template.should_receive(:render).with('foo_fields', @fieldset).and_return('tags')
        concat(builder.render_field_set(@fieldset))
      end
    end
    
  end
end