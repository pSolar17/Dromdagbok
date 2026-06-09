extends Resource
class_name TextWriter

## A text-writing tool that allows developers to display text with custom behavior.
## Supports colored text, text speed, and so much more.
## Doesn't need to be in the tree to work.

var rt_label : RichTextLabel = null
## Text that will be displayed.
var text : String = ""
## Text speed in characters/sec.
var text_speed : int = 25
## Set internally.
var writing = false

func _init(rich_text_label : RichTextLabel, text_to_write : String, text_speed : int = 25):
	self.rt_label = rich_text_label
	self.text = text_to_write
	self.text_speed = text_speed

func start():
	if not is_instance_valid(rt_label):
		print("%s ERROR: Invalid instance of RichTextLabel provided." % self)
		return
