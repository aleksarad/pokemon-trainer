require "colorize"

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

    ##Functionality
    #Menus

    #select pokemon to train menu
    def select_pokemon
        self.chosen_pokemon = prompt.select("Choose a pokemon to train", Pokemon.list_pokemon_names)
        self.pokemon_instance = Pokemon.find_pokemon_instance(self.chosen_pokemon)
        puts "\n"
    end

    #type of training menu
    def train 
        Interface.clear
        self.current_pokemon_stats
        response = prompt.select("Train #{self.chosen_pokemon}?", ["Learn a new move", "Replace existing move", "Forget a move"])

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
        answer = prompt.select("Continue training or exit?", ["Continue training #{self.chosen_pokemon}", "Train another pokemon", "Exit"])
        if answer == "Exit"
            self.exit_music_and_message
        elsif answer == "Continue training #{self.chosen_pokemon}"
            puts "\n"
            self.train
        elsif answer == "Train another pokemon"
            Interface.clear
            puts "\n"
            self.select_pokemon
            self.train
        end
    end

    #Functionality helpers
    def display_moves
        answer = prompt.select("Choose a move", Move.list_move_names)
        answer_arr = answer.split(' - ')
        remove_brackets = answer_arr[0].delete('[]')
    end

    def learn_a_new_move
        if self.pokemon_instance.moves.length < 4
            chosen_move = self.display_moves
            self.pokemon_instance.teach_move(chosen_move)
        else
            puts "\n Max moves learned! \n".colorize(:light_red)
        end
    end

    def update_move 
        if pokemon_instance.moves.length !=0
            old_move = prompt.select("Select a move to replace", self.pokemon_instance.list_moves_names)
            new_move = self.display_moves
            self.pokemon_instance.update_move(old_move, new_move)
        else 
            puts "\n #{self.chosen_pokemon} doesn't know any moves to replace! \n".colorize(:red)
        end
    end

    def delete_move 
        if pokemon_instance.moves.length !=0
            delete_move = prompt.select("Select a move to forget", self.pokemon_instance.list_moves_names)
            self.pokemon_instance.delete_move_from_pokemon(delete_move)
        else 
            puts "\n #{self.chosen_pokemon} doesn't know any moves yet! \n".colorize(:red)
        end
    end

    def current_pokemon_stats
        puts " #{self.chosen_pokemon} ".colorize(:black).on_green
        puts "Type: #{self.pokemon_instance.poke_type}"
        puts "Current Moves:"
        puts self.pokemon_instance.list_moves_names
        puts "\n"
    end


    #CLI Helpers
    def start 
        prompt.select("These daycare pokemon need your help learning some moves. They're counting on you!",["Start"])
        puts `afplay 'lib/music/SFX_Selection_Click_Beep_rdblu.mp3'`
    end

    def self.learn_loading
        puts "\n"
        3.times do |x|
            print "｡･:*:･ ﾟ".colorize(:yellow)
            sleep(1)
        end
        sleep(1)
    end

    def self.delete_loading
        puts "\n"
        print "1.. ".colorize(:yellow)
        sleep(1)
        print " 2.. ".colorize(:yellow)
        sleep(1)
        print "and.. ".colorize(:yellow)
        sleep(1)
        print "Poof! ".colorize(:yellow)
        sleep(1)
    end

    def self.clear
        system "clear"
        Ascii.logo
    end

    def exit_music_and_message
        Interface.clear
        puts "\n The pokemon look so happy, please come back and train soon! \n".colorize(:green)
        Ascii.pikachu
        puts `afplay 'lib/music/pikachu.mp3'`
    end

end
