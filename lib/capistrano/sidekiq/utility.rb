module Capistrano
  module Sidekiq
    module Utility
      def run_sidekiq_cmd(&block)
        on roles fetch(:sidekiq_roles) do |host|
          if host.user == fetch(:sidekiq_user)
            within release_path do
              with rack_env: fetch(:sidekiq_env), rails_env: fetch(:sidekiq_env) do
                instance_eval(&block)
              end
            end
          else
            as fetch(:sidekiq_user) do
              within release_path do
                with rack_env: fetch(:sidekiq_env), rails_env: fetch(:sidekiq_env) do
                  instance_eval(&block)
                end
              end
            end
          end
        end
      end

      def sidekiq_running?
        return false unless test("[ -f #{fetch(:sidekiq_pid)} ]")

        unless test(:kill, '-0', "$( cat #{fetch(:sidekiq_pid)} )")
          execute(:rm, fetch(:sidekiq_pid))

          return false
        end

        true
      end

      def sidekiq_signal(sig)
        fail 'Sidekiq is not running!' unless sidekiq_running?

        execute(:kill, "-#{sig}", "$( cat #{fetch(:sidekiq_pid)} )")
      end

      def quiet_sidekiq
        return unless sidekiq_running?

        execute(:sidekiqctl, :quiet, fetch(:sidekiq_pid))
      end

      def start_sidekiq
        execute(:sidekiq,
          "--pidfile #{fetch(:sidekiq_pid)}",
          "--environment #{fetch(:sidekiq_env)}",
          "--logfile #{fetch(:sidekiq_log)}",
          "--daemon"
        )

        4.times do
          sleep 2

          return if sidekiq_running?
        end

        fail('Sidekiq failed to start!')
      end

      def stop_sidekiq
        return unless sidekiq_running?

        execute(:sidekiqctl, :stop, fetch(:sidekiq_pid), fetch(:sidekiq_timeout))
      end

      def restart_sidekiq
        stop_sidekiq if sidekiq_running?
        start_sidekiq
      end
    end
  end
end
