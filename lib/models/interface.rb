class Interface
    attr_accessor :prompt, :pokemon, :pokemon_instance, :chosen_pokemon

    def run
        Ascii.logo
        self.start
        puts "\n"
        self.train
    end

    def initialize
        @prompt = TTY::Prompt.new
    end

    def start 
        prompt.select("Welcome to Pokemon Trainer!",["Start"])
    end

    def self.learn_loading
        3.times do |x|
            print "｡･:*:･ﾟ"
            sleep(1)
        end
        sleep(1)
    end
    "1... 2... and... Poof!"
    def self.delete_loading
        print "1.. "
        sleep(1)
        print " 2.. "
        sleep(1)
        print "and.. "
        sleep(1)
        print "Poof!"
        sleep(1)
    end

    def select_pokemon
        @chosen_pokemon = prompt.select("Choose a pokemon to train", Pokemon.list_pokemon_names)
        @pokemon_instance = Pokemon.find_pokemon_instance(@chosen_pokemon)
        puts "\n"
        puts "#{@chosen_pokemon}'s current moves:"
        puts @pokemon_instance.list_moves_names
        puts "\n"
    end

    def train 
        self.select_pokemon
        response = prompt.select("Train #{@chosen_pokemon}?", ["Learn a new move", "Replace existing move", "Forget a move"])

        if response == "Learn a new move"
            self.learn_a_new_move
            self.continue_training_or_exit
        elsif response == "Replace existing move"
            self.update_move
            self.continue_training_or_exit
        elsif response == "Forget a move"
            self.delete_move
            self.continue_training_or_exit
        end
    end

    def display_moves
        prompt.select("Choose a move", Move.list_move_names)
    end

    def learn_a_new_move
        chosen_move = self.display_moves
        @pokemon_instance.teach_move(chosen_move)
    end

    def update_move 
        old_move = prompt.select("Select a move to replace", @pokemon_instance.list_moves_names)
        new_move = self.display_moves
        @pokemon_instance.update_move(old_move, new_move)
    end

    def delete_move 
        delete_move = prompt.select("Select a move to forget", @pokemon_instance.list_moves_names)
        @pokemon_instance.delete_move_from_pokemon(delete_move)
        puts @pokemon_instance.list_moves
    end

    def continue_training_or_exit
        answer = prompt.select("Continue training or exit?", ["Continue training", "Exit"])
        if answer == "Exit"
            puts "Come back and train any time!"
        elsif answer == "Continue training"
            puts "

           ⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒⌒

            "
            self.train
        end
    end
end