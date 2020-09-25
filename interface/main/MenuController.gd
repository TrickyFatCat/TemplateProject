#* This script controls focus of buttons which are its children

extends Control

onready var buttons : Array = get_children()


# func _ready() -> void:
#     Events.connect("input_device_changed", self, "_switch_focus")
#     # _focus_button(0)
#     pass


# func _focus_button(button_index: int = 0) -> void:
#     buttons[button_index].grab_focus()


# func _unfocus_button(button_index: int) -> void:
#     buttons[button_index].release_focus()


# func _switch_focus(_device_index) -> void:
#     if InputManager.is_current_input_gamepad():
#         _focus_button(0)
#         return