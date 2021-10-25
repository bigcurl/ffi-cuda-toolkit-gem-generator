# frozen_string_literal: true

module Parser
  def self.parse_typedefs_definition(xml_doc, file_id)
    typedefs = []

    xml_doc.xpath("//Typedef[@file='#{file_id}']").each do |typedef|
      type_id = typedef.attr('type')
      type_element = xml_doc.at_xpath("//*[@id='#{type_id}']")

      type_name = nil

      while type_name.nil?
        case type_element.name
        when 'Struct', 'Typedef', 'FundamentalType', 'Enumeration', 'Union'
          type_name = type_element.attr('name')
        when 'FunctionType'
          type_name = 'pointer' # TODO: Build FunctionType. Parse seperatly?
        else
          type_element = xml_doc.at_xpath("//*[@id='#{type_element.attr('type')}']")
        end
      end

      typedefs << {
        id: typedef.attr('id'),
        name: typedef.attr('name'),
        type_id: type_id,
        type_name: type_name
      }
    end

    typedefs
  end
end
