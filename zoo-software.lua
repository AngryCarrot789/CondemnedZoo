-- https://pastebin.com/PHEMm13R

DRIVE_SIDE = "west"

-- Use this table structure for each mob, to simply everything :)
CREEPER = { id = 10, x = -3865, y = 68, z = -4595 }
MAGMA = { id = 10, x = -3863, y = 68, z = -4603 }
SKELETON = { id = 11, x = -3865, y = 68, z = -4605 }

function loadRoomIntoKeyCard(mob)
    -- As long as mob follows the table structure at the top, this works
    security.loadSecurityCode(DRIVE_SIDE, mob.id) 
end

function registerButton(button)
    security.registerButton(button.x, button.y, button.z, button.id)
end

function registerButtons()
    registerButton(CREEPER)
    registerButton(MAGMA)
    registerButton(SKELETON)
end

function doApp()
    while (true) do
        term.write(">")
        local input = read()
        if (input == "help") then
            print("loadcode   - Loads a code into the keycard in the drive to the left of this PC")
            print("help       - Shows help")
            print("clear      - Clears the screen")
        elseif (input == "loadcode") then
            print("Which mob do you want to load?")
            print("Make sure there's a keycard in the drive!")
            print("Available rooms: creeper, magma")
            local room = string.lower(read())
            if (room == "creeper") then
                loadRoomIntoKeyCard(CREEPER)
            elseif (room == "magma") then
                loadRoomIntoKeyCard(MAGMA)
            else
                print("Unknown room: " .. room)
            end
        elseif (input == "clear") then
            return
        elseif (input == "reboot") then
            print(":(")
            os.sleep(1)
            os.reboot()
        elseif (input == "update") then
            print("TODO: Auto update system, pull from pastebin")
        else
            print("Unknow command: " .. input)
        end 
    end
end

registerButtons()

while (true) do
    term.setCursorPos(1, 1)
    term.setBackgroundColor(colours.black)
    term.setTextColor(colours.white)
    term.clear()

    print("Welcome to the Zoo Keycard System v1.0")
    print("By Carrot and Rolcam :-)")
    print("")
    print("Enter a command. type 'help' for a list of commands")

    doApp()

    os.sleep(1)
end
