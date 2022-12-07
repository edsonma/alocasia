# frozen_string_literal: true

SEMIAN_TICKETS = ENV.fetch('SEMIAN_TICKETS', 10).freeze
SEMIAN_SUCCESS_THRESHOLD = ENV.fetch('SEMIAN_SUCCESS_THRESHOLD', 1).freeze
SEMIAN_ERROR_THRESHOLD = ENV.fetch('SEMIAN_ERROR_THRESHOLD', 5).freeze
SEMIAN_ERROR_TIMEOUT = ENV.fetch('SEMIAN_ERROR_TIMEOUT', 30).freeze

SEMIAN_DEFAULT_PARAMETERS = {
  tickets: SEMIAN_TICKETS.to_i,
  success_threshold: SEMIAN_SUCCESS_THRESHOLD.to_i,
  error_threshold: SEMIAN_ERROR_THRESHOLD.to_i,
  error_timeout: SEMIAN_ERROR_TIMEOUT.to_i,
}.freeze

Semian.subscribe do |event, resource, _scope, _adapter, payload|
  if event != :lru_hash_gc && event == :state_change
    if resource.closed? && (payload[:state] == :open)
      puts "semian.request.open_circuit - #{resource.name}"
    end
  end
end