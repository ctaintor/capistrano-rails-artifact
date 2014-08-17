namespace :rails_artifact do
  desc 'Check that the repo is reachable'
  task :check do
  end

  desc 'Copy repo to releases'
  task :create_release do
    on release_roles :all do
      archive_url = fetch(:build_artifact_location)
      file_location = '/tmp/build-artifact.tar.gz'
      execute :mkdir, '-p', release_path
      execute :sudo, "rm -f #{file_location}"
      execute :cp, "'#{archive_url}' '#{file_location}'"
      #execute :wget, "--no-check-certificate  -q -O '#{file_location}' '#{archive_url}'"
      within release_path do
        execute :tar, "-xzf '#{file_location}'"
        sudo :chown, "-R rails:rails_runners ."
        sudo :chmod, "-R g+w ."
      end
      execute :rm, file_location
    end
  end

  desc 'Determine the revision that will be deployed'
  task :set_current_revision do
  end
end
