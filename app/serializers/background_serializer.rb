class BackgroundSerializer
  include JSONAPI::Serializer

  set_type :image

  attributes :id, :location, :image_url, :credit
end