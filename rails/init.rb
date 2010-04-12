# coding: utf-8
require File.join(File.dirname(__FILE__), *%w[.. lib formtastic])
require File.join(File.dirname(__FILE__), *%w[.. lib formtastic layout_helper])
Dir["#{File.dirname(__FILE__)}/renderers/*.rb"].each {|f| require f}
ActionView::Base.send :include, Formtastic::SemanticFormHelper
ActionView::Base.send :include, Formtastic::LayoutHelper

require File.join(File.dirname(__FILE__), *%w[.. lib formtastic html_attr])
ActionView::Base.send :include, Formtastic::HtmlAttr
