# frozen_string_literal: true

module Parser
  def self.parse_unions_definition(cuda_header_path, file_id)
    unions = []
    # open xml file
    doc = File.open(cuda_header_path) { |f| Nokogiri::XML(f) }

    doc.xpath("//Union[@file='#{file_id}']").each do |union|
      member_ids = union.attr('members').split
      fields = member_ids.map do |member_id|
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
