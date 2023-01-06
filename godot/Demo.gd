extends Node2D


onready var server_connection := $ServerConnection
onready var debug_panel := $CanvasLayer/DebugPanel


func _ready() -> void:
	yield(request_authentication(), "completed")
	yield(connect_to_server(), "completed")


func request_authentication() -> void:
	var email := "test@test.com"
	var password := "password"
	
	debug_panel.write_message("Authenticating user %s: " % email)
	var result: int = yield(server_connection.authenticate_async(email, password), "completed")
	
	if result == OK:
		debug_panel.write_message("Authenticated user %s successfully." % email)
	else:
		debug_panel.write_message("Could not authenticate user %s." % email)


func connect_to_server() -> void:
	var result: int = yield(server_connection.connect_to_server_async(), "completed")
	if result == OK:
		debug_panel.write_message("Connected to the server.")
	elif ERR_CANT_CONNECT:
		debug_panel.write_message("Could not connect to server.")
