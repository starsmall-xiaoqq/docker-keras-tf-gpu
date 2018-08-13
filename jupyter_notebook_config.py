import os
from IPython.lib import passwd

c = get_config()
c.NotebookApp.ip = '0.0.0.0'
c.NotebookApp.port = int(os.getenv('PORT', 8888))
c.NotebookApp.open_browser = False
c.NotebookApp.allow_root = True
c.NotebookApp.token = 'aaa'
