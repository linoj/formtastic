module Formtastic
  module ClassicFormtasticRenderer
    
    # this is the primary renderer api method
    def render_input(input)
      parts = {}
      parts[:errors] = input[:inline_errors] if input[:inline_errors].present?
      parts[:input]  = 
        if input[:items].present?
          contents = render_items(input)
          wrap_contents_in_fieldset(input[:label], contents)
        elsif input[:chronos].present?
          contents = render_chronos(input)
          wrap_contents_in_fieldset(input[:label], contents)
        else
          [input[:label], input[:input]].join
        end      
      parts[:hints]  = template.content_tag(:p, input[:hint], :class => 'inline-hints') if input[:hint].present?
      list_item_content = inline_order.map do |type|
        parts[type]
      end.compact.join("\n") 
      list_item_content = [input[:hidden], list_item_content].join("\n")   
      template.content_tag(:li, list_item_content, input[:wrapper])
    end    
    
    # render a fieldset. Note, contents are a string, already rendered.
    def render_field_set(fieldset)
      legend = fieldset[:legend]
      legend  = template.content_tag(:legend, template.content_tag(:span, legend)) unless legend.blank?
      
      contents = fieldset[:contents]
      contents = contents.join if contents.respond_to?(:join)

      template.content_tag(:fieldset,
        [legend, template.content_tag(:ol, contents)].join,
        fieldset[:wrapper]
      )
    end


    #
    protected
    
    # used for radios and check_boxes
    def render_items( input )
      contents = input[:items].to_a.map do |item|
        li_content = template.content_tag(:label,
          "#{item[:input]} #{item[:label]}",
          :for => item[:input_id]
        )
        template.content_tag(:li, li_content, item[:wrapper])
      end.join
    end

    # used for date/time selects
    def render_chronos( input )
      contents = input[:chronos].to_a.map do |item|
        template.content_tag(:li, [item[:label], item[:input] ].join )
      end.join
    end
        
    def wrap_contents_in_fieldset(label, contents)
      template.content_tag(:fieldset,
        template.content_tag(:legend, label, :class => 'label') <<
        template.content_tag(:ol, contents)
      )      
    end
    
  end
end