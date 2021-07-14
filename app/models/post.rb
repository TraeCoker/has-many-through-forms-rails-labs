class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :users, through: :comments
  #accepts_nested_attributes_for :categories, reject_if: proc { |cat| cat['name'].blank? }

  def categories_attributes=(category_attributes)
    category_attributes.values.each do |category_attribute|
      category = Category.find_or_create_by(category_attribute)
      self.categories << category if category.name != ""
    end
  end

  def unique_users_by_comment
    collection = self.comments.collect{|c| c.user}
    collection.uniq{|user| user.username}
  end 

end
