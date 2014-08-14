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
      execute :privileged_sudo, "rm -f #{file_location}"
      execute :privileged_wget, "--no-check-certificate  -O '#{file_location}' '#{archive_url}' > /dev/null 2>&1"
      within release_path do
        execute(:tar, "-xzf #{file_location}")
      end
      execute :privileged_sudo, "rm #{file_location}"
    end
  end

  desc 'Determine the revision that will be deployed'
  task :set_current_revision do
  end
end
