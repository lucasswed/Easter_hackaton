require "oauth2"
require "json"

UID = ""
SECRET = ""

# Create the client with your credentials
client = OAuth2::Client.new(UID, SECRET, site: "https://api.intra.42.fr")
#
#Get an access token
token = client.client_credentials.get_token

user = token.get("/v2/users?filter[login]=jaiveca-").parsed

# get user data
id = user[0]['id']
data = token.get("/v2/users/#{id}").parsed

# basic info
info = {
  "name": data[:usual_full_name],
  "login": data[:login],
  "campus": data[:campus][0][:name]
}

# harcoded 42 main cursus -- might not exist
cursus = data[:cursus_users].select { | cursus | cursus[:cursus][:id] == 21 }
info[:cursus] = cursus[0][:cursus];

# skills
info[:skills] = cursus[0][:skills]

# projects
projects_filtered = []
projects = data[:projects_users].select { | project | (project[:cursus_ids].include? 21 and project[:status] == 'finished') }
projects.each { | p | projects_filtered << ({"final_mark": p[:final_mark], "name": p[:project][:name] }) }
info[:projects] = projects_filtered

File.write("projects.json", JSON.dump(info))

