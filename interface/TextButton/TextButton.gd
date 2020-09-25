#* A siple text button
#! ATTENTION! Most of logic here is a hack, as the base logic of Button node is ruined by mouse hovering.
#! I hope the problem will be solved in the future.
# TODO check if the hovering bug is fixed.

extends Button
class_name ButtonText

export(bool) var is_focused_on_ready := false
export(bool) var enable_mouse_warp := false
export(Color) var font_color_normal = Color.whitesmoke
export(Color) var font_color_focus = Color.orange
export(Color) var font_color_hover = Color.orange # TODO add color change on hover
export(Color) var font_color_press = Color.yellow
export(Color) var font_color_disable = Color.gray # TODO add color change on disable

var is_mouse_inside : bool = false

onready var buttonText : Label = $ButtonText


func _init() -> void:
	connect("mouse_entered", self, "_on_mouse_enter")
	connect("mouse_exited", self, "_on_mouse_exit")
	connect("focus_entered", self, "_on_focus_entered")
	connect("focus_exited", self, "_on_focus_exited")
	connect("button_down", self, "_on_button_down")
	connect("button_up", self, "_on_button_up")
	Events.connect("input_device_changed", self, "_switch_mouse_filter")

	

func _ready() -> void:
	if is_focused_on_ready:
		grab_focus()
	
	buttonText.text = text
	buttonText.visible = true
	text = ""
	
	if enable_mouse_warp:
		get_viewport().warp_mouse(rect_position)


func on_button_up() -> void:
	#* Write logic for your button in this function
	pass


func _on_mouse_enter() -> void:
	is_mouse_inside = true
	grab_focus()


func _on_mouse_exit() -> void:
	is_mouse_inside = false


func _on_focus_entered() -> void:
	_change_font_color(font_color_focus)


func _on_focus_exited() -> void:
	_change_font_color(font_color_normal)


func _on_button_down() -> void:
	_change_font_color(font_color_press)


func _on_button_up() -> void:
	_change_font_color(font_color_focus)
	on_button_up()


func _change_font_color(color: Color) -> void:
	buttonText.add_color_override("font_color", color)
		

func _switch_mouse_filter(_device_index: int) -> void:
	if InputManager.is_current_input_keyboard():
		mouse_filter = Control.MOUSE_FILTER_STOP
		return
		
	if InputManager.is_current_input_gamepad():
		mouse_filter = Control.MOUSE_FILTER_IGNORE
		return

