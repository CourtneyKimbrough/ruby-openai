require "openai"
require "dotenv/load"

client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))

request = ""

dash = "-"

# Prepare an Array of previous messages
message_list = [
  {
    "role" => "system",
    "content" => "You are a helpful assistant who talks like Mr.Beast."
  }
]

puts "Hello! How can I help you today?"

while request != "bye"
  
  puts dash * 50
  request = gets.chomp

  if request != "bye"
    message_list.push({"role" => "system", "content" => request})
  # Call the API to get the next message from GPT
    api_response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: message_list
      }
    )

    choices_array = api_response.fetch("choices")
    index_hash= choices_array[0]
    message_hash = index_hash.fetch("message")
    content = message_hash.fetch("content").to_s

    puts dash * 50
    puts content

    message_list.push({"role" => "assistant", "content" => content})

    

    end
  end

  puts dash * 50
  
  puts "Goodbye!"
