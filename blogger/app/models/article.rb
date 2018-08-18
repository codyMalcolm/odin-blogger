class Article < ApplicationRecord
  has_many :comments
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  def tag_list=(tags_string)
    tag_names = tags_string.split(', ').map{|t| t.downcase}.uniq
    new_or_found_tags = tag_names.map{|n| Tag.find_or_create_by(name: n)}
    self.tags = new_or_found_tags
  end

  def tag_list
    self.tags.map {|t| t.name}.join(", ")
  end

end
