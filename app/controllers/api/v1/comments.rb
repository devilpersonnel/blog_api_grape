module API
  module V1
    class Comments < Grape::API
      version 'v1'
      format :json

      resource :post do

        desc "Returns a list of all comments for a post"
        params do
          requires :post_id, type: Integer, desc: 'Post id'
        end
        get ':post_id/comments' do
          post = Post.find( params[:post_id] )
          { post: post.as_json(only: [:id, :title]).merge(comments: post.comments.as_json(only: [:id, :commenter, :text])) }
        end

      end
    end
  end
end