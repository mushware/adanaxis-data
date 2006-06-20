
class AdanaxisMaterialLibrary < MushObject
  def self.cCreate
	MushMaterial.cDefine(
	  :name => 'attendant-mat',
	  :texture_name => 'attendant-tex'
	)
  end
end
