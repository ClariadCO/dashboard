require "faraday"
require "faraday_middleware"
require "addressable/uri"

class App < ApplicationRecord
  has_attached_file :avatar, styles: { thumb: "175x175>" }, default_url: "/images/:style/missing_avatar.png"
  has_attached_file :background, styles: { cover: "322x538>" }, default_url: "/images/:style/missing_background.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  scope :not_featured, -> { where(featured: false)}
  scope :android, -> { where(app_type: "android") }
  scope :ios, -> { where(app_type: "ios") }
  scope :featured, -> { where(featured: true)}

  before_create :import_from

  def download_url
    if self.download_link.nil?
      case self.app_type
      when "ios"
        self.app_store
      when "android"
        self.google_store
      end
    else
      self.download_link
    end
  end

  def import_from
    case self.app_type
    when "ios"
      self.import_from_itunes
    when "android"
      self.import_from_google
    end
  end

  def import_from_itunes
    unless self.app_store.nil?
      response = self.scrapp_itunes_app rescue false
      if response && response["resultCount"] > 0
        itunes_app = response["results"].first
        self.background = itunes_app["screenshotUrls"].sample
        self.avatar = itunes_app["artworkUrl512"]
        self.name = itunes_app["trackName"]
        self.description = itunes_app["description"].gsub("\n", "<br>")
        self.short_description = itunes_app["description"][0..140]+"..."
      end
    end
  end

  def import_from_google
    unless self.google_store.nil?
      response = self.scrapp_google_app rescue false
      if response
        google_app = response["content"]["store_info"] rescue nil
        unless google_app.nil?
          self.background = google_app["screenshots"].sample
          self.avatar = google_app["icon"]
          self.name = google_app["title"]
          self.description = google_app["description"]
          self.short_description = google_app["description"][0..140]+"..."
        end
      end
    end
  end

  def self.apple_get url, data = {}
    request = self.apple_rest.get do |req|
      req.url "#{url}", data
      req.headers['Accept'] = 'application/json'
      req.headers['Content-Type'] = 'application/json; charset=utf-8'
      req.body = data.to_json
    end
    return request.body
  end

  def self.apple_rest
    api_uri = 'http://itunes.apple.com/'
    @rest = Faraday.new(:url => api_uri, :ssl => {:verify => false},  headers: { accept: 'application/json', :"Content-Type" => 'application/json; charset=utf-8' }) do |faraday|
      faraday.response :logger
      faraday.response :json, :content_type => /\b(json|json-home)$/
      faraday.adapter  Faraday.default_adapter
    end
    @rest
  end

  def scrapp_itunes_app
    apple_id = self.app_store.match(/id([0-9]*)/).to_a.last rescue nil
    unless apple_id.nil?
      response = App.apple_get("lookup", {id: apple_id, callback: "scrapp"}).gsub("scrapp(", "").gsub(");", "")
      #self.itunes_data = response
      #self.save!
      return JSON.parse(response)
    end
  end

  def self.google_get url, data = {}
    request = self.google_rest.get do |req|
      req.url "#{url}", data
      req.headers['Accept'] = 'application/json'
      req.headers['Content-Type'] = 'application/json; charset=utf-8'
      req.body = data.to_json
    end
    return request.body
  end


  def self.google_rest
    api_uri = 'https://api.apptweak.com/'
    @rest = Faraday.new(
      :url => api_uri, 
      :ssl => {:verify => false},  
      headers: {accept: 'application/json', :"Content-Type" => 'application/json; charset=utf-8', :"X-Apptweak-Key" => "13vsg5fqHpc65cJCW6W5wsHsO5A"}) do |faraday|
      faraday.response :logger
      faraday.response :json, :content_type => /\b(json|json-home)$/
      faraday.adapter  Faraday.default_adapter
    end
    @rest
  end

  def scrapp_google_app
    uri = Addressable::URI.parse(self.google_store)
    google_id = uri.query_values["id"] rescue nil
    unless google_id.nil?
      response = App.google_get("/android/applications/#{google_id}.json", {})
      return response
    end
  end
end