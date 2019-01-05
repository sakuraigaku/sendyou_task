class Cooking
  attr_accessor :id
  attr_accessor :name

  def initialize(id:,name:)
    self.id = id
    self.name = name
  end

  def info
    return "{\"id\":#{id},\"name\":\"#{name}\"},"
  end

end