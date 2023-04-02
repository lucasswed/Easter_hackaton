require "oauth2"

def get_user (uid, secret, name)
  token=""
  begin
  # Create the client with your credentials
  client = OAuth2::Client.new(uid, secret, site: "https://api.intra.42.fr")
  #Get an access token
  token = client.client_credentials.get_token
  rescue
    STDERR.write "error: invalid credentials\n"
    exit 1
  end
  token
end

def load_user_data(token, name, cursus_id=21)
  begin
    user = token.get("/v2/users?filter[login]=#{name}").parsed
  rescue
    STDERR.write "error: received http error\n"
    exit 2
  end
  if user.empty?
    STDERR.write "error: invalid credentials\n"
    exit 1
  end

  # get user data
  id = user[0]['id']
  begin
  data = token.get("/v2/users/#{id}").parsed
  rescue
    STDERR.write "error: received http error"
    exit 2
  end

  # basic info
  info = {
    "name": data[:usual_full_name],
    "login": data[:login],
    "email": data[:email],
    "campus": data[:campus][0]["name"],
    "image": data[:image][:link]
  }

  # harcoded 42 main cursus -- might not exist
  cursus = data[:cursus_users].select { | cursus | cursus[:cursus][:id] == 21 }

  if cursus.empty?
    STDERR.write "error: Provided user is not subscribed to 42cursus\n"
    exit 1
  end

  info[:cursus] = cursus[0][:cursus];
  
  # skills
  info[:skills] = cursus[0][:skills]
  
  # projects
  projects_filtered = []
  projects = data[:projects_users].select { | project | (project[:cursus_ids].include? cursus_id and project[:status] == 'finished') }
  projects.each { | p | projects_filtered << ({ :id => p[:project][:id], :final_mark => p[:final_mark], :name => p[:project][:name] }) }

  info[:projects] = projects_filtered
  
  info
end
