#* This is a basic menu controller class. It contains basic functions.
#* Inherit all menu scripts from this class

extends Control
class_name Menu

export(bool) var is_active := true setget _set_is_active

var menu_buttons : Array


func _set_menu_buttons(menu_node: Control) -> void:
	menu_buttons = menu_node.get_children()


func _set_is_active(value: bool) -> void:
	is_active = value
	visible = value
	_set_buttons_active(value)


func _set_buttons_active(value: bool) -> void:
	for button in menu_buttons:
		button.is_active = value


func _focus_first_button() -> void:
	_focus_button(0)


func _focus_button(button_index: int) -> void:
	menu_buttons[button_index].grab_focus()


func _release_focus() -> void:
	if get_focus_owner():
		get_focus_owner().release_focus()
