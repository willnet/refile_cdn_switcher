require 'refile_cdn_switcher/version'
require 'refile/rails'

module RefileCdnSwitcher
  module RefileMonkeyPatch
    def attachment_url(object, name, *args, **kargs)
      return super if object.use_cdn?(name) && Refile.cdn_host
      host = Rails.application.routes.url_helpers.root_url
      super(object, name, *args, **kargs.merge(host: host))
    end
  end

  module ActiveRecordMonkeyPatch
    def use_cdn?(attr_name)
      self.class.instance_variable_get(:@_cdn)[attr_name.to_sym]
    end

    module ClassMethods
      def attachment(name, **kargs)
        @_cdn ||= {}

        if kargs.delete(:cdn)
          @_cdn.merge!(name.to_sym => true)
        else
          @_cdn.merge!(name.to_sym => false)
        end

        super(name, **kargs)
      end
    end
  end
end

ActiveSupport.on_load(:active_record) do
  prepend RefileCdnSwitcher::ActiveRecordMonkeyPatch

  class << self
    prepend RefileCdnSwitcher::ActiveRecordMonkeyPatch::ClassMethods
  end
end

class << Refile
  prepend RefileCdnSwitcher::RefileMonkeyPatch
end
