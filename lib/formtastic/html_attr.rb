module Formtastic
  module HtmlAttr  
    # view helper renders an html attributes hash
    # for example,
    #   <fieldset <%= html_attr wrapper %>>
    def html_attr(wrapper)
      raw wrapper.map {|atr,value| "#{atr}=\"#{value}\"" if value.present? }.compact.join(' ') 
    end  
  end
end
