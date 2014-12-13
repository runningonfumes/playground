module EventHandler

  def on(*events, &block)
    events.each do |event_name|
      DomainRepository.on(event_name, &block)
    end
  end
  
end
