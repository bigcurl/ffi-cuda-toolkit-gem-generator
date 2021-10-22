# frozen_string_literal: true

class GenerateDriverApiCastxml < ApplicationSubcommand
  def execute
    @logger = Logger.new($stdout)
    @logger.info 'Start generate-driver-api-xml subcommand'

    cuda_version_path = File.join(__dir__, '..', '..', '..', 'vendor', 'nvidia', 'cuda-documentation')
    cuda_versions = Dir.entries(cuda_version_path).select do |entry|
      File.directory? File.join(cuda_version_path, entry) and !['.', '..'].include?(entry)
    end

    cuda_versions.each do |cuda_version|
      @logger.info "Start parsing CUDA version #{cuda_version}"

      cuda_header_path = File.join(
        __dir__,
        '..',
        '..',
        '..',
        'vendor',
        'nvidia',
        'cuda-documentation',
        cuda_version,
        'cuda.h.xml'
      )

      # Parse File
      file_id = Parser.parse_file_definition(cuda_header_path)

      # Parse Function
      functions_definition = Parser.parse_functions_definition(cuda_header_path, file_id)

      # Parse Enum
      enums_definition = Parser.parse_enums_definition(cuda_header_path, file_id)

      # Parse Union
      # unions_definition = Parser.parse_unions_definition(cuda_header_path, file_id)

      # Parse Struct
      # structs_definition = Parser.parse_structs_definition(cuda_header_path, file_id)

      # Parse Typedefs
      typedefs_definition = Parser.parse_typedefs_definition(cuda_header_path, file_id)

      # Parse FundamentalTypes
      fundamental_type_definition = Parser.parse_fundamental_type_definition(cuda_header_path, file_id)

      @logger.info "End parsing CUDA version #{cuda_version}"
    end

    @logger.info 'End generate-driver-api subcommand'
  end
end
