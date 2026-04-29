extends Area2D

var word: String

func set_word(w:String):
	word = w
	$Label.text = word
