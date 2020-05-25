class Interface
    attr_accessor :prompt, :pokemon, :chosen_pokemon

    def initialize
        @prompt = TTY::Prompt.new
    end

    def select_pokemon
        prompt.select("Choose a pokemon to train", Pokemon.list_pokemon_names)
    end

    def train 
        chosen_pokemon = self.select_pokemon

        response = prompt.select("Train #{chosen_pokemon}?", ["Learn a new move", "Replace existing move", "Unlearn a move"])
        pokemon_instance = Pokemon.find_pokemon_instance(chosen_pokemon)

        if response == "Learn a new move"
            #if moves.length > 4, do not allow a new move to be selected
            #if pokemon already knows this move "already knows move"
            chosen_move = self.display_moves
            pokemon_instance.teach_move(chosen_move)
            p pokemon_instance.list_moves
        elsif response == "Replace existing move"
            old_move = prompt.select("Select a move to replace", pokemon_instance.list_moves_names)
            new_move = self.display_moves
            pokemon_instance.update_move(old_move, new_move)
            p pokemon_instance.list_moves
        elsif response == "Unlearn a move"
            delete_move = prompt.select("Select a move to replace", pokemon_instance.list_moves_names)
            pokemon_instance.delete_move_from_pokemon(delete_move)
            p pokemon_instance.list_moves
        end
    end

    def display_moves
        prompt.select("Choose a move", Move.list_move_names)
    end

    def learn_a_new_move
    end

    def new_move_validation

    end
    
    def continue_training_or_exit
        answer = prompt.select("Continue training or exit?", ["Continue training", "Exit"])
        if answer == "Exit"
            p "Thank you! Come back and train anytime"
        else 
            self.train
        end
    end
end