class AddComplete < ActiveRecord::Migration
  def self.up
    add_column :iteration_comments, :complete, :integer
  end

  def self.down
    remove_column :iteration_comments, :complete
  end
end
