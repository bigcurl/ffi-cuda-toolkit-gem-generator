# frozen_string_literal: true

module Parser
  def self.parse_functions_definition(xml_doc, file_id)
    functions = []

    xml_doc.xpath("//Function[@file='#{file_id}']").each do |function|
      args = function.xpath('Argument').map do |arg|
        type_id = arg.attr('type')
        element = xml_doc.at_xpath("//*[@id='#{type_id}']")

        type_name = nil

        while type_name.nil?
          case element.name
          when 'Struct', 'Typedef', 'FundamentalType', 'Enumeration', 'Union'
            type_name = element.attr('name')
          when 'FunctionType'
            type_name = 'pointer' # TODO: Build FunctionType. Parse seperatly?
          else
            element = xml_doc.at_xpath("//*[@id='#{element.attr('type')}']")
          end
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
