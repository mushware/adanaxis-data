
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
    :name => "star#{i}-mat",
    :texture_name => "star#{i}-tex"
    )
  end
  10.times do |i|
    MushMaterial.cDefine(
    :name => "ember#{i}-mat",
    :texture_name => "ember#{i}-tex"
    )
  end
  10.times do |i|
    MushMaterial.cDefine(
    :name => "flare#{i}-mat",
    :texture_name => "flare#{i}-tex"
    )
  end


  end
end
