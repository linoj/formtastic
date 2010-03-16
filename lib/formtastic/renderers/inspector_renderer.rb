module Formtastic
  module InspectorRenderer
    
    def render_input(input)
      input.to_yaml
    end
    
    def render_field_set(fieldset)
      template.content_tag(:pre, fieldset.to_yaml)
    end
    
  end
end