# frozen_string_literal: true

class VideoService
  def self.create_video(images, audio_path, output_path, delay_between_frames)
    return if images.empty?

    input_images = images.map { |image_path| "-loop 1 -t #{delay_between_frames} -i #{image_path}" }.join(' ')

    audio_option = ''
    audio_option = "-i #{audio_path}" if audio_path.present?

    command = "ffmpeg -y #{input_images} #{audio_option} -filter_complex \"[0:v] concat=n=#{images.length}:v=1 [v]\" -map \"[v]\" #{output_path}"
    system(command)
    output_path
  end
end
