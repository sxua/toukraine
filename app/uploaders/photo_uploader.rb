# encoding: utf-8
require 'carrierwave/processing/mini_magick'

class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "system/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  version :full do
    process resize_to_fill: [1000, 600]
    process quality: 90
    process convert: 'jpg'
  end
  
  version :preview, from_version: :full do
    process resize_to_fill: [770, 350]
    process convert: 'jpg'
  end
  
  version :thumb, from_version: :preview do
    process resize_to_fill: [140, 64]
    process convert: 'jpg'
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    "original.#{model.image.file.extension}" if original_filename
  end

end