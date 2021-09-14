module Abstract
  def abstract_methods(*methods)
    methods.each do |method_name|
      define_method method_name do |*_args|
        raise NotImplementedError, "This is an abstract base method (#{method_name}). Implement in your subclass."
      end
    end
  end
end
