require 'base64'
require 'openssl'
require 'stringio'
require 'zlib'

module Adyen
  module Encoding
    def self.hmac_base64(hmac_key, message)
      digest = OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), Array(hmac_key).pack("H*"), message)
      Base64.strict_encode64(digest).strip
    end

    def self.gzip_base64(message)
      sio = StringIO.new
      gz  = Zlib::GzipWriter.new(sio)
      gz.write(message)
      gz.close
      Base64.strict_encode64(sio.string)
    end
  end
end