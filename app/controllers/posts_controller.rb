class PostsController < ApplicationController
	before_filter :authenticate_user!
	def new
		@post = Post.new();
	end

	/def index
		@posts = Post.all
	end/
	def index
  		@posts = Post.all.page(params[:page]).per(5)
	end
	
	def create
		@post = Post.new(params[:post].permit(:title, :text))

		if @post.save
			redirect_to @post
		else
			render 'new'
		end
	end

	def show
		@post = Post.find(params[:id])
		@comentarios = @post.comments.page(params[:page]).per(1)
	end

	def edit
		@post = Post.find(params[:id])
	end

	def destroy
	  @post = Post.find(params[:id])
	  @post.destroy
	 
	  redirect_to posts_path
	end
	
	def update
	  @post = Post.find(params[:id])
	 
	  if @post.update(params[:post].permit(:title, :text))
	    redirect_to @post
	  else
	    render 'edit'
	  end
	end


	private 
		def post_params
			params.require(:post).permit(:title, :text)
		end
end
