require "backtastic/version"
require 'backbone-on-rails'
require "inflection-js-rails"
require "twitter-bootstrap-rails"
require "active_support/inflections"

module Backtastic
  class BacktasticEngine < Rails::Engine
  end

  def self.validations_for(model)
    validations = {}
  	model.validators.each do |validator|
      attribute = validator.attributes.first
      validator_type = validator.class.to_s.gsub(/^Active.*::Validations::/, "").gsub(/Validator$/, "").downcase
      validations[attribute] ||= {}
      validations[attribute][validator_type] = options_from(validator)
    end
    validations
  end

  def self.options_from(validator)
    options = validator.options.dup
    options.each do |option, value|
      options[option] = value.is_a?(Regexp) ? value.inspect : value
    end
    options
  end

end
