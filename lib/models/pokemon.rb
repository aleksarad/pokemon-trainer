class Pokemon < ActiveRecord::Base
    has_many :trainings
    has_many :moves, through: :trainings


    #Create
    def teach_move(move_name)
        new_move = Move.find_by name: move_name

        if !self.list_moves_names.include?(move_name)
            self.moves << new_move
            Interface.learn_loading
            puts "#{self.name} learned #{move_name}!".colorize(:light_cyan)
            puts `afplay 'lib/music/move_learned.mov'`
            puts self.list_moves
        else
           puts "#{self.name} already knows #{move_name}!".colorize(:light_red)
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
        ⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒        
       ".colorize(:cyan)
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
        Interface.delete_loading
        print " #{self.name} forgot #{old_move}!".colorize(:light_cyan)
        sleep(1)
        self.moves.delete(old_move_instance)
    end

    #Update
    def update_move(old_move, new_move)
        if !self.list_moves_names.include?(new_move)
            delete_move_from_pokemon(old_move)
            teach_move(new_move)
        else 
            puts "#{self.name} already knows #{new_move}!".colorize(:light_red) 
        end
    end
end

