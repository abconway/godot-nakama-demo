extends Node2D

const KEY := "defaultkey"
var _session: NakamaSession
var _client:= Nakama.create_client(KEY, "127.0.0.1", 7350, "http")
var _socket: NakamaSocket


func authenticate_async(email: String, password: String) -> int:
	var result := OK
	
	var new_session: NakamaSession = yield(_client.authenticate_email_async(email, password, null, true), "completed")
	if not new_session.is_exception():
		_session = new_session
	else:
		result = new_session.get_exception().status_code
	
	return result


func connect_to_server_async() -> int:
	_socket = Nakama.create_socket_from(_client)
	var result : NakamaAsyncResult = yield(_socket.connect_async(_session), "completed")
	if not result.is_exception():
		_socket.connect("closed", self, "_on_NakamaSocket_closed")
		return OK
	return ERR_CANT_CONNECT


func _on_NakamaSocket_closed() -> void:
	_socket = null
