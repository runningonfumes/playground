module EventHandler

  def on(*events, &block)
    events.each do |event_name|
      Rails.logger.info "** Registering #{event_name} for #{self.class}"
      DomainRepository.on(event_name, &block)
    end
  end
  
end
