# frozen_string_literal: true

module Parser
  def self.parse_structs_from_documentation(cuda_docu_path)
    struct_html_pages_paths = Dir[File.join(cuda_docu_path, 'struct*')].sort
    struct_html_pages_paths.reject! { |name| name.include? 'group__CUDA__TYPES.html' }

    parse_struct_html_pages(struct_html_pages_paths)
    # ffi_type_structs = transform_struct_c_types_into_ffi_types(c_type_structs)
    # store_ffi_type_structs_on_disk(ffi_type_structs)
  end

  def self.parse_struct_html_pages(struct_html_pages_paths)
    c_type_structs = []
    struct_html_pages_paths.each do |struct_html_pages_path|
      struct_name = ''
      variable_list = []
      track = 1

      doc = File.open(struct_html_pages_path) { |f| Nokogiri::HTML(f) }

      # Get struct name
      doc.css('.topictitle2').each do |struct_description|
        next unless struct_description.text.include? 'Struct'

        list = struct_description.text.strip.gsub(/[[:space:]]/, ' ').split(' ')
        unless list.empty?
          struct_name = list[1]
          break
        end
      end

      # Get list of struct variables
      temp_type = ''
      doc.css('.members dt span').each do |description|
        parsed = description.text.strip.gsub(/[[:space:]]/, ' ').gsub(/ +/, ' ').strip
        if track.even?
          next if temp_type.empty?

          temp_type = case temp_type
                      when 'unsigned int'
                        'uint'
                      when 'unsigned long long'
                        'ulong_long'
                      when 'void **', 'void *', 'const void *'
                        'pointer'
                      else
                        temp_type.gsub(/[[:space:]]/, '').gsub(' ', '').strip
                      end
          temp_type = 'pointer' if temp_type.include?('**') || temp_type.include?('*')
          variable_list << { name: parsed, type: temp_type }
          temp_type = ''
        else
          temp_type = parsed unless parsed.include? '::'
        end
        track += 1
      end

      c_type_structs << { name: struct_name, members: variable_list } unless variable_list.empty?
    end

        # "size_t  CUDA_ARRAY3D_DESCRIPTOR_v2::Height [inherited] "
        # case description.elements.count
        # when 3
        #   return_type = description.elements[0].text.strip.split('\n').join(' ')
  #         struct_name = description.elements[1].text.strip
  #         function_name = description.elements[2].text.strip
  #       when 2
  #         return_type = description.child.text.split("\n").join('').strip.split.join(' ')
  #         struct_name = description.elements[0].text.strip
  #         function_name = description.elements[1].text.strip
  #       end

  #       # Fix errors in documents from nvidia
  #       return_type = 'void *' if return_type == '*'
  #       return_type = 'void *' if return_type.include? '[MAX_PLANES]'

  #       # TODO: Still problems with:
  #       # CUDA_EXTERNAL_MEMORY_HANDLE_DESC_v1::@12::@13
  #       # CUDA_EXTERNAL_SEMAPHORE_HANDLE_DESC_v1::@14::@15
  #       # CUDA_EXTERNAL_SEMAPHORE_SIGNAL_PARAMS_v1::@16::@17
  #       # CUDA_EXTERNAL_SEMAPHORE_SIGNAL_PARAMS_v1::@16::@19
  #       # CUDA_EXTERNAL_SEMAPHORE_WAIT_PARAMS_v1::@20::@21
  #       # CUDA_EXTERNAL_SEMAPHORE_WAIT_PARAMS_v1::@20::@23
  #       # CUDA_EXTERNAL_SEMAPHORE_WAIT_PARAMS_v1::@20::@22

  #       layout << { function_name: function_name, return_type: return_type }
  #     end

  #     c_type_structs << { struct_name: struct_name, layout: layout } unless layout.empty?
  #   end
    c_type_structs
  end

  # def transform_struct_c_types_into_ffi_types(c_type_structs)
  #   ffi_type_structs = []

  #   c_type_structs.each do |c_type_struct|
  #     struct_name = c_type_struct[:struct_name]
  #     layout = c_type_struct[:layout].map do |layout_pair|
  #       return_type = ffi_types(layout_pair[:return_type])
  #       if return_type.nil?
  #         puts "Problem while parsing struct return type: #{layout_pair[:return_type]}"
  #         nil
  #       else
  #         layout_pair[:return_type] = return_type
  #         layout_pair
  #       end
  #     end

  #     next if layout.nil? || layout.any?(&:nil?)

  #     ffi_type_structs << { struct_name: struct_name, layout: layout }
  #   end
  #   ffi_type_structs
  # end

  # def store_ffi_type_structs_on_disk(ffi_type_structs)
  #   ### Generate class from template
  #   # class InputEvent < FFI::Struct
  #   #   layout :mi, MouseInput
  #   # end

  #   struct_template = %(
  #     class <%= struct_name %> < FFI::Struct
  #     layout <%= layout %>
  #     end
  #   )

  #   # create module folder
  #   FileUtils.mkdir_p File.join('gem', 'cuda', 'lib', 'cuda', 'driver', 'structs')

  #   a = Erubi::Engine.new(struct_template).src
  #   ffi_type_structs.each do |ffi_type_struct|
  #     layout = ffi_type_struct[:layout].map { |x| ":#{x[:function_name]}, :#{x[:return_type]}" }.join(",\n ")
  #     name = ffi_type_struct[:struct_name]

  #     splitted_name = name.split('_v').first

  #     struct_name = if splitted_name == splitted_name.upcase
  #                     name.downcase.pascal_case
  #                   else
  #                     name.pascal_case
  #                   end
  #     br = OpenStruct.new(name: struct_name, layout: layout).instance_eval(a)

  #     file_name = if splitted_name == splitted_name.upcase
  #                   name.downcase.snake_case
  #                 else
  #                   name.snake_case.gsub('c_u', 'cu_')
  #                 end

  #     file_name = "#{file_name}.rb"
  #     File.open(File.join('gem', 'cuda', 'lib', 'cuda', 'driver', 'structs', file_name), 'w') { |file| file.write(br) }
  #   end
  # end
end
