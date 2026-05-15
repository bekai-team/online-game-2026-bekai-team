extends Button

@export var quest_id: String = "quest_001"
@export var quest_title: String = "Перші кроки"

func _on_pressed() -> void:
	if has_node("/root/QuestManager"):
		get_node("/root/QuestManager").accept_quest(quest_id, quest_title)
		
		disabled = true
		text = "Взято"
