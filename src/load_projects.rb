require "oauth2"
require "json"

projects = [
  "Libft",
  "get_next_line",
  "ft_printf",
  "Born2beroot",
  "so_long",
  "FdF",
  "fract-ol",
  "pipex",
  "minitalk",
  "push_swap",
  "Philosophers",
  "minishell",
  "NetPractice",
  "miniRT",
  "cub3d",
  "CPP Module 00",
  "CPP Module 01",
  "CPP Module 02",
  "CPP Module 03",
  "CPP Module 04",
  "CPP Module 05",
  "CPP Module 06",
  "CPP Module 07",
  "CPP Module 08",
  "CPP Module 09",
  "ft_containers",
  "ft_irc",
  "webserv",
  "Inception",
  "ft_transcendence"
]

def get_user (uid, secret)
  # Create the client with your credentials
  client = OAuth2::Client.new(UID, SECRET, site: "https://api.intra.42.fr")
  #Get an access token
  client.client_credentials.get_token
end

def load_projects(token, projects)
  projects_data = []
  projects.each { | p |
    sleep 0.5
    data = token.get("/v2/projects?filter[name]=#{p}").parsed
    puts "Parsing #{data[0]["name"]}"
    projects_data << {
      :id => data[0]["id"],
      :name => data[0]["name"],
      :description => data[0]["project_sessions"][0]["description"],
      :objectives => data[0]["project_sessions"][0]["objectives"]
    }
  }
end

File.write("42cursus_projects.json", JSON.dump(projects_data))
