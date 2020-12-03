module Mongoid
  module Serializable
    def serializable_hash(options = nil)
      options ||= {}
      options[:except] = (options[:except] || []) | ["modifier", "updated_at", "created_at", "ip"]

      attrs = {}
      names = field_names(options)
      method_names = Array.wrap(options[:methods]).map do |name|
        name.to_s if respond_to?(name)
      end.compact
      (names + method_names).each do |name|
        without_autobuild do
          serialize_attribute(attrs, name, names, options)
        end
      end
      serialize_relations(attrs, options) if options[:include]

      attrs["id"] = attrs.delete("_id")
      attrs
    end
  end
end


module BSON
  class ObjectId
    def as_json(options = {})
      to_s
    end
  end
end
