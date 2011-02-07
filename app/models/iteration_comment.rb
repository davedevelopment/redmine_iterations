class IterationComment < ActiveRecord::Base
  unloadable

  belongs_to :iteration, :class_name => "Iteration", :foreign_key => "iteration_id"
  belongs_to :author, :class_name => "User", :foreign_key => "author_id"
end
