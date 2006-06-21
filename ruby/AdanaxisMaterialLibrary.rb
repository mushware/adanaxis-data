
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
  end
end
