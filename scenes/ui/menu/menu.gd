extends Control

onready var campaign_button = $"campaign_button"
onready var skirmish_button = $"skirmish_button"
onready var editor_button = $"editor_button"
onready var settings_button = $"settings_button"
onready var quit_button = $"quit_button"
onready var animations = $"animations"
onready var gamepad_adapter = $"/root/GamepadAdapter"

onready var switcher = $"/root/SceneSwitcher"
onready var audio = $"/root/SimpleAudioLibrary"

var main_menu
var recent_button_used = null

func _ready():
    self.campaign_button.grab_focus()

func bind_menu(menu):
    self.main_menu = menu

func _on_skirmish_button_pressed():
    self.recent_button_used = self.skirmish_button
    self.audio.play("menu_click")
    self.main_menu.open_picker()

func _on_editor_button_pressed():
    self.recent_button_used = self.editor_button
    self.audio.stop()
    self.gamepad_adapter.disable()
    self.switcher.map_editor()

func _on_settings_button_pressed():
    self.recent_button_used = self.settings_button
    self.audio.play("menu_click")
    self.main_menu.open_settings()

func _on_campaign_button_pressed():
    self.recent_button_used = self.campaign_button
    self.audio.play("menu_click")
    self.main_menu.open_campaign_selection()

func _on_quit_button_pressed():
    self.get_tree().quit()

func show_panel():
    self.animations.play("show")
    yield(self.get_tree().create_timer(0.1), "timeout")

    if self.recent_button_used != null:
        self.recent_button_used.grab_focus()
    else:
        self.campaign_button.grab_focus()

func hide_panel():
    self.animations.play("hide")
