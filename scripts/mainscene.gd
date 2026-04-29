extends Node

@onready var http_request = $WordapiRequester
var words = []

func _ready() -> void:
	fetch_words()

func fetch_words():
	var url = "https://random-words-api.kushcreates.com/api?language=es&category=countries&length=6&words=3"
	http_request.request(url)

func _on_wordapi_requester_request_completed(_result: int, response_code: int, _headers: PackedStringArray, body: PackedByteArray) -> void:
	if response_code == 200:
		var json = JSON.parse_string(body.get_string_from_utf8())
		for word_info in json:
			var word = word_info["word"] 
			words.append(word)
		print("Fetched words: ", words)
		spawn_words()
	else: 
		print("failed")
		
func spawn_words():
	for word in words:
		var word_node = preload("res://scenes/Word.tscn").instantiate()
		word_node.set_word(word)
		word_node.position = Vector2(randf_range(100, 1000), randf_range(-100, 100))
		add_child(word_node)
		
