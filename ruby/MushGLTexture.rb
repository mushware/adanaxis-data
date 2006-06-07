
class MushGLTexture
  def MushGLTexture.cDefine(paramHash)
    cRubyDefine(paramHash);
  end

  def MushGLTexture.cPreCache(texName)
    cRubyPreCache(texName);
  end

end
