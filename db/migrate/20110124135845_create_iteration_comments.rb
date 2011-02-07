class CreateIterationComments < ActiveRecord::Migration
  def self.up
    create_table :iteration_comments do |t|
      t.column :iteration_id, :integer
      t.column :author_id, :integer
      t.column :comments, :text
      t.column :support, :integer
      t.column :offer, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :iteration_comments
  end
end
