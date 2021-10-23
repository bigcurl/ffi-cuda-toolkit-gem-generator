# frozen_string_literal: true

module Parser
  def self.parse_typedefs_definition(xml_doc, file_id)
    typedefs = []

    xml_doc.xpath("//Typedef[@file='#{file_id}']").each do |typedef|
      type_id = typedef.attr('type')
      type_name = xml_doc.at_xpath("//*[@id='#{type_id}']").attr('name')

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
