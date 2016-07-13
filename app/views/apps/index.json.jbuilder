json.array!(@apps) do |app|
  json.extract! app, :id, :name, :description, :short_description, :uid, :app_store, :google_store
  json.url app_url(app, format: :json)
end
