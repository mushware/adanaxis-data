
class MushGLTexture
  def self.cDefine(paramHash)
    cRubyDefine(paramHash);
  end

  def self.cPreCache(texName)
    cRubyPreCache(texName);
  end

end
