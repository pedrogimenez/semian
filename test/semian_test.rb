require 'test_helper'

class TestSemian < MiniTest::Unit::TestCase
  def setup
    Semian.destroy(:testing) rescue nil
  end

  def test_unsupported_acquire_yields
    acquired = false
    Semian.register :testing, tickets: 1, error_threshold: 1, error_timeout: 2, success_threshold: 1
    Semian[:testing].acquire { acquired = true }
    assert acquired
  end

  def test_unsuported_constants
    assert defined?(Semian::BaseError)
    assert defined?(Semian::SyscallError)
    assert defined?(Semian::TimeoutError)
    assert defined?(Semian::InternalError)
    assert defined?(Semian::Resource)
  end

  def test_disabled_via_env_var
    ENV['SEMIAN_DISABLED'] = '1'

    refute Semian.enabled?
  ensure
    ENV.delete('SEMIAN_DISABLED')
  end

end
