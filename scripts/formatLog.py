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

dbDescriptor = lambda event: event['u'] + ', ' + event['db'] + ', ' + event['p'] + ', ' + event['d']
eventDescriptor = {
    'insert': dbDescriptor,
    'select': dbDescriptor,
    'update': dbDescriptor,
    'delete': dbDescriptor,
    'script_start': lambda event: event['s'],
    'script_end': lambda event: event['s'],
    'script_md5': lambda event: event['s'] + ', ' + event['md5'],
    'commit': lambda event: event['url'] + ', ' + event['rev'],
    'script_svn': lambda event: event['s'] + ', ' + event['status'] + ', ' + event['url'] + ', ' + event['rev1'] + ', ' + event['rev2'],
}
    

def buildMonPolyEvent(event):
    eventProperties = eventDescriptor[event['type']](event)
    return '@' + event['ts'] + ' ' + event['type'] + '(' + eventProperties + ')'

originalLogFilePath = os.path.join('/', 'root', 'OM', 'ldcc.csv')
monpolyLogFilePath = os.path.join('/', 'root', 'OM', 'ldcc-monpoly.csv')
originalLogFile = open(originalLogFilePath, 'r')
monpolyLogFile = open(monpolyLogFilePath, 'w')
for line in originalLogFile:
    event = parseEvent(line)
    monpolyEvent = buildMonPolyEvent(event)
    monpolyLogFile.write(monpolyEvent + '\n')
monpolyLogFile.close()
originalLogFile.close()
