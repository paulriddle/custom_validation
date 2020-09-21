module CustomValidation
  class UnknownValidation < StandardError; end
  class RecordInvalid < StandardError; end

  module ClassMethods
    def validate(attr_name, options)
      validations[attr_name] = options
    end

    def validations
      @validations ||= {}
    end
  end

  def validate!
    self.class.validations.each do |attr_name, options|
      value = self.send(attr_name)

      case options.keys.first
      when :presence
        if value.nil? || (value.respond_to?(:size) && value.size == 0) ||
            (value.respond_to?(:empty?) && value.empty?)
          raise RecordInvalid.new("Validation failed on #{attr_name}, #{options}")
        end
      when :format
        unless value.match?(options.values.first)
          raise RecordInvalid.new("Validation failed on #{attr_name}, #{options}")
        end
      when :type
        unless value.kind_of?(options.values.first)
          raise RecordInvalid.new("Validation failed on #{attr_name}, #{options}")
        end
      else
        raise UnknownValidation
      end
    end
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def self.included(base)
    base.extend(ClassMethods)
  end
end
