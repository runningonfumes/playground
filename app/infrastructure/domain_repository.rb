module DomainRepository

  class << self

    include Wisper::Publisher
  
    def aggregates
      Thread.current[:"DomainRepositoryCurrentStore"]
    end
  
    def begin
      Thread.current[:"DomainRepositoryCurrentStore"] = Set.new
    end
  
    def add(aggregate)
      self.aggregates << aggregate
      aggregate
    end
  
    def commit
      aggregates.each do |aggregate|
        while event = aggregate.applied_events.shift
          save event
          broadcast event.name, event
        end
      end
    end
    
    def method_missing(meth, *args, &blk)
      if meth.to_s =~ /^find_(.+)/
        find($1, args.first)
      else
        super
      end
    end
    
    def find(type, uid)
      events = CommitsRepository.new.find(uid)
      
      # We could detect here that an aggregate doesn't exist (it has no events) 
      # instead of inside the aggregate itself
      
      add type.camelize.constantize.build_from(events)
    end

    private
    
    def save(event)
      CommitsRepository.new.store(event.aggregate_uid, event)
    end

    def publish(event)
      publish_event(event.name, {:data => event.data})
    end
    
  end
  
end
