json.extract! post, :id, :title, :text, :upvotes, :downvotes, :link, :created_at, :updated_at
json.url post_url(post, format: :json)