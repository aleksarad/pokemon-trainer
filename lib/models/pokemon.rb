class Pokemon < ActiveRecord::Base
    has_many :trainings
    has_many :moves, through: :trainings

    #CRUD methods
    def teach_move(move_name)
        new_move = Move.find_by name: move_name

        if !self.list_moves_names.include?(move_name)
            self.moves << new_move
            self.move_learned_animation_and_sound(move_name)
            self.list_moves
        else
           puts "#{self.name} already knows #{move_name}!".colorize(:light_red)
        end
    end

    def delete_move_from_pokemon(old_move)
        old_move_instance = self.moves.find_by name: old_move
        self.moves.delete(old_move_instance)
        self.move_deleted_animation_and_sound(old_move)
    end

    def update_move(old_move, new_move)
        if !self.list_moves_names.include?(new_move)
            delete_move_from_pokemon(old_move)
            teach_move(new_move)
            # self.move_updated_animation_and_sound(old_move, new_move)
        else 
            puts "#{self.name} already knows #{new_move}!".colorize(:light_red) 
        end

        #figure out why this isn't working on the interface end
        # if !self.list_moves_names.include?(new_move)
        #     old_move_id = find_id(old_move)
        #     new_move_id = find_id(new_move)
        #     training_instance = self.trainings.find_by move_id: old_move_id
        #     training_instance.update(move_id: new_move_id)
        # else 
        #     puts "#{self.name} already knows #{new_move}!".colorize(:light_red) 
        # end
        # self.list_moves
    end

    def find_id(move_name)
        move_instance = Move.all.find_by name: move_name
        move_instance.id
    end


    #move to interface?
    def list_moves
       names =  self.list_moves_names
       types = self.moves.collect{|move| move.move_type}
       category = self.moves.collect{|move| move.category}

       puts "

       #{self.name}'s Moves:
        
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

       ".colorize(:light_cyan)
    end

    #Helper Methods
    def list_moves_names
        self.moves.collect{|move| move.name}
    end

    def self.list_pokemon_names
        by_dex = self.all.sort_by {|pokemon| pokemon.dex_num}
        by_dex.collect {|pokemon| pokemon.name}
    end

    def self.find_pokemon_instance(pokemon_name)
        self.all.find{|pokemon| pokemon.name == pokemon_name}
    end

    def random_message
        ["#{self.name} looks sleepy.",
        "#{self.name} wants to keep training!",
        "#{self.name} yawned.", 
        "#{self.name} is excited!",
        "#{self.name} seems confused.",
        "#{self.name} is having fun!",
        "#{self.name} is surprised.", 
        "#{self.name} is pumped!",
        "#{self.name} fell asleep.",
        "#{self.name} looked around.",
        "#{self.name} seems to like you.",
        "#{self.name} found a snack.",
        "#{self.name} is jumping around!",
        "#{self.name} made a noise!"].sample
    end

    def move_learned_animation_and_sound(move_name)
        Interface.learn_loading
        puts "#{self.name} learned #{move_name}!".colorize(:light_cyan)
        puts `afplay 'lib/music/move_learned.mov'`
        # puts "\n #{self.random_message}"
    end

    def move_deleted_animation_and_sound(move_name)
        Interface.delete_loading
        print " #{self.name} forgot #{move_name}!".colorize(:light_cyan)
        puts `afplay 'lib/music/SFX_Faint_No_HP_IMDOWN_rbysph.mp3'`
        # puts "\n #{self.random_message}"
    end

    # def move_updated_animation_and_sound(old_move, new_move)
    #     Interface.learn_loading
    #     puts "#{self.name} forgot #{old_move} and learned #{new_move}!".colorize(:light_cyan)
    #     puts `afplay 'lib/music/move_learned.mov'`
    #     puts "\n #{self.random_message}"
    #     self.list_moves
    # end

end

