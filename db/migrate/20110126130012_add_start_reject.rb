class AddStartReject < ActiveRecord::Migration
  def self.up
    add_column :iteration_comments, :start, :integer
    add_column :iteration_comments, :reject, :integer
  end

  def self.down
    remove_column :iteration_comments, :start
    remove_column :iteration_comments, :reject
  end
end
