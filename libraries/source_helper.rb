module RabbitMQ
  class SourceHelper
    attr_reader :node

    def initialize(node)
      @node = node
    end

    def build_environment
      {'CFLAGS' => '-O2 -pipe -O2 -I/usr/include -I/opt/local/include -I/opt/local/include/gettext',
       'LDFLAGS' => '-L/opt/local/gcc47/lib -Wl,-R/opt/local/gcc47/lib -L/usr/lib/amd64 -Wl,-R/usr/lib/amd64 -L/opt/local/lib -Wl,-R/opt/local/lib',
       'TARGET_DIR' => "/opt/local/lib/erlang/lib/rabbitmq_server-#{version}",
       'SBIN_DIR' => '/opt/local/sbin/',
       'MAN_DIR' => '/opt/local/man',
       'MANPREFIX' => '/opt/local',
       'PATH' => '/usr/local/sbin:/usr/local/bin:/opt/local/sbin:/opt/local/bin:/usr/sbin:/usr/bin:/sbin'
      }
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

    def requires_sh_patching?
      %w(smartos solaris2).include?(node['platform'])
    end

    private

    def config
      node['rabbitmq']
    end
  end
end
