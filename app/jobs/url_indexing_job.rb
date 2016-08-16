class UrlIndexingJob < ApplicationJob
  queue_as :default

  def perform(indexed_url)
    page  = Net::HTTP.get(URI.parse(indexed_url.url))
    html_nodes = Nokogiri.parse(page)
    content_hash = (html_nodes.search 'h1', 'h2', 'h3', 'a').group_by(&:name)
    clean_up(content_hash)

    indexed_url.content = content_hash
    indexed_url.status = 'Processed'
    indexed_url.save

  rescue Timeout::Error
    indexed_url.update_attribute(:status, "Request Timed out..")
  rescue Exception => e
    indexed_url.update_attribute(:status, e.message())
  end

  def clean_up(content_hash)
    content_hash.each do |k, v|
      if k == 'a'
        content_hash[k] = v.map {|link| link.attributes["href"].value}
      else
        content_hash[k] = v.map {|node| node.text}
      end
    end
  end
end
