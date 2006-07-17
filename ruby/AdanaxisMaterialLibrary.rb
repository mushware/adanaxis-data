
class AdanaxisMaterialLibrary < MushObject
  def self.cCreate
	MushMaterial.cDefine(
	  :name => 'attendant-mat',
	  :texture_name => 'attendant-tex'
	)
	MushMaterial.cDefine(
	  :name => 'projectile-mat',
	  :texture_name => 'projectile-tex'
	)
	MushMaterial.cDefine(
	  :name => 'world1-mat',
	  :texture_name => 'world1-tex'
	)
    10.times do |i|
  	  MushMaterial.cDefine(
	    :name => "deco#{i}-mat",
	    :texture_name => "deco#{i}-tex"
	    )
    end
  end
end
