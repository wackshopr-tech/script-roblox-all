-- Bypass SimpleSpy สำหรับแมพที่รัน SimpleSpy แล้วโดนเตะ คร๊าบบบ

if setreadonly then
    for k, v in pairs(getgc(true)) do
        if pcall(function() return rawget(v, "indexInstance") end) 
        and type(rawget(v, "indexInstance")) == "table" 
        and rawget(v, "indexInstance")[1] == "kick" then

            if not isreadonly(v) then
                print("Readonly = false \n Continuing...")
                v.tvk = {"kick", function() return game.Workspace:WaitForChild("") end}
                wait(1.5)
                print("Bypassed")
            else
            print("Readonly = true \n bypassing readonly...")
                setreadonly(v, false)
                v.tvk = {"kick", function() return game.Workspace:WaitForChild("") end}
                setreadonly(v, true)
                wait(1.5)
                print("Finished \n Bypassed")
            end
        end
    end
else
    print("setreadonly is not available in this environment.")
end


loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/78n/SimpleSpy/main/SimpleSpyBeta.lua"))()
