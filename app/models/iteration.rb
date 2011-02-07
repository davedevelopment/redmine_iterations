class Iteration < ActiveRecord::Base
  unloadable

  has_many :comments, :dependent => :delete_all, :class_name => "IterationComment", :foreign_key => "iteration_id"
  has_many :votes, :dependent => :delete_all, :class_name => "IterationVote", :foreign_key => "iteration_id"
  belongs_to :author, :class_name => "User", :foreign_key => "author_id"


  def volunteers 
    comments.select {|c| c.offer? }.collect {|c| c.author}
  end

  def supporters
    comments.select {|c| c.support? }.collect {|c| c.author} - volunteers
  end

  def stakeholders
    s = comments.select {|c| c.support? || c.offer?}.sort {|a,b| a.author.lastname <=> b.author.lastname}
    s.reject {|c| c.support? && !c.offer? && volunteers.include?(c.author)}
  end 

  def non_empty_comments
    comments.select {|c| !c.comments.nil? && c.comments != '' }
  end
end
