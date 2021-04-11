#!/usr/bin/env python

import subprocess
import sys
import re
from container_id_finder import ContainerIdFinder

def main():
    container_name = sys.argv[1]

    print("trying to attach to container " + container_name)

    container_name = convertContainerName(container_name)
    container_id = ContainerIdFinder(container_name).find()
    
    if container_id == 0:
        print("no matching container found")
        return False

    attachToContainer(container_id)
    

def convertContainerName(container_name):
    return container_name

def attachToContainer(container_id):
    subprocess.run("sudo docker exec -it " + container_id + " /bin/bash", shell=True)

    
if __name__ == "__main__":
    main()
