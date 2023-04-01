import json
import os
import codecs

def simple_normalization(text):
    mapping ={
            "أ":"ا",
            "آ":"ا",
            "إ":"ا"
        }
    for key, value in mapping.items():
        text = text.replace(key,value)
    return text


def add_property_to_json(input_file, output_file):
    with open(input_file, 'r', encoding='utf-8') as json_file:
        data = json.load(json_file)

    for obj in data:
        normalize_name = simple_normalization(obj['name'])
        obj.update({'normalize_name': normalize_name})

    with open(output_file, 'w', encoding='utf-8') as json_file:
        json.dump(data, json_file, ensure_ascii=False, indent=4)


def join_json_files(folder_path, output_file_name):
    # Get a list of all the JSON files in the folder
    file_list = [f for f in os.listdir(folder_path) if f.endswith('.json')]

    # Sort the file list based on the file names
    file_list.sort()
    
    # Create an empty list to store all the JSON objects
    objects_list = []

    # Loop through each file in the folder and append its objects to the list
    for file_name in file_list:
        with open(os.path.join(folder_path, file_name), 'r', encoding='utf-8-sig') as json_file:
            objects = json.load(json_file)
            objects_list.extend(objects)

    # Write the objects list to a new JSON file
    with open(output_file_name, 'w', encoding='utf-8') as output_file:
        json.dump(objects_list, output_file, indent=4, ensure_ascii=False)


json_folder = "data"
output_file = "siyar_group.json"
normalize_file = "siyar_normalize.json"

join_json_files(json_folder,output_file)
add_property_to_json(output_file,normalize_file)