module Formtastic
  module ErbRenderer
    
    # render the input
    #   looks for partial named for the :as widget ('_string', '_textarea' etc) in
    #   - app/views/CURRENT_CONTROLLERS/
    #   - app/views/formtastic/
    #   - vendor/plugins/formtastic/app/views/formtastic/
    #   if not found, then looks for a generic '_input' partial in the same places
    #   or '_items' or '_chronos'
    
    def render_input(input)
      #debugger
      defaults = { # to avoid undefined local variables in templates
        :method       => nil,
        :as           => nil,
        :options      => {},
        :label        => nil,
        :hint         => nil,
        :errors       => nil,
        :inline_errors => nil,
        :hidden       => nil,
        :structure    => nil
      }      
      input.reverse_merge!(defaults)
      partial = input[:options][:partial] || input[:as].to_s
      structure = input[:structure]
      partial = "#{structure}_#{partial}" if structure.present?
      begin
        template.render( partial, input )
      rescue ActionView::MissingTemplate
        begin
          template.render( "formtastic/#{partial}", input )
        rescue ActionView::MissingTemplate
          partial = input[:chronos].present? ? 'chronos' : (input[:items].present? ? 'items' : 'input')
          partial = "#{structure}_#{partial}" if structure.present?
          begin
            template.render( partial, input )
          rescue ActionView::MissingTemplate
            template.render( "formtastic/#{partial}", input )
          end
        end
      end
    end
    
    def render_field_set(fieldset)
      #debugger
      defaults = { # to avoid undefined local variables in templates
        :options      => {},
        :legend       => nil,
        :contents     => nil,
      }
      fieldset.reverse_merge!(defaults)
      partial = fieldset[:options][:partial] || 'fields'
      structure = fieldset[:structure]
      partial = "#{structure}_#{partial}" if structure.present?
      begin
        template.render( partial, fieldset )
      rescue ActionView::MissingTemplate
        template.render( "formtastic/#{partial}", fieldset )
      end
    end
    
  end
end