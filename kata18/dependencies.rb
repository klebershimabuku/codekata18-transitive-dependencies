require 'pry'
class Dependencies
  def initialize
    @items = {}
  end

  def add_direct(element, dependencies)
    @items[element] = dependencies
  end

  def dependencies_for(element)
    direct_dependencies = dependencies(element)
    sub_dependencies = []

    direct_dependencies.each do |dep|
      sub_dependencies << dependencies(dep)
    end

    [direct_dependencies + sub_dependencies].flatten.uniq.sort
  end

  protected
  def dependencies(element)

    list = @items.select { |k,_| k == element }.values.flatten
    sub_deps = []
    list.each do |item|
      sub_deps << dependencies(item)
    end

    list + sub_deps
  end
end
