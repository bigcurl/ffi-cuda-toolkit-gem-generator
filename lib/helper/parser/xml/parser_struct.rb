# frozen_string_literal: true

module Parser
  def self.parse_structs_definition(xml_doc, file_id)
    structs = []

    xml_doc.xpath("//Struct[@file='#{file_id}']").each do |struct|
      next if struct.attr('name').empty?
      next if struct.attr('incomplete') && struct.attr('incomplete') == '1'
      next if struct.attr('members').nil?

      member_ids = struct.attr('members').split
      fields = member_ids.map do |member_id|
        element = xml_doc.at_xpath("//*[@id='#{member_id}']")
        name = element.attr('name')

        type_name = nil

        while type_name.nil?
          case element.name
          when 'ArrayType'
            name_element = xml_doc.at_xpath("//*[@id='#{element.attr('type')}']")
            type_name = "[:#{name_element.attr('name')}, #{element.attr('max').to_i + 1}]"
          when 'Struct'
            # TODO: check for anonymous structs here
            # debugger
            type_name = element.attr('name')
          when 'Union'
            union_member_ids = element.attr('members').split
            fields = union_member_ids.map do |union_member_id|
              field_element = xml_doc.at_xpath("//*[@id='#{union_member_id}']")
              field_name = field_element.attr('name')

              field_type_name = nil

              while field_type_name.nil?
                case field_element.name
                when 'Typedef', 'FundamentalType', 'Enumeration', 'Union', 'Struct'
                  debugger
                  field_type_name = field_element.attr('name')
                else
                  field_element = xml_doc.at_xpath("//*[@id='#{field_element.attr('type')}']")
                end
              end
              debugger
              ":#{field_name}, #{field_type_name}"
            end

            name = ':union'
            type_name = ''.dup # can't modify frozen String that is why we call dup
            type_name << "Class.new(FFI::Union) do \n"
            type_name << 'layout '
            type_name << fields.join(", \n")
            type_name << "\n end"
            type_name << "\n"
          when 'Typedef', 'FundamentalType', 'Enumeration'
            type_name = element.attr('name')
          else
            element = xml_doc.at_xpath("//*[@id='#{element.attr('type')}']")
          end
        end

        { name: name, type_name: type_name }
      end

      structs << {
        id: struct.attr('id'),
        name: struct.attr('name'),
        fields: fields
      }
    end

    debugger
    structs
  end
end
