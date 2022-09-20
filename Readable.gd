extends Spatial
class_name Readable

export var queued_text = [
	str(
		"A very old grave", "\n",
		"the names and dates are not ledgible anymore"
	)
]

func interaction():
	return queued_text[0]

func interact(picker):
	pass
