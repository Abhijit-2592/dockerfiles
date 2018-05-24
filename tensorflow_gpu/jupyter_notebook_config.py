# @Author: abhijit
# @Date:   24-May-2018 16-05-64
# @Last modified by:   abhijit
# @Last modified time: 24-May-2018 16-05-87
import os
from IPython.lib import passwd

c.NotebookApp.ip = '*'
c.NotebookApp.port = 8888
c.NotebookApp.open_browser = False

# set a password
c.NotebookApp.password = passwd('password123')
