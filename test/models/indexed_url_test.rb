require 'test_helper'

class IndexedUrlTest < ActiveSupport::TestCase
  test "should not save IndexededUrl without url" do
    indexed_url = IndexedUrl.new()
    assert_not indexed_url.valid?
    assert_includes indexed_url.errors[:url], "can't be blank"
    assert_includes indexed_url.errors[:url], "does not match standard url regex"
    assert_not indexed_url.save
  end

  test "should not save IndexededUrl with invalid url" do
    indexed_url = IndexedUrl.new(url: 'some_invalid_url')
    assert_not indexed_url.valid?
    assert_includes indexed_url.errors[:url], "does not match standard url regex"
    assert_not indexed_url.save

  end

  test "should save IndexededUrl with valid url" do
    indexed_url = IndexedUrl.new(url: 'http://some-valid-url.com/some-page')
    assert indexed_url.valid? true
    assert indexed_url.save
  end
end
