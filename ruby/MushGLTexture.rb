
class MushGLTexture
  def MushGLTexture.cDefine(paramHash)
    puts "Defining texture"
    paramHash.each { |key, value|
      puts "#{key} = #{value}"
    }
    cRubyDefine(paramHash);
  end
end
