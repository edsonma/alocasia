# frozen_string_literal: true

class RedisService
  class << self
    def fetch_redis(semian_name:, url: ENV['REDIS_URL'], timeout: ENV['REDIS_TIMEOUT'])
      semian_parameters = SEMIAN_DEFAULT_PARAMETERS.merge({ name: semian_name })
      @fetch_redis ||= Redis.new(semian: semian_parameters, url: url, timeout: timeout)
    end
  end
end