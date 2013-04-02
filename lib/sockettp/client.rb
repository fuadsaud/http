module Sockettp
  module Client
    autoload :ConnectionFactory, 'sockettp/client/connection_factory'

    class << self
      #
      # Makes a request to a sockettp server.
      #
      # _uri_ must be a valid Sockettp URI (with the sockettp: scheme), host
      # address and file path. Informing the port is optional, since it defaults
      # to 9000 (see Sockettp and URI::Sockettp).
      #
      def request(uri)
        uri = URI(uri)

        fail URI::BadURIError if !uri.is_a? URI::Sockettp

        socket = ConnectionFactory.connect uri.host, uri.port

        socket.puts uri.path

        begin
          response = socket.gets
          JSON.parse(response)
        rescue
          puts $!
          raise "Couldn't reach #{uri.host}:#{uri.port}"
        end
      end
    end
  end
end
