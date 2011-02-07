class IterationsController < ApplicationController
  unloadable
  before_filter :require_login, :except => :rss

  def rss
    @comments = IterationComment.find(:all, :order => 'created_at DESC')
    render :layout => false
    response.headers["Content-Type"] = "application/xml; charset=utf-8"
  end

  def list

    @status = !params[:status].nil? ? params[:status] : nil
    @iterations = Iteration.all
    if !@status.nil?
      @iterations = @iterations.select {|i| !i.status.nil? && i.status == @status }
    end

    if @status.nil? || @status == 'available'
      @iterations = @iterations.sort {|a,b| b.stakeholders.length <=> a.stakeholders.length}
    else
      @iterations = @iterations.sort {|a,b| a.updated_at <=> b.updated_at}
    end
  end

  def view
    @user = User.current
    @iteration = Iteration.find(params[:id])
    @comment = IterationComment.new({:iteration => @iteration}) 
    @comment.iteration = @iteration
    rescue ActiveRecord::RecordNotFound 
        render_404
  end

  def comment 
    @user = User.current
    @iteration = Iteration.find(params[:id])

    if params[:title] != @iteration.title
        @iteration.title = params[:title]
        @iteration.save
    end

    if params[:start]
        @iteration.status = 'in progress'
        @iteration.save
    elsif params[:reject]
        @iteration.status = 'rejected'
        @iteration.save
    elsif params[:complete]
        @iteration.status = 'completed'
        @iteration.save
    end

    params[:iteration_comment][:author] = @user
    params[:iteration_comment][:iteration] = @iteration
    @comment = IterationComment.new(params[:iteration_comment])

    if (params[:offer]) 
        @comment.offer = 1
    elsif (params[:support])
        @comment.support = 1
    elsif (params[:start])
        @comment.start = 1
    elsif (params[:reject])
        @comment.reject = 1
    elsif (params[:complete])
        @comment.complete = 1
    end

    @comment.save
    redirect_to :action => :view, :id => @iteration.id

    rescue ActiveRecord::RecordNotFound 
        render_404
  end  

  def suggest 
    @user = User.current
    @iteration = Iteration.new
  end

  def create
    @user = User.current
    @iteration = Iteration.new
    @iteration.author = @user
    @iteration.title = params[:title]
    @iteration.status = 'available'
    @iteration.save
    @iterationComment = IterationComment.new
    @iterationComment.author = @user
    @iterationComment.iteration = @iteration
    @iterationComment.comments = params[:comments]
    @iterationComment.support = 1
    if params[:offer]
        @iterationComment.offer = 1
    end
    @iterationComment.save

    redirect_to :action => :view, :id => @iteration.id
  end
end
