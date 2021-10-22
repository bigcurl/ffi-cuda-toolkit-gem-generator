# frozen_string_literal: true

module Parser
  def self.parse_functions_definition(xml_doc, file_id)
    functions = []

    xml_doc.xpath("//Function[@file='#{file_id}']").each do |function|
      args = function.xpath('Argument').map do |arg|
        {
          name: arg.attr('name'),
          type_id: arg.attr('type')
        }
      end

      functions << {
        id: function.attr('id'),
        name: function.attr('name'),
        return_type_id: function.attr('returns'),
        arguments: args
      }
    end

    Parser.replace_function_types(xml_doc, functions)
  end

  def self.replace_function_types(xml_doc, functions)
    functions.each do |function|
      function[:arguments].each do |argument|
        type_element = xml_doc.at_xpath("//*[@id='#{argument[:type_id]}']")
        argument[:type_name] = case type_element.name
                               when 'PointerType'
                                 ':pointer'
                               when 'Typedef', 'FundamentalType'
                                 type_element.attr('name')
                               end
      end

      return_type = xml_doc.at_xpath("//*[@id='#{function[:return_type_id]}']")
      function[:return_type_name] = return_type.attr('name')
    end

    functions
  end
end
