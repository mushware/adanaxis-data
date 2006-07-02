

class AdanaxisFontLibrary < MushObject
  def self.cCreate
  	MushGLTexture::cDefine(
		:name          => 'library-font1-tex',
        :type          => 'TIFF',
		:filename      => MushConfig.cGlobalPixelsPath+'/font-mono1.tiff',
		:cache         => 0
	)
  
	font1 = MushGLFont.new(
      :name => 'library-font1',
      :texture_name => 'library-font1-tex',
      :divide => [8,12],
      :extent => [337/8.0, 768/12.0],
      :size => 0.05
    )
  end
end
