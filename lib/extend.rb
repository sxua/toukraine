require 'ostruct'

class Hash
  
  ##
  # Creates OpenStruct object from given Hash.
  # 
  # Returns: {OpenStruct}
  # 
  def to_ostruct
    OpenStruct.new(self)
  end

end