# frozen_string_literal: true

module Parser
  def self.parse_enums_definition(cuda_header_path, file_id)
    enums = []
    # open xml file
    doc = File.open(cuda_header_path) { |f| Nokogiri::XML(f) }

    doc.xpath("//Enumeration[@file='#{file_id}']").each do |enum|
      values = enum.xpath('EnumValue').map do |value|
        {
          value: value.attr('name'),
          init: value.attr('init')
        }
      end

      enums << {
        id: enum.attr('id'),
        name: enum.attr('name'),
        values: values
      }
    end
    enums
  end
end
