require 'tempfile'

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
      f = File.open(file, 'w')
      f.write(content)
      f.flush
      f.close
    end
    after do
      File.delete(tmp_file)
    end
    tmp_file
  end

  def create_temp_dir(prefix)
    tmp_dir = Dir.mktmpdir(prefix)
    after do
      FileUtils.rm_rf(tmp_dir)
    end
    Dir.open(tmp_dir)
  end
end