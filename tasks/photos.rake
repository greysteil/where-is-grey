require 'prius'
require 'google/apis/drive_v3'
require 'exifr'
require 'fog/aws'
require 'mini_magick'
require_relative "../app/app"

if ENV['RACK_ENV'].nil? || ENV['RACK_ENV'].to_sym == :development
  require 'fog/local'
  require 'dotenv'
  Dotenv.load
end

# Load environment variables used by Google Auth
Prius.load(:google_account_type)
Prius.load(:google_client_id)
Prius.load(:google_client_secret)
Prius.load(:google_refresh_token)

# Load environment variables used by Google Drive
Prius.load(:google_drive_folder_id)

# Load environment variables used to upload images to S3
Prius.load(:aws_photo_bucket)
Prius.load(:aws_access_key_id)
Prius.load(:aws_secret_access_key)

namespace :photos do
  desc 'Pull latest photos from Google Drive'
  task :fetch_latest do
    photos =
      drive.list_files(
        q: "'#{Prius.get(:google_drive_folder_id)}' in parents " \
           "AND trashed = false",
        fields: 'files(id, name, mime_type)'
      ).files

    # Download each photo, process its EXIF data, and upload it to S3
    photos.each do |photo|
      next if Photo.exists?(external_id: photo.id)

      tempfile = drive.get_file(photo.id, download_dest: Tempfile.new)
      tempfile.rewind

      exif_details = EXIFR::JPEG.new(tempfile)

      image = MiniMagick::Image.new(tempfile.path).auto_orient
      image_body = File.read(image.path)

      thumbnail = image.resize("200x200")
      thumbnail_body = File.read(thumbnail.path)

      filename = "photos/#{photo.id}"

      s3_file = s3_bucket.files.create(
        key: filename + ".jpeg",
        body: image_body,
        public: true,
        content_type: photo.mime_type
      )
      s3_bucket.files.create(
        key: filename + "_t.jpeg",
        body: thumbnail_body,
        public: true,
        content_type: photo.mime_type
      )

      Photo.create(
        latitude: exif_details.gps.latitude,
        longitude: exif_details.gps.longitude,
        url: s3_file.public_url,
        external_id: photo.id,
        description: photo.name,
        taken_at: exif_details.date_time_original
      )
    end
  end

  desc 'Delete all photos from app (so they can be re-synched from Drive)'
  task :delete_all do
    Photo.all.each(&:destroy!)
  end
end

##################
# Helper methods #
##################

def drive
  @drive_client ||=
    begin
      client = Google::Apis::DriveV3::DriveService.new

      # TODO: Move to constructing auth explicitly
      client.authorization = Google::Auth.get_application_default

      client
    end
end

def s3_bucket
  storage = Fog::Storage.new(fog_options)

  storage.directories.get(Prius.get(:aws_photo_bucket)) ||
    storage.directories.create(key: Prius.get(:aws_photo_bucket),
                               location: "us-west-2")
end

def fog_options
  if ENV['RACK_ENV'].nil? || ENV['RACK_ENV'].to_sym == :development
    { provider: "Local",
      local_root: File.expand_path("../../app/static", __FILE__),
      endpoint: "http://localhost:9393" }
  else
    { provider: "AWS",
      aws_access_key_id: Prius.get(:aws_access_key_id),
      aws_secret_access_key: Prius.get(:aws_secret_access_key),
      region: "us-west-2" }
  end
end
