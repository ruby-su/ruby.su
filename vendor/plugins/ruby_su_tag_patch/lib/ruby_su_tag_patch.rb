ActsAsTaggableOn::Tag.class_eval do
  before_create :set_permalink

  def to_param
    permalink
  end

  protected

  def set_permalink
    self.permalink = name.parameterize
  end
end
