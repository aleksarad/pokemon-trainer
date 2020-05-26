class Pokemon < ActiveRecord::Base
    has_many :trainings
    has_many :moves, through: :trainings

    #Create
    def teach_move(move_name)
        new_move = Move.find_by name: move_name
        if self.moves.length < 4 && !self.list_moves_names.include?(move_name)
            self.moves << new_move
            puts self.list_moves
        elsif self.moves.length >= 4
            puts "Max moves learned"
        elsif self.list_moves_names.include?(move_name)
           puts "#{self.name} already knows #{move_name}!"
        end
    end

    #Read
    def list_moves
       names =  self.list_moves_names
       types = self.moves.collect{|move| move.move_type}
       category = self.moves.collect{|move| move.category}

       puts "
        ⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒
            #{names[0]}
                #{types[0]} #{category[0]}
        ⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒
            #{names[1]}
                #{types[1]} #{category[1]}
        ⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒
            #{names[2]}
                #{types[2]} #{category[2]}
        ⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒
            #{names[3]}
                #{types[3]} #{category[3]}
       "
    end

    def list_moves_names
        self.moves.collect{|move| move.name}
    end

    def self.list_pokemon_names
        self.all.collect{|pokemon| pokemon.name}
    end

    def self.find_pokemon_instance(pokemon_name)
        self.all.find{|pokemon| pokemon.name == pokemon_name}
    end

    #Delete
    def delete_move_from_pokemon(old_move)
        old_move_instance = self.moves.find_by name: old_move
        self.moves.delete(old_move_instance)
    end

    #Update
    def update_move(old_move, new_move)
        delete_move_from_pokemon(old_move)
        teach_move(new_move)
    end
end

