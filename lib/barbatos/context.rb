require 'forwardable'

module Barbatos
  class Context
    extend Forwardable

    attr_reader :request
    attr_accessor :response

    def initialize(env)
      @request = Rack::Request.new(env)
      @response = Rack::Response.new
    end

    def not_found
      status!(404)
    end

    def forbidden
      status!(401)
    end

    def status!(status_code)
      response.status = status_code
      self
    end

    def body!(content)
      response.body = content
      self
    end

    delegate [:status, :body] => :@response
  end
end
