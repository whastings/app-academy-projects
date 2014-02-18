require 'oauth'
require 'launchy'
require 'yaml'
require 'addressable/uri'

class TwitterSession

  TOKEN_FILE = "access_token.yml"

  def self.get(path, query_values)

    access_token.get(self.pathto_url(path, query_values)).body
  end

  def self.post(path, req_params)
    access_token.post(self.pathto_url(path, req_params))
  end

  def self.api_key
    return @api_key if @api_key
    key = Rails.root.join('.api_key')
    @api_key = File.read(key).chomp
  end

  def self.api_secret
    return @api_secret if @api_secret
    secret = Rails.root.join('.api_secret')
    @api_secret = File.read(secret).chomp
  end

  def self.access_token
    if File.exist?(TOKEN_FILE)
      File.open(TOKEN_FILE) { |f| @access_token = YAML.load(f)}
    else
      @access_token = request_access_token
      File.open(TOKEN_FILE, "w") { |f| YAML.dump(@access_token, f) }
    end
    @access_token
  end

  def self.pathto_url(path, query_values = nil)

    url = Addressable::URI.new(
      scheme: "https",
      host: "api.twitter.com",
      path: "/1.1/#{path}.json",
      query_values: query_values
    )

    url.to_s

  end
  def self.request_access_token
    request = consumer.get_request_token
    authorize_url = request.authorize_url
    puts "Go here to get your access PIN:"
    Launchy.open(authorize_url)
    puts "Please enter your PIN:"
    pin = gets.chomp
    access_token = request.get_access_token(
      oauth_verifier: pin
    )
  end

  def self.consumer
    @consumer ||= OAuth::Consumer.new(
      api_key,
      api_secret,
      site: 'https://twitter.com'
    )
  end

end