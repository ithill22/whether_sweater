class BackgroundSerializer
  include JSONAPI::Serializer

  set_type :image

  attributes :location, :image_url, :credit
end