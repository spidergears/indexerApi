class IndexedUrlSerializer < ActiveModel::Serializer
  attributes :id, :url, :status, :content

  def content
    object.content.each do |k, v|
      object.content[k] = JSON.parse v
    end
  end
end
