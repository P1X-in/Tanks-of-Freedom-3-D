extends "res://scenes/board/logic/scripting/outcomes/base_outcome.gd"

var where
var template_name = null
var type
var rotation = 0

func _execute(_metadata):
    var tile = self.board.map.model.get_tile(self.where)

    if self.type == "decoration":
        tile.decoration.clear()
        self.board.map.builder.place_decoration(self.where, self.template_name, self.rotation)
    elif self.type == "frame":
        tile.frame.clear()
        self.board.map.builder.place_frame(self.where, self.template_name, self.rotation)
    elif self.type == "terrain":
        tile.terrain.clear()
        self.board.map.builder.place_terrain(self.where, self.template_name, self.rotation)

    self.board.audio.play("menu_click")

func _ingest_details(details):
    self.where = Vector2(details['where'][0], details['where'][1])
    self.template_name = details['template']
    self.type = details['type']
    if details.has('rotation'):
        self.rotation = details['rotation']
