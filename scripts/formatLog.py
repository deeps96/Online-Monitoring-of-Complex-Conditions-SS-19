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

dbDescriptor = lambda event: 'user=' + event['u'] + ', database=' + event['db'] + ', p=' + event['p'] + ', d=' + event['d']
eventDescriptor = {
    'insert': dbDescriptor,
    'select': dbDescriptor,
    'update': dbDescriptor,
    'delete': dbDescriptor,
    'script_start': lambda event: 'script=' + event['s'],
    'script_end': lambda event: 'script=' + event['s'],
    'script_md5': lambda event: 'script=' + event['s'] + ', md5=' + event['md5'],
    'commit': lambda event: 'url=' + event['url'] + ', revision=' + event['rev'],
    'script_svn': lambda event: 'script=' + event['s'] + ', status=' + event['status'] + ', url=' + event['url'] + ', revision1=' + event['rev1'] + ', revision2=' + event['rev2'],
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
