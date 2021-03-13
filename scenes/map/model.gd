
const SIZE = 40

var tile_template = preload("res://scenes/map/tile.gd")

var tiles = {}
var scripts = {}

func _init():
    for x in range(self.SIZE):
        for y in range(self.SIZE):
            self.tiles[str(x) + "_" + str(y)] = self.tile_template.new(x, y)
    self.connect_neightbours()

func get_tile(position):
    return self.tiles[str(position.x) + "_" + str(position.y)]

func get_tile2(x, y):
    return self.tiles[str(x) + "_" + str(y)]

func get_dict():
    var tiles_dict = {}
    for i in self.tiles.keys():
        if self.tiles[i].has_content():
          tiles_dict[i] = self.tiles[i].get_dict()

    return {
        "metadata" : {},
        "tiles" : tiles_dict,
        "scripts" : self.scripts
    }

func connect_neightbours():
    var tile

    for x in range(self.SIZE):
        for y in range(self.SIZE):

            tile = self.get_tile2(x, y)

            if x > 0:
                tile.add_neighbour(tile.WEST, self.get_tile2(x-1, y))

            if x < self.SIZE - 1:
                tile.add_neighbour(tile.EAST, self.get_tile2(x+1, y))

            if y > 0:
                tile.add_neighbour(tile.NORTH, self.get_tile2(x, y-1))

            if y < self.SIZE - 1:
                tile.add_neighbour(tile.SOUTH, self.get_tile2(x, y+1))


func get_player_units(side):
    var units = []
    for i in self.tiles.keys():
        if self.tiles[i].has_friendly_unit(side):
            units.append(self.tiles[i].unit.tile)

    return units

func get_player_buildings(side):
    var buildings = []
    for i in self.tiles.keys():
        if self.tiles[i].has_friendly_building(side):
            buildings.append(self.tiles[i].building.tile)

    return buildings

func get_player_units_tiles(side):
    var units = []
    for i in self.tiles.keys():
        if self.tiles[i].has_friendly_unit(side):
            units.append(self.tiles[i])

    return units

func get_player_buildings_tiles(side):
    var buildings = []
    for i in self.tiles.keys():
        if self.tiles[i].has_friendly_building(side):
            buildings.append(self.tiles[i])

    return buildings

func get_enemy_units_tiles(side):
    var units = []
    for i in self.tiles.keys():
        if self.tiles[i].has_enemy_unit(side):
            units.append(self.tiles[i])

    return units

func get_enemy_buildings_tiles(side):
    var buildings = []
    for i in self.tiles.keys():
        if self.tiles[i].has_enemy_building(side):
            buildings.append(self.tiles[i])

    return buildings

func ingest_scripts(incoming_scripts):
    if incoming_scripts == null:
        return

    self.scripts = incoming_scripts

func get_player_bunker_position(side):
    for i in self.tiles.keys():
        if self.tiles[i].has_friendly_hq(side):
            return self.tiles[i].position

    return null

func get_player_bunkers(side):
    var bunkers = []

    for i in self.tiles.keys():
        if self.tiles[i].has_friendly_hq(side):
            bunkers.append(self.tiles[i])

    return bunkers
