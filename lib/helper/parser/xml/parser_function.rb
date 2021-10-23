# frozen_string_literal: true

module Parser
  def self.parse_functions_definition(xml_doc, file_id)
    functions = []

    xml_doc.xpath("//Function[@file='#{file_id}']").each do |function|
      args = function.xpath('Argument').map do |arg|
        type_id = arg.attr('type')

        type_element = xml_doc.at_xpath("//*[@id='#{type_id}']")
        type_name = case type_element.name
                    when 'PointerType'
                      type = nil
                      type_element_n = type_element
                      while type.nil?
                        type_element_n = xml_doc.at_xpath("//*[@id='#{type_element_n.attr('type')}']")
                        if type_element_n.name == 'FundamentalType' || type_element_n.name == 'Typedef'
                          type = type_element_n.attr('name')
                        end
                      end
                      type
                    when 'Typedef', 'FundamentalType'
                      type_element.attr('name')
                    end

        {
          name: arg.attr('name'),
          type_id: type_id,
          type_name: type_name
        }
      end
      return_type_id = function.attr('returns')
      return_type = xml_doc.at_xpath("//*[@id='#{return_type_id}']")
      return_type_name = return_type.attr('name')

      functions << {
        id: function.attr('id'),
        name: function.attr('name'),
        return_type_id: return_type_id,
        return_type_name: return_type_name,
        arguments: args
      }
    end

    functions
  end
end
