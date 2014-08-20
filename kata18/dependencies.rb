require 'pry'
class Dependencies
  def initialize
    @items = {}
    @used = []
    @all = []
  end

  def add_direct(element, dependencies)
    @items[element] = dependencies
  end

  def dependencies_for(element)
    @used = []
    dependencies(element).flatten.uniq.sort.keep_if { |e| e != element }
  end

  protected
  def dependencies(element)

    if @used.include? element
      return @all
    else
      @used << element
    end

    list ||= @items.select { |k,_| k == element }.values.flatten
    sub_deps = []
    list.each do |item|
      @all << item
      sub_deps << dependencies(item)
    end

    list + sub_deps
  end
end
