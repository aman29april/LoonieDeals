# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_230_824_072_700) do
  create_table 'action_text_rich_texts', force: :cascade do |t|
    t.string 'name', null: false
    t.text 'body'
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[record_type record_id name], name: 'index_action_text_rich_texts_uniqueness', unique: true
  end

  create_table 'active_admin_comments', force: :cascade do |t|
    t.string 'namespace'
    t.text 'body'
    t.string 'resource_type'
    t.integer 'resource_id'
    t.string 'author_type'
    t.integer 'author_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[author_type author_id], name: 'index_active_admin_comments_on_author'
    t.index ['namespace'], name: 'index_active_admin_comments_on_namespace'
    t.index %w[resource_type resource_id], name: 'index_active_admin_comments_on_resource'
  end

  create_table 'active_storage_attachments', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.bigint 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness',
                                                    unique: true
  end

  create_table 'active_storage_blobs', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.string 'service_name', null: false
    t.bigint 'byte_size', null: false
    t.string 'checksum'
    t.datetime 'created_at', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'active_storage_variant_records', force: :cascade do |t|
    t.bigint 'blob_id', null: false
    t.string 'variation_digest', null: false
    t.index %w[blob_id variation_digest], name: 'index_active_storage_variant_records_uniqueness', unique: true
  end

  create_table 'admin_users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_admin_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_admin_users_on_reset_password_token', unique: true
  end

  create_table 'categories', force: :cascade do |t|
    t.string 'name'
    t.integer 'deals_count', default: 0
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'slug'
    t.integer 'position'
    t.integer 'parent_id'
    t.index ['parent_id'], name: 'index_categories_on_parent_id'
  end

  create_table 'categories_deals', id: false, force: :cascade do |t|
    t.integer 'deal_id', null: false
    t.integer 'category_id', null: false
    t.index %w[category_id deal_id], name: 'index_categories_deals_on_category_id_and_deal_id'
    t.index %w[deal_id category_id], name: 'index_categories_deals_on_deal_id_and_category_id'
  end

  create_table 'categories_stores', id: false, force: :cascade do |t|
    t.integer 'category_id', null: false
    t.integer 'store_id', null: false
    t.index %w[category_id store_id], name: 'index_categories_stores_on_category_id_and_store_id'
    t.index %w[store_id category_id], name: 'index_categories_stores_on_store_id_and_category_id'
  end

  create_table 'companies', force: :cascade do |t|
    t.string 'name'
    t.string 'logo'
    t.string 'hq'
    t.string 'address'
    t.string 'linkedin'
    t.string 'indeed'
    t.string 'url'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'coupons', force: :cascade do |t|
    t.integer 'store_id', null: false
    t.string 'code'
    t.decimal 'discount'
    t.date 'expiration_date'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['store_id'], name: 'index_coupons_on_store_id'
  end

  create_table 'deals', force: :cascade do |t|
    t.string 'title', null: false
    t.text 'body'
    t.decimal 'price'
    t.decimal 'retail_price'
    t.decimal 'discount'
    t.string 'url'
    t.string 'coupon'
    t.boolean 'pinned', default: false
    t.datetime 'published_at', precision: nil
    t.boolean 'featured', default: false
    t.string 'slug'
    t.string 'short_slug'
    t.string 'meta_keywords'
    t.string 'meta_description'
    t.datetime 'expiration_date'
    t.integer 'view_count', default: 0
    t.integer 'upvotes', default: 0
    t.integer 'downvotes', default: 0
    t.integer 'store_id', null: false
    t.integer 'category_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'kind'
    t.datetime 'starts_at'
    t.index ['category_id'], name: 'index_deals_on_category_id'
    t.index ['store_id'], name: 'index_deals_on_store_id'
  end

  create_table 'friendly_id_slugs', force: :cascade do |t|
    t.string 'slug', null: false
    t.integer 'sluggable_id', null: false
    t.string 'sluggable_type', limit: 50
    t.string 'scope'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[slug sluggable_type scope], name: 'index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope',
                                           unique: true
    t.index %w[slug sluggable_type], name: 'index_friendly_id_slugs_on_slug_and_sluggable_type'
    t.index %w[sluggable_type sluggable_id], name: 'index_friendly_id_slugs_on_sluggable_type_and_sluggable_id'
  end

  create_table 'likes', force: :cascade do |t|
    t.string 'likeable_type'
    t.integer 'likeable_id'
    t.integer 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[likeable_type likeable_id], name: 'index_likes_on_likeable_type_and_likeable_id'
    t.index ['user_id'], name: 'index_likes_on_user_id'
  end

  create_table 'links', force: :cascade do |t|
    t.string 'label'
    t.string 'image'
    t.string 'url'
    t.integer 'number_of_clicks', default: 0
    t.boolean 'pinned', default: false
    t.integer 'position'
    t.boolean 'enabled'
    t.string 'short_slug'
    t.integer 'deal_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'extra_info'
    t.index ['deal_id'], name: 'index_links_on_deal_id'
  end

  create_table 'posts', force: :cascade do |t|
    t.string 'title'
    t.text 'body'
    t.integer 'likes_count', default: 0
    t.datetime 'published_at', precision: nil
    t.boolean 'featured', default: false
    t.string 'picture'
    t.bigint 'user_id'
    t.string 'slug'
    t.integer 'responses_count', default: 0, null: false
    t.text 'lead'
    t.string 'meta_keywords'
    t.string 'meta_description'
    t.string 'language'
    t.integer 'view_count', default: 0
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['slug'], name: 'index_posts_on_slug', unique: true
    t.index ['user_id'], name: 'index_posts_on_user_id'
  end

  create_table 'recurring_schedules', force: :cascade do |t|
    t.integer 'deal_id', null: false
    t.string 'recurrence_type'
    t.string 'day_of_week'
    t.integer 'day_of_month'
    t.datetime 'starts_at'
    t.datetime 'expires_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['deal_id'], name: 'index_recurring_schedules_on_deal_id'
  end

  create_table 'referral_codes', force: :cascade do |t|
    t.string 'referal_link'
    t.string 'referal_code'
    t.text 'referal_text'
    t.integer 'position'
    t.boolean 'enabled'
    t.integer 'store_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['store_id'], name: 'index_referral_codes_on_store_id'
  end

  create_table 'site_settings', force: :cascade do |t|
    t.string 'ig_id'
    t.string 'ig_secret_token'
    t.string 'facebook_access_token'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'social_accounts', force: :cascade do |t|
    t.string 'url'
    t.integer 'number_of_clicks', default: 0
    t.integer 'position'
    t.string 'account_type'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'social_media_posts', force: :cascade do |t|
    t.integer 'deal_id'
    t.text 'social_media_accounts'
    t.text 'text'
    t.datetime 'scheduled_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['deal_id'], name: 'index_social_media_posts_on_deal_id'
  end

  create_table 'static_pages', force: :cascade do |t|
    t.string 'title'
    t.string 'body'
    t.string 'picture'
    t.string 'meta_keywords'
    t.string 'meta_description'
    t.string 'slug'
    t.bigint 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_static_pages_on_user_id'
  end

  create_table 'stores', force: :cascade do |t|
    t.string 'name'
    t.text 'description'
    t.string 'website'
    t.string 'affiliate_id'
    t.boolean 'featured', default: false
    t.string 'slug'
    t.string 'meta_keywords'
    t.string 'meta_description'
    t.integer 'deals_count', default: 0
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'referral'
  end

  create_table 'tag_relationships', force: :cascade do |t|
    t.integer 'tag_id', null: false
    t.integer 'related_tag_id', null: false
    t.integer 'relevance', default: 0, null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['related_tag_id'], name: 'index_tag_relationships_on_related_tag_id'
    t.index %w[tag_id related_tag_id], name: 'index_tag_relationships_on_tag_id_and_related_tag_id', unique: true
    t.index ['tag_id'], name: 'index_tag_relationships_on_tag_id'
  end

  create_table 'taggings', force: :cascade do |t|
    t.bigint 'tag_id', null: false
    t.string 'subject_type', null: false
    t.bigint 'subject_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[subject_type subject_id], name: 'index_taggings_on_subject'
    t.index ['tag_id'], name: 'index_taggings_on_tag_id'
  end

  create_table 'tags', force: :cascade do |t|
    t.string 'name', null: false
    t.boolean 'featured', default: false
    t.string 'lowercase_name'
    t.string 'slug'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'active_storage_variant_records', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'coupons', 'stores'
  add_foreign_key 'deals', 'categories'
  add_foreign_key 'deals', 'stores'
  add_foreign_key 'links', 'deals'
  add_foreign_key 'recurring_schedules', 'deals'
  add_foreign_key 'referral_codes', 'stores'
  add_foreign_key 'social_media_posts', 'deals'
end
