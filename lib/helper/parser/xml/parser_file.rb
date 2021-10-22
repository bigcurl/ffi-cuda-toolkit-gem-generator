# frozen_string_literal: true

module Parser
  def self.parse_file_definition(cuda_header_path)
    file = {}
    # open xml file
    doc = File.open(cuda_header_path) { |f| Nokogiri::XML(f) }
    doc.at_xpath("//File[@name='cuda.h']").attr('id')
  end
end
