

class AdanaxisFontLibrary < MushObject
  def self.cCreate
  	MushGLTexture::cDefine(
		:name          => 'font1-tex',
        :type          => 'TIFF',
		:filename      => MushConfig.cGlobalPixelsPath+'/font-mono1.tiff',
		:cache         => 0
	)
  
	font1 = MushGLFont.new(
      :name => 'font1',
      :texture_name => 'font1-tex',
      :divide => [8,12],
      :extent => [337, 768]
    )
  end
end