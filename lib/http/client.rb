module HTTP
  module Client

    autoload :Connection, 'http/client/connection'

    #
    # Makes a request to an http server.
    #
    # _uri_ must be a valid HTTP URI (with the http: scheme), host
    # address and file path. Informing the port is optional, since it defaults
    # to 9000 (see HTTP and URI::HTTP).
    #
    def self.request(uri)
      uri = URI(uri)

      fail URI::BadURIError unless uri.is_a? URI::HTTP

      begin
        response = connection(uri.host, uri.port).request uri.path
        JSON.parse(response)
      rescue
        puts $!
        raise "Couldn't reach #{uri.host}:#{uri.port}"
      end
    end

    private

    def self.connection(host, port)
      Connection.connect(host, port)
    end
  end
end