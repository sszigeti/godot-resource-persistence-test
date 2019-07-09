extends MarginContainer


"""
Export template download URL: 
https://downloads.tuxfamily.org/godotengine/3.0.6/Godot_v3.0.6-stable_export_templates.tpz

Godot 3.0.6 download URL:
https://downloads.tuxfamily.org/godotengine/3.0.6/
"""


onready var debug = $Label
const DATAFILE_NAME = "res://my_data.var"
const TEST_VALUE = "Hello, this is a persisted variable"


func _ready():
	debug.text = ""
	var file_size = _get_data_file_size()
	if file_size == -1:
		debug.text += "Data file does not exist. Attempting to create it.\n"
		_create_data_file()
	else:
		debug.text += "OK, data file exists.\n"
	file_size = _get_data_file_size()
	debug.text += "The data file size is: %s\n" % file_size
	_get_variable_from_data_file()


func _create_data_file():
	var f = File.new()
	f.open(DATAFILE_NAME, File.WRITE)
	var test_var = TEST_VALUE
	f.store_var(test_var)
	debug.text += "OK, data file has been created, and a variable has been stored in it with this value: %s\n" % test_var
	f.close()


func _get_data_file_size():
	var f = File.new()
	if not f.file_exists(DATAFILE_NAME):
		return -1
	f.open(DATAFILE_NAME, File.READ)
	var file_size = f.get_len()
	f.close()
	return file_size


func _get_variable_from_data_file():
	debug.text += "Attempting to read persisted variable from the data file.\n"
	var f = File.new()
	f.open(DATAFILE_NAME, File.READ)
	var test_var = f.get_var()
	f.close()
	debug.text += "Persisted variable value: %s.\n" % test_var
	if test_var == "Hello, this is a persisted variable":
		debug.text += "OK, the persisted variable has the expected value.\n"
	else:
		debug.text += "SORRY, the persisted value should be %s but it is %s.\n" % [TEST_VALUE, test_var]
