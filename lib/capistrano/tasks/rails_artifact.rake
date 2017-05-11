namespace :rails_artifact do
  desc 'Check that the repo is reachable'
  task :check do
  end

  desc 'Copy repo to releases'
  task :create_release do
    on release_roles :all do
      archive_url = fetch(:rails_artifact_archive_location)
      compression = fetch(:rails_artifact_compression, 'gz')
      bucket      = fetch(:rails_artifact_source_bucket)
      s3_options  = fetch(:rails_artifact_s3_options)

      case compression
        when 'gz'
          tar_option = 'z'
          extension = '.tar.gz'
        when 'bzip'
          tar_option = 'j'
          extension = '.tar.bzip'
        when 'xz'
          tar_option = 'J'
          extension = '.tar.xz'
        else
          tar_option = ''
          extension = '.tar'
      end

      file_location = "/tmp/build-artifact-files/build-artifact#{extension}"

      execute :mkdir, '-p', File.dirname(file_location)
      execute :rm, "-f #{file_location}"

      execute :mkdir, '-p', release_path

      if bucket
        execute :aws, "s3 cp #{s3_options} s3://#{bucket}/#{archive_url} #{file_location}"
      else
        execute :wget, "--no-check-certificate  -q -O '#{file_location}' '#{archive_url}'"
      end

      within release_path do
        execute :tar, "-x#{tar_option}f '#{file_location}'"
      end
      execute :rm, file_location
    end
  end

  desc 'Determine the revision that will be deployed'
  task :set_current_revision do
  end
end
