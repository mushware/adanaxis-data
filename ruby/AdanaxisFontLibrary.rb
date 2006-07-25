

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
    
    MushGLTexture::cDefine(
		  :name          => 'symbol1-font-tex',
      :type          => 'TIFF',
		  :filename      => MushConfig.cGlobalPixelsPath+'/symbol1.tiff',
		  :cache         => 0
	  )
    
    font2 = MushGLFont.new(
      :name => 'symbol1-font',
      :texture_name => 'symbol1-font-tex',
      :divide => [8,8],
      :extent => [512.0/8, 512.0/8],
      :size => 1
    )
    
  end
end
