extends Control

signal message_sent(text) 

@onready var input_field = $ModalWindow/MainVBox/DialogueInput
@onready var output_label = $ModalWindow/MainVBox/TopHBox/DialogueScroll/OutputLabel

func _ready():
	output_label.append_text("[b][color=#53EBE4]Stranger:[/color][/b] Привіт. Ти тут новенький?[br]\n\n")

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_ENTER and input_field.has_focus():
		_send_message()
		get_viewport().set_input_as_handled()

func _send_message():
	var msg = input_field.text.strip_edges()
	if msg == "": return
	
	output_label.append_text("[b]Player:[/b] " + msg + "\n")
	message_sent.emit(msg)
	input_field.clear()
