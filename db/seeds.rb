Pokemon.destroy_all
Move.destroy_all
Training.destroy_all

#Pokemon
Pokemon.create(name:"Sylveon", poke_type:"Fairy", dex_num:700)
Pokemon.create(name:"Blastoise", poke_type:"Water", dex_num:9)
Pokemon.create(name:"Ampharos", poke_type:"Electric", dex_num:181)
Pokemon.create(name:"Venusaur", poke_type:"Grass/Poison", dex_num:3)
Pokemon.create(name:"Charizard", poke_type:"Fire", dex_num:6)
Pokemon.create(name:"Raichu", poke_type:"Electric", dex_num:26)
Pokemon.create(name:"Sandslash", poke_type:"Ground", dex_num:28)
Pokemon.create(name:"Ninetales", poke_type:"Fire", dex_num:38)
Pokemon.create(name:"Muk", poke_type:"Poison", dex_num:89)
Pokemon.create(name:"Gengar", poke_type:"Ghost", dex_num:94)
Pokemon.create(name:"Gyarados", poke_type:"Water/Flying", dex_num:130)
Pokemon.create(name:"Lapras", poke_type:"Water/Ice", dex_num:131)
Pokemon.create(name:"Eevee", poke_type:"Normal", dex_num:133)
Pokemon.create(name:"Dragonite", poke_type:"Dragon", dex_num:149)
Pokemon.create(name:"Sudowoodo", poke_type:"Rock", dex_num:185)
Pokemon.create(name:"Absol", poke_type:"Dark", dex_num:359)
Pokemon.create(name:"Alakazam", poke_type:"Psychic", dex_num:65)
Pokemon.create(name:"Lucario", poke_type:"Fighting/Steel", dex_num:448)
Pokemon.create(name:"Flygon", poke_type:"Ground/Dragon", dex_num:330)
Pokemon.create(name:"Scizor", poke_type:"Bug/Steel", dex_num:212)



#Moves

Move.create(name: "Return", move_type:"Normal", category: "Physical")
Move.create(name: "Draining Kiss", move_type: "Fairy", category: "Special")
Move.create(name: "Hydro Pump", move_type: "Water", category: "Special")
Move.create(name: "Thunder Punch", move_type: "Electric", category: "Physical")
Move.create(name: "Fly", move_type: "Flying", category:"Physical")
Move.create(name: "Roar", move_type: "Normal", category:"Status")
Move.create(name: "X-Scissor", move_type: "Bug", category: "Physical")
Move.create(name: "Crunch", move_type: "Dark", category: "Physical")
Move.create(name: "Draco Meteor", move_type: "Dragon", category: "Special")
Move.create(name: "Double Kick", move_type: "Fighting", category: "Physical")
Move.create(name: "Flamethrower", move_type: "Fire", category: "Special")
Move.create(name: "Shadow Ball", move_type: "Ghost", category: "Special")
Move.create(name: "Giga Drain", move_type: "Grass", category: "Special")
Move.create(name: "Earthquake", move_type: "Ground", category: "Physical")
Move.create(name: "Ice Beam", move_type: "Ice", category: "Special")
Move.create(name: "Psychic", move_type: "Psychic", category: "Special")
Move.create(name: "Toxic", move_type: "Poison", category: "Status")
Move.create(name: "Swords Dance", move_type: "Normal", category: "Status")