# frozen_string_literal: true

module Parser
  def self.parse_unions_definition(xml_doc, file_id)
    unions = []

    xml_doc.xpath("//Union[@file='#{file_id}']").each do |union|
      # member_ids = union.attr('members').split
      # fields = member_ids.map do |member_id|
      # end

      unions << {
        id: union.attr('id'),
        name: union.attr('name'),
        fields: fields
      }
    end
    unions
  end
end
