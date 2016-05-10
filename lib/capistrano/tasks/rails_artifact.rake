namespace :rails_artifact do
  desc 'Check that the repo is reachable'
  task :check do
  end

  desc 'Copy repo to releases'
  task :create_release do
    on release_roles :all do
      archive_url = fetch(:rails_artifact_archive_location)
      compression = fetch(:rails_artifact_compression, 'gz')

      case compression
        when 'gz'
          tar_option = 'z'
        when 'xz'
          tar_option = 'J'
      end

      file_location = "/tmp/build-artifact-files/build-artifact.tar.#{compression}"

      execute :mkdir, '-p', File.dirname(file_location)
      execute :rm, "-f #{file_location}"

      execute :mkdir, '-p', release_path
      execute :wget, "--no-check-certificate  -q -O '#{file_location}' '#{archive_url}'"
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
