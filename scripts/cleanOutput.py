

def bin_split(split_string):
    new_string = ""
    for x in range(0, len(split_string), 8):
        new_string += split_string[x:x+8] + " "
    new_string += "\n"
    print(new_string)


bin_split(input("Write your binary fuckbundle here: "))
