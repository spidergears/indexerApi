class Api::V1::IndexedUrlsController < ApplicationController
  def index
    render json: ActiveModel::Serializer::CollectionSerializer.new(IndexedUrl.all, 
      each_serializer: ::IndexedUrlSerializer).as_json
  end

  def create
    indexed_url = IndexedUrl.new(url_params)

    if indexed_url.save
      UrlIndexingJob.perform_later(indexed_url)
      render json: {status: indexed_url.status}, status: 201
    else
      render json: { errors: indexed_url.errors.messages }, status: 422
    end
  rescue Exception => e
    render json: { errors: "Invalid request" }, status: 400
  end

  private
  def url_params
    params.permit(:url)
  end
end
