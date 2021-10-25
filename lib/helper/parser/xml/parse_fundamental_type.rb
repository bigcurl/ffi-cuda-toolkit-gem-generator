# frozen_string_literal: true

module Parser
  def self.parse_fundamental_type_definition(xml_doc, _file_id)
    fundamental_types = []

    xml_doc.xpath('//FundamentalType').each do |fundamental_type|
      ffi_type = case fundamental_type[:name]
                 when '__int128', 'unsigned __int128', 'long double'
                   next
                 when 'long unsigned int', 'long long unsigned int'
                   :ulong_long
                 when 'int'
                   :int
                 when 'float'
                   :float
                 when 'double'
                   :double
                 when 'long int'
                   :long
                 when 'long long int'
                   :long_long
                 when 'short unsigned int'
                   :ushort
                 when 'unsigned int'
                   :uint
                 when 'short int'
                   :short
                 when 'void'
                   :pointer
                 when 'char', 'signed char'
                   :char
                 when 'unsigned char'
                   :uchar
                 end

      fundamental_types << {
        id: fundamental_type.attr('id'),
        name: fundamental_type.attr('name'),
        type_name: fundamental_type[:name],
        ffi_type: ffi_type
      }
    end
    fundamental_types
  end
end
