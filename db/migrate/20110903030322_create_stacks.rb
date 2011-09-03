class CreateStacks < ActiveRecord::Migration
  def self.up
    create_table :stacks do |t|
      t.integer :interest_id
      t.string :question
      t.string :question_subtext
      t.string :chart_type
      t.string :choice_picker_type
      t.integer :created_by

      t.timestamps
    end
    add_index :stacks, :stack_id
    add_index :stacks, :created_by
  end

  def self.down
    drop_table :stacks
  end
end
