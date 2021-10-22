# frozen_string_literal: true

module Parser
  def self.parse_define_from_documentation(cuda_docu_path)
    define_html_page = Dir[File.join(cuda_docu_path, 'group__CUDA__TYPES.html')]

    parse_define_html_page(define_html_page)
  end

  def self.parse_define_html_page(define_html_page_paths)
    c_type_defines = []

    define_html_page_paths.each do |define_html_page_path|
      doc = File.open(define_html_page_path) { |f| Nokogiri::HTML(f) }

      doc.css('dt.description span').each do |description|
        values = []
        values = description.text.split(' ') if description.text.include? '#define'
        # values[2].gsub('(void*)', '') if !values[2].nil? && (values[2].include? '(void*)')

        # remove any conversion
        values[2]&.gsub!(/\([a-zA-Z*]+\)/, '')
        values[2]&.gsub!(/\(/, '')
        values[2]&.gsub!(/\)/, '')

        c_type_defines << { name: values[1], value: values[2] } if values.count >= 3
      end
    end
    c_type_defines
  end
end
