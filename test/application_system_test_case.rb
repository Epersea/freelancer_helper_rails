require "test_helper"
require_relative 'helpers/system_authentication_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]
  include SystemAuthenticationHelper
end
