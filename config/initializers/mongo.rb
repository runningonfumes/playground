# require 'mongo'
#
# mongo_client = MongoClient.new(ENV.fetch('BOOT2DOCKER_IP'), 27017)
# @db = mongo_client.db('revents')
# coll = @db.collection("commits")
# coll.remove
# coll.create_index('uid')
# puts @db.index_information('commits'), 'xxxxxx'
