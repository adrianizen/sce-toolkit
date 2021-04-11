import re
import subprocess

class ContainerIdFinder:

    def __init__(self, container_name):
        self.container_name = container_name
        return
        
    def find(self):
        container_list = self.getContainerList()

        matched_line = self.getMatchedLine(container_list)
        if matched_line == 0:
            return 0

        container_id = self.getIdPart(matched_line)

        if not container_id:
            return 0
    
        return container_id

    def getIdPart(self, matched_line):
        container_id_match = re.findall("^[a-z0-9]+", matched_line)
        
        if not container_id_match:
            return 0
        else:
            return container_id_match[0]

    def getMatchedLine(self, container_list):
        pattern = "[^\n]+?" + self.container_name + "_[0-9]+.*?"
        matched_pattern = re.findall(pattern, str(container_list))

        if not matched_pattern:
            return 0
        else:
            return matched_pattern[0]

    def getContainerList(self):
        return subprocess.check_output("docker ps", shell=True).decode("utf-8").rstrip('\n')
