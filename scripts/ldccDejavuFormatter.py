import os

def parseEvent(line):
    values = line.split(', ')
    if(len(values) == 0):
        print('Skipping empty row.')
        return None
    event = { 'type': values.pop(0) }
    for value in values:
        keyValue = value.split(' = ')
        event[keyValue[0]] = keyValue[1].rstrip("\n\r")
    return event

dbDescriptor = lambda event: event['ts'] + ',' + event['u'] + ',' + event['db'] + ',' + event['p'] + ',' + event['d']
eventDescriptor = {
    'insert': dbDescriptor,
    'select': dbDescriptor,
    'update': dbDescriptor,
    'delete': dbDescriptor,
    'script_start': lambda event: event['ts'] + ',' + event['s'],
    'script_end': lambda event: event['ts'] + ',' + event['s'],
    'script_md5': lambda event: event['ts'] + ',' + event['s'] + ',' + event['md5'],
    'commit': lambda event: event['ts'] + ',' + event['url'] + ',' + event['rev'],
    'script_svn': lambda event: event['ts'] + ',' + event['s'] + ',' + event['status'] + ',' + event['url'] + ',' + event['rev1'] + ',' + event['rev2'],
}
    

def buildDejavuEvent(event):
    eventProperties = eventDescriptor[event['type']](event)
    return event['type'] + ',' + eventProperties

originalLogFilePath = os.path.join('/', 'root', 'OM', 'ldcc.csv')
dejavuLogFilePath = os.path.join('/', 'root', 'OM', 'ldcc-dejavu.csv')
originalLogFile = open(originalLogFilePath, 'r')
dejavuLogFile = open(dejavuLogFilePath, 'w')
for line in originalLogFile:
    event = parseEvent(line)
    dejavuEvent = buildDejavuEvent(event)
    dejavuLogFile.write(dejavuEvent + '\n')
dejavuLogFile.close()
originalLogFile.close()
