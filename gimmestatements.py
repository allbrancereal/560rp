import os
import json
import re

# Define the directory
directory = os.getcwd()

# Define the regex pattern
pattern = re.compile(r':(query|prepare)\((.*?)\)', re.IGNORECASE)

# Initialize an empty list to store the statements
statements = []

def recursive_search(directory):
    # Loop through every file in the directory
    for filename in os.listdir(directory):
        file_path = os.path.join(directory, filename)
        # Check if the path is a directory
        if os.path.isdir(file_path):
            # Recursively search the subdirectory
            recursive_search(file_path)
        # Check if the file is a Lua file
        elif filename.endswith(".lua"):
            # Open the file
            with open(file_path, 'r') as file:
                # Read the file
                content = file.read()
                # Find all the :query and :prepare statements
                matches = pattern.findall(content)
                # Add the statements to the list
                statements.extend(matches)

# Start the recursive search
recursive_search(directory)

# Write the statements to a JSON file
with open('statements.json', 'w') as file:
    json.dump(statements, file, indent=4)
