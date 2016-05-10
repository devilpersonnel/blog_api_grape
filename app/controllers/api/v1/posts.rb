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

        desc "Creates a new post"
        params do
          requires :title, type: String, desc: 'Post title'
          requires :content, type: String, desc: 'Post content'
        end
        post do
          Post.create(title: params[:title], content: params[:content])
        end

      end

    end
  end
end