class AddGitHubFieldsToRepository < ActiveRecord::Migration[7.0]
  def change
    add_column :repositories, :github_id, :integer
    add_column :repositories, :full_name, :string
    add_column :repositories, :private, :boolean
    add_column :repositories, :github_created_at, :datetime
    add_column :repositories, :github_updated_at, :datetime
    add_column :repositories, :github_push_at, :datetime
    add_column :repositories, :default_branch, :string
  end
end
