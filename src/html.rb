require "erb"

TEMPLATE = "<!DOCTYPE html>
<html lang='en'>
	<head>
		<meta charset='UTF-8'>
		<meta http-equiv='X-UA-Compatible' content='IE=edge'>
		<meta name='viewport' content='width=device-width, initial-scale=1.0'>
		<title>Portfólio</title>
		<link rel='shortcut icon' href='../imgs/42.svg' type='image/x-icon'>
		<link rel='stylesheet' href='styles/style.css'>
		<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css' rel='stylesheet' integrity='sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp' crossorigin='anonymous'>
		<script src='https://kit.fontawesome.com/00e90511fb.js' crossorigin='anonymous'></script>
		<script src='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/js/bootstrap.bundle.min.js' integrity='sha384-qKXV1j0HvMUeCBQ+QVp7JcfGl760yU08IQ+GpUo5hlbpg51QRiuqHAJz8+BrxE/N' crossorigin='anonymous'></script>
	</head>
	<body>
		<div class='bg'></div>
		<div class='content'>
			<header>
				<div class='avatar' style='background-image: url(<%= user_data[:image] %>);'></div>
				<div id='user_info'>
					<span id='full-name'><%= user_data[:name] %></span>
					<span id='username'><a href='https://profile.intra.42.fr/users/<%= user_data[:login] %>'><%= user_data[:login] %></a></span>
					<span id='email'><a href='mailto:<%= user_data[:email] %>'><i class='fa-regular fa-envelope' id='icone'></i> <%= user_data[:email] %></a></span>
					<span id='campus'>Campus: <%= user_data[:campus] %></span>
					<div id='cursus'>
						<span>Cursus: 42 Cursus</span>
						<div class='progress' role='progressbar' style='height: 20px; background-color: #5e5f60;'>
						<% $completed = 0 %>
						<% user_data[:projects].each do |projects| %>
							<% if projects[:name] != 'Exam Rank 02' && projects[:name] != 'Exam Rank 03' && projects[:name] != 'Exam Rank 04' && projects[:name] != 'Exam Rank 05' && projects[:name] != 'Exam Rank 06' %>
								<% $completed = $completed + 1 %>
							<% end %>
						<% end %>
							<div class='progress-bar progress-bar-striped progress-bar-animated' style='width: calc(<%= $completed %>/24*100%); background-color: var(--primary);'><%= $completed %>/24</div>
						</div>
					</div>
				</div>
			</header>
			<aside id='skills'>
				<h2>Skills:</h2>
				<ul>
					<% user_data[:skills].each do |skills| %>
						<li> <%= skills[:name] %> </li>
					<%end %>
				</ul>
			</aside>
			<section class='projects'>
			<% user_data[:projects].each do |projects| %>
				<% projects_data.each do |proj| %>
				<% if proj['id'] == projects[:id] && projects[:name] != 'Exam Rank 02' && projects[:name] != 'Exam Rank 03' && projects[:name] != 'Exam Rank 04' && projects[:name] != 'Exam Rank 05' && projects[:name] != 'Exam Rank 06' %>
				<div class='card'>
					<h5 class='title'><%= projects[:name] %></h5>
					<div class='card-body'>
						<h6 class='grade'><%= projects[:final_mark] %>%</h6>
						<% projects_data.each do |proj| %>
							<% if proj['id'] == projects[:id] %>
								<h6 class='keywords'>Keywords</h6>
								<ul>
								<% proj['objectives'].each do |objectives| %>
									<li><%= objectives %></li>
								<%end %>	
								</ul>
							<a href='#PROJECT_FULL<%= projects[:id] %>' class='button' data-bs-toggle='collapse'>⌄</a>
					</div>
					<div class='collapse' id='PROJECT_FULL<%= projects[:id] %>'>
						<span class='description-title'>Description:</span>
						<br>
						<span class='description-body'>
						<%= proj['description'] %></span>
					</div>
					<%end %>	
					<%end %>
				</div>
				<% end %>
			<%end %>
			<%end %>
			</section>
		</div>
	</body>
</html>
"

def generate_html(projects_data, user_data)
  rhtml = ERB.new(TEMPLATE)

  File.open("./output/#{user_data[:login]}.html", 'w') do |f|
    f.write rhtml.result(binding)
  end
end
