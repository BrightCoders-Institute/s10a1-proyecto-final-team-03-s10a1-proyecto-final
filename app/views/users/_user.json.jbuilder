json.extract! user, :id, :name, :lastName, :birthday, :weight, :height, :email, :created_at, :updated_at
json.url user_url(user, format: :json)
