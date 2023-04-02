require 'erb'

TEMPLATE = "<h1> Insert html template here </h1>
<% $completed = 0 %>
<p id=username> <%= user_data[:name] %> </p>
<p id=email> <%= user_data[:email] %> </p>
<p id=login> <%= user_data[:login] %> </p>
<p id=email> <%= user_data[:campus] %> </p>
<% user_data[:skills].each do |skills| %>
	<p id=skills> <%= skills[:name] %> </p>
<%end %>
<img src=<%= user_data[:image] %> >
<% user_data[:projects].each do |projects| %>
	<% if projects[:name] != 'Exam Rank 02' && projects[:name] != 'Exam Rank 03' && projects[:name] != 'Exam Rank 04' && projects[:name] != 'Exam Rank 05' && projects[:name] != 'Exam Rank 06' %>
		<% $completed = $completed + 1 %>
		<p><%= projects[:name] %></p>
		<p><%= projects[:final_mark] %></p>
		<% projects_data.each do |proj| %>
			<% if proj['id'] == projects[:id] %>
				<p><%= proj['description'] %></p>
				<% proj['objectives'].each do |objectives| %>
					<p>.....<%= objectives %></p>
				<%end %>		
			<%end %>	
		<%end %>
	 <%end %>
<%end %>

<p id=total> COMPLETED PROJECTS <%= $completed %> </p>
"

def generate_html(projects_data, user_data)
  rhtml = ERB.new(TEMPLATE)

  File.open("./output/#{user_data[:login]}.html", 'w') do |f|
    f.write rhtml.result(binding)
  end
end
