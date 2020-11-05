extends Node2D

onready var animations = $"animations"
onready var label_node = $"label"
onready var label_text = $"label/label"

export var analog_axis_x = JOY_ANALOG_LX
export var analog_axis_y = JOY_ANALOG_LY
export var device_id = 0

var fields = []
var focused_field = null

func _ready():
    self.fields = [
        $"fields/field1",
        $"fields/field2",
        $"fields/field3",
        $"fields/field4",
        $"fields/field5",
        $"fields/field6",
        $"fields/field7",
        $"fields/field8",
    ]
    self.set_process_input(false)

func _input(event):
    var axis_value = Vector2()

    axis_value.x = Input.get_joy_axis(self.device_id, self.analog_axis_x)
    axis_value.y = Input.get_joy_axis(self.device_id, self.analog_axis_y)

    if axis_value.length() > 0.5:
        var angle = rad2deg(axis_value.angle()) + 112.5
        if angle < 0.0:
            angle += 360
        
        angle = int(round(angle))

        var option = (angle - (angle % 45)) / 45

        self.focus_field(option)

        if event.is_action_pressed("ui_accept"):
            self.execute_focused_field()

    else:
        self.unfocus_field()

func show_menu():
    self.animations.play("show")
    self.set_process_input(true)

func hide_menu():
    self.animations.play("hide")
    self.set_process_input(false)
    self.unfocus_field()

func set_field(icon, new_label, index):
    self.fields[index].set_field(icon, new_label)

func focus_field(index):
    if index >= self.fields.size():
        return
    if self.fields[index].focused:
        return

    self.unfocus_field()

    if not self.fields[index].is_assigned():
        return

    self.fields[index].focus()
    self.show_label(self.fields[index].label)
    self.focused_field = self.fields[index]

func unfocus_field():
    if self.focused_field != null:
        self.focused_field.unfocus()
    self.hide_label()
    self.focused_field = null

func show_label(new_label):
    self.label_node.show()
    self.label_text.set_text(new_label)

func hide_label():
    self.label_node.hide()


func execute_focused_field():
    if self.focused_field == null:
        return

    self.focused_field.execute_bound_method()