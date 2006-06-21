
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
  end
end
