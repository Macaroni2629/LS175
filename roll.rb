require "socket"

server = TCPServer.new("localhost", 3004)

loop do
  client = server.accept

  request_line = client.gets
  next if !request_line || request_line =~ /favicon/
  split_1 = request_line.split(" ")

  method = split_1[0]

  answer = split_1[1].chars.find_index("?")

  client.puts "HTTP/1.1 200 OK"
  client.puts "Content-Type: text/plain\r\n\r\n"

  puts request_line
   unless split_1[1] == "/"
     path = split_1[1][0..answer - 1] 
  
    new_path = split_1[1].split(path)[1]
    p new_path
    pairs = new_path.split("&") 

    pairs.map! { |word| word.delete("?") }

    pairs.map! { |word| word.split("=") }

    final = pairs.to_h

    range_of_numbers = 0..final["dice"].to_i

    final["rolls"].to_i.times { |num| client.puts range_of_numbers.to_a.sample }
  end

  client.puts request_line

  client.close
end