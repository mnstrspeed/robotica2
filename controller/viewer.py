import sys, math, Tkinter
from joystick import *

def draw_joystick(master, canvas, x, y, left, right):
	(cx, cy) = square_to_circle(x / float(JOYSTICK_MAX_VALUE), \
		y / float(JOYSTICK_MAX_VALUE))
	
	canvas.delete(Tkinter.ALL)
	canvas.create_arc(0, 0, 800, 800, start=0, extent=180, fill="grey")
	canvas.create_arc(0, 0, 800, 800, start=180, extent=180, fill="dark grey")
	canvas.create_line(0, 400, 800, 400)
	canvas.create_oval(400.0 + cx * 390.0 - 10, 400.0 + cy * 390.0 - 10, \
		400.0 + cx * 390.0 + 10, 400.0 + cy * 390.0 + 10, fill="black")
	canvas.create_rectangle(800, 0, 1000, 800, fill="grey")
	canvas.create_rectangle(800, (1.0 - left) * 800.0, 1000, 800, fill="green")
	canvas.create_rectangle(1000, 0, 1200, 800, fill="grey")
	canvas.create_rectangle(1000, (1.0 - right) * 800.0, 1200, 800, fill="green") 
	master.update()

def create_window(width, height, title):
	master = Tkinter.Tk()
	master.title(title)
	canvas = Tkinter.Canvas(master, width=width, height=height)
	canvas.pack()
	return master, canvas

pipe = open('/dev/input/js0','r')

x = y = left = right = 0

master, canvas = create_window(1200, 800, "joystick")
draw_joystick(master, canvas, x, y, left, right)

running = True
while running:
	_, val, event_type, index = get_event(pipe)

	if event_type == EVENT_TYPE_BUTTON and \
			index == 8 and val == BUTTON_VAL_PRESSED:
		running = False
	if event_type == EVENT_TYPE_JOYSTICK:
		if index == 0:
			x = -val
		elif index == 1:
			y = -val
	
		if y >= 0:
			left, right = compute_motor_power(x, y)
			# print "L {:.2f}\tR {:.2f}".format(left, right)
	
	draw_joystick(master, canvas, -x, -y, left, right)
