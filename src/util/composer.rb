class Proc
  def self.compose(f, g)
    lambda { |*args| f[g[*args]] }
  end

  def compose(g)
    Proc.compose(self, g)
  end

  alias_method :*, :compose
end