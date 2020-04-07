# Inspired by the the ActiveAdmin::CSV builder class defined at
# https://github.com/activeadmin/activeadmin
# The ActiveAdmin code is Copyright (c) Greg Bell, VersaPay Corporation

class Column

  attr_reader :name, :data, :options

  def initialize(name, options = {}, block = nil)
    @options = options
    options[:humanize_name] = true if options[:humanize_name].nil?
    @name = humanize_name(name, @options[:humanize_name])
    @data = block || name.to_sym
  end

  def humanize_name(name, humanize_name_option)
    if humanize_name_option
      name.to_s.humanize
    else
      name.to_s
    end
  end

  def value(resource)
    case data
    when Symbol, String then resource.send(data)
    when Proc then resource.instance_exec(resource, &data)
    end
  end
end
