
const PLAYER_HUMAN = "human"
const PLAYER_AI = "ai"


var current_player = 0
var turn = 1

var players = []



func add_player(type, side):
    self.players.append({
        "type": type,
        "side": side,
        "ap" : 0,
        "alive" : true
    })


func switch_to_next_player():
    self.current_player += 1
    if self.current_player >= self.players.size():
        self.current_player = 0
        self.turn += 1

    if not self.is_current_player_alive():
        self.switch_to_next_player()

func get_current_player():
    return self.players[self.current_player]

func get_current_ap():
    return self.get_current_param("ap")

func get_current_side():
    return self.get_current_param("side")

func get_current_param(param_name):
    var player_data = self.get_current_player()
    return player_data[param_name]

func add_player_ap(id, value):
    self.players[id]["ap"] += value

func use_player_ap(id, value):
    self.players[id]["ap"] -= value

func use_current_player_ap(value):
    self.use_player_ap(self.current_player, value)

func add_current_player_ap(value):
    self.add_player_ap(self.current_player, value)

func can_current_player_afford(amount):
    return self.get_current_ap() >= amount

func is_current_player_ai():
    return self.get_current_param("type") == self.PLAYER_AI

func is_current_player_alive():
    return self.get_current_param("alive")

func eliminate_player(side):
    var index = 0

    while index < self.players.size():
        if self.players[index]['side'] == side:
            self.players[index]['alive'] = false
            return
        index += 1

func count_alive_players():
    var amount = 0

    for player in self.players:
        if player["alive"]:
            amount += 1

    return amount
