require 'minitest/autorun'
require 'sshkit'
require 'sshkit/dsl'

class CapistranoRailsArtifactSpec < MiniTest::Unit::TestCase
  def setup
    system("vagrant up")
    configure_sshkit_for_vagrant
  end

  def teardown
    system("vagrant destroy -f")
  end

  # This is the sole test that is run. Of course it'd be nicer to have more tests, but each one adds
  # time, so... meh
  def test_deploy_works
    puts "Deploying once"
    result = `bundle exec cap testing deploy`
    assert_equal true, $?.success?, "Deployment failed. Output was:\n#{result}"

    check_file_and_permissions

    puts "Deploying twice"
    result = `bundle exec cap testing deploy`
    assert_equal true, $?.success?, "2nd Deployment failed. Output was:\n#{result}"

    puts "Deploying the last time"
    result = `bundle exec cap testing deploy`
    assert_equal true, $?.success?, "3rd Deployment failed - likely a permissions error. Output was:\n#{result}"

    puts "Testing rollback"
    result = `bundle exec cap testing deploy:rollback`
    assert_equal true, $?.success?, "Rollback failed. Output was:\n#{result}"
    check_only_one_release
  end

  def check_file_and_permissions
    release_dir_writable = false
    release_dir_readable = false
    release_artifact_writable = false
    release_artifact_readable = false
    on('deploy_target') do
      releases_dir = '/tmp/capistrano-rails-artifact/releases'
      timestamp = capture("ls #{releases_dir}").lines[0].chomp
      release_dir = File.join(releases_dir,timestamp)

      release_dir_writable = test("[ -w #{release_dir} ]")
      release_dir_readable= test("[ -r #{release_dir} ]")
      release_artifact_writable = test("[ -w #{release_dir}/ARTIFACT ]")
      release_artifact_readable = test("[ -r #{release_dir}/ARTIFACT ]")
    end
    assert_equal true, release_dir_writable, "release dir is not writable"
    assert_equal true, release_dir_readable, "release dir is not readable"
    assert_equal true, release_artifact_writable, "release artifact is not writable"
    assert_equal true, release_artifact_readable, "release artifact is not readable"
  end

  def check_only_one_release
    dirs_in_releases = []
    on('deploy_target') do
      dirs_in_releases = capture("ls /tmp/capistrano-rails-artifact/releases").lines.map(&:chomp)
    end
    assert_equal 1, dirs_in_releases.size
  end

  def configure_sshkit_for_vagrant
    require 'tempfile'
    tempfile = Tempfile.open('vagrant-ssh-config')

    system("vagrant ssh-config > #{tempfile.path}")

    unless $?.success?
      puts "You need to `vagrant up` first!"
      exit(1)
    end

    SSHKit.config.backend.configure do |config|
      config.ssh_options = {config: tempfile.path}
    end
  end
end

