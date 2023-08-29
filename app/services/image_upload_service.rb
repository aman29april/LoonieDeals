# frozen_string_literal: true

class ImageUploadService
  def self.upload_image(image)
    upload(image)
  end

  def self.upload_images(urls)
    secure_urls = []
    urls.each_with_index do |photo, index|
      secure_urls << upload(photo, "instagram_upload#{index}")
    end
    secure_urls
  end

  def self.upload_video(file)
    upload(file, 'video', 'video')
  end

  def self.upload(photo_url, id = 'instagram_upload', resource_type = 'image')
    response = Cloudinary::Uploader.upload(photo_url,
                                           folder: 'looniedeals/tmp/',
                                           public_id: id,
                                           overwrite: true,
                                           resource_type:,
                                           use_filename: true,
                                           unique_filename: false)

    # response['url']
    response['secure_url']
  end
end
