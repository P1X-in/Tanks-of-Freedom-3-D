extends Control

onready var audio = $"/root/SimpleAudioLibrary"
onready var settings = $"/root/Settings"

onready var label = $"label"
onready var button = $"toggle"

export var option_name = ""
export var option_key = ""

func _ready():
    self.label.set_text(self.option_name)
    self._read_setting()

func _read_setting():
    var value = self.settings.get_option(self.option_key)

    match value:
        null:
            self.button.set_text("???")
            self.button.set_disabled(true)
        true:
            self.button.set_text("ON")
        false:
            self.button.set_text("OFF")

func _on_toggle_button_pressed():
    self.audio.play("menu_click")
    self.settings.set_option(self.option_key, not self.settings.get_option(self.option_key))
    self._read_setting()
