import os

try:
    directory = os.path.dirname(__file__)
    for f in os.listdir(directory):
        if ".png" in f or ".zip" in f:
            os.remove(f'{directory}/{f}')
    print('clean png')
except:
    print('error clean png')
