import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;

import javax.bluetooth.RemoteDevice;

import lejos.nxt.Button;
import lejos.nxt.ButtonListener;
import lejos.nxt.LCD;
import lejos.nxt.Motor;
import lejos.nxt.NXTRegulatedMotor;
import lejos.nxt.SensorPort;
import lejos.nxt.TouchSensor;
import lejos.nxt.UltrasonicSensor;
import lejos.nxt.comm.BTConnection;
import lejos.nxt.comm.Bluetooth;
import lejos.util.Delay;

public class Main 
{	
	private static void turnToPartner(BotRole role)
	{	
		NXTRegulatedMotor motor = role == BotRole.LEFT ? Motor.A : Motor.C;
		motor.setSpeed(90);
		motor.forward();
		
		TouchSensor sensor = new TouchSensor(SensorPort.S2);
		while (!sensor.isPressed())
			Delay.msDelay(10);
		
		motor.stop();
	}
	
	private static void waitForEdge(UltrasonicSensor sensor, final int THRESHOLD)
	{
		int streak = 0;
		int streakBegin = 0;
		
		int previousMeasurement;
		int currentMeasurement = sensor.getDistance();
		do
		{
			Delay.msDelay(20);
			
			previousMeasurement = currentMeasurement;
			currentMeasurement = sensor.getDistance();
			
			if (streak > 0)
			{
				if (Math.abs(currentMeasurement - streakBegin) > THRESHOLD &&
						Math.abs(currentMeasurement - previousMeasurement) <= THRESHOLD) // stay in streak
				{
					streak++;
				}
				else // drop out: drop values in streak
				{
					previousMeasurement = streakBegin;
					streak = 0;
				}
			}
			
			if (streak == 0 && Math.abs(currentMeasurement - previousMeasurement) > THRESHOLD)
			{
				streak = 1;
				streakBegin = previousMeasurement;
			}
		}
		while (streak < 3);
	}
	
	private static int locateTarget(BotRole role)
	{
		UltrasonicSensor sensor = new UltrasonicSensor(SensorPort.S1);
		sensor.continuous();
		
		NXTRegulatedMotor motor = role == BotRole.LEFT ? Motor.A : Motor.C;
		motor.setSpeed(90);
		motor.resetTachoCount();
		motor.backward();
		
		waitForEdge(sensor, 10);
		System.out.println("edge at " + motor.getTachoCount());
		waitForEdge(sensor, 10);
		System.out.println("object at " + motor.getTachoCount());
		int start = motor.getTachoCount();
		waitForEdge(sensor, 10);
		System.out.println("ends at " + motor.getTachoCount());
		int end = motor.getTachoCount();
		
		motor.stop();
		motor.rotate(motor.getTachoCount() * -1);
		
		return start + ((end - start) / 2);
	}
	
	private static BotRole pickRole()
	{		
		LCD.clear(0);
		LCD.drawString("Select role L/R", 0, 0);
		while (true)
		{
			if (Button.LEFT.isDown())
			{
				LCD.clear(0);
				return BotRole.LEFT;
			}
			if (Button.RIGHT.isDown())
			{
				LCD.clear(0);
				return BotRole.RIGHT;
			}
		}
	}
	
	private static boolean isMaster(String slaveName)
	{
		return !Bluetooth.getFriendlyName().equals(slaveName);
	}
	
	private static BTConnection connectToPartner(String slaveName) throws IOException
	{
		if (isMaster(slaveName))
		{
			RemoteDevice device = Bluetooth.getKnownDevice(slaveName);
			if (device != null)
			{
				BTConnection connection = Bluetooth.connect(device);
				if (connection != null)
					return connection;
				else
					throw new IOException("Connection to " + slaveName + " failed");
			}
			else
			{
				throw new IOException("Unknown device: " + slaveName);
			}
		}
		else
		{
			return Bluetooth.waitForConnection();
		}
	}
	
	private static void move(int order, BotRole role)
	{
		NXTRegulatedMotor a = role == BotRole.LEFT ? Motor.A : Motor.C;
		NXTRegulatedMotor b = role == BotRole.LEFT ? Motor.C : Motor.A;
		a.setSpeed(360);
		b.setSpeed(360);
		
		a.rotate(-180, true);
		b.rotate(180, true);
		
		while (a.isMoving() || b.isMoving())
			Delay.msDelay(10);
		
		a.stop();
		b.stop();
		
		if (order == 0 && role == BotRole.LEFT)
		{
			// right
			a.forward();
		}
		else if (order == 1 && role == BotRole.RIGHT)
		{
			// left
			b.forward();
		}
		else if (order == 2)
		{
			// straight ahead
			a.forward();
			b.forward();
		}
		
		Delay.msDelay(3000);
		a.stop();
		b.stop();
	}
	
	private static int computeMovement(int alphaLeft, int alphaRight)
	{
		if (alphaLeft > 180 && alphaRight > -180)
		{
			// right
			return 0;
		}
		else if (alphaRight < 180 && alphaRight < -180)
		{
			// left
			return 1;
		}
		else
		{
			// forward
			return 2;
		}
	}

	public static void main(String[] args)
	{
		Button.ESCAPE.addButtonListener(new ButtonListener() {
			@Override
			public void buttonPressed(Button b) 
			{
				System.exit(0);
			}
			@Override
			public void buttonReleased(Button b) { }
		});
		
		BotRole role = pickRole();
		try
		{
			BTConnection connection = connectToPartner("NXT");
			DataInputStream is = connection.openDataInputStream();
			DataOutputStream os = connection.openDataOutputStream();
			
			while (!Button.ESCAPE.isDown())
			{
				System.out.println("Turning to partner");
				turnToPartner(role);
				
				System.out.println("Locating target");
				int alpha = locateTarget(role);
				
				int order;
				if (isMaster("NXT"))
				{
					int remoteAlpha = is.readInt();
					order = computeMovement(alpha, remoteAlpha);
					os.writeInt(order);
					os.flush();
				}
				else
				{
					os.writeInt(alpha);
					os.flush();
					order = is.readInt();
				}
				System.out.println("Moving to target");
				move(order, role);
				
				Delay.msDelay(10000);
			}
			
			is.close();
			os.close();
			connection.close();
		}
		catch (Exception ex)
		{
			
		}
	}
}
