# frozen_string_literal: true

module Parser
  def self.parse_file_definition(xml_doc)
    xml_doc.at_xpath("//File[@name='cuda.h']").attr('id')
  end
end
