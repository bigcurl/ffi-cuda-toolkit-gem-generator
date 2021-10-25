# frozen_string_literal: true

module Parser
  def self.parse_unions_definition(xml_doc, file_id)
    unions = []

    xml_doc.xpath("//Union[@file='#{file_id}']").each do |union|
      next if union.attr('name').empty?

      member_ids = union.attr('members').split
      fields = member_ids.map do |member_id|
        element = xml_doc.at_xpath("//*[@id='#{member_id}']")
        name = element.attr('name')

        type_name = nil

        while type_name.nil?
          case element.name
          when 'Typedef', 'FundamentalType', 'Enumeration', 'Union', 'Struct'
            type_name = element.attr('name')
          else
            element = xml_doc.at_xpath("//*[@id='#{element.attr('type')}']")
          end
        end

        { name: name, type_name: type_name }
      end

      unions << {
        id: union.attr('id'),
        name: union.attr('name'),
        fields: fields
      }
    end

    unions
  end
end
