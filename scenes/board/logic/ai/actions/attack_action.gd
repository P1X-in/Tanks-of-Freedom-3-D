extends "res://scenes/board/logic/ai/actions/abstract_action.gd"

var unit
var interaction
var target
var path_length

func _init(unit_tile, interaction_tile, target_tile, path_length_val):
    self.unit = unit_tile
    self.interaction = interaction_tile
    self.target = target_tile
    self.path_length = path_length_val

func perform(board):
    board.select_tile(self.unit.position)
    if self.interaction != null:
        board.select_tile(self.interaction.position)
        yield(board.get_tree().create_timer(self.path_length * 0.1), "timeout")
    board.select_tile(self.target.position)
    board.unselect_tile()
