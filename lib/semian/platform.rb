module Semian
  # Determines if Semian supported on the current platform.
  def self.supported_platform?
    /linux/.match(RUBY_PLATFORM)
  end
end
