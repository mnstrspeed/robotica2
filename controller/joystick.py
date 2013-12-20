import sys, struct, math 

EVENT_TYPE_BUTTON = 1
EVENT_TYPE_JOYSTICK = 2
BUTTON_VAL_PRESSED = 1
BUTTON_VAL_RELEASED = 0
JOYSTICK_MAX_VALUE = 32767

def get_event(pipe):
	event = ""
	while len(event) < 8:
		event += pipe.read(1)
		if len(event) == 8:
			return struct.unpack("IhBB", event)

def square_to_circle(x, y):
	return (x * math.sqrt(1 - 0.5*y*y),
		y * math.sqrt(1 - 0.5*x*x))

def compute_motor_power(x, y):	
	(cx, cy) = square_to_circle( \
		x / float(JOYSTICK_MAX_VALUE), y / float(JOYSTICK_MAX_VALUE))
	power = math.hypot(cx, cy)

	angle = math.atan2(cy, cx) - 0.5 * math.pi
	right = power * (1.0 if angle <= 0 else  1 - (angle / 1.5707))
	left = power * (1.0 if angle >= 0 else 1 + (angle / 1.5707))

	return left, right
