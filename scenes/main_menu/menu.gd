extends Control

func _ready():
	# Called every time the node is added to the scene.
	GameState.connect("connection_failed", self, "_on_connection_failed")
	GameState.connect("connection_succeeded", self, "_on_connection_success")
	GameState.connect("player_list_changed", self, "refresh_lobby")
	GameState.connect("game_ended", self, "_on_game_ended")
	GameState.connect("game_error", self, "_on_game_error")

func _process(delta):
	if (Input.is_action_just_pressed("ui_cancel")):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().quit()

func _on_host_pressed():
	if $Connect/Name.text == "":
		$Connect/ErrorLabel.text = "Invalid name!"
		return

	$Connect.hide()
	$Players.show()
	$Connect/ErrorLabel.text = ""

	var player_name = $Connect/Name.text
	GameState.host_game(player_name)
	refresh_lobby()

func _on_join_pressed():
	if $Connect/Name.text == "":
		$Connect/ErrorLabel.text = "Invalid name!"
		return

	var ip = $Connect/IP.text
	if not ip.is_valid_ip_address():
		$Connect/ErrorLabel.text = "Invalid IPv4 address!"
		return

	$Connect/ErrorLabel.text=""
	$Connect/HostButton.disabled = true
	$Connect/JoinButton.disabled = true

	var player_name = $Connect/Name.text
	GameState.join_game(ip, player_name)
	# refresh_lobby() gets called by the player_list_changed signal

func _on_connection_success():
	$Connect.hide()
	$Players.show()

func _on_connection_failed():
	$Connect/HostButton.disabled = false
	$Connect/JoinButton.disabled = false
	$Connect/ErrorLabel.set_text("Connection failed.")

func _on_game_ended():
	show()
	$Connect.show()
	$Players.hide()
	$Connect/HostButton.disabled = false
	$Connect/JoinButton.disabled

func _on_game_error(errtxt):
	$Error.dialog_text = errtxt
	$Error.popup_centered_minsize()

func refresh_lobby():
	var players = GameState.get_player_list()
	players.sort()
	$Players/List.clear()
	$Players/List.add_item(GameState.get_player_name() + " (You)")
	for p in players:
		$Players/List.add_item(p)

	$Players/StartButton.disabled = not get_tree().is_network_server()

func _on_start_pressed():
	GameState.begin_game()
