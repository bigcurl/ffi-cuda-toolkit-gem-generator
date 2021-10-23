# frozen_string_literal: true

module Parser
  def self.parse_fundamental_type_definition(xml_doc, _file_id)
    fundamental_types = []

    xml_doc.xpath('//FundamentalType').each do |fundamental_type|
      ffi_type = case fundamental_type[:name]
      when '__int128', 'unsigned __int128', 'long double'
        next
      when 'long unsigned int'
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
      when 'long long unsigned int'
        :ulong_long
      when 'short unsigned int'
        :ushort
      when 'unsigned int'
        :uint
      when 'signed char'
        :char
      when 'short int'
        :short
      when 'void'
        :void
      when 'char'
        :char
      when 'unsigned char'
        :uchar
      end

      fundamental_types << {
        id: fundamental_type.attr('id'),
        name: fundamental_type.attr('name'),
        type_name: ffi_type
      }
    end
    Parser.replace_fundamental_types(fundamental_types)
  end

  def self.replace_fundamental_types(fundamental_types)
    fundamental_types.each do |fundamental_type|
      fundamental_type[:ffi_type] = case fundamental_type[:name]
                                    when '__int128', 'unsigned __int128', 'long double'
                                      nil
                                    when 'long unsigned int'
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
                                    when 'long long unsigned int'
                                      :ulong_long
                                    when 'short unsigned int'
                                      :ushort
                                    when 'unsigned int'
                                      :uint
                                    when 'signed char'
                                      :char
                                    when 'short int'
                                      :short
                                    when 'void'
                                      :void
                                    when 'char'
                                      :char
                                    when 'unsigned char'
                                      :uchar
                                    end
    end
    fundamental_types
  end
end
