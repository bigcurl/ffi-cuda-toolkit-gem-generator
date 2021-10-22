# frozen_string_literal: true

module Parser
  def self.parse_functions_definition(cuda_header_path, file_id)
    functions = []
    # open xml file
    doc = File.open(cuda_header_path) { |f| Nokogiri::XML(f) }

    doc.xpath("//Function[@file='#{file_id}']").each do |function|
      args = function.children.map do |_arg|
        {
          name: function.attr('name'),
          return_type_id: function.attr('returns')
        }
      end

      functions << {
        id: function.attr('id'),
        name: function.attr('name'),
        return_type_id: function.attr('returns'),
        arguments: args
      }
    end
    functions
  end
end
