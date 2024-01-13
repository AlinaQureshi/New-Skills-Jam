extends ColorRect

@export var textSpeed = 0.03

var dialog
var phraseNum : int = 0
var finished :bool = false

const dialogues = {
	"Intro" : [ "Why did I volunteer for this colonization project?", 
	"I feel so far from home... so alone.",
	"I have to find a way to communicate with this alien race.",
	"They need something... something that fits here...?",
	"If I can retrieve it, maybe we'll be able to communicate.",
	"But this oxygen only lasts so long..."
	],
	"Item1" : [
		"Four moons... I'll name them.",
		"Euro, Amerika, Asiana, and Afrikana.",
		"...So I never forget where I came from." ],
	"Item2" : [
		"Purple... a mixture of red and blue.",
		"A red fire that lights my way...",
		"To a clear blue sea of certainty.",
		"If only I could share my knowledge and where I came from." ],	
	"Item3" : [
		"It looks just like them...",
		"Perseus, Cassiopeia, Andromeda.",
		"We can't be all that different if our stars align."],	
}	

func SayDialogue(key: String):
	$Timer.wait_time = textSpeed
	dialog = getDialog(key)
	nextPhrase()

func _ready():
	$Timer.wait_time = textSpeed
	dialog = getDialog("Intro")
	nextPhrase()
	
func _process(_delta):
	if Input.is_action_just_pressed("advance_dialogue"):
		if finished:
			nextPhrase()
		else: 
			$Text.visible_characters = len($Text.text)

func getDialog(key: String) -> Array:
	return dialogues[key]

func nextPhrase():
	print(len(dialog))
	print (phraseNum)
	if phraseNum >= len(dialog):
		queue_free()
		return
	finished = false
	
	$Text.bbcode_text = dialog[phraseNum]

	$Text.visible_characters = 0
	while $Text.visible_characters < len($Text.text):
		$Text.visible_characters += 1
		$Timer.start()
		await $Timer.timeout
		
	finished = true
	phraseNum += 1
	return
