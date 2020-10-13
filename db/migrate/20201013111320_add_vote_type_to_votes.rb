class AddVoteTypeToVotes < ActiveRecord::Migration[5.2]
  def change
    add_column :votes, :vote_type, :integer
  end
end
