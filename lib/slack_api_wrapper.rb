# require `httparty`

class SlackApiWrapper
  BASE_URL = "https://slack.com/api/"
  TOKEN = ENV["SLACK_TOKEN"]

  def self.list_channels
    url = BASE_URL + "channels.list?" + "token=#{TOKEN}" + "&pretty=1&exclude_archived=1"
    data = HTTParty.get(url)
    channel_list = []
    if data["channels"]
      data["channels"].each do |channel_data|
        channel_list << self.create_channel(channel_data)
      end
    end
    return channel_list
  end

  def self.send_msg(channel, msg, token = nil)
    token = TOKEN if token == nil
    puts "Sending message to channel #{channel}: #{msg}"

    url = BASE_URL + "chat.postMessage?" + "token=#{token}"

    response = HTTParty.post(url,
    body:  {
      "text" => "#{msg}",
      "channel" => "#{channel}",
      "username" => "Roberts-Robit",
      "icon_emoji" => ":robot_face:",
      "as_user" => "false"
    },
    :headers => { 'Content-Type' => 'application/x-www-form-urlencoded' })
    return response.success?
  end

  private

  def self.create_channel(api_params)
    Channel.new(
      api_params["name"],
      api_params["id"],
      {
        purpose: api_params["purpose"],
        is_archived: api_params["is_archived"],
        members: api_params["members"]
      }
    )
  end
end
