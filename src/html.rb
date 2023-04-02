require 'erb'

TEMPLATE = "<h1> Insert html template here </h1>
<p id=username> example: <%= user_data[:name] %> </p>"

def generate_html(projects_data, user_data)
  rhtml = ERB.new(TEMPLATE)

  File.open("./output/#{user_data[:login]}.html", 'w') do |f|
    f.write rhtml.result(binding)
  end
end
