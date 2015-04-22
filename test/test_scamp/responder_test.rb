require 'minitest_helper'

class TestScampBc3Responder < Minitest::Test
	def test_converts_callback_urls_to_https
		r = Scamp::BC3::Responder.new(nil, "http://someurl.tld")
		assert_equal "https://someurl.tld.text", r.subsequent_post_uri.to_s
	end

	def test_leaves_https_urls_alone
		r = Scamp::BC3::Responder.new(nil, "https://someurl.tld")
		assert_equal "https://someurl.tld.text", r.subsequent_post_uri.to_s
	end
end
