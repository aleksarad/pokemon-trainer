class Move < ActiveRecord::Base
    has_many :trainings
    has_many :pokemons, through: :trainings

    def self.list_move_names
        Move.all.collect{|move| move.name}
    end
end