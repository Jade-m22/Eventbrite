class AddValidatedToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :validated, :boolean, default: false
  end
end
