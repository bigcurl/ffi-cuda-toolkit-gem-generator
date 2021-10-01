class GenerateDriverApi < ApplicationSubcommand
  def execute
    @logger = Logger.new(STDOUT)
    @logger.info 'Start generate-driver-api subcommand'

    # Select version to parse
    cuda_version = '11.4.2' # default for now

    # Parsrequiree html documentation
    cuda_docu_path = File.join(__dir__, "../../../archived_documentation/#{cuda_version}/")

    ## Generate unions
    ### Garther html pages
    union_html_pages_paths = Dir[File.join(cuda_docu_path, 'cuda-driver-api', 'union*')].sort

    ### Parse from html
    # union = {name: "", layout: [{name: "", type: ""}]}

    ### Transform c types output into ffi types

    ### Generate class from template

    # class InputEvent < FFI::Union
    #   layout :mi, MouseInput
    # end

    ## Generate structs
    ### Garther html pages
    struct_html_pages_paths = Dir[File.join(cuda_docu_path, 'cuda-driver-api', 'struct*')].sort
    # remove Data types used by CUDA driver from list
    struct_html_pages_paths.reject! { |name| name.include? 'group__CUDA__TYPES.html' }

    ### Parse structs from html
    # struct = {name: "", layout: [{name: "", type: ""}]}
    c_type_structs = parse_struct_html_pages(struct_html_pages_paths)

    ### Transform parsed output to ruby code
    ruby_type_structs = transform_c_type_structs_into_ruby_type_structs(c_type_structs)

    ### Generate class from template
    # class InputEvent < FFI::Struct
    #   layout :mi, MouseInput
    # end

    struct_template = %{
      class <%= ruby_type_structs[name] %> < FFI::Struct
      layout <%= ruby_type_structs[layout].join(',\n') %>
      end
    }

    ## Generate typedefs
    ### Garther html pages
    ### Parse typedefs from html
    ### Transform parsed output to ruby code
    ### Genrate class from template

    ## Generate define
    ### Garther html pages
    ### Parse typedefs from html
    ### Transform parsed output to ruby code
    ### Genrate class from template

    ## Generate enum
    ### Garther html pages
    ### Parse typedefs from html
    ### Transform parsed output to ruby code
    ### Genrate class from template

    ## Generate modules/functions
    ### Garther html pages
    ### Parse modules from html
    ### Transform parsed output to ruby code
    ### Genrate class from template

    @logger.info 'End generate-driver-api subcommand'
  end

  private

  def parse_struct_html_pages(struct_html_pages_paths)
    c_type_structs = []
    struct_html_pages_paths.each do |struct_html_pages_path|
      struct_name = ''
      layout = []

      doc = File.open(struct_html_pages_path) { |f| Nokogiri::HTML(f) }
      doc.css('.description span').each do |description|
        # "size_t  CUDA_ARRAY3D_DESCRIPTOR_v2::Height [inherited] "
        if description.elements.count == 3
          return_type = description.elements[0].text.strip.split('\n').join(' ')
          struct_name = description.elements[1].text.strip
          function_name = description.elements[2].text.strip
        elsif description.elements.count == 2
          return_type = description.child.text.split("\n").join('').strip.split.join(' ')
          struct_name = description.elements[0].text.strip
          function_name = description.elements[1].text.strip
        end

        # Fix errors in documents from nvidia
        return_type = 'void *' if return_type == '*'
        return_type = 'void *' if return_type.include? '[MAX_PLANES]'

        layout << { function_name: function_name, return_type: return_type }
      end

      c_type_structs << { struct_name: struct_name, layout: layout } unless layout.empty?
    end
    c_type_structs
  end

  def transform_c_type_structs_into_ruby_type_structs(_c_type_structs)
    ruby_type_structs = []
  end
end
