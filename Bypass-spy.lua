-- Bypass SimpleSpy สำหรับแมพที่รัน SimpleSpy แล้วโดนเตะ คร๊าบบบ


local getgc = getgc or get_gc_objects
local setreadonly = setreadonly or make_writeable
local isreadonly = isreadonly or is_readonly

if not getgc then
    warn("Executor ของคุณไม่รองรับ getgc() - สคริปต์ไม่สามารถทำงานได้คร๊าบบบ")
    return
end

print("Starting Anti-Kick Bypass...")

for _, v in pairs(getgc(true)) do
    local success, result = pcall(function()
        return type(v) == "table" and rawget(v, "indexInstance")
    end)

    if success and type(result) == "table" then
        if result[1] and tostring(result[1]):lower() == "kick" then
            
            local function applyBypass()
                v.tvk = {"kick", function() 
                    print("Kick prevented!") 
                    return nil 
                end}
            end

            if isreadonly and setreadonly then
                if isreadonly(v) then
                    setreadonly(v, false)
                    applyBypass()
                    setreadonly(v, true)
                else
                    applyBypass()
                end
                print("Bypass applied to a protected table.")
            else
                pcall(applyBypass)
            end
        end
    end
end

print("Bypass Process Finished.")


loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/78n/SimpleSpy/main/SimpleSpyBeta.lua"))()
