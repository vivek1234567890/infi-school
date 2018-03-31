class AddSignatoryEmailToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :signatory_email, :string
  end
end
