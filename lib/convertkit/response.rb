module Convertkit
  class Response
    attr_reader :status, :body, :links, :meta
    
    def initialize(status, body)
      @status = status
      @body = body
      @links = parse_links
      @meta = parse_meta
      
      @body.freeze
    end
    
    def success?
      (200..209).include?(status)
    end
    
    def ==(other)
      status == other.status &&
      body == other.body
    end
    
    def parse_links
      body.is_a?(Hash) ? body.delete(:links) : nil
    end
    
    def parse_meta
      body.is_a?(Hash) ? body.delete(:meta) : nil
    end
  end
end