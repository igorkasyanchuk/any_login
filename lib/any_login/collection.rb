module AnyLogin
  class Collection
    attr_reader :collection_raw

    def initialize(collection_raw)
      @collection_raw = collection_raw
    end

    def grouped?
      type == :grouped
    end

    def to_a
      collection_raw.collect do |e|
        if grouped?
          [e[0], e[1].collect(&AnyLogin.name_method)]
        else
          if AnyLogin.name_method.is_a?(Symbol)
            e.send(AnyLogin.name_method)
          else
            AnyLogin.name_method.call(e)
          end
        end
      end
    end

    private

    def type
      @type ||= if collection_raw[0].is_a?(Array)
                  :grouped
                else
                  :single
                end
    end
  end
end
