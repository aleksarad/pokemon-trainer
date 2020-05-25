require_relative '../config/environment'

interface = Interface.new
interface.train
interface.continue_training_or_exit