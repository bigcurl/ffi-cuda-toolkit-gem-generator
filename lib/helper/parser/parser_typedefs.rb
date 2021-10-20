# frozen_string_literal: true

module Parser
  def self.parse_typedefs_from_documentation(cuda_docu_path)
    html_pages_paths = Dir[File.join(cuda_docu_path, 'group__CUDA__*')].sort
    html_pages_paths.select! { |name| name.include? 'group__CUDA__TYPES.html' }

    parse_typedef_html_pages(html_pages_paths)
  end

  def self.parse_typedef_html_pages(html_pages_paths)
    c_type_typedefs = []

    html_pages_paths.each do |html_pages_path|
      doc = File.open(html_pages_path) { |f| Nokogiri::HTML(f) }
      doc.css('dt.description span').each do |description|
        next unless description.text.include? 'typedef'

        type = description.text.split[-1].strip

        target_string = description.text.split[1..-2].join(' ').strip
        target = :pointer if target_string.include? '*'
        target = target_string.gsub(' ', '_').to_sym if target.nil?

        c_type_typedefs << { ffi_type: target, cuda_type: type }
      end
    end
    c_type_typedefs.reverse
  end
end
