module ActiveRecordView
  def self.included(base)
    base.send :extend, ClassMethods
  end

  module ClassMethods
    def instantiate(record)
      model = find_sti_class(record[inheritance_column]).allocate
      model.instance_variable_set("@orig_attributes", record)
      new_columns = ["id", "created_at", "deleted_at", "updated_at", "lock_version"].concat(@column_inclusions || [])
      model.init_with('attributes' => record.reject{|key, value| !new_columns.include?(key)})
      model
    end
  end

  def becomes(klass)
    became = klass.new
    became.instance_variable_set("@orig_attributes", @orig_attributes)
    new_columns = ["id", "created_at", "deleted_at", "updated_at", "lock_version"].concat(klass.instance_variable_get("@column_inclusions") || [])
    attributes = @orig_attributes.reject{|key, value| !new_columns.include?(key)}
    became.instance_variable_set("@attributes", attributes)
    became.instance_variable_set("@attributes_cache", @attributes_cache)
    became.instance_variable_set("@new_record", new_record?)
    became.instance_variable_set("@destroyed", destroyed?)
    became
  end

  def to_xml(options={})
    options[:root] = self.class.superclass.name.downcase unless options.has_key? "root" || self.class.superclass == ActiveRecord::Base
    super options
  end

  def as_json(options={})
    options = {} unless options # to_json uses as_json and options is passed as nil
    options[:root] = self.class.superclass.name.downcase unless options.has_key? "root" || self.class.superclass == ActiveRecord::Base
    super options
  end

end