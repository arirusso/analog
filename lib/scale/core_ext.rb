class Numeric

  def scaled
    Scale.transform(self)
  end

  def scaled_using(source, destination)
    Scale.transform(self).using(source, destination)
  end

  def scaled_from(source)
    Scale.transform(self).from(source)
  end

  def scaled_to(destination)
    Scale.transform(self).to(destination)
  end

end
