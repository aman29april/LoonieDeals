# == Schema Information
#
# Table name: posts
#
#  id               :integer          not null, primary key
#  body             :text
#  featured         :boolean          default(FALSE)
#  language         :string
#  lead             :text
#  likes_count      :integer          default(0)
#  meta_description :string
#  meta_keywords    :string
#  picture          :string
#  published_at     :datetime
#  responses_count  :integer          default(0), not null
#  slug             :string
#  title            :string
#  view_count       :integer          default(0)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :bigint
#
# Indexes
#
#  index_posts_on_slug     (slug) UNIQUE
#  index_posts_on_user_id  (user_id)
#
class Post < ApplicationRecord
  # validates :user_id, presence: true
  validates :title, presence: true,
                    length: { minimum: 5 }, allow_blank: false
  validates :body, presence: true, length: { minimum: 50 }, allow_blank: false
  validates :all_tags, length: { minimum: 2 }, allow_blank: false, presence: true

  belongs_to :store

  has_many :taggings, as: :subject, dependent: :destroy
  has_many :tags, through: :taggings

  has_many :items, -> { order('sort_rank asc') }, dependent: :destroy

  scope :recent, -> { order(created_at: :desc) }
  scope :latest, ->(number) { recent.limit(number) }
  scope :top_stories, ->(number) { order(likes_count: :desc).limit(number) }
  scope :published, -> { where.not(published_at: nil) }
  scope :drafts, -> { where(published_at: nil) }
  scope :featured, -> { where(featured: true) }
  scope :by_user, ->(user) { where(user:) }
  delegate :username, to: :user
  delegate :full_name, to: :user, prefix: :user

  before_save :generate_lead!

  extend FriendlyId
  friendly_id :title, use: %i[slugged history finders]

  has_rich_text :body

  mount_uploader :picture, PostImageUploader

  # has_rich_text :content

  def unpublish
    self.published_at = nil
  end

  def publish
    self.published_at = Time.zone.now
    self.slug = nil # let FriendlyId generate slug
    save
  end

  def self.tagged_with(name)
    Tag.find_by!(name:).posts
  end

  def body_text
    body.body&.to_plain_text || ''
  end

  def published?
    published_at.present?
  end

  def words
    body.split(' ')
  end

  def word_count
    words.size
  end

  def all_tags=(names)
    self.tags = names.split(',').map do |name|
      Tag.first_or_create_with_name!(name)
    end
    RelatedTagsCreator.create(tag_ids)
  end

  def all_tags
    tags.map(&:name).join(', ')
  end

  def related_posts(size: 3)
    Post.joins(:taggings).where.not(id:).where(taggings: { tag_id: tag_ids }).distinct
        .published.limit(size).includes(:user)
  end

  def body_html
    body.body&.to_html
  end

  def generate_lead!
    body_doc = Nokogiri::HTML::DocumentFragment.parse(body_html) if published?

    add_css_class_to_pre_tags(body_doc)
    body.body = body_doc.to_html
  end

  def meta_info
    {
      title:,
      description: meta_description.present? ? meta_description : title,
      keywords: meta_keywords.present? ? meta_keywords : all_tags
    }
  end

  private

  def add_css_class_to_pre_tags(doc)
    doc.search('pre').tap { |ns| ns.add_class("language-#{language}") }
    doc
  end

  # TODO: Not working. Fix this.
  def set_target_blank(doc)
    # doc.css('a').each do |link|
    #   link['target'] = '_blank'
    # end
    #
    doc.search('a').tap { |link| link.attr('target', '_blank') }
    doc
  end
end
