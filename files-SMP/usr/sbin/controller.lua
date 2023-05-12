-- Controller Interface which controls the backlight of the
-- Easybox 904 XDSL display.

require "alarm"

local lanes = require "lanes".configure()

timeout=90
print ("Activating timer for ",timeout,"seconds")

function stop_lcd4linux()
	print("Shut down lcd4linux!")
	os.execute("/etc/init.d/lcd4linux stop")
end

function switch_on_display()
	print("Switching on display!")
	os.execute("/etc/init.d/lcd4linux start")
	os.execute("echo '1' >>/sys/class/backlight/fb_ili9341_eb904/bl_power")
end

function switch_off_display()
	print("Switching off display!")
	os.execute("echo '0' >>/sys/class/backlight/fb_ili9341_eb904/bl_power")
	print("Schedule lcd4linux shutdown in ",timeout, "seconds.")
	alarm(timeout,stop_lcd4linux)
end

alarm(timeout,switch_off_display)

local linda = lanes.linda()
local function readInput()
	local evdev = require "evdev"
	print ("Start reading from input...")
	-- (assuming event0 is the keyboard, which in practice easily varies)
	local keyboard = evdev.Device "/dev/input/event0"
	while true do
		local timestamp, eventType, eventCode, value = keyboard:read()
		if eventType == evdev.EV_KEY then
			if eventCode == evdev.KEY_ESC then
				break
			end
			if value == 0 then
				print("Key Released:", eventCode)
				linda:send( "KeyAction", eventCode)    -- linda as upvalue
			else
				print("Key Pressed:", eventCode)
				linda:send( "KeyAction", eventCode)    -- linda as upvalue
			end
		end
	end
end

a = lanes.gen( "*", readInput)()
switch_on_display()
while true do
		local key, val = linda:receive( 10.0, "KeyAction")    -- timeout in seconds
		if val ~= nil then
			-- print( tostring( linda) .. " received: " .. val)
			switch_on_display()
			alarm(timeout,switch_off_display)
		end
end
