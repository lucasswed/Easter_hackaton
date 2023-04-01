require 'erb'

#TODO create html

name = "test"
cost = 10
desc = "test2"
code = "test3"

features = ["feature1", "feature2"]
# Create template.
template = %{
  <html>
    <head><title>Ruby Toys -- <%= name %></title></head>
    <body>

      <h1><%= name %> (<%= code %>)</h1>
      <p><%= desc %></p>

      <ul>
        <% features.each do |f| %>
          <li><b><%= f %></b></li>
        <% end %>
      </ul>

      <p>
        <% if cost < 10 %>
          <b>Only <%= cost %>!!!</b>
        <% else %>
           Call for a price, today!
        <% end %>
      </p>

    </body>
  </html>
}.gsub(/^  /, '')

rhtml = ERB.new(template)

File.open('index.html', 'w') do |f|
  f.write rhtml.result(binding)
end
