# == Schema Information
#
# Table name: deals
#
#  id              :integer          not null, primary key
#  description     :text
#  discount        :decimal(, )
#  expiration_date :date
#  pinned          :boolean
#  price           :decimal(, )
#  title           :string
#  url             :string
#  view_count      :integer          default(0)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  store_id        :integer          not null
#
# Indexes
#
#  index_deals_on_store_id  (store_id)
#
# Foreign Keys
#
#  store_id  (store_id => stores.id)
#
class Deal < ApplicationRecord
  belongs_to :store, counter_cache: true
  belongs_to :category, counter_cache: true

  has_one_attached :image

  has_many :taggings, as: :subject, dependent: :destroy
  has_many :tags, through: :taggings

  validates :title, presence: true, allow_blank: false
  validate :price_less_than_retail_price

  scope :published, -> { where.not(published_at: nil) }
  scope :featured, -> { where(featured: true) }
  scope :recent, -> { order(created_at: :desc) }
  scope :latest, ->(number) { recent.limit(number) }

  scope :top_stories, ->(number) { latest(number).order(upvotes: :desc) }

  has_rich_text :body

  before_save :calculate_discount
  after_commit :generate_image_variants, on: :create
  after_create_commit :optimize_image

  def free?
    price.zero?
  end

  def affiliate_url
    affiliate_id = store.affiliate.present? ? store.affiliate : nil
    url_with_affiliate = "#{link}?affiliate=#{affiliate_id}"
    URI.encode(url_with_affiliate)
  end

  def discount_percentage
    return 0 if price.nil? || discount.nil? || price.zero?

    (discount / price.to_f) * 100
  end

  def body_html
    body.body&.to_html
  end

  def all_tags
    tags.map(&:name).join(', ')
  end

  def unpublish
    self.published_at = nil
  end

  def publish!
    self.published_at = Time.zone.now
    self.slug = nil # let FriendlyId generate slug
    save
  end

  def expire!
    self.expiration_date = Time.zone.now
    save
  end

  def published?
    published_at.present?
  end

  def available?
    expiration_date.blank? || (expiration_date > Time.zone.now)
  end

  def expired?
    !available?
  end

  def meta_info
    {
      title:,
      description: meta_description.present? ? meta_description : title,
      keywords: meta_keywords.present? ? meta_keywords : all_tags
    }
  end

  private

  def calculate_discount
    return unless price.present? && retail_price.present?

    self.discount = retail_price - price
  end

  def price_less_than_retail_price
    if price.present? && retail_price.present? && price >= retail_price
      errors.add(:price, "must be less than retail price")
    end
  end

  def generate_image_variants
    image.variant(resize: '600x400>').processed if image.attached?
  end

   def optimize_image
    if image.attached?
      optimized_image = ImageOptimizationService.optimize_image(image)
      self.image = optimized_image
    end
  end
end
