json.extract! match, :id, :created_at, :updated_at
json.users json.array! match.users.pluck, :identifier
json.url match_url(match, format: :json)
