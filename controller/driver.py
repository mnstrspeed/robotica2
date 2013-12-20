import sys, subprocess
from joystick import *

def botbus_send_command(botbus, command):
	botbus.stdin.write(command)
	botbus.stdin.flush()
	return botbus_check_ok(botbus)

def botbus_check_ok(botbus):	
	message = botbus.stdout.readline()
	return message == "*\n" or message == "*V\n"

def botbus_get_bus_list():
	command = 'botbus/con/chauffeur --emu --lijst'
	botbus = subprocess.Popen(command.split(' '), stdout=subprocess.PIPE)
	for line in botbus.stdout:
		yield line[:-1]

def botbus_get_bus(string):
	sub = string[string.find('[') + 1:string.find(']')]
	return sub.split(';')

def select_botbus_bus():
	options = list(botbus_get_bus_list())
	i = 0
	for option in options:
		print i, "-", option
		i = i + 1
	selected = input("choose a bus: ")
	if selected >= 0 and selected < len(options):
		return botbus_get_bus(options[selected])
	else:
		print "that's not a bus >.>"
		return select_botbus_bus()

running = True

bus = select_botbus_bus()

print 'starting botbus'
command = 'botbus/con/chauffeur --emu --bus'.split(' ')
command = command + bus

botbus = subprocess.Popen(command, \
	stdout=subprocess.PIPE, stdin=subprocess.PIPE)
print "botbus started ({})".format(botbus.pid)

if not botbus_check_ok(botbus):
	print "botbus initialization failed"
	running = False

try:
	print 'opening joystick'
	pipe = open('/dev/input/js0', 'r')
	print 'ready'
	
	x = y = left = right = 0
	while running:
		_, val, event_type, index = get_event(pipe)
	
		if event_type == EVENT_TYPE_BUTTON and val == BUTTON_VAL_PRESSED:
			if index == 9: # start button = stop button. MAKES PERFECT SENSE.
				running = False
					
		elif event_type == EVENT_TYPE_JOYSTICK:
			if index == 0:
				x = -val
			elif index == 1:
				y = -val
			
			if (index == 0 or index == 1) and y >= 0:
				(left, right) = compute_motor_power(x, y)
				leftval = int(left * 255.0)
				rightval = int(right * 255.0)
				print "sending (L: {:.2f} [{:03d}], R: {:.2f}) [{:03d}] to botbus".format(left, leftval, right, rightval)
	
				ok1 = botbus_send_command(botbus, 'S 0x01 ' + str(leftval) + '\n')
				ok2 = botbus_send_command(botbus, 'S 0x02 ' + str(rightval) + '\n')
				
				if not (ok1 and ok2):
					print "failed to send one or more botbus commands"
					running = False 
except IOError:
	print "joystick unplugged or botbus broken"
except KeyboardInterrupt:
	print "as you wish, my lord"

print 'terminating'

botbus.stdin.write('Q\n')
botbus.stdin.flush()
botbus.stdout.readline()
