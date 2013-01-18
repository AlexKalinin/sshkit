module SSHKit

  class Configuration

    attr_writer :output, :backend, :command_map

    def output
      @output ||= format=:pretty
    end

    def backend
      @backend ||= SSHKit::Backend::Netssh
    end

    def format=(format)
      formatter = SSHKit::Formatter.const_get(format.capitalize)
      self.output = formatter.new($stdout)
    end

    def command_map
      @command_map ||= begin
        Hash.new do |hash, command|
          if %w{if test time}.include? command.to_s
            hash[command] = command.to_s
          else
            hash[command] = "/usr/bin/env #{command}"
          end
        end
      end
    end

  end

end
