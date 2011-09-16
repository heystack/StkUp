class CreateQas < ActiveRecord::Migration
  def self.up
    create_table :qas do |t|
      t.integer :stack_id
      t.string :qa_link
      t.string :qa_desc
      t.string :qa_target

      t.timestamps
    end
  end

  def self.down
    drop_table :qas
  end
end
