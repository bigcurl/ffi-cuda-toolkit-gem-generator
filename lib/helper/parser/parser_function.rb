# frozen_string_literal: true

module Parser
  def self.parse_functions_from_documentation(cuda_docu_path)
    function_html_pages_paths = Dir[File.join(cuda_docu_path, 'group__CUDA__*')].sort
    function_html_pages_paths.reject! { |name| name.include? 'group__CUDA__TYPES.html' }

    # Filtered out until the lib has been found where this is in
    # Seems to be different from the driver lib binary
    function_html_pages_paths.reject! { |name| name.include? 'group__CUDA__GRAPHICS.html' }
    function_html_pages_paths.reject! { |name| name.include? 'group__CUDA__EGL.html' }
    function_html_pages_paths.reject! { |name| name.include? 'group__CUDA__GL.html' }

    # struct = {module_name: "", functions: [{function_name: "", return_type: "type", arguments: ["type"]}]}
    parse_function_html_pages(function_html_pages_paths)
  end

  def self.parse_function_html_pages(function_html_pages_paths)
    c_type_modules = []
    function_html_pages_paths.each do |function_html_pages_path|
      c_type_functions = []
      function_name = ''

      doc = File.open(function_html_pages_path) { |f| Nokogiri::HTML(f) }

      module_name = doc.css('.topictitle2').text.split(' ')[1].gsub('[', '').gsub(']', '')
      doc.css('dt.description').each do |description|
        # "CUresult cuCtxCreate (  CUcontext* pctx, unsigned int  flags, CUdevice dev )"
        next if description.text.include? 'enum' # some pages also mention enums

        return_type = description.text.strip.split('(')[0].split[0..-2].join(' ')
        function_name = description.text.strip.split('(')[0].split[-1]

        args = []
        description.text.strip.split('(')[1].split(')')[0].split(',').each do |arg|
          name = ''
          type = ''

          if arg.include? '*'
            name = arg.split('*')[-1].strip
            type = "#{arg.split('*')[0..-2].join(' ').strip} *"
          else
            name = arg.split(' ')[-1].strip # special blank character
            type = arg.split(' ')[0..-2].join(' ').strip # special blank character
          end

          next if name.include?('void') && type.empty? # skip when no args

          type = 'unsigned int' if type == 'unsigned'

          args << { type: type, name: name }
        end

        c_type_functions << { return_type: return_type, function_name: function_name, args: args }
      end
      c_type_modules << { module_name: module_name, functions: c_type_functions }
    end
    c_type_modules
  end
end
