require "test_helper"

class Api::V1::IndexedUrlsControllerTest < ActionDispatch::IntegrationTest
  include ActiveJob::TestHelper

  def test_index
    @indexed_url = IndexedUrl.create(url: 'http://some-valid-url.com/some-page')
    get api_v1_indexed_urls_url, as: :json
    assert_response 200
    assert_includes @response.body, @indexed_url.url
  end
  
  def test_create
    assert_difference('IndexedUrl.count') do
      post api_v1_indexed_urls_url, params: {url: 'http://some-other-valid-url.com/some-page'}, as: :json
    end
  end

  def test_create_job_enqueue
    assert_enqueued_with(job: UrlIndexingJob) do
      post api_v1_indexed_urls_url, params: {url: 'http://some-other-valid-url.com/some-page'}, as: :json
    end
  end
end
