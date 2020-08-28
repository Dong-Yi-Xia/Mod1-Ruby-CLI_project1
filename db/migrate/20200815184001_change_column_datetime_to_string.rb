class ChangeColumnDatetimeToString < ActiveRecord::Migration[5.2]
  def change
    change_column :movies, :release_date, :string 
  end
end
