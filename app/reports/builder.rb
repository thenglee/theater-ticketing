# Inspired by the the ActiveAdmin::CSV builder class defined at
# https://github.com/activeadmin/activeadmin
# The ActiveAdmin code is Copyright (c) Greg Bell, VersaPay Corporation

class Builder

  attr_accessor :collection, :output, :columns, :options

  def initialize(columns, options, collection, output)
    @columns = columns
    @options = options
    @collection = collection
    @output = output
  end

  def build
    build_header
    build_rows
    output
  end

  def build_header
    nil
  end

  def build_rows
    collection.each do |resource|
      output << build_row(resource)
    end
  end

  def build_row(resource)
    result = {}
    columns.each do |column|
      result[column.name] = encode(column.value(resource), options)
    end
    result
  end

  def encode(content, options)
    if options[:encoding]
      content.to_s.encode(options[:encoding], options[:encoding_options])
    else
      content
    end
  end
end
