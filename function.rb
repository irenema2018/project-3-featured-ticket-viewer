
def send_api_request(url)
  auth = {:username => session[:email], :password => session[:password]}
  response = HTTParty.get(url,:basic_auth => auth)

  if response.code != 200
    session[:error_message] = 'Something was wrong. The Zendesk API may not be available or your credentials may not be entered correctly.'
    redirect '/error'
  end

  return response
end

def create_user_object(users_array)
  users = {}
  users_array.each do |user|
    id = user['id']
    name = user['name']
    users[id] = name
  end
  return users
end

def access_to_different_page(page_url)
  response = send_api_request(page_url)
             
  @tickets = response['tickets']
  session[:next_page_url] = response['next_page']
  session[:prev_page_url] = response['previous_page']

  @users = create_user_object(response['users'])
end