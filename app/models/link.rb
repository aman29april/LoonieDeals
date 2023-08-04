# frozen_string_literal: true

# == Schema Information
#
# Table name: links
#
#  id               :integer          not null, primary key
#  label            :string
#  image            :string
#  url              :string
#  number_of_clicks :integer          default(0)
#  pinned           :boolean          default(FALSE)
#  position         :integer
#  enabled          :boolean
#  deal_id          :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Link < ApplicationRecord
  belongs_to :deal
  acts_as_list

  scope :enabled_only, -> { where(enabled: true) }
  scope :by_position, -> { order(position: :asc) }
  scope :latest, ->(number) { recent.limit(number) }
  scope :pinned, -> { where(pinned: true) }
  scope :un_pinned, -> { where(pinned: false) }

  validates :label, presence: true, length: { maximum: 100 }, allow_blank: false
  validates :url, presence: true, allow_blank: false
  validates :url, format: { with: URI::DEFAULT_PARSER.make_regexp, message: 'must be a valid URL' }

  has_one_attached :image

  def self.create_from(deal)
    link = Link.create(deal:, label: deal.title, url: deal.affiliate_url, short_slug: deal.short_slug, position: 1)
    return unless deal.image.attached?

    link.image.attach(io: StringIO.new(deal.image.download),
                      filename: deal.image.filename,
                      content_type: deal.image.content_type)
  end

  def expire!
    self.enabled = false
    self.pinned = false
    self.short_slug = nil
    save
  end
end
