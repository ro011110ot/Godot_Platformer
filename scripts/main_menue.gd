extends Control

# Path to your first level
const FIRST_LEVEL_PATH = "res://scenes/level_1.tscn"

func _ready() -> void:
	# Connect signals for the buttons
	$Menue/VBoxContainer/StartButton.pressed.connect(_on_start_pressed)
	$Menue/VBoxContainer/QuitButton.pressed.connect(_on_quit_pressed)
	
	# Grab focus for controller/keyboard support
	$Menue/VBoxContainer/StartButton.grab_focus()

func _on_start_pressed() -> void:
	# Switch to the first level scene
	get_tree().change_scene_to_file(FIRST_LEVEL_PATH)

func _on_quit_pressed() -> void:
	# Close the application
	get_tree().quit()
