class RemoveUniqueIndexFromPrecatoriosOnCredorId < ActiveRecord::Migration[6.1]
  def change
    remove_index :precatorios, :credor_id
  end
end
