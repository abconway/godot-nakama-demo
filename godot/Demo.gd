extends Node2D


onready var server_connection := $ServerConnection
onready var debug_panel := $CanvasLayer/DebugPanel

func _ready() -> void:
	var email := "test@test.com"
	var password := "password"
	
	debug_panel.write_message("Authenticating user %s: " % email)
	var result: int = yield(server_connection.authenticate_async(email, password), "completed")
	
	if result == OK:
		debug_panel.write_message("Authenticated user %s successfully." % email)
	else:
		debug_panel.write_message("Could not authenticate user %s." % email)
