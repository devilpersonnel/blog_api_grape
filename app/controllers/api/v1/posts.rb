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

        desc "Returns a specific post"
        params do
          requires :id, type: Integer, desc: 'Post id.'
        end
        route_param :id do
          get do
            Post.find(params[:id])
          end
        end

      end

    end
  end
end