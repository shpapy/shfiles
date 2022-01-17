import os
import requests
import subprocess
from winregistry import WinRegistry as Reg

# system info collection
sysinfo = subprocess.check_output("systeminfo", shell=True);
#os.system('systeminfo')
netstat = subprocess.check_output("netstat -anb", shell=True);
#os.system('netstat -anb')
netuser = subprocess.check_output("net user", shell=True);
#os.system('net user')
subprocess.check_output("ipconfig", shell=True);

# create and delete reg keys
reg = Reg()
path = r'HKLM\System\ControlSet001\services\tcpip\removeme'
reg.create_key(path)
reg.delete_key(path)

# disable firewall notifications
reg = Reg()
path = r'HKLM\System\ControlSet001\services\sharedaccess\parameters\firewallpolicy\domainprofile'
reg.read_key(path)
reg.write_value(path, 'DisableNotifications', 0x00000001, 'REG_DWORD')
reg.write_value(path, 'DisableNotifications', 0x00000000, 'REG_DWORD')

# create a scheduled task with lssas.exe
winpath = os.environ['WINDIR']
winpath = winpath + "\system32\calc.exe"
os.system('schtasks /create /tn "Amazon Cloud Agent" /tr ' + winpath + ' /sc ONSTART /ru system')
os.system('schtasks /delete /F /tn "Amazon Cloud Agent"')

# save results to a file and perform a get request
f = open("c:\\users\\public\\results.txt", "w")
f.write("Done")
f.write(str(sysinfo))
f.write(str(netstat))
f.write(str(netuser))
f.close()

x = requests.get('https://pastebin.com/REZULTS', verify=False)
print(x.status_code)