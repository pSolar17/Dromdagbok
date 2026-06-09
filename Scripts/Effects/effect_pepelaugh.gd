extends Effect

const descriptions = [
	"He doesn't know",
	"Он не знает",
	"彼は知りません",
	"他不知道",
	"Il ne sait pas",
	"Hän ei tiedä",
	"Han vet inte",
	"Anh ấy không biết",
	"Δεν ξέρει",
	"Ta ei tea",
	"Hij weet het niet",
	"Han ved det ikke",
	"On neví",
	"On ne zna",
	"Той не знае",
	"Ён не ведае",
	"Նա չգիտի",
	"هو لا يعرف",
	"Hy weet nie",
	"Er weiß es nicht",
	"მან არ იცის",
	"הוא לא יודע",
	"उसको नहीं मालूम",
	"Nem tudja",
	"Hann veit það ekki",
	"Non lo sa",
	"Ол білмейді",
	"그는 모른다",
	"Viņš nezina",
	"Jis nežino",
	"On nie wie",
	"Ele não sabe",
	"El nu știe",
	"El no lo sabe",
	"O bilmiyor",
	"Він не знає",
	"Akazi"
]

func get_effect_desc():
	return descriptions.pick_random()
