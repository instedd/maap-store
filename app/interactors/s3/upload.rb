module S3
  class Upload
    include Interactor

    def call
      context.record.reload
      upload_file!
      context.record.update(s3_file_path: key)
    end

    private

    def upload_file!
      Aws::S3::Resource.new.bucket(Rails.application.secrets.aws_s3_bucket)
                       .object(key).upload_file(local_file_path)
    end

    def local_file_path
      ActiveStorage::Blob.service.send(
        :path_for,
        context.record.sheet_file.key
      )
    end

    def extension
      context.record.sheet_file.blob.read_attribute(:filename).split('.').last
    end

    def key
      "#{[Rails.application.secrets.aws_s3_prefix,
          context.record.class.name.underscore,
          context.record.id].join('/')}.#{extension}"
    end
  end
end
