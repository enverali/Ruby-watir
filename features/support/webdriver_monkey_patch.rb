module Selenium::WebDriver::Chrome
  class Bridge
    def extract_service_args(opts)
      args = []
      args += opts.delete(:service_args) if opts.has_key?(:service_args)
      args << "--log-path=#{opts.delete(:service_log_path)}" if opts.has_key?(:service_log_path)
      args
    end
  end
end