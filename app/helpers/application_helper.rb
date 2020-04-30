module ApplicationHelper
  # Right know we don't need to read files from other than local
  # directories, not even in prod. S3 is only being used as an
  # upload endpoint. If ever needed, we can require 'open-uri'
  # to read files from other sources (such as S3 or web)
  def json_from_active_storage_attachment(blob_key)
    path = ActiveStorage::Blob.service.send(:path_for, blob_key)
    open(path, 'r') { |file| JSON.load(file) }
  end
end
