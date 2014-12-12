require 'mongo'

class CommitsRepository
  include Mongo

  def initialize
    mongo_client = MongoClient.new(ENV.fetch('BOOT2DOCKER_IP'), 27017)
    @db = mongo_client.db('revents')
    @db.collection("commits").ensure_index('uid')
  end

  def store(aggregate_id, event)
    event = event.to_h
    event["timestamp"] = get_timestamp
    event["aggregate_id"] = aggregate_id
    @db["commits"].insert(event)
  end

  def find(aggregate_id)
    @db["commits"].find(uid: aggregate_id).map do |event|
      Event.new(name: event['name'], data: event.with_indifferent_access)
    end
  end

  def get_timestamp
    Time.now.strftime('%Y%m%d%H%M%S%L')
  end
end