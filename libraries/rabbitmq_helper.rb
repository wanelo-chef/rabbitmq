module RabbitMQ
  class Helper
    attr_reader :node

    def initialize(node)
      @node = node
    end

    def source_directory
      [Chef::Config['file_cache_path'], "rabbitmq-server-#{version}"].join('/')
    end

    def tar_file
      [Chef::Config['file_cache_path'], tar_file_name].join('/')
    end

    def remote_tar_file
      [mirror, "v#{version}", tar_file_name].join('/')
    end

    def tar_file_name
      "rabbitmq-server-#{version}.tar.gz"
    end

    def version
      config['version']
    end

    def mirror
      config['mirror']
    end

    private

    def config
      node['rabbitmq']
    end
  end
end
