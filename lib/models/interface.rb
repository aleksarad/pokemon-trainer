class Interface
    attr_accessor :prompt, :pokemon, :pokemon_instance, :chosen_pokemon

    def initialize
        @prompt = TTY::Prompt.new
    end

    #Main Runner Method
    def run
        Ascii.logo
        self.start
        puts "\n"
        self.select_pokemon
        self.train
    end

    #CLI Helpers
    def start 
        prompt.select("These pokemon need your help learning some moves. They're counting on you!",["Start"])
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

    ##Functionality
    #Menus

    #select pokemon to train menu
    def select_pokemon
        @chosen_pokemon = prompt.select("Choose a pokemon to train", Pokemon.list_pokemon_names)
        @pokemon_instance = Pokemon.find_pokemon_instance(@chosen_pokemon)
        puts "\n"
    end

    #type of training menu
    def train 
        self.current_pokemon_stats
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

    #continue training or exit menu
    def continue_training_or_exit
        answer = prompt.select("Continue training or exit?", ["Continue training #{@chosen_pokemon}", "Train another pokemon", "Exit"])
        if answer == "Exit"
            puts "Come back and train any time!"
        elsif answer == "Continue training #{@chosen_pokemon}"
            puts "\n"
            self.train
        elsif answer == "Train another pokemon"
            puts "\n"
            self.select_pokemon
            self.train
        end
    end

    #Functionality helpers
    def display_moves
        prompt.select("Choose a move", Move.list_move_names)
    end

    def learn_a_new_move
        if @pokemon_instance.moves.length < 4
            chosen_move = self.display_moves
            @pokemon_instance.teach_move(chosen_move)
        else
            puts "\n"
            puts "Max moves learned!"
            puts "\n"
        end
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

    def current_pokemon_stats
        puts "[#{@chosen_pokemon}]"
        puts "Type: #{@pokemon_instance.poke_type}"
        puts "Current Moves:"
        puts @pokemon_instance.list_moves_names
        puts "\n"
    end

end