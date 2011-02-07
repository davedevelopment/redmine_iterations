class CreateIterations < ActiveRecord::Migration
  def self.up
    create_table :iterations do |t|
      t.column :title, :string
      t.column :status, :string
      t.column :author_id, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :iterations
  end
end
