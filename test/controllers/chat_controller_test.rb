require 'test_helper'


describe ChatController do


  it "can get the index path" do
    get root_path

    must_respond_with :ok
  end

  it "can get the new message form" do
    get chat_new_path("PLACEHOLDER")

    must_respond_with :ok
  end

  it "can send a message" do
    post chat_create_path("PLACEHOLDER")

    must_redirect_to root_path
  end
end
