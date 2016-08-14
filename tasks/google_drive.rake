require 'prius'
require 'google/apis/drive_v3'
require 'exifr'

if ENV['RACK_ENV'].nil? || ENV['RACK_ENV'].to_sym == :development
  require 'dotenv'
  Dotenv.load
end

# Load environment variables used by Google Auth
Prius.load(:google_account_type)
Prius.load(:google_client_id)
Prius.load(:google_client_secret)
Prius.load(:google_refresh_token)
Prius.load(:google_drive_folder_id)

def drive
  @drive_client ||=
    begin
      client = Google::Apis::DriveV3::DriveService.new

      # TODO: Move to constructing auth explicitly
      client.authorization = Google::Auth.get_application_default

      client
    end
end

namespace :google_drive do
  desc 'Pull latest photos from Google Drive'
  task :fetch_latest_photos do
    photos =
      drive.list_files(
        q: "'#{Prius.get(:google_drive_folder_id)}' in parents",
        fields: 'files(id, web_view_link)'
      ).files

    photos.each do |photo|
      # Download each photo and process its EXIF data
      content = drive.get_file(photo.id, download_dest: StringIO.new)
      content.rewind
      exif_details = EXIFR::JPEG.new(content)

      # TODO: push file to S3, or find a better way of viewing from Drive
      drive.create_permission(
        photo.id,
        { type: 'anyone', role: 'reader' },
        fields: 'id'
      )

      Photo.create(
        latitude: exif_details.gps.latitude,
        longitude: exif_details.gps.longitude,
        url: photo.web_view_link
      )
    end
  end
end
