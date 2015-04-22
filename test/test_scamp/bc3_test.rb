require 'minitest_helper'

class TestScampBc3 < Minitest::Test
	def test_that_it_has_a_version_number
		refute_nil ::Scamp::Bc3::VERSION
	end
end
