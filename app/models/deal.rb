# frozen_string_literal: true

# == Schema Information
#
# Table name: deals
#
#  id               :integer          not null, primary key
#  title            :string           not null
#  body             :text
#  price            :decimal(, )
#  retail_price     :decimal(, )
#  discount         :decimal(, )
#  url              :string
#  pinned           :boolean          default(FALSE)
#  published_at     :datetime
#  featured         :boolean          default(FALSE)
#  slug             :string
#  short_slug       :string
#  meta_keywords    :string
#  meta_description :string
#  expiration_date  :datetime
#  view_count       :integer          default(0)
#  upvotes          :integer          default(0)
#  downvotes        :integer          default(0)
#  store_id         :integer          not null
#  category_id      :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Deal < ApplicationRecord
  include Rails.application.routes.url_helpers
  include ImageConversionConcern
  extend FriendlyId

  friendly_id :title, use: :slugged

  attr_accessor :auto_create_link, :generated_image, :image_full_with, :store_background, :hide_discount,
                :enlarge_image_by, :hide_coupon

  belongs_to :store, counter_cache: true
  belongs_to :category, counter_cache: true

  delegate :name, to: :store, prefix: true
  delegate :name, to: :category, prefix: true

  has_one_attached :image
  has_one :link

  has_many :taggings, as: :subject, dependent: :destroy
  has_many :tags, through: :taggings

  validates :title, presence: true, allow_blank: false
  validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true
  validates :retail_price, :discount, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true
  validate :price_less_than_retail_price
  validates :url, format: { with: URI::DEFAULT_PARSER.make_regexp, message: 'must be a valid URL' }, allow_blank: true

  scope :published, -> { where.not(published_at: nil) }
  scope :featured, -> { where(featured: true) }
  scope :recent, -> { order(created_at: :desc) }
  scope :active, -> { where(expiration_date: nil) }
  scope :active_first, -> { order(Deal.arel_table[:expiration_date].desc.nulls_first) }
  scope :latest, ->(number) { recent.limit(number) }

  scope :top_stories, ->(number) { latest(number).order(upvotes: :desc) }

  has_rich_text :body

  before_save :calculate_discount
  before_save -> { convert_image_to_jpg(image) }

  before_create :set_short_slug

  validate :image_format_validation

  after_create :create_link

  with_options(if: :auto_create_link) do |it|
    it.validates :url, format: { with: URI::DEFAULT_PARSER.make_regexp, message: 'must be a valid URL' },
                       allow_blank: false, on: :create_link
    it.validates :title, presence: true, allow_blank: false
  end

  def free?
    price.zero?
  end

  def affiliate_url
    affiliate = store.affiliate_id
    link = url_or_store_url
    return link if affiliate.blank?

    url_with_affiliate = "#{link}?#{affiliate}"
    URI.encode(url_with_affiliate)
  end

  def url_or_store_url
    return url if url.present?

    store.website
  end

  def discount_percentage
    return 0 if discount.nil?

    "#{discount.to_i}%"
  end

  def body_html
    body.body&.to_html
  end

  def body_text
    body.body&.to_plain_text || ''
  end

  def self.tagged_with(name)
    Tag.find_by!(name:).deals
  end

  def all_tags
    tags.map(&:name).join(', ')
  end

  def all_tags=(names)
    self.tags = names.split(',').map do |name|
      name.strip!
      Tag.first_or_create_with_name!(name)
    end
    RelatedTagsCreator.create(tag_ids)
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
    self.short_slug = nil

    link.expire! if link.present?

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

  def image_attached?
    image.attached?
  end

  def image_url
    return unless image.attached?

    url_for(image.representation(resize_to_limit: [300, 300]).processed)
  end

  def text_with_url
    [title, url].reject!(&:blank?)&.join(' - ')
  end

  private

  def create_link
    Link.create_from(self) if auto_create_link
  end

  def convert_image_to_jpeg
    blob = image.blob
    return unless blob.present?

    converted_image = ImageConversionService.convert_to_jpeg(blob.download)
    image.purge # Remove the existing image
    # image.attach(io: converted_image, filename: "#{SecureRandom.hex}.jpg")
    image.attach(io: converted_image, filename: blob.filename)
  end

  def calculate_discount
    return unless price.present? && retail_price.present?

    discount_amount = retail_price - price
    discount_percentage = (discount_amount / retail_price.to_f) * 100

    self.discount = discount_percentage.round(2)
  end

  def price_less_than_retail_price
    return unless price.present? && retail_price.present? && price >= retail_price

    errors.add(:price, 'must be less than retail price')
  end

  def generate_image_variants
    image.variant(resize: '600x400>').processed if image.attached?
  end

  def optimize_image
    return unless image.attached?

    optimized_image = ImageOptimizationService.optimize_image(image)
    self.image = optimized_image
  end

  def image_format_validation
    return unless image.attached?

    return if image.content_type.in?(%w[image/jpeg image/jpg image/png])

    errors.add(:image, 'must be a JPEG, JPG, or PNG file')
    image.purge # Remove the invalid image
  end

  def set_short_slug
    self.short_slug = ShortIdUtil.generate_short_slug
  end
end
