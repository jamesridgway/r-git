require 'tempfile'
require 'securerandom'
module TestResources
  def self.included(example_group)
    example_group.extend(self)
  end

  def create_temp_file(filename)
    tmp_file = Tempfile.new(filename)
    before do
      FileUtils.touch(tmp_file)
    end
    define_method(:content_for_file) do |file, content|
      File.open(file, 'w') do |f|
        f.write(content)
      end
    end
    after do
      File.delete(tmp_file)
    end
    tmp_file
  end

  def generate_temp_filename(filename)
    tmp_file_path = Tempfile.new(filename).path
    before do
      File.delete(tmp_file_path)
    end
    tmp_file_path
  end

  def create_temp_dir(prefix)
    tmp_dir = Dir.mktmpdir(prefix)
    before do
      tmp_dir = Dir.mktmpdir(prefix)
    end
    after do
      FileUtils.rm_rf(tmp_dir)
    end
    Dir.open(tmp_dir)
  end

  def setup_test_root
    root_dir = create_temp_dir('root_folder')
    after do
      FileUtils.rm_rf(root_dir)
    end
    config_file = create_temp_file('rgit.yml')
    config = Rgit::Configuration.load(config_file.path)
    config.add_root(root_dir.path)
    config
  end

  def add_mock_repo(config)
    root_dir = config.roots[0]
    repo_path = File.join(root_dir, SecureRandom.hex(4), 'repo1')
    FileUtils.mkdir_p(File.join(repo_path, '.git'))
    FileUtils.touch(File.join(repo_path, '.git', 'config'))

    mock_repo = double('git repo')
    allow(mock_repo).to receive(:dir).and_return(Dir.open(repo_path))
    allow(Git).to receive(:open).with(repo_path).and_return(mock_repo)
    mock_repo
  end
end
