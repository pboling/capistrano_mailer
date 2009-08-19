require 'test/unit'
require 'yaml'
require 'rubygems/specification'

class BuildGemTest < Test::Unit::TestCase
  def test_build_gem
    data = File.read(File.join(File.dirname(__FILE__), '..', 'capistrano_mailer.gemspec'))
    spec = nil

    if data !~ %r{!ruby/object:Gem::Specification}
      Thread.new { spec = eval("$SAFE = 3\n#{data}") }.join
    else
      spec = YAML.load(data)
    end

    assert spec.validate
  end
end
