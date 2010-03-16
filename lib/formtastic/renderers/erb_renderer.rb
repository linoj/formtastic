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
      begin
        template.render( input[:as].to_s, input )
      rescue ActionView::MissingTemplate
        begin
          template.render( "formtastic/#{input[:as]}", input )
        rescue ActionView::MissingTemplate
          partial = input[:chronos].present? ? 'chronos' : (input[:items].present? ? 'items' : 'input')
          begin
            template.render( partial, input )
          rescue ActionView::MissingTemplate
            template.render( "formtastic/"+partial, input )
          end
        end
      end
    end
    
    def render_field_set(fieldset)
      begin
        template.render( 'fieldset', fieldset )
      rescue ActionView::MissingTemplate
        template.render( 'formtastic/fieldset', fieldset )
      end
    end
    
  end
end