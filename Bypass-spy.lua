-- [[ Adonis Anti-Cheat Bypass for SimpleSpy ]] --

local getinfo = getinfo or debug.getinfo
local DEBUG = false
local Hooked = {}
local Detected, Kill

-- เริ่มต้นการทำงานด้วย Thread Identity สำหรับการ Hook
setthreadidentity(2)

-- ส่วนที่ 1: ค้นหาและ Hook ฟังก์ชันขัดขวางของ Adonis ใน GC
for _, v in pairs(getgc(true)) do
    if typeof(v) == "table" then
        local DetectFunc = rawget(v, "Detected")
        local KillFunc = rawget(v, "Kill")

        -- Hook ฟังก์ชัน Detected
        if typeof(DetectFunc) == "function" and not Detected then
            Detected = DetectFunc
            
            hookfunction(Detected, function(Action, Info, NoCrash)
                if Action ~= "_" and DEBUG then
                    warn(`[Bypass] Adonis AntiCheat flagged | Method: {Action} | Info: {Info}`)
                end
                return true -- ส่งค่ากลับเพื่อให้ Anti-cheat คิดว่าทำงานปกติแต่ไม่ทำอะไรเรา
            end)

            table.insert(Hooked, Detected)
        end

        -- Hook ฟังก์ชัน Kill
        if rawget(v, "Variables") and rawget(v, "Process") and typeof(KillFunc) == "function" and not Kill then
            Kill = KillFunc

            hookfunction(Kill, function(Info)
                if DEBUG then
                    warn(`[Bypass] Adonis AntiCheat tried to kill (fallback): {Info}`)
                end
                -- ปล่อยว่างไว้เพื่อระงับการ Kill
            end)

            table.insert(Hooked, Kill)
        end
    end
end

-- ส่วนที่ 2: Hook debug.info เพื่อป้องกันการ Check Stack
local OldDebugInfo; OldDebugInfo = hookfunction(getrenv().debug.info, newcclosure(function(...)
    local LevelOrFunc, Info = ...

    if Detected and LevelOrFunc == Detected then
        if DEBUG then
            warn(`[Bypass] Adonis sanity check detected and neutralized.`)
        end
        return coroutine.yield(coroutine.running()) -- หยุดการทำงานของ Thread นั้นไปเลย
    end
    
    return OldDebugInfo(...)
end))

-- คืนค่า Thread Identity กลับไปที่ระดับปกติ
setthreadidentity(7)

-- ส่วนที่ 3: Bypass ระบบการ Kick (Instance Index)
if setreadonly then
    for _, v in pairs(getgc(true)) do
        local hasIndexInstance = pcall(function() return rawget(v, "indexInstance") end)
        
        if hasIndexInstance and type(rawget(v, "indexInstance")) == "table" and rawget(v, "indexInstance")[1] == "kick" then
            local isRO = isreadonly(v)
            
            if isRO then setreadonly(v, false) end
            
            -- เปลี่ยนเป้าหมายการ Kick ให้ไปรอ Object ที่ไม่มีจริงแทน (Infinite Wait)
            v.tvk = {"kick", function() return game.Workspace:WaitForChild("NonExistentObject") end}
            
            if isRO then setreadonly(v, true) end
            
            print("[Bypass] Kick method redirected successfully.")
        end
    end
else
    warn("[Error] setreadonly is not available in this environment.")
end

-- ส่วนที่ 4: รัน SimpleSpy
print("[System] Loading SimpleSpy...")
task.wait(1)
loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/78n/SimpleSpy/main/SimpleSpyBeta.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
