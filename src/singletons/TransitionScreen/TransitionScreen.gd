extends CanvasLayer

const MIN_CUTOFF: float = 0.0
const MAX_CUTOFF: float = 1.0
const TRANSITION_DURATION: float = 0.75

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


func _on_TransitionTween_tween_all_completed() -> void:
	stateMachine.transition_to(target_state)
	set_transition_mask(null)

	
func _ready() -> void:
	stateMachine.set_physics_process(false)


func start_transition() -> void:
	if !stateMachine.is_current_state(state_transition):
		target_state = state_opened if stateMachine.is_current_state(state_closed) else state_closed
		#Switching masks
		randomize()
		var new_mask: = load(masks[randi() % masks.size()])
		set_transition_mask(new_mask)
		
		#Tween activation
		match target_state:
			state_opened:
				activate_tween(MIN_CUTOFF, MAX_CUTOFF)
			state_closed:
				activate_tween(MAX_CUTOFF, MIN_CUTOFF)
		
		stateMachine.transition_to(state_transition)


func set_cutoff(value: float) -> void:
	value = clamp(value, MIN_CUTOFF, MAX_CUTOFF)
	screen_shader.set_shader_param("cutoff", value)


func activate_tween(initial_value: float, target_value: float) -> void:
# warning-ignore:return_value_discarded
	transitionTween.interpolate_method(
		self,
		"set_cutoff",
		initial_value,
		target_value,
		TRANSITION_DURATION,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN
	)
# warning-ignore:return_value_discarded
	transitionTween.start()


func set_transition_mask(new_mask: Texture) -> void:
	screen_shader.set_shader_param("mask", new_mask)

