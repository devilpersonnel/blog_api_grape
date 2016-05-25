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

        desc "Returns a comment for a post"
        params do
          requires :post_id, type: Integer, desc: "Post id"
          requires :id, type: Integer, desc: "Comment id"
        end
        get ':post_id/comments/:id' do
          post = Post.find( params[:post_id] )
          { post: post.as_json(only: [:id, :title]).merge(comment: post.comments.find(params[:id]).as_json(only: [:id, :commenter, :text])) }
        end

        desc "Returns a created comment for a post"
        params do
          requires :post_id, type: Integer, desc: "Post id"
          requires :commenter, type: String, desc: "Name of commenter"
          requires :text, type: String, desc: "Text in comment"
        end
        post ':post_id/comments' do
          article = Post.find( params[:post_id] )
          article.comments.create(commenter: params[:commenter], text: params[:text])
        end

        desc "Updates and returns a specific comment"
        params do
          requires :post_id, type: Integer, desc: "Post_id"
          requires :id, type: Integer, desc: "Comment ID"
        end
        put ':post_id/comments/:id' do
          post = Post.find(params[:post_id])
          comment = post.comments.where(id: params[:id]).last
          if comment.update( commenter: params[:commenter], text: params[:text])
            comment
          else
            { error: comment.errors.full_messages.to_sentence }
          end
        end

        desc "Deletes a comment for a post"
        params do
          requires :post_id, type: Integer, desc: "Post id"
          requires :id, type: Integer, desc: "Comment id"
        end
        delete ':post_id/comments/:id' do
          post = Post.find(params[:post_id])
          comment = post.comments.where(id: params[:id]).last
          comment.destroy
          { success: 'Comment was successfully deleted' }
        end

      end
    end
  end
end