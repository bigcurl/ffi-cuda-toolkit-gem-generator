# frozen_string_literal: true

module Parser
  def self.parse_typedefs_definition(cuda_header_path, file_id)
    typedefs = []
    # open xml file
    doc = File.open(cuda_header_path) { |f| Nokogiri::XML(f) }

    doc.xpath("//Typedef[@file='#{file_id}']").each do |typedef|
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
