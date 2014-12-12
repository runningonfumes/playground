class Event
  attr_accessor :name
  attr_accessor :aggregate_uid
  attr_accessor :data

  def initialize(data)
    self.data = data[:data]
    self.name = data[:name]
  end

  def aggregate_uid=(id)
    puts id, '***'
    data[:uid] = id
  end

  def aggregate_uid
    data[:uid]
  end

  def to_h
    data.merge(name: name, uid: aggregate_uid)
  end
end