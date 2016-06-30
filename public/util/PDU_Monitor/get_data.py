from pysnmp.entity.rfc3413.oneliner import cmdgen
from datetime import datetime
import os
import time
from cStringIO import StringIO


store_dir = '.'

cmdGen = cmdgen.CommandGenerator()

def getStatus():
    errorIndication, errorStatus, errorIndex, varBinds = cmdGen.getCmd(
        cmdgen.CommunityData('public', mpModel=0),
        cmdgen.UdpTransportTarget(('168.0.0.1', 161)),
        cmdgen.MibVariable('1.3.6.1.4.1.318.1.1.12.2.3.1.1.2.1'),
        cmdgen.MibVariable('1.3.6.1.4.1.318.1.1.12.2.3.1.1.2.2'),
        cmdgen.MibVariable('1.3.6.1.4.1.318.1.1.12.2.3.1.1.2.3')
    )

    # Check for errors and print out results
    if errorIndication:
        return ['error']*3
    else:
        if errorStatus:
            return ['error']*3
        else:
            status = [i[1].prettyPrint() for i in varBinds]
            return status


def method5():
    file_str = StringIO()
    for num in xrange(loop_count):
        file_str.write(`num`)
        return file_str.getvalue()

def writeLog():
    status = getStatus()
    if status[0] == 'error':
        return
    datestamp = datetime.now()
    log = ''
    log += datestamp.strftime("%Y-%m-%dT%H:%M:%S")
    log += '\t'
    log += '\t'.join([str(int(i)/10.0*220.0) for i in status])
    log += '\n'
    logfile = store_dir + '/' + datestamp.strftime("%Y%m%d%H") + 'data.tsv'
    if os.path.exists(logfile):
        with open(logfile,"a") as f:
            f.write(log)
    else:
        with open(logfile,"a") as f:
            f.write("date\tampere1\tampere2\tampere3\n")
            f.write(log)

while True:
    writeLog()
    time.sleep(2)
