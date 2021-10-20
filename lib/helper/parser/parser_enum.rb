# frozen_string_literal: true

module Parser
  def self.parse_enums_from_documentation(cuda_docu_path)
    enum_html_pages_paths = Dir[File.join(cuda_docu_path, 'group__CUDA__*')].sort
    enum_html_pages_paths.select! { |name| name.include? 'group__CUDA__TYPES.html' }

    parse_enum_html_pages(enum_html_pages_paths)
  end

  def self.parse_enum_html_pages(enum_html_pages_paths)
    c_type_enums = []

    enum_html_pages_paths.each do |enum_html_pages_path|
      doc = File.open(enum_html_pages_path) { |f| Nokogiri::HTML(f) }

      enum_name = ''
      values = []
      doc.css('.description~ .description+ .description dt').each do |description|
        if description.text.include? 'enum'
          c_type_enums << { enum_name: enum_name, values: values } unless values.empty?
          enum_name = ''
          values = []
          enum_name = description.text.strip.split[1]
        else
          name = description.text.split('=')[0]
          value = description.text.split('=')[1]
          values << { name: name, value: value }
        end
      end
    end
    c_type_enums
  end
end
