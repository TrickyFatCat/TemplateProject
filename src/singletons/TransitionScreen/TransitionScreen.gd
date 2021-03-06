extends CanvasLayer

const MIN_CUTOFF: float = 0.0
const MAX_CUTOFF: float = 1.0
const TRANSITION_DURATION: float = 0.5

var target_state: String = ""
var masks: Array = [
	"res://materials/Transition/Masks/shader_mask_shards_1.png",
	"res://materials/Transition/Masks/shader_mask_shards_2.png",
	"res://materials/Transition/Masks/shader_mask_shards_3.png",
	"res://materials/Transition/Masks/shader_mask_shards_4.png"
]

onready var stateMachine: StateMachine = $StateMachine
onready var transitionTween: Tween = $TransitionTween
onready var screen: ColorRect = $ColorRect
onready var screen_shader: ShaderMaterial = screen.material
onready var state_opened: String = get_node("StateMachine/Opened").name
onready var state_closed: String = get_node("StateMachine/Closed").name
onready var state_transition: String = get_node("StateMachine/Transition").name

	
func _ready() -> void:
	transitionTween.connect("tween_all_completed", self, "_on_tween_completed")
	stateMachine.set_physics_process(false)
	

func start_transition() -> void:
	if stateMachine.is_current_state(state_transition):
		return

	target_state = state_opened if stateMachine.is_current_state(state_closed) else state_closed
	var cutoff_start = MIN_CUTOFF if target_state == state_opened else MAX_CUTOFF
	var cutoff_finish = MAX_CUTOFF if target_state == state_opened else MIN_CUTOFF
	_set_random_mask()
	_activate_tween(cutoff_start, cutoff_finish)
	stateMachine.transition_to(state_transition)


func is_transitionig() -> bool:
	return stateMachine.is_current_state(state_transition)


func _on_tween_completed() -> void:
	stateMachine.transition_to(target_state)
	_set_transition_mask(null)


func _set_cutoff(value: float) -> void:
	value = clamp(value, MIN_CUTOFF, MAX_CUTOFF)
	screen_shader.set_shader_param("cutoff", value)
	# print_debug(value)


func _activate_tween(initial_value: float, target_value: float) -> void:
# warning-ignore:return_value_discarded
	transitionTween.interpolate_method(
		self,
		"_set_cutoff",
		initial_value,
		target_value,
		TRANSITION_DURATION,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN
	)
# warning-ignore:return_value_discarded
	transitionTween.start()


func _set_transition_mask(new_mask: Texture) -> void:
	screen_shader.set_shader_param("mask", new_mask)


func _set_random_mask() -> void:
	randomize()
	var new_mask: = load(masks[randi() % masks.size()])
	_set_transition_mask(new_mask)