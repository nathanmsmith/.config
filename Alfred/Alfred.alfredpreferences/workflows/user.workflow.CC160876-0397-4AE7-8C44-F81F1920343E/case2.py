# case2.py
#
# 2014-09-10 by Derick Fay
#
# original inspiration from jdc0589's CaseConversion plug-in for SublimeText:
# https://github.com/jdc0589/CaseConversion/blob/master/case_conversion.py
#
#
# built with deanishe's Alfred Workflow library:
# http://www.deanishe.net/alfred-workflow/index.html
#

import sys
import re
import string
import os
from workflow import Workflow
from titlecase import *

def SendDown(key):
    string = str(key)
    cmd = """osascript -e 'tell application "System Events" to key down (key code """ + string   + ")'"
    os.system(cmd)
    
def copy_selection():
	SendDown(8)

def to_upper(text):
	return text.upper()
	
def to_lower(text):
	return text.lower()

def to_capitalized(text):
	text = string.capwords(text)
	return text
	
def to_sentence_case(text):
	text = text[0].upper() + text[1:].lower()
	return text

# titlecase defined in separate file - from https://muffinresearch.co.uk/titlecasepy-titlecase-in-python/
 
def main(wf):
     theString = wf.args[0]

     # Add items to Alfred feedback with uids so Alfred will track frequency of use
     result = to_upper(theString)
     wf.add_item(title=result, subtitle='Upper Case', valid=True, arg=result, icon='snake.png',uid='uppercase')
     
     result = to_lower(theString)
     wf.add_item(title=result, subtitle='Lower Case', valid=True, arg=result, icon='pascal.png',uid='lowercase')
     
     result = to_capitalized(theString)
     wf.add_item(title=result, subtitle='Capitalized', valid=True, arg=result, icon='cobra.png',uid='capitalized')
     
     result = to_sentence_case(theString)
     wf.add_item(title=result, subtitle='Sentence Case', valid=True, arg=result, icon='camel.png',uid='sentencecase')
     
     result = titlecase(theString)
     wf.add_item(title=result, subtitle='Title Case', valid=True, arg=result, icon='dot.png',uid='title	case')
          
     # Send output to Alfred
     wf.send_feedback()

if __name__ == '__main__':
     wf = Workflow()
     # Assign Workflow logger to a global variable, so all module
     # functions can access it without having to pass the Workflow
     # instance around
     log = wf.logger
     sys.exit(wf.run(main))