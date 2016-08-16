require 'test_helper'
require 'minitest/mock'

class UrlIndexingJobTest < ActiveJob::TestCase
  setup do
    @indexed_url = IndexedUrl.create(
      url: 'http://some-valid-url.com/some-page'
      )
  end

  test "changes status of IndexedUrl on job completion" do
    UrlIndexingJob.perform_now(@indexed_url)
    assert_not_equal [@indexed_url.status], 'Processing'
  end

  test "page is parsed as expected and content is extracted" do
    fake_html = <<-EOS
      <html>
        <head><title>Some Title</title></head>
        <body>
          <h1>heading11</h1>
          <h1>heading12</h1>
          <h2>heading21</h2>
          <h2>heading22</h2>
          <h3>heading31</h3>
          <h3>heading32</h3>
          <a href="http://example.com/page1"></a>
          <a href="http://example.com/page2"></a>
        </body>
      </html>
    EOS

    instance = UrlIndexingJob.new
    html_stub = -> (url) { return fake_html}
    Net::HTTP.stub :get, html_stub do 
      UrlIndexingJob.perform_now(@indexed_url)
      @indexed_url.content.each {|k,v| @indexed_url.content[k] = JSON.parse(v)}
      
      assert_equal @indexed_url.content, {
        "h1"=> ["heading11", "heading12"],
        "h2"=> ["heading21", "heading22"],
        "h3"=> ["heading31", "heading32"],
        "a"=> ["http://example.com/page1", "http://example.com/page2"]
      }
    end
    # instance.stub :open, html_stub do
    #   instance.perform(@indexed_url)
    #   @indexed_url.content.each {|k,v| @indexed_url.content[k] = JSON.parse(v)}
      
    #   assert_equal @indexed_url.content, {
    #     "h1"=> ["heading11", "heading12"],
    #     "h2"=> ["heading21", "heading22"],
    #     "h3"=> ["heading31", "heading32"],
    #     "a"=> ["http://example.com/page1", "http://example.com/page2"]
    #   }
    # end
  end
end
