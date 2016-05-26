# Copied from https://github.com/thoughtbot/paperclip/blob/e60f00027704298455c039e111d96bcf46e12822/lib/paperclip/io_adapters/http_url_proxy_adapter.rb
# so that mockbot can send in urls to images
module Paperclip
  class HttpUrlProxyAdapter < UriAdapter

    REGEXP = /\Ahttps?:\/\//

    def initialize(target)
      super(URI(target))
    end

  end
end

Paperclip.io_adapters.register Paperclip::HttpUrlProxyAdapter do |target|
  String === target && target =~ Paperclip::HttpUrlProxyAdapter::REGEXP
end
