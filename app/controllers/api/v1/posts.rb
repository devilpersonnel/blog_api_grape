module API
  module V1
    class Posts < Grape::API
      version 'v1'
      format :json

      resource :posts do
        desc "Returns a list of all posts"
        get do
          Post.all
        end
      end

    end
  end
end