# frozen_string_literal: true

module Parser
  def self.parse_typedefs_definition(xml_doc, file_id)
    typedefs = []

    xml_doc.xpath("//Typedef[@file='#{file_id}']").each do |typedef|
      typedefs << {
        id: typedef.attr('id'),
        name: typedef.attr('name'),
        type_id: typedef.attr('type')
      }
    end
    Parser.replace_fundamental_types(typedefs)
  end

  def self.replace_fundamental_types(typedefs); end
end
