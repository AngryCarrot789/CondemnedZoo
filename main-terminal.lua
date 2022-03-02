-- https://pastebin.com/PHEMm13R - Original code from Carrot (server dev)
-- https://pastebin.com/eK1x4YFy - This Branch (Rolcam's Version)
-- This uses a security API/plugin developed for a tekkit server. Without them this program is useless
 
DRIVE_SIDE = "west"
 
-- Use this table structure for each mob, to simply everything :)
data = fs.open(".config", "r")
idDat = data.readLine()
data.close()
staticID = tonumber(idDat)
tempID = 0
CREEPER = { id = staticID, x = -3865, y = 68, z = -4595 }
MAGMA = { id = staticID, x = -3863, y = 68, z = -4603 }
SKELETON = { id = staticID, x = -3865, y = 68, z = -4605 }
 
function loadRoomIntoKeyCard(mob)
    -- As long as mob follows the table structure at the top, this works
    security.loadSecurityCode(DRIVE_SIDE, mob.id) 
end
 
function doApp()
    while (true) do
        term.setTextColor(colors.orange)
        term.write(">")
        local input = read()
        if (input == "help") then
            print("loadcode   - Loads a code into the keycard in the drive to the left of this PC")
            print("help       - Shows help")
            print("regen      - Regenerates security codes*")
            print("update     - Updates the program*")
            print("clear      - Clears the screen")
            print("ver        - Displays version info")
            print(" ")
            print(" *Command is password protected")
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
            term.setTextColor(colors.red)
            print("Please input the administrative staff code:")
            aCode = read("*")
            if aCode == "zaAdmin" then
                term.setTextColor(colors.green)
                print("Password Accepted")
                aLoop = 1
                sleep(1)
                while aLoop == 1 do
                    term.clear()
                    term.setCursorPos(1,1)
                    term.setTextColor(colors.cyan)
                    print("Administrative Access - System Updater \n ")
                    print("Which version would you like to update to?")
                    print("Rolcam - Updates to Rolcam's Version (this version)")
                    print("Carrot - Updates to TheRareCarrot's Version")
                    aVer = read()
                    if aVer == "Rolcam" or aVer == "rolcam" then
                        print("Updating program...")
                        print("You have selected: Rolcam's Version")
                        fs.delete("startup")
                        shell.run("pastebin get eK1x4YFy startup")
                        print("Update Successful")
                        print("Rebooting to finish installation...")
                        sleep(2)
                        os.reboot()
                    elseif aVer == "Carrot" or aVer == "carrot" then
                        print("Updating program...")
                        print("You have selected: TheRareCarrot's Version")
                        fs.delete("startup")
                        shell.run("pastebin get PHEMm13R startup")
                        print("Update Successful")
                        print("Rebooting to finish installation...")
                        sleep(2)
                        os.reboot()  
                    else
                        term.setTextColor(colors.red)
                        print("Invalid Branch")
                        sleep(1)
                    end
                end
            else
                term.setTextColor(colors.red)
                print("Invalid Code")
                sleep(1)
            end
        elseif input == "regen" then
            term.setTextColor(colors.red)
            print("Please input the administrative staff code:")
            aCode = read("*")
            if aCode == "zaAdmin" then
                term.setTextColor(colors.green)
                print("Password Accepted")
                sleep(1)
                cLoop = 1
                while cLoop = 1 do
                    term.clear()
                    term.setCursorPos(1,1)
                    term.setTextColor(colors.cyan)
                    print("Administrative Access - Code Regenerator \n ")
                    print("Currently the code is: " .. staticID)
                    print("Please make your selection:")
                    print("random     - Generates a random code")
                    print("manual     - Manually generates a code")
                    print("end        - Exits without updating the code")
                    aVer = read()
                    if aVer == "random" then
                        dLoop = 1
                        while dLoop == 1 do
                            tempID = math.random()
                            term.clear()
                            term.setCursorPos(1,1)
                            term.setTextColor(colors.orange)
                            print("The new code will be: " .. tempID .. " - Is this ok? y/n")
                            cInput = read()
                            if cInput == "y" or cInput == "Y" then
                                print("The security code will now be changed. Please Wait...")
                                data = fs.open(".config", "r")
                                idDat = data.readLine()
                                data.close()
                            elseif cInput == "n" or cInput == "N" then
                            else
                            end
                        end
                        
                    elseif aVer == "manual" then
                        
                    elseif aVer == "end" then
                        
                    else
                        term.setTextColor(colors.red)
                        print("Invalid Selection")
                        sleep(1)
                    end
                end
            else
                term.setTextColor(colors.red)
                print("Invalid Code")
                sleep(1)
            end
        elseif input == "ver" then
            print("Branch: Rolcam's")
            print("Version 0.9 [InDev]")
            print("Designed for the Condemned Zoo")
        else
            print("Unknown command: " .. input)
        end 
    end
end
 
function registerButton(button)
    security.registerButton(button.x, button.y, button.z, button.id)
end
 
function registerButtons()
    registerButton(CREEPER)
    registerButton(MAGMA)
    registerButton(SKELETON)
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
