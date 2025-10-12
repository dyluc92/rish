if not _RUN_BY_LOADER then
  gg.alert("⚠️ Script Tidak Bisa Dijalankan")
  os.exit()  -- langsung keluar tanpa stacktrace
end

local function safe_pcall(f, ...)
  local ok, res = pcall(f, ...)
  return ok, res
end



-- quick repeated clearing burst: runs for ~duration_ms milliseconds
local function anti_log_burst(duration_ms)
    local step = 25 -- ms per iteration (small sleep)
    local loops = math.max(1, math.floor(duration_ms / step))
    for i = 1, loops do
        -- try best-effort clears (pcall so no crash)
        pcall(gg.clearResults)
        pcall(gg.clearList)
        -- try to remove any list items if gg.getListItems available
        if type(gg.getListItems) == "function" then
            local ok, cur = pcall(gg.getListItems)
            if ok and type(cur) == "table" and #cur > 0 then
                pcall(gg.removeListItems, cur)
            end
        end
        gg.sleep(step)
    end
end

-- safe addListItems wrapper: add items, then immediately clear results/list to avoid leaving traces
local function safe_addListItems(items)
    if not items or type(items) ~= "table" then
        -- nothing to add
        return false
    end
    -- clear first to avoid mixing with prior results
    pcall(gg.clearResults)
    pcall(gg.clearList)
    gg.sleep(20)
    -- add (wrapped in pcall)
    local ok, res = pcall(gg.addListItems, items)
    gg.sleep(20)
    -- immediately clear results/list after adding (best-effort)
    pcall(gg.clearResults)
    pcall(gg.clearList)
    return ok, res
end

-- safe setValues wrapper (if you use gg.setValues after addList)
local function safe_setValues(tbl)
    if not tbl or type(tbl) ~= "table" then return false end
    local ok, res = pcall(gg.setValues, tbl)
    -- cleanup
    pcall(gg.clearResults)
    pcall(gg.clearList)
    return ok, res
end

-- run a short burst (about 1500 ms). Adjust if you want shorter/longer.
anti_log_burst(1500)

-- after this preamble, continue with rest of your original script
-- IMPORTANT: replace direct calls to gg.addListItems(...) in your script with safe_addListItems(...)
-- and replace gg.setValues(...) with safe_setValues(...) where appropriate.

gg.setVisible(false)
local freeuns = false
UltimoMenu = nil
local naousou = true
local naousou2 = false

function SalvarUltimoMenu(menu_tipo) UltimoMenu = menu_tipo end

function setg(offset, new)
    local table = gg.getResults(40)
    for i = 1, #table do
        table[i]["address"] = table[i]["address"] + offset
        table[i]["flags"] = gg.TYPE_DWORD
        table[i]["value"] = new
        table[i]["freezeType"] = gg.FREEZE_NORMAL
        table[i]["freeze"] = true
        gg.addListItems(table)
    end
end
function setd(offset, new)
    local table = gg.getResults(30)
    for i = 1, #table do
        table[i]["address"] = table[i]["address"] + offset
        table[i]["flags"] = gg.TYPE_DWORD
        table[i]["value"] = new
        table[i]["freeze"] = true
        gg.addListItems(table)
    end
end
function setd2(offset, new)
    local table = gg.getResults(30)
    for i = 1, #table do
        table[i]["address"] = table[i]["address"] + offset
        table[i]["flags"] = gg.TYPE_DWORD
        table[i]["value"] = new
        table[i]["freeze"] = false
        gg.addListItems(table)
        gg.setValues(table)
    end
end
function setf(offset, new)
    local table = gg.getResults(30)
    for i = 1, #table do
        table[i]["address"] = table[i]["address"] + offset
        table[i]["flags"] = gg.TYPE_FLOAT
        table[i]["value"] = new
        table[i]["freeze"] = true
        gg.addListItems(table)
    end
end

function wait_for_action()
    gg.setVisible(false)
    repeat gg.sleep(100) until gg.isVisible()
end

function ItemPass()
    gg.clearResults()
    gg.clearList()
    -- gg.setRanges(gg.REGION_C_ALLOC)
    gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS)
    -- gg.setRanges(gg.REGION_ANONYMOUS)
    -- gg.setRanges(gg.REGION_JAVA_HEAP | gg.REGION_C_HEAP | gg.REGION_C_ALLOC | gg.REGION_C_DATA | gg.REGION_C_BSS | gg.REGION_PPSSPP | gg.REGION_ANONYMOUS)

    gg.getValues({{address = 0xABCDEF12, flags = gg.TYPE_DWORD}})
    gg.searchNumber("1599361808;65537;1599099674:449", gg.TYPE_DWORD) --
    gg.refineNumber("1599361808", gg.TYPE_DWORD)
    n = gg.getResultCount()
    jz = gg.getResults(n)

    for i = 1, n do
        gg.addListItems({
            [1] = {
                address = jz[i].address - 8,
                flags = gg.TYPE_DWORD,
                freeze = true,
                value = "0",
                gg.TYPE_DWORD
            }
        })
        gg.addListItems({
            [1] = {
                address = jz[i].address - 12,
                flags = gg.TYPE_DWORD,
                freeze = true,
                value = "0",
                gg.TYPE_DWORD
            }
        })
        gg.addListItems({
            [1] = {
                address = jz[i].address - 16,
                flags = gg.TYPE_DWORD,
                freeze = true,
                value = "0",
                gg.TYPE_DWORD
            }
        })
    end
    gg.clearResults()
end

function menuescolhas2(menu_tipo)
    SalvarUltimoMenu(menu_tipo)
    if menu_tipo == 1 then
        MNV = gg.choice({
            '🌟 • Unlock Gold Pass', '⏳ • Freeze Reward',
            '💣 • Items', "🎉 • Skins", "🏠 • Decoration",
            '🎫 • Coupons', '🍂 • Crop Time', '🎯 • Avatar',
            '⚓ • Stickers', '🏭 • Poster',
            "☢️ • construction and barn", '🎉 • Badge',
            '💎 • Name and Frame', '❌ • Back'
        }, nil,[[╔════════════════════╗
║ R I S H  G A M I N G ║
╚════════════════════╝ 
]])
        if MNV == nil then return end
        if MNV == 1 then hackGoldenpass() end
        if MNV == 2 then ItemPass() end
        if MNV == 3 then menuescolhas2(2) end
        if MNV == 4 then menuescolhas2(11) end
        if MNV == 5 then menuescolhas2(12) end
        if MNV == 6 then menuescolhas2(5) end
        if MNV == 7 then hack("x") end
        if MNV == 8 then menuescolhas2(551) end
        if MNV == 9 then menuescolhas2(552) end
        if MNV == 10 then menuescolhas2(553) end
        if MNV == 11 then menuescolhas2(220) end
        if MNV == 12 then menuescolhas2(22987) end
        if MNV == 13 then menuescolhas2(9287) end
        if MNV == 14 then MENUFREE() end
    elseif menu_tipo == 2 then
        MNZ = gg.choice({
            '💣 • Mine', '🏭 • Construction', '🌟 • Gems',
            '💎 • Ingots', "🎁 • ADVANTAGE HACK",
            "🚀 • BOOSTER LAB HACK", "🚀 • BOOSTER MINIGAME HACK",
            '❌ • Return'
        }, nil, 'CHOOSE ONE OPTION')

        if MNZ == nil then return end
        if MNZ == 1 then menuescolhas2(7) end
        if MNZ == 2 then menuescolhas2(8) end
        if MNZ == 3 then menuescolhas2(9) end
        if MNZ == 4 then menuescolhas2(10) end
        if MNZ == 5 then menuescolhas2(15) end
        if MNZ == 6 then menuescolhas2(16) end
        if MNZ == 7 then menuescolhas2(170) end
        if MNZ == 8 then menuescolhas2(1) end

    elseif menu_tipo == 551 then
        MAVATR = gg.choice({
            '🏭 • 1 year', '🏭 • 2 years', '🏭 • 3 years',
            '🏭 • 4 years', '🏭 • 5 years', '🏭 • 6 years',
            '🏭 • 7 years', '🏭 • 8 years', '🏭 • 9 years',
            '🏭 • 10 years', '🏭 • 11 years', '🏭 • ava 1',
            '🏭 • ava 2', '🏭 • ava 3', '🏭 • ava 4',
            '🏭 • ava 5', '🏭 • ava 6', '🏭 • ava 7',
            '🏭 • ava 8', '🏭 • ava 9', '🏭 • ava 10',
            '🏭 • ava 11', '🏭 • ava 12', '🏭 • ava 13',
            '🏭 • ava 14', '🏭 • ava 15', '🏭 • ava 16',
            '🏭 • ava 17', '🏭 • ava 18', '🏭 • ava 19',
            '🏭 • ava 20', '🏭 • ava 21', '🏭 • ava 22',
            '🏭 • ava 23', '🏭 • ava 24', '🏭 • ava 25',
            '🏭 • ava 26', '🏭 • ava 27', '🏭 • ava 28',
            '🏭 • ava 29', '🏭 • ava 30', '🏭 • ava 31',
            '🏭 • ava 32', '🏭 • ava 33', '🏭 • ava 325',
            '🏭 • ava 326', '🏭 • ava 330', '🏭 • ava 333',
            '🏭 • ava 334', '🏭 • ava 335', '🏭 • ava 339',
            '🏭 • ava 341', '🏭 • ava 347', '🏭 • ava 350',
            '🏭 • ava 354', '🏭 • ava 355', '🏭 • ava 358',
            '🏭 • ava 363', '🏭 • ava 366', '🏭 • ava 369',
            '🏭 • ava 374', '🏭 • ava 381', '🏭 • ava 294',
            '🏭 • ava 153', '🏭 • ava 196', '🏭 • ava 238',
            '🏭 • ava 246', '🏭 • ava 256', '🏭 • ava 265',
            '🏭 • ava 276', '🏭 • ava 277', '🏭 • ava 283',
            '🏭 • ava 284', '🏭 • ava 288', '🏭 • ava 289',
            '🏭 • ava 292', '🏭 • ava 293', '🏭 • ava 296',
            '🏭 • ava 297', '🏭 • ava 299', '🏭 • ava 306',
            '🏭 • ava 308', '🏭 • ava 315', '🏭 • ava 105',
            '🏭 • ava 1', '🏭 • ava 73', '🏭 • ava 23',
            '🏭 • ava 45', '🏭 • ava 25', '🏭 • ava 264',
            '🏭 • ava 348', '🏭 • ava 67', '🏭 • ava 83',
            '🏭 • ava 4', '🏭 • ava 254', '🏭 • ava 63',
            '🏭 • ava 90', '🏭 • ava 91', '🏭 • ava 302',
            '🏭 • ava 305', '🏭 • ava 307', '🏭 • ava 318',
            '🏭 • ava 321', '🏭 • ava 242', '🏭 • ava 243',
            '❌ • Volver'
        }, nil, 'CHOOSE ONE OPTION')
        if MAVATR == nil then return end
        if MAVATR == 1 then hack("t1AVATR") end
        if MAVATR == 2 then hack("t2AVATR") end
        if MAVATR == 3 then hack("t3AVATR") end
        if MAVATR == 4 then hack("t4AVATR") end
        if MAVATR == 5 then hack("t5AVATR") end
        if MAVATR == 6 then hack("t6AVATR") end
        if MAVATR == 7 then hack("t7AVATR") end
        if MAVATR == 8 then hack("t8AVATR") end
        if MAVATR == 9 then hack("t9AVATR") end
        if MAVATR == 10 then hack("t10AVATR") end
        if MAVATR == 11 then hack("t11AVATR") end
        if MAVATR == 12 then hack("t12AVATR") end
        if MAVATR == 13 then hack("t13AVATR") end
        if MAVATR == 14 then hack("t14AVATR") end
        if MAVATR == 15 then hack("t15AVATR") end
        if MAVATR == 16 then hack("t16AVATR") end
        if MAVATR == 17 then hack("t17AVATR") end
        if MAVATR == 18 then hack("t18AVATR") end
        if MAVATR == 19 then hack("t19AVATR") end
        if MAVATR == 20 then hack("t20AVATR") end
        if MAVATR == 21 then hack("t21AVATR") end
        if MAVATR == 22 then hack("t22AVATR") end
        if MAVATR == 23 then hack("t23AVATR") end
        if MAVATR == 24 then hack("t24AVATR") end
        if MAVATR == 25 then hack("t25AVATR") end
        if MAVATR == 26 then hack("t26AVATR") end
        if MAVATR == 27 then hack("t27AVATR") end
        if MAVATR == 28 then hack("t28AVATR") end
        if MAVATR == 29 then hack("t29AVATR") end
        if MAVATR == 30 then hack("t30AVATR") end
        if MAVATR == 31 then hack("t31AVATR") end
        if MAVATR == 32 then hack("t32AVATR") end
        if MAVATR == 33 then hack("t33AVATR") end
        if MAVATR == 34 then hack("t34AVATR") end
        if MAVATR == 35 then hack("t35AVATR") end
        if MAVATR == 36 then hack("t36AVATR") end
        if MAVATR == 37 then hack("t37AVATR") end
        if MAVATR == 38 then hack("t38AVATR") end
        if MAVATR == 39 then hack("t39AVATR") end
        if MAVATR == 40 then hack("t40AVATR") end
        if MAVATR == 41 then hack("t41AVATR") end
        if MAVATR == 42 then hack("t42AVATR") end
        if MAVATR == 43 then hack("t43AVATR") end
        if MAVATR == 44 then hack("t44AVATR") end
        if MAVATR == 45 then hack("t45AVATR") end
        if MAVATR == 46 then hack("t46AVATR") end
        if MAVATR == 47 then hack("t47AVATR") end
        if MAVATR == 48 then hack("t48AVATR") end
        if MAVATR == 49 then hack("t49AVATR") end
        if MAVATR == 50 then hack("t50AVATR") end
        if MAVATR == 51 then hack("t51AVATR") end
        if MAVATR == 52 then hack("t52AVATR") end
        if MAVATR == 53 then hack("t53AVATR") end
        if MAVATR == 54 then hack("t54AVATR") end
        if MAVATR == 55 then hack("t55AVATR") end
        if MAVATR == 56 then hack("t56AVATR") end
        if MAVATR == 57 then hack("t57AVATR") end
        if MAVATR == 58 then hack("t58AVATR") end
        if MAVATR == 59 then hack("t59AVATR") end
        if MAVATR == 60 then hack("t60AVATR") end
        if MAVATR == 61 then hack("t61AVATR") end
        if MAVATR == 62 then hack("t62AVATR") end
        if MAVATR == 63 then hack("t63AVATR") end
        if MAVATR == 64 then hack("t64AVATR") end
        if MAVATR == 65 then hack("t65AVATR") end
        if MAVATR == 66 then hack("t66AVATR") end
        if MAVATR == 67 then hack("t67AVATR") end
        if MAVATR == 68 then hack("t68AVATR") end
        if MAVATR == 69 then hack("t69AVATR") end
        if MAVATR == 70 then hack("t70AVATR") end
        if MAVATR == 71 then hack("t71AVATR") end
        if MAVATR == 72 then hack("t72AVATR") end
        if MAVATR == 73 then hack("t73AVATR") end
        if MAVATR == 74 then hack("t74AVATR") end
        if MAVATR == 75 then hack("t75AVATR") end
        if MAVATR == 76 then hack("t76AVATR") end
        if MAVATR == 77 then hack("t77AVATR") end
        if MAVATR == 78 then hack("t78AVATR") end
        if MAVATR == 79 then hack("t79AVATR") end
        if MAVATR == 80 then hack("t80AVATR") end
        if MAVATR == 81 then hack("t81AVATR") end
        if MAVATR == 82 then hack("t82AVATR") end
        if MAVATR == 83 then hack("t83AVATR") end
        if MAVATR == 84 then hack("t84AVATR") end
        if MAVATR == 85 then hack("t85AVATR") end
        if MAVATR == 86 then hack("t86AVATR") end
        if MAVATR == 87 then hack("t87AVATR") end
        if MAVATR == 88 then hack("t88AVATR") end
        if MAVATR == 89 then hack("t89AVATR") end
        if MAVATR == 90 then hack("t90AVATR") end
        if MAVATR == 91 then hack("t91AVATR") end
        if MAVATR == 92 then hack("t92AVATR") end
        if MAVATR == 93 then hack("t93AVATR") end
        if MAVATR == 94 then hack("t94AVATR") end
        if MAVATR == 95 then hack("t95AVATR") end
        if MAVATR == 96 then hack("t96AVATR") end
        if MAVATR == 97 then hack("t97AVATR") end
        if MAVATR == 98 then hack("t98AVATR") end
        if MAVATR == 99 then hack("t99AVATR") end
        if MAVATR == 100 then hack("t100AVATR") end
        if MAVATR == 101 then hack("t101AVATR") end
        if MAVATR == 102 then hack("t102AVATR") end
        if MAVATR == 103 then hack("t103AVATR") end
        if MAVATR == 104 then hack("t104AVATR") end
        if MAVATR == 105 then hack("t105AVATR") end
        if MAVATR == 106 then menuescolhas2(1) end

    elseif menu_tipo == 552 then
        SDIF = gg.choice({
            '🏭 • Sticker menu 1', '🏭 • Sticker menu 2',
            '❌ • Return'
        }, nil, 'CHOOSE ONE OPTION')

        if SDIF == nil then return end
        if SDIF == 1 then menuescolhas2(7552) end
        if SDIF == 2 then menuescolhas2(8552) end
        if SDIF == 3 then menuescolhas2(1) end

    elseif menu_tipo == 7552 then -- Stickers
        MSTICK = gg.choice({
            '🌟 • Sticker 1', '🌟 • Sticker 2', '🌟 • Sticker 3',
            '🌟 • Sticker 4', '🌟 • Sticker 5', '🌟 • Sticker 6',
            '🌟 • Sticker 7', '🌟 • Sticker 8', '🌟 • Sticker 9',
            '🌟 • Sticker 10', '🌟 • Sticker 11', '🌟 • Sticker 12',
            '🌟 • Sticker 13', '🌟 • Sticker 14', '🌟 • Sticker 15',
            '🌟 • Sticker 16', '🌟 • Sticker 17', '🌟 • Sticker 18',
            '🌟 • Sticker 19', '🌟 • Sticker 20', '🌟 • Sticker 21',
            '🌟 • Sticker 22', '🌟 • Sticker 23', '🌟 • Sticker 24',
            '🌟 • Sticker 25', '🌟 • Sticker 26', '🌟 • Sticker 27',
            '🌟 • Sticker 28', '🌟 • Sticker 29', '🌟 • Sticker 30',
            '🌟 • Sticker 31', '🌟 • Sticker 32', '🌟 • Sticker 33',
            '🌟 • Sticker 34', '🌟 • Sticker 35', '🌟 • Sticker 36',
            '🌟 • Sticker 37', '🌟 • Sticker 38', '🌟 • Sticker 39',
            '🌟 • Sticker 40', '🌟 • Sticker 41', '🌟 • Sticker 42',
            '🌟 • Sticker 43', '🌟 • Sticker 44', '🌟 • Sticker 45',
            '🌟 • Sticker 46', '🌟 • Sticker 47', '🌟 • Sticker 48',
            '🌟 • Sticker 49', '🌟 • Sticker 50', '🌟 • Sticker 51',
            '🌟 • Sticker 52', '🌟 • Sticker 53', '🌟 • Sticker 54',
            '🌟 • Sticker 55', '❌ • Volver'
        }, nil, 'CHOOSE ONE OPTION')
        if MSTICK == nil then return end
        if MSTICK == 1 then hack("t1STICK") end
        if MSTICK == 2 then hack("t2STICK") end
        if MSTICK == 3 then hack("t3STICK") end
        if MSTICK == 4 then hack("t4STICK") end
        if MSTICK == 5 then hack("t5STICK") end
        if MSTICK == 6 then hack("t6STICK") end
        if MSTICK == 7 then hack("t7STICK") end
        if MSTICK == 8 then hack("t8STICK") end
        if MSTICK == 9 then hack("t9STICK") end
        if MSTICK == 10 then hack("t10STICK") end
        if MSTICK == 11 then hack("t11STICK") end
        if MSTICK == 12 then hack("t12STICK") end
        if MSTICK == 13 then hack("t13STICK") end
        if MSTICK == 14 then hack("t14STICK") end
        if MSTICK == 15 then hack("t15STICK") end
        if MSTICK == 16 then hack("t16STICK") end
        if MSTICK == 17 then hack("t17STICK") end
        if MSTICK == 18 then hack("t18STICK") end
        if MSTICK == 19 then hack("t19STICK") end
        if MSTICK == 20 then hack("t20STICK") end
        if MSTICK == 21 then hack("t21STICK") end
        if MSTICK == 22 then hack("t22STICK") end
        if MSTICK == 23 then hack("t23STICK") end
        if MSTICK == 24 then hack("t24STICK") end
        if MSTICK == 25 then hack("t25STICK") end
        if MSTICK == 26 then hack("t26STICK") end
        if MSTICK == 27 then hack("t27STICK") end
        if MSTICK == 28 then hack("t28STICK") end
        if MSTICK == 29 then hack("t29STICK") end
        if MSTICK == 30 then hack("t30STICK") end
        if MSTICK == 31 then hack("t31STICK") end
        if MSTICK == 32 then hack("t32STICK") end
        if MSTICK == 33 then hack("t33STICK") end
        if MSTICK == 34 then hack("t34STICK") end
        if MSTICK == 35 then hack("t35STICK") end
        if MSTICK == 36 then hack("t36STICK") end
        if MSTICK == 37 then hack("t37STICK") end
        if MSTICK == 38 then hack("t38STICK") end
        if MSTICK == 39 then hack("t39STICK") end
        if MSTICK == 40 then hack("t40STICK") end
        if MSTICK == 41 then hack("t41STICK") end
        if MSTICK == 42 then hack("t42STICK") end
        if MSTICK == 43 then hack("t43STICK") end
        if MSTICK == 44 then hack("t44STICK") end
        if MSTICK == 45 then hack("t45STICK") end
        if MSTICK == 46 then hack("t46STICK") end
        if MSTICK == 47 then hack("t47STICK") end
        if MSTICK == 48 then hack("t48STICK") end
        if MSTICK == 49 then hack("t49STICK") end
        if MSTICK == 50 then hack("t50STICK") end
        if MSTICK == 51 then hack("t51STICK") end
        if MSTICK == 52 then hack("t52STICK") end
        if MSTICK == 53 then hack("t53STICK") end
        if MSTICK == 54 then hack("t54STICK") end
        if MSTICK == 55 then hack("t55STICK") end
        if MSTICK == 56 then menuescolhas2(1) end
    elseif menu_tipo == 8552 then -- Stickers
        MSTICKx = gg.choice({
            '🌟 • Sticker 1x', '🌟 • Sticker 2x', '🌟 • Sticker 3x',
            '🌟 • Sticker 4x', '🌟 • Sticker 5x', '🌟 • Sticker 6x',
            '🌟 • Sticker 7x', '🌟 • Sticker 8x', '🌟 • Sticker 9x',
            '🌟 • Sticker 10x', '🌟 • Sticker 11x',
            '🌟 • Sticker 12x', '🌟 • Sticker 13x',
            '🌟 • Sticker 14x', '🌟 • Sticker 15x',
            '🌟 • Sticker 16x', '🌟 • Sticker 17x',
            '🌟 • Sticker 18x', '🌟 • Sticker 19x',
            '🌟 • Sticker 20x', '🌟 • Sticker 21x',
            '🌟 • Sticker 22x', '🌟 • Sticker 23x',
            '🌟 • Sticker 24x', '🌟 • Sticker 25x',
            '🌟 • Sticker 26x', '🌟 • Sticker 27x',
            '🌟 • Sticker 28x', '🌟 • Sticker 29x',
            '🌟 • Sticker 30x', '🌟 • Sticker 31x',
            '🌟 • Sticker 32x', '🌟 • Sticker 33x',
            '🌟 • Sticker 34x', '🌟 • Sticker 35x',
            '🌟 • Sticker 36x', '🌟 • Sticker 37x',
            '🌟 • Sticker 38x', '🌟 • Sticker 39x',
            '🌟 • Sticker 40x', '🌟 • Sticker 41x',
            '🌟 • Sticker 42x', '🌟 • Sticker 43x',
            '🌟 • Sticker 44x', '🌟 • Sticker 45x',
            '🌟 • Sticker 46x', '🌟 • Sticker 47x',
            '🌟 • Sticker 48x', '🌟 • Sticker 49x',
            '🌟 • Sticker 50x', '❌ • Volver'
        }, nil, 'CHOOSE ONE OPTION')
        if MSTICKx == nil then return end
        if MSTICKx == 1 then hack("t1STICKx") end
        if MSTICKx == 2 then hack("t2STICKx") end
        if MSTICKx == 3 then hack("t3STICKx") end
        if MSTICKx == 4 then hack("t4STICKx") end
        if MSTICKx == 5 then hack("t5STICKx") end
        if MSTICKx == 6 then hack("t6STICKx") end
        if MSTICKx == 7 then hack("t7STICKx") end
        if MSTICKx == 8 then hack("t8STICKx") end
        if MSTICKx == 9 then hack("t9STICKx") end
        if MSTICKx == 10 then hack("t10STICKx") end
        if MSTICKx == 11 then hack("t11STICKx") end
        if MSTICKx == 12 then hack("t12STICKx") end
        if MSTICKx == 13 then hack("t13STICKx") end
        if MSTICKx == 14 then hack("t14STICKx") end
        if MSTICKx == 15 then hack("t15STICKx") end
        if MSTICKx == 16 then hack("t16STICKx") end
        if MSTICKx == 17 then hack("t17STICKx") end
        if MSTICKx == 18 then hack("t18STICKx") end
        if MSTICKx == 19 then hack("t19STICKx") end
        if MSTICKx == 20 then hack("t20STICKx") end
        if MSTICKx == 21 then hack("t21STICKx") end
        if MSTICKx == 22 then hack("t22STICKx") end
        if MSTICKx == 23 then hack("t23STICKx") end
        if MSTICKx == 24 then hack("t24STICKx") end
        if MSTICKx == 25 then hack("t25STICKx") end
        if MSTICKx == 26 then hack("t26STICKx") end
        if MSTICKx == 27 then hack("t27STICKx") end
        if MSTICKx == 28 then hack("t28STICKx") end
        if MSTICKx == 29 then hack("t29STICKx") end
        if MSTICKx == 30 then hack("t30STICKx") end
        if MSTICKx == 31 then hack("t31STICKx") end
        if MSTICKx == 32 then hack("t32STICKx") end
        if MSTICKx == 33 then hack("t33STICKx") end
        if MSTICKx == 34 then hack("t34STICKx") end
        if MSTICKx == 35 then hack("t35STICKx") end
        if MSTICKx == 36 then hack("t36STICKx") end
        if MSTICKx == 37 then hack("t37STICKx") end
        if MSTICKx == 38 then hack("t38STICKx") end
        if MSTICKx == 39 then hack("t39STICKx") end
        if MSTICKx == 40 then hack("t40STICKx") end
        if MSTICKx == 41 then hack("t41STICKx") end
        if MSTICKx == 42 then hack("t42STICKx") end
        if MSTICKx == 43 then hack("t43STICKx") end
        if MSTICKx == 44 then hack("t44STICKx") end
        if MSTICKx == 45 then hack("t45STICKx") end
        if MSTICKx == 46 then hack("t46STICKx") end
        if MSTICKx == 47 then hack("t47STICKx") end
        if MSTICKx == 48 then hack("t48STICKx") end
        if MSTICKx == 49 then hack("t49STICKx") end
        if MSTICKx == 50 then hack("t50STICKx") end
        if MSTICKx == 51 then menuescolhas2(1) end

    elseif menu_tipo == 553 then
        MCARTE = gg.choice({
            '💎 • Fountain Sign', '💎 • Aloha Sign',
            '💎 • Aviator Sign', '💎 • Big Screen Sign',
            '💎 • Old Ranch Sign', '💎 • Windmill Sign',
            '💎 • Mechanical Sign', '💎 • Cactus Sign',
            '💎 • Artisan Sign', '💎 • Flower Sign',
            '💎 • Awesome Sign', '💎 • Musical Sign',
            '💎 • Luminous Sign', '💎 • Neon Sign',
            '💎 • Wild West Sign', '💎 • Christmas Sign',
            '💎 • Large Halloween Sign', '💎 • City Day Sign',
            '💎 • Farmer Card', '💎 • City of Lights Card',
            '💎 • City of Dreams Card', '💎 • Ancestral Card',
            '💎 • Stone Card', '💎 • Zero Card', '💎 • Easter Card',
            '💎 • Paranormal Card', '💎 • Inflatable Monster Card',
            '💎 • Snowboard Card', '💎 • Bubblegum World Card',
            '💎 • Beach Bar Card', '💎 • Sweet Home Card',
            '💎 • Story Card', '💎 • Rocker Card', '💎 • Card 26',
            '💎 • Card 27', '💎 • Card 28', '💎 • Card 29',
            '💎 • Card 30', '💎 • Card 31', '💎 • Card 32',
            '💎 • Card 33', '💎 • Card 34', '💎 • Card 35',
            '💎 • Card 36', '💎 • Card 37', '💎 • Card 38',
            '💎 • Card 39', '💎 • Card 40', '💎 • Card 41',
            '💎 • Card 42', '💎 • Card 43', '💎 • Card 44',
            '💎 • Carte 45', '💎 • Card 46', '💎 • Card 47',
            '❌ • Back'
        }, nil, 'CHOOSE ONE OPTION')

        if MCARTE == nil then return end
        if MCARTE == 1 then Cartel_1("r1MCARTE") end
        if MCARTE == 2 then Cartel_2("r2MCARTE") end
        if MCARTE == 3 then Cartel_3("r3MCARTE") end
        if MCARTE == 4 then Cartel_4("r4MCARTE") end
        if MCARTE == 5 then Cartel_5("r5MCARTE") end
        if MCARTE == 6 then Cartel_6("r6MCARTE") end
        if MCARTE == 7 then Cartel_7("r7MCARTE") end
        if MCARTE == 8 then Cartel_8("r8MCARTE") end
        if MCARTE == 9 then Cartel_9("r9MCARTE") end
        if MCARTE == 10 then Cartel_10("r10MCARTE") end
        if MCARTE == 11 then Cartel_11("r11MCARTE") end
        if MCARTE == 12 then Cartel_12("r12MCARTE") end
        if MCARTE == 13 then Cartel_13("r13MCARTE") end
        if MCARTE == 14 then Cartel_14("r14MCARTE") end
        if MCARTE == 15 then Cartel_15("r15MCARTE") end
        if MCARTE == 16 then Cartel_16("r16MCARTE") end
        if MCARTE == 17 then Cartel_17("r17MCARTE") end
        if MCARTE == 18 then Cartel_18("r18MCARTE") end
        if MCARTE == 19 then Cartel_19("r19MCARTE") end
        if MCARTE == 20 then Cartel_20("r20MCARTE") end
        if MCARTE == 21 then Cartel_21("r21MCARTE") end
        if MCARTE == 22 then Cartel_22("r22MCARTE") end
        if MCARTE == 23 then Cartel_23("r23MCARTE") end
        if MCARTE == 24 then Cartel_24("r24MCARTE") end
        if MCARTE == 25 then Cartel_25("r25MCARTE") end
        if MCARTE == 26 then Cartel_26("r26MCARTE") end
        if MCARTE == 27 then Cartel_27("r27MCARTE") end
        if MCARTE == 28 then Cartel_28("r28MCARTE") end
        if MCARTE == 29 then Cartel_29("r29MCARTE") end
        if MCARTE == 30 then Cartel_30("r30MCARTE") end
        if MCARTE == 31 then Cartel_31("r31MCARTE") end
        if MCARTE == 32 then Cartel_32("r32MCARTE") end
        if MCARTE == 33 then Cartel_33("r33MCARTE") end
        if MCARTE == 34 then Cartel_34("r34MCARTE") end
        if MCARTE == 35 then Cartel_35("r35MCARTE") end
        if MCARTE == 36 then Cartel_36("r36MCARTE") end
        if MCARTE == 37 then Cartel_37("r37MCARTE") end
        if MCARTE == 38 then Cartel_38("r38MCARTE") end
        if MCARTE == 39 then Cartel_39("r39MCARTE") end
        if MCARTE == 40 then Cartel_40("r40MCARTE") end
        if MCARTE == 41 then Cartel_41("r41MCARTE") end
        if MCARTE == 42 then Cartel_42("r42MCARTE") end
        if MCARTE == 43 then Cartel_43("r43MCARTE") end
        if MCARTE == 44 then Cartel_44("r44MCARTE") end
        if MCARTE == 45 then Cartel_45("r45MCARTE") end
        if MCARTE == 46 then Cartel_46("r46MCARTE") end
        if MCARTE == 47 then Cartel_47("r47MCARTE") end
        if MCARTE == 48 then Cartel_48("r48MCARTE") end
        if MCARTE == 49 then Cartel_49("r49MCARTE") end
        if MCARTE == 50 then Cartel_50("r50MCARTE") end
        if MCARTE == 51 then Cartel_51("r51MCARTE") end
        if MCARTE == 52 then Cartel_52("r52MCARTE") end
        if MCARTE == 53 then Cartel_53("r53MCARTE") end
        if MCARTE == 54 then Cartel_54("r54MCARTE") end
        if MCARTE == 55 then Cartel_55("r55MCARTE") end
        if MCARTE == 56 then menuescolhas2(1) end

    elseif menu_tipo == 3 then
        MNZ = gg.choice({
            '🐶 • Animals', '💣 • Forge', '💣 • Cow Feed Mill',
            '💣 • Chicken Feed Mill', '💣 • Sheep Feed Mill',
            '❌ • Return'
        }, nil,
                        [[╔════════════════════╗
║ R I S H  G A M I N G ║
╚════════════════════╝]])

        if MNZ == nil then return end
        if MNZ == 1 then hack14() end
        if MNZ == 2 then hack2() end
        if MNZ == 3 then hackAliVacas() end
        if MNZ == 4 then hackAliGallinas() end
        if MNZ == 5 then hackAliOvejas() end
        if MNZ == 6 then MENUFREE() end

    elseif menu_tipo == 5 then
        MNC = gg.choice({
            '🎫 • Order Coupon', '🎫 • Expansion Coupon',
            '🎫 • Granary Coupon', '🎫 • Industry Coupon',
            '🎫 • Train Coupon', '🎫 • Island Coupon',
            '🎫 • Merchant Coupon', '❌ • Return'
        }, nil, 'CHOOSE ONE OPTION')

        if MNC == nil then return end
        if MNC == 1 then hack("a") end
        if MNC == 2 then hack("b") end
        if MNC == 3 then hack("c") end
        if MNC == 4 then hack("d") end
        if MNC == 5 then hack("e") end
        if MNC == 6 then hack("f") end
        if MNC == 7 then hack("mm") end
        if MNC == 8 then menuescolhas2(1) end
    elseif menu_tipo == 22987 then
        MYU = gg.choice({
            '💎 • Badge 1', '💎 • Badge 2', '💎 • Badge 3',
            '💎 • Badge 4', '💎 • Badge 5', '💎 • Badge 6',
            '❌ • Return'
        }, nil, 'CHOOSE ONE OPTION')
        if MYU == nil then return end
        if MYU == 1 then hackBadg("a") end
        if MYU == 2 then hackBadg("b") end
        if MYU == 3 then hackBadg("c") end
        if MYU == 4 then hackBadg("d") end
        if MYU == 5 then hackBadg("e") end
        if MYU == 6 then hackBadg("f") end
        if MYU == 7 then menuescolhas2(1) end
    elseif menu_tipo == 9287 then
        MNxC = gg.choice({'🕷 • Name', '🎫 • Frame', '❌ • Return'},
                         nil, 'CHOOSE ONE OPTION')
        if MNxC == nil then return end
        if MNxC == 1 then Name_1() end
        if MNxC == 2 then Frame_1() end
        if MNxC == 3 then menuescolhas2(1) end

    elseif menu_tipo == 15 then
        MXC = gg.choice({
            "🎁 • 2x Train", "🎁 • Laboratory", "🎁 • Airplane",
            "🎁 • 2x Market", "🎁 • Airplane box",
            "🎁 • 2 game tokens", "🎁 • 50 lucky houses",
            "❌ • Return"

        }, nil, "CHOOSE ONE OPTION")
        if MXC == nil then return end
        if MXC == 1 then hack("lv1") end
        if MXC == 2 then hack("lv2") end
        if MXC == 3 then hack("lv3") end
        if MXC == 4 then hack("lv4") end
        if MXC == 5 then hack("lv5") end
        if MXC == 6 then hack("lv9") end
        if MXC == 7 then hack("lv10") end
        if MXC == 8 then menuescolhas2(1) end

    elseif menu_tipo == 16 then
        MAC = gg.choice({
            "👑 • Ship", "👑 • Train", "👑 • Efficient Foundry",
            "👑 • Market", "👑 • Factories",
            "👑 • Helicopter Orders", "👑 • Rapid Crops",
            "👑 • Double Harvests", "👑 • Double Farms",
            "👑 • Earn Double Heli", "👑 • Chat Requests",
            "👑 • Zoo", "👑 • Craft Two Products",
            "👑 • Double Coins Airplane", "👑 • Orders",
            "👑 • Ingot Ships", "❌ • Return"
        }, nil, "CHOOSE ONE OPTION")

        if MAC == nil then return end
        if MAC == 1 then hack("lb1") end
        if MAC == 2 then hack("lb2") end
        if MAC == 3 then hack("lb3") end
        if MAC == 4 then hack("lb4") end
        if MAC == 5 then hack("lb5") end
        if MAC == 6 then hack("lb6") end
        if MAC == 7 then hack("lb7") end
        if MAC == 8 then hack("lb8") end
        if MAC == 9 then hack("lb9") end
        if MAC == 10 then hack("lb10") end
        if MAC == 11 then hack("lb11") end
        if MAC == 12 then hack("lb12") end
        if MAC == 13 then hack("lb13") end
        if MAC == 14 then hack("lb14") end
        if MAC == 15 then hack("lb15") end
        if MAC == 16 then hack("lb16") end
        if MAC == 17 then menuescolhas2(1) end

    elseif menu_tipo == 170 then
        MRT = gg.choice({
            "⚔️ • lives", "⚔️ • ball", "⚔️ • rockets",
            "⚔️ • bombs", "⚔️ • fire hydrant", "⚔️ • pickaxe",
            "⚔️ • hand", "⚔️ • energy minigame",
            "⚔️ • double", "❌ • Return"
        }, nil, "CHOOSE ONE OPTION")
        if MRT == nil then return end
        if MRT == 1 then hack("lm1") end
        if MRT == 2 then hack("lm2") end
        if MRT == 3 then hack("lm02") end
        if MRT == 4 then hack("lm002") end
        if MRT == 5 then hack("lm3") end
        if MRT == 6 then hack("lm4") end
        if MRT == 7 then hack("lm5") end
        if MRT == 8 then hack("lm6") end
        if MRT == 9 then hack("lm7") end
        if MRT == 10 then menuescolhas2(1) end
    elseif menu_tipo == 6 then
        MNF = gg.choice({
            '🍀 • XP (Wheat)', '📦 • City Market',
            '🏭 • Industry Academy', '🚃📦 • XP Train',
            '🚃📦 • Wheat Train', '🚃 • Freeze Clover Train',
            '🛬📦 • XP Plane 6 boxes',
            '🛬📦 • XP Plane If it doesnt work 1/6 boxes',
            '🛬📦 • Ask for help plane 6 boxes',
            '🛬📦 • XP Plane 9 boxes',
            '🛬📦 • XP Plane If it doesnt work 1/9 boxes',
            '🛬📦 • Ask for help plane 9 boxes',
            '🛬 • Plane return to base',
            '🃏✉️🪧📩🚃 • train card', '🚀 • Heli Auto',
            '💺 • Airplane Auto', '👾 • Freeze Population',
            '❌ • Return'
        }, nil,
                        [[╔════════════════════╗
║ R I S H  G A M I N G ║
╚════════════════════╝]])

        if MNF == nil then return end
        if MNF == 1 then hack16(true) end
        if MNF == 2 then hack13() end
        if MNF == 3 then hack2C() end
        if MNF == 4 then hackTrEn() end
        if MNF == 5 then hackTrEn_1() end -- hackTrEnTrebol_1
        if MNF == 6 then hackTrEnTrebol_1() end
        if MNF == 7 then hackAvion_xp() end
        if MNF == 8 then hackAvion_1() end -- hackAvion_1
        if MNF == 9 then hackPedirAyudaAvion() end -- hackAvion_1
        if MNF == 10 then hackAvion_xp_9() end
        if MNF == 11 then hackAvion_1_9() end -- hackAvion_1
        if MNF == 12 then hackPedirAyudaAvion_9() end -- hackAvion_1
        if MNF == 13 then hackAvion_Volver() end
        if MNF == 14 then hackTrEnCarta_1() end
        if MNF == 15 then hack12() end
        if MNF == 16 then hack("lv6") end
        if MNF == 17 then hack255() end
        if MNF == 18 then MENUFREE() end

    elseif menu_tipo == 7 then
        MNM = gg.choice({
            '💣 • Dynamite', '💣 • Pickaxe', '💣 • Explosive',
            '❌ • Return'
        }, nil, 'CHOOSE ONE OPTION')

        if MNM == nil then return end
        if MNM == 1 then hack("g") end
        if MNM == 2 then hack("h") end
        if MNM == 3 then hack("i") end
        if MNM == 4 then menuescolhas2(2) end

    elseif menu_tipo == 8 then
        MNN = gg.choice({
            '🏭 • Glass', '🏭 • Brick', '🏭 • Slab', '🏭 • Saw',
            '🏭 • Jackhammer', '🏭 • Drill', '❌ • Back'
        }, nil, 'CHOOSE ONE OPTION')

        if MNN == nil then return end
        if MNN == 1 then hack("j") end
        if MNN == 2 then hack("k") end
        if MNN == 3 then hack("l") end
        if MNN == 4 then hack("j2") end
        if MNN == 5 then hack("k2") end
        if MNN == 6 then hack("l2") end
        if MNN == 7 then menuescolhas2(2) end

    elseif menu_tipo == 9 then
        MNU = gg.choice({
            '💎 • Orange', '💎 • Green', '💎 • Red',
            '❌ • Return'
        }, nil, 'CHOOSE ONE OPTION')

        if MNU == nil then return end
        if MNU == 1 then hack("n") end
        if MNU == 2 then hack("m") end
        if MNU == 3 then hack("o") end
        if MNU == 4 then menuescolhas2(2) end

    elseif menu_tipo == 10 then
        FGds = gg.choice({
            '💎 • Bronze Ingot', '💎 • Silver Ingot',
            '💎 • Gold Ingot', '💎 • Platinum Ingot', '❌ • Return'
        }, nil, 'CHOOSE ONE OPTION')

        if FGds == nil then return end
        if FGds == 1 then hack("lg1") end
        if FGds == 2 then hack("lg2") end
        if FGds == 3 then hack("lg3") end
        if FGds == 4 then hack("lg4") end
        if FGds == 5 then menuescolhas2(2) end

    elseif menu_tipo == 11 then
        MaxJE = gg.choice({
            "🛰️ • Skin 1 Castle", "🚀 • Skin 2 Helicopter",
            "⚓ • Skin 3 Helipad", "🎯 • Skin 4 Train",
            "🛬 • Skin 5 Train Station", "🚁 • Skin 6 Airplane",
            "☃️ • Skin 7 Airport", "🚁 • Skin 8 Boats",
            "☃️ • Skin 9 Ports", "🚁 • Skin 10 Chickens",
            "☃️ • Skin 11 Cows", "🚁 • Skin 12 Sheep",
            "☃️ • Skin 13 Pigs", '❌ • Back'
        }, nil, "CHOOSE ONE OPTION")
        if MaxJE == nil then return end
        if MaxJE == 1 then menuescolhas2(101) end
        if MaxJE == 2 then menuescolhas2(102) end
        if MaxJE == 3 then menuescolhas2(103) end
        if MaxJE == 4 then menuescolhas2(104) end
        if MaxJE == 5 then menuescolhas2(105) end
        if MaxJE == 6 then menuescolhas2(106) end
        if MaxJE == 7 then menuescolhas2(107) end
        if MaxJE == 8 then menuescolhas2(108) end
        if MaxJE == 9 then menuescolhas2(109) end
        if MaxJE == 10 then menuescolhas2(110) end
        if MaxJE == 11 then menuescolhas2(111) end
        if MaxJE == 12 then menuescolhas2(112) end
        if MaxJE == 13 then menuescolhas2(113) end
        if MaxJE == 14 then menuescolhas2(1) end

    elseif menu_tipo == 101 then
        MaxJES_1 = gg.choice({
            "🛰️ • Skin 1 Gatsby Island Palace",
            "🚀 • Skin 2 Gatsby Island Mansion",
            "⚓ • Skin 3 Gatsby Island House", "🎯 • Skin 4 Pirate Fort",
            "🛬 • Skin 5 Pirate Base", "🚁 • Skin 6 Pirate Hut",
            "☃️ • Skin 7 Easter Village", "🚁 • Skin 8 Little Paris",
            "☃️ • Skin 9 Aztec Island",
            "🚁 • Skin 10 Neanderthal Island",
            "☃️ • Skin 11 Ice Castle", "🚁 • Skin 12 Witch's House",
            "☃️ • Skin 13 Witch's Mansion",
            "☃️ • Skin 14 Witch's Castle", '❌ • Return'
        }, nil, "CHOOSE ONE OPTION")
        if MaxJES_1 == nil then return end
        if MaxJES_1 == 1 then hack("Cas_1") end
        if MaxJES_1 == 2 then hack("Cas_2") end
        if MaxJES_1 == 3 then hack("Cas_3") end
        if MaxJES_1 == 4 then hack("Cas_4") end
        if MaxJES_1 == 5 then hack("Cas_5") end
        if MaxJES_1 == 6 then hack("Cas_6") end
        if MaxJES_1 == 7 then hack("Cas_7") end
        if MaxJES_1 == 8 then hack("Cas_8") end
        if MaxJES_1 == 9 then hack("Cas_9") end
        if MaxJES_1 == 10 then hackFortress_1() end
        if MaxJES_1 == 11 then hackFortress_2() end
        if MaxJES_1 == 12 then hackFortress_3() end
        if MaxJES_1 == 13 then hackFortress_4() end
        if MaxJES_1 == 14 then hackFortress_5() end
        if MaxJES_1 == 15 then menuescolhas2(11) end
    elseif menu_tipo == 102 then
        MaxJES_2 = gg.choice({
            "🚁 • Skin 1 Helicopter",
            "🚁 • Skin 2 Super Delivery Robot",
            "🚁 • Skin 3 Santa's Little Helper's Sleigh",
            "🚁 • Skin 4 Flying Saucer", "🚁 • Skin 5 Flying Carpet",
            "🚁 • Skin 6 Lounger Drone", "🚁 • Skin 7 Flying Boat",
            "🚁 • Skin 8 Private", "🚁 • Skin 9 Clubber",
            "🚁 • Skin 10 Feathered", "🚁 • Skin 11 HeliEgg",
            "🚁 • Skin 12 Flying Basticapho", "🚁 • Skin 13 Pirate",
            "🚁 • Skin 14 Holiday", "🚁 • Skin 15 Gala",
            "🚁 • Skin 16 Space", "🚁 • Skin 17 Santa's Sleigh",
            "🚁 • Skin 18 Eggplant", "🚁 • Skin 19 Pumpkin-Chopper",
            "🚁 • Skin 20 Surveillance Blimp",
            "🚁 • Skin 21 Flying Cauldron", '❌ • Back'
        }, nil, "CHOOSE ONE OPTION")
        if MaxJES_2 == nil then return end
        if MaxJES_2 == 1 then hack("heli_1") end
        if MaxJES_2 == 2 then hack("heli_2") end
        if MaxJES_2 == 3 then hack("heli_3") end
        if MaxJES_2 == 4 then hack("heli_4") end
        if MaxJES_2 == 5 then hack("heli_5") end
        if MaxJES_2 == 6 then hack("heli_6") end
        if MaxJES_2 == 7 then hack("heli_7") end
        if MaxJES_2 == 8 then hack("heli_8") end
        if MaxJES_2 == 9 then hack("heli_9") end
        if MaxJES_2 == 10 then hack("heli_10") end
        if MaxJES_2 == 11 then hackhelicopter_1() end
        if MaxJES_2 == 12 then hackhelicopter_2() end
        if MaxJES_2 == 13 then hackhelicopter_3() end
        if MaxJES_2 == 14 then hackhelicopter_4() end
        if MaxJES_2 == 15 then hackhelicopter_5() end
        if MaxJES_2 == 16 then hackhelicopter_6() end
        if MaxJES_2 == 17 then hackhelicopter_8() end
        if MaxJES_2 == 18 then hackhelicopter_9() end
        if MaxJES_2 == 19 then hackhelicopter_10() end
        if MaxJES_2 == 20 then hackhelicopter_12() end
        if MaxJES_2 == 21 then hackhelicopter_13() end
        if MaxJES_2 == 22 then menuescolhas2(11) end

    elseif menu_tipo == 103 then
        MaxJES_3 = gg.choice({
            "🚁 • Skin 1 Holiday Helipad",
            "🚁 • Skin 2 Nomads' Harbor Helipad",
            "🚁 • Skin 3 Sports Arena Helipad",
            "🚁 • Skin 4 Flying Saucer Hangar Helipad",
            "🚁 • Skin 5 Base Station Helipad",
            "🚁 • Skin 6 Vegetable Helipad",
            "🚁 • Skin 7 Sultan's Palace Helipad",
            "🚁 • Skin 8 Luxury Helipad", "🚁 • Skin 9 Club Helipad",
            "🚁 • Skin 10 Carnival Stage Helipad",
            "🚁 • Skin 11 Royal Palace Helipad",
            "🚁 • Skin 12 Detective Agency Helipad",
            "🚁 • Skin 13 Sleigh Parking Helipad",
            "🚁 • Skin 14 Gala Helipad", "🚁 • Skin 15 Pirate Helipad",
            "🚁 • Skin 16 Space Helipad Helipad",
            "🚁 • Skin 17 Easter Helipad",
            "🚁 • Skin 18 Sunken Palace Helipad", '❌ • Back'
        }, nil, "CHOOSE ONE OPTION")
        if MaxJES_3 == nil then return end
        if MaxJES_3 == 1 then hackhelicopterPlace_1() end
        if MaxJES_3 == 2 then hackhelicopterPlace_2() end
        if MaxJES_3 == 3 then hackhelicopterPlace_3() end
        if MaxJES_3 == 4 then hackhelicopterPlace_4() end
        if MaxJES_3 == 5 then hackhelicopterPlace_5() end
        if MaxJES_3 == 6 then hackhelicopterPlace_6() end
        if MaxJES_3 == 7 then hackhelicopterPlace_7() end
        if MaxJES_3 == 8 then hackhelicopterPlace_8() end
        if MaxJES_3 == 9 then hackhelicopterPlace_9() end
        if MaxJES_3 == 10 then hackhelicopterPlace_10() end
        if MaxJES_3 == 11 then hackhelicopterPlace_11() end
        if MaxJES_3 == 12 then hackhelicopterPlace_12() end
        if MaxJES_3 == 13 then hackhelicopterPlace_13() end
        if MaxJES_3 == 14 then hackhelicopterPlace_14() end
        if MaxJES_3 == 15 then hackhelicopterPlace_15() end
        if MaxJES_3 == 16 then hackhelicopterPlace_16() end
        if MaxJES_3 == 17 then hackhelicopterPlace_17() end
        if MaxJES_3 == 18 then hackhelicopterPlace_18() end
        if MaxJES_3 == 19 then menuescolhas2(11) end

    elseif menu_tipo == 104 then
        MaxJES_4 = gg.choice({
            "🛰️ • Skin 1 Christmas Train", "🚀 • Skin 2 Ghost Train",
            "⚓ • Skin 3 Ultra Express Train",
            "🎯 • Skin 4 Primordial Express Train",
            "🛬 • Skin 5 Pascual Express Train",
            "🚁 • Skin 6 Theater Express Train",
            "☃️ • Skin 7 Dragon Train",
            "🚁 • Skin 8 Astromobile Train",
            "☃️ • Skin 9 Wooden Wagon Train",
            "🚁 • Skin 10 Musical Train",
            "☃️ • Skin 11 Chivalrous Train",
            "🚁 • Skin 12 Express Railcar Train",
            "☃️ • Skin 13 Disco Train", "☃️ • Skin 14 Floral Train",
            "☃️ • Skin 13 Chrismas 2024",
            "☃️ • Skin 14 Halloween 2024", '❌ • Return'
        }, nil, "CHOOSE ONE OPTION")
        if MaxJES_4 == nil then return end
        if MaxJES_4 == 1 then hack("Tre_1") end
        if MaxJES_4 == 2 then hack("Tre_2") end
        if MaxJES_4 == 3 then hack("Tre_3") end
        if MaxJES_4 == 4 then hack("Tre_4") end
        if MaxJES_4 == 5 then hack("Tre_5") end
        if MaxJES_4 == 6 then hack("Tre_6") end
        if MaxJES_4 == 7 then hack("Tre_7") end
        if MaxJES_4 == 8 then hack("Tre_8") end
        if MaxJES_4 == 9 then hack("Tre_9") end
        if MaxJES_4 == 10 then hack("Tre_10") end
        if MaxJES_4 == 11 then hack("Tre_11") end
        if MaxJES_4 == 12 then hack("Tre_12") end
        if MaxJES_4 == 13 then hack("Tre_13") end
        if MaxJES_4 == 14 then hack("Tre_14") end
        if MaxJES_4 == 15 then hacktrain_1() end
        if MaxJES_4 == 16 then hacktrain_2() end
        if MaxJES_4 == 17 then menuescolhas2(11) end
    elseif menu_tipo == 105 then
        MaxJES_5 = gg.choice({
            "🛰️ • Express Gate Station Skin 1",
            "🚀 • Haunted Station Skin 2", "⚓ • Disco Station Skin 3",
            "🎯 • Space Station Skin 4", "🛬 • Mythical Station Skin 5",
            "🚁 • Flower Festival Station Skin 6",
            "☃️ • Training Camp Station Skin 7",
            "🚁 • Recording Station Skin 8",
            "☃️ • Castle Station Skin 9",
            "🚁 • Romantic Station Skin 10",
            "☃️ • Easter Station Skin 11",
            "🚁 • Cowboy Station Skin 12",
            "☃️ • Backstage Station Skin 13",
            "☃️ • China Station Skin 14",
            "🚁 • Halloween Station Skin 15",
            "☃️ • Primitive Settlement Station Skin 16",
            "☃️ • Christmas Station Skin 17", '❌ • Back'
        }, nil, "CHOOSE ONE OPTION")
        if MaxJES_5 == nil then return end
        if MaxJES_5 == 1 then hack("Esta_1") end
        if MaxJES_5 == 2 then hack("Esta_2") end
        if MaxJES_5 == 3 then hack("Esta_3") end
        if MaxJES_5 == 4 then hack("Esta_4") end
        if MaxJES_5 == 5 then hacktrain_station_1() end
        if MaxJES_5 == 6 then hacktrain_station_2() end
        if MaxJES_5 == 7 then hacktrain_station_3() end
        if MaxJES_5 == 8 then hacktrain_station_4() end
        if MaxJES_5 == 9 then hacktrain_station_5() end
        if MaxJES_5 == 10 then hacktrain_station_6() end
        if MaxJES_5 == 11 then hacktrain_station_7() end
        if MaxJES_5 == 12 then hacktrain_station_8() end
        if MaxJES_5 == 13 then hacktrain_station_9() end
        if MaxJES_5 == 14 then hacktrain_station_10() end
        if MaxJES_5 == 15 then hacktrain_station_11() end
        if MaxJES_5 == 16 then hacktrain_station_12() end
        if MaxJES_5 == 17 then hacktrain_station_13() end
        if MaxJES_5 == 18 then menuescolhas2(11) end
    elseif menu_tipo == 106 then
        MaxJES_6 = gg.choice({
            "🛬 • Rocket Plane Skin 1",
            "🛬 • Super Rocket Plane Skin 2",
            "🛬 • Supersonic Dragon Plane Skin 3",
            "🛬 • Space Rocket Plane Skin 4", "🛬 • Rock Plane Skin 5",
            "🛬 • Aero Plane Skin 6", "🛬 • Frosted Plane Skin 7",
            "🛬 • Lucky Plane Skin 8", "🛬 • Arabian Plane Skin 9",
            "🛬 • Fashion Plane Skin 10", "🛬 • Stealth Plane Skin 11",
            "🛬 • Seaplane Skin 12", "🛬 • Festive Plane Skin 13",
            "🛬 • Spectral Plane Skin 14", "🛬 • Avian Plane Skin 15",
            "🛬 • Flying Triene Plane Skin 16",
            "🛬 • Symphonic Plane Skin 17", '❌ • Back'
        }, nil, "CHOOSE ONE OPTION")
        if MaxJES_6 == nil then return end
        if MaxJES_6 == 1 then hack("Avio_1") end
        if MaxJES_6 == 2 then hack("Avio_2") end
        if MaxJES_6 == 3 then hack("Avio_3") end
        if MaxJES_6 == 4 then hack("Avio_4") end
        if MaxJES_6 == 5 then hack("Avio_5") end
        if MaxJES_6 == 6 then hack("Avio_6") end
        if MaxJES_6 == 7 then hack("Avio_7") end
        if MaxJES_6 == 8 then hack("Avio_8") end
        if MaxJES_6 == 9 then hack("Avio_9") end
        if MaxJES_6 == 10 then hack("Avio_10") end
        if MaxJES_6 == 11 then hack("Avio_11") end
        if MaxJES_6 == 12 then hackairplane_1() end
        if MaxJES_6 == 13 then hackairplane_2() end
        if MaxJES_6 == 14 then hackairplane_3() end
        if MaxJES_6 == 15 then hackairplane_4() end
        if MaxJES_6 == 16 then hackairplane_5() end
        if MaxJES_6 == 17 then hackairplane_7() end
        if MaxJES_6 == 18 then menuescolhas2(11) end
    elseif menu_tipo == 107 then
        MaxJES_7 = gg.choice({
            "🛬 • Skin 1 Rocker Airport", "🛬 • Skin 2 Sweet Airport",
            "🛬 • Skin 3 Movie Airport",
            "🛬 • Skin 4 Secret Base Airport",
            "🛬 • Skin 5 Aero Airport", "🛬 • Skin 6 Space Airport",
            "🛬 • Skin 7 Festival Airport",
            "🛬 • Skin 8 Tropical Airport",
            "🛬 • Skin 9 Rainbow Airport",
            "🛬 • Skin 10 Five-Star Airport",
            "🛬 • Skin 11 Santa's House Airport",
            "🛬 • Skin 12 Symphony Airport",
            "🛬 • Skin 13 Ghost Airport",
            "🛬 • Skin 14 Pascual Airport",
            "🛬 • Skin 15 Ski Resort Airport", '❌ • Return'
        }, nil, "CHOOSE ONE OPTION")
        if MaxJES_7 == nil then return end
        if MaxJES_7 == 1 then hack("Aero_1") end
        if MaxJES_7 == 2 then hack("Aero_2") end
        if MaxJES_7 == 3 then hack("Aero_3") end
        if MaxJES_7 == 4 then hack("Aero_4") end
        if MaxJES_7 == 5 then hack("Aero_5") end
        if MaxJES_7 == 6 then hack("Aero_6") end
        if MaxJES_7 == 7 then hack("Aero_7") end
        if MaxJES_7 == 8 then hack("Aero_8") end
        if MaxJES_7 == 9 then hack("Aero_9") end
        if MaxJES_7 == 10 then hackairport_1() end
        if MaxJES_7 == 11 then hackairport_2() end
        if MaxJES_7 == 12 then hackairport_3() end
        if MaxJES_7 == 13 then hackairport_4() end
        if MaxJES_7 == 14 then hackairport_5() end
        if MaxJES_7 == 15 then hackairport_6() end
        if MaxJES_7 == 16 then menuescolhas2(11) end

    elseif menu_tipo == 108 then
        MaxJES_8 = gg.choice({
            "🛰️ • Skin 1 Cruise Ship",
            "🚀 • Skin 2 Greek Bireme Ship", "⚓ • Skin 3 Viking Ship",
            "🎯 • Skin 4 Steamship", "🛬 • Skin 5 Arctic Ship",
            "🚁 • Skin 6 Gift Ship", "☃️ • Skin 7 Ghost Ship",
            "🚁 • Skin 8 Holiday Boat", "☃️ • Skin 9 Love Boat",
            '❌ • Volver'
        }, nil, "CHOOSE ONE OPTION")
        if MaxJES_8 == nil then return end
        if MaxJES_8 == 1 then hack("Barc_1") end
        if MaxJES_8 == 2 then hack("Barc_2") end
        if MaxJES_8 == 3 then hack("Barc_3") end
        if MaxJES_8 == 4 then hack("Barc_4") end
        if MaxJES_8 == 5 then hack("Barc_5") end
        if MaxJES_8 == 6 then hackship_1() end
        if MaxJES_8 == 7 then hackship_2() end
        if MaxJES_8 == 8 then hackship_3() end
        if MaxJES_8 == 9 then hackship_4() end
        if MaxJES_8 == 10 then menuescolhas2(11) end
    elseif menu_tipo == 109 then
        MaxJES_9 = gg.choice({
            "🛰️ • Skin 1 Tropical Port", "🚀 • Skin 2 Pirate Port",
            "⚓ • Skin 3 Classic Port", "🎯 • Skin 4 Jungle Port",
            "🛬 • Skin 5 Viking Port", "🚁 • Skin 6 Christmas Port",
            "☃️ • Skin 7 Port Tavern Port", "🚁 • Skin 8 Sugar Port",
            "☃️ • Skin 9 Creepy Port", "🚁 • Skin 10 Holiday Port",
            "☃️ • Skin 11 Romantic Port", '❌ • Back'
        }, nil, "CHOOSE ONE OPTION")
        if MaxJES_9 == nil then return end
        if MaxJES_9 == 1 then hack("Puer_1") end
        if MaxJES_9 == 2 then hack("Puer_2") end
        if MaxJES_9 == 3 then hack("Puer_3") end
        if MaxJES_9 == 4 then hack("Puer_4") end
        if MaxJES_9 == 5 then hack("Puer_5") end
        if MaxJES_9 == 6 then hackharbor_1() end
        if MaxJES_9 == 7 then hackharbor_2() end
        if MaxJES_9 == 8 then hackharbor_3() end
        if MaxJES_9 == 9 then hackharbor_4() end
        if MaxJES_9 == 10 then hackharbor_5() end
        if MaxJES_9 == 11 then hackharbor_6() end
    elseif menu_tipo == 110 then
        MaxJES_110 = gg.choice({
            "🛰️ • Skin 1 Festive Hen", "🚀 • Skin 2 Hen with Chiton",
            "⚓ • Skin 3 Leprechaun Hen", "🎯 • Skin 4 Birthday Hen",
            "🛬 • Skin 5 Adventurous Hen",
            "🚁 • Skin 6 Cheerleader Hen", "☃️ • Skin 7 Pilot Hen",
            "🚁 • Skin 8 Disco Hen", "☃️ • Skin 9 Hens",
            "🚁 • Skin 10 Hens", "☃️ • Skin 11 Hens",
            "🚁 • Skin 12 Hens", "☃️ • Skin 13 Hens", '❌ • Return'
        }, nil, "CHOOSE ONE OPTION")
        if MaxJES_110 == nil then return end
        if MaxJES_110 == 1 then hack("Galli_1") end
        if MaxJES_110 == 2 then hack("Galli_2") end
        if MaxJES_110 == 3 then hack("Galli_3") end
        if MaxJES_110 == 4 then hack("Galli_4") end
        if MaxJES_110 == 5 then hack("Galli_5") end
        if MaxJES_110 == 6 then hack("Galli_6") end
        if MaxJES_110 == 7 then hack("Galli_7") end
        if MaxJES_110 == 8 then hack("Galli_8") end
        if MaxJES_110 == 9 then menuescolhas2(109) end
        if MaxJES_110 == 10 then menuescolhas2(110) end
        if MaxJES_110 == 11 then menuescolhas2(111) end
        if MaxJES_110 == 12 then menuescolhas2(112) end
        if MaxJES_110 == 13 then menuescolhas2(113) end
        if MaxJES_110 == 14 then menuescolhas2(11) end
    elseif menu_tipo == 111 then
        MaxJES_111 = gg.choice({
            "🛰️ • Corsair Cow Skin 1", "🚀 • Elegant Cow Skin 2",
            "⚓ • Arctic Cow Skin 3", "🎯 • Verbena Cow Skin 4",
            "🛬 • Atlantean Queen Cow Skin 5", "🚁 • Spy Cow Skin 6",
            "☃️ • Paschal Cow Skin 7", "🚁 • Astronaut Cow Skin 8",
            "☃️ • Bloodsucking Cow Skin 9", "🚁 • Alpine Cow Skin 10",
            "☃️ • Cow Skin 11", "🚁 • Cow Skin 12",
            "☃️ • Cow Skin 13", '❌ • Return'
        }, nil, "CHOOSE ONE OPTION")
        if MaxJES_111 == nil then return end
        if MaxJES_111 == 1 then hack("Vaca_1") end
        if MaxJES_111 == 2 then hack("Vaca_2") end
        if MaxJES_111 == 3 then hack("Vaca_3") end
        if MaxJES_111 == 4 then hack("Vaca_4") end
        if MaxJES_111 == 5 then hack("Vaca_5") end
        if MaxJES_111 == 6 then hack("Vaca_6") end
        if MaxJES_111 == 7 then hack("Vaca_7") end
        if MaxJES_111 == 8 then hack("Vaca_8") end
        if MaxJES_111 == 9 then hack("Vaca_9") end
        if MaxJES_111 == 10 then hack("Vaca_10") end
        if MaxJES_111 == 11 then menuescolhas2(111) end
        if MaxJES_111 == 12 then menuescolhas2(112) end
        if MaxJES_111 == 13 then menuescolhas2(113) end
        if MaxJES_111 == 14 then menuescolhas2(11) end
    elseif menu_tipo == 112 then
        MaxJES_112 = gg.choice({
            "🛰️ • Skin 1 Rocker Sheep", "🚀 • Skin 2 Beeelica Sheep",
            "⚓ • Skin 3 Egyptian Sheep", "🎯 • Skin 4 Carnival Sheep",
            "🛬 • Skin 5 Noble Bandit Sheep",
            "🚁 • Skin 6 Birthday Sheep",
            "☃️ • Skin 7 Research Sheep",
            "🚁 • Skin 8 Gladiator Sheep", "☃️ • Skin 9 Easter Sheep",
            "🚁 • Skin 10 Festival Sheep", "☃️ • Skin 11 Gala Sheep",
            "🚁 • Skin 12 Sheep", "☃️ • Skin 13 Sheep",
            '❌ • Return'
        }, nil, "CHOOSE ONE OPTION")
        if MaxJES_112 == nil then return end
        if MaxJES_112 == 1 then hack("Ovej_1") end
        if MaxJES_112 == 2 then hack("Ovej_2") end
        if MaxJES_112 == 3 then hack("Ovej_3") end
        if MaxJES_112 == 4 then hack("Ovej_4") end
        if MaxJES_112 == 5 then hack("Ovej_5") end
        if MaxJES_112 == 6 then hack("Ovej_6") end
        if MaxJES_112 == 7 then hack("Ovej_7") end
        if MaxJES_112 == 8 then hack("Ovej_8") end
        if MaxJES_112 == 9 then hack("Ovej_9") end
        if MaxJES_112 == 10 then hack("Ovej_10") end
        if MaxJES_112 == 11 then hack("Ovej_11") end
        if MaxJES_112 == 12 then menuescolhas2(112) end
        if MaxJES_112 == 13 then menuescolhas2(113) end
        if MaxJES_112 == 14 then menuescolhas2(11) end
    elseif menu_tipo == 113 then
        MaxJESxd_113 = gg.choice({
            "🛰️ • Cerdo Ceremonial", "🛰️ • Cerdo valentin",
            '❌ • Volver'
        }, nil, "CHOOSE ONE OPTION")
        if MaxJESxd_113 == nil then return end
        if MaxJESxd_113 == 1 then hack("Cerdj_1") end
        if MaxJESxd_113 == 2 then hack("Cerdj_2") end
        if MaxJESxd_113 == 3 then menuescolhas2(11) end
    elseif menu_tipo == 12 then
        MaxJP = gg.choice({
            "🎲 • Decoration 1", "🎲 • Decoration 2",
            "🎲 • Valentine's Day", "🎲 • Christmas",
            "🎲 • Halloween", "🎲 • The First", "🎲 • Sports",
            "🎲 • Airplane", "🎲 • Candy", "🎲 • Ruins",
            "🎲 • Townshi Statues", "🎲 • Tree", "🎲 • Inflatable",
            "🎲 • Puzzle", "🎲 • Diamonds", "🎲 • China",
            "🎲 • Event Decoration", "🎲 • Kids Decoration",
            "🎲 • Expedition", "❌ • Return"
        }, nil, "CHOOSE ONE OPTION")
        if MaxJP == nil then return end
        if MaxJP == 1 then menuescolhas2(1220) end
        if MaxJP == 2 then menuescolhas2(1350) end
        if MaxJP == 3 then menuescolhas2(120) end
        if MaxJP == 4 then menuescolhas2(121) end
        if MaxJP == 5 then menuescolhas2(123) end
        if MaxJP == 6 then menuescolhas2(124) end
        if MaxJP == 7 then menuescolhas2(125) end
        if MaxJP == 8 then menuescolhas2(126) end
        if MaxJP == 9 then menuescolhas2(127) end
        if MaxJP == 10 then menuescolhas2(128) end
        if MaxJP == 11 then menuescolhas2(129) end
        if MaxJP == 12 then menuescolhas2(130) end
        if MaxJP == 13 then menuescolhas2(131) end
        if MaxJP == 14 then menuescolhas2(132) end
        if MaxJP == 15 then menuescolhas2(133) end
        if MaxJP == 16 then menuescolhas2(134) end
        if MaxJP == 17 then menuescolhas2(135) end
        if MaxJP == 18 then menuescolhas2(136) end
        if MaxJP == 19 then menuescolhas2(5360) end
        if MaxJP == 20 then menuescolhas2(1) end

    elseif menu_tipo == 1220 then
        MaxJTyMT = gg.choice({
            "🎲 • Walk of Fame", "🎲 • Venetian Bridge",
            "🎲 • Transformation Studio", "🎲 • Open-air Planetarium",
            "🎲 • Vineyard Cafe", "🎲 • Happy Elephants",
            "🎲 • Maxi Blender", --
            "🎲 • Macedonian Parterre", --
            "🎲 • Stilt Dance", "🎲 • Loch Ness Monster",
            "🎲 • Haunted Ship", "🎲 • Diplodocus",
            "🎲 • Galloping", "🎲 • Stonehenge", "🎲 • Waterfall",
            "🎲 • Hourglass", "🎲 • Peacock Statue",
            "🎲 • Atlantean Trident", "🎲 • Pixies", --
            "🎲 • Statue Sea Relic", "🎲 • Coral Corner",
            "🎲 • Sea Explorers", "🎲 • Lily Pad Fairy", --
            "🎲 • Treasure Keeper", "🎲 • Falconry",
            "🎲 • Ghost Ship", "🎲 • Carnivorous Plant",
            "🎲 • Flower Swing", --
            "🎲 • Cocoloco Beach Bar", "🎲 • Surf Pool",
            "🎲 • Bungalow", "🎲 • Palm Tree Seesaw",
            "🎲 • Farmer's Totem", "🎲 • Scribe's Workshop",
            "🎲 • Naval Cannon", "🎲 • Flower Palette",
            "🎲 • Magic Tap", "🎲 • Music Fountain",
            "🎲 • Gramophone Carousel", "🎲 • Set Filming",
            "🎲 • Movie Fountain", "🎲 • Music Store",
            "🎲 • Pharaoh Statue", "🎲 • Papyrus Boat",
            "🎲 • Trojan Horse", "🎲 • Amphitheater",
            "🎲 • Arabian Horse", "🎲 • Swan Pond",
            "🎲 • Weeping Willow", "🎲 • Fallen Tree",
            "🎲 • Waterfall", "🎲 • Satellite Station",
            "🎲 • Parisian Square", "🎲 • Bike Parking",
            "🎲 • Bookstore", "🎲 • Flower Boutique",
            "🎲 • Giant Synthesizer", "❌ • Return"
        }, nil, "CHOOSE ONE OPTION")
        if MaxJTyMT == nil then return end
        if MaxJTyMT == 1 then hack("r14px") end
        if MaxJTyMT == 2 then hack("r15px") end
        if MaxJTyMT == 3 then hack("r16px") end
        if MaxJTyMT == 4 then hack("r1JTyMT") end
        if MaxJTyMT == 5 then hack("r2JTyMT") end
        if MaxJTyMT == 6 then hack("r3JTyMT") end
        if MaxJTyMT == 7 then hack("r4JTyMT") end
        if MaxJTyMT == 8 then hack("r5JTyMT") end
        if MaxJTyMT == 9 then hack("r6JTyMT") end
        if MaxJTyMT == 10 then hack("r7JTyMT") end
        if MaxJTyMT == 11 then hack("r8JTyMT") end
        if MaxJTyMT == 12 then hack("r9JTyMT") end
        if MaxJTyMT == 13 then hack("r10JTyMT") end
        if MaxJTyMT == 14 then hack("r11JTyMT") end
        if MaxJTyMT == 15 then hack("r12JTyMT") end
        if MaxJTyMT == 16 then hack("r13JTyMT") end
        if MaxJTyMT == 17 then hack("r14JTyMT") end
        if MaxJTyMT == 18 then hack("r15JTyMT") end
        if MaxJTyMT == 19 then hack("r16JTyMT") end
        if MaxJTyMT == 20 then hack("r17JTyMT") end
        if MaxJTyMT == 21 then hack("r18JTyMT") end
        if MaxJTyMT == 22 then hack("r19JTyMT") end
        if MaxJTyMT == 23 then hack("r20JTyMT") end
        if MaxJTyMT == 24 then hack("r21JTyMT") end
        if MaxJTyMT == 25 then hack("r22JTyMT") end
        if MaxJTyMT == 26 then hack("r23JTyMT") end
        if MaxJTyMT == 27 then hack("r24JTyMT") end
        if MaxJTyMT == 28 then hack("r25JTyMT") end
        if MaxJTyMT == 29 then hack("r26JTyMT") end
        if MaxJTyMT == 30 then hack("r27JTyMT") end
        if MaxJTyMT == 31 then hack("r28JTyMT") end
        if MaxJTyMT == 32 then hack("r29JTyMT") end
        if MaxJTyMT == 33 then hack("r30JTyMT") end
        if MaxJTyMT == 34 then hack("r31JTyMT") end
        if MaxJTyMT == 35 then hack("r32JTyMT") end
        if MaxJTyMT == 36 then hack("r33JTyMT") end
        if MaxJTyMT == 37 then hack("r34JTyMT") end
        if MaxJTyMT == 38 then hack("r35JTyMT") end
        if MaxJTyMT == 39 then hack("r36JTyMT") end
        if MaxJTyMT == 40 then hack("r37JTyMT") end
        if MaxJTyMT == 41 then hack("r38JTyMT") end
        if MaxJTyMT == 42 then hack("r39JTyMT") end
        if MaxJTyMT == 43 then hack("r40JTyMT") end
        if MaxJTyMT == 44 then hack("r41JTyMT") end
        if MaxJTyMT == 45 then hack("r42JTyMT") end
        if MaxJTyMT == 46 then hack("r43JTyMT") end
        if MaxJTyMT == 47 then hack("r44JTyMT") end
        if MaxJTyMT == 48 then hack("r45JTyMT") end
        if MaxJTyMT == 49 then hack("r46JTyMT") end
        if MaxJTyMT == 50 then hack("r47JTyMT") end
        if MaxJTyMT == 51 then hack("r48JTyMT") end
        if MaxJTyMT == 52 then hack("r49JTyMT") end
        if MaxJTyMT == 53 then hack("r50JTyMT") end
        if MaxJTyMT == 54 then hack("r51JTyMT") end
        if MaxJTyMT == 55 then hack("r52JTyMT") end
        if MaxJTyMT == 56 then hack("r53JTyMT") end
        if MaxJTyMT == 57 then hack("r54JTyMT") end
        if MaxJTyMT == 58 then menuescolhas2(12) end
    elseif menu_tipo == 1350 then
        MaxDECORT = gg.choice({
            "🎲 • Dancing Fountain", "🎲 • Water Slide",
            "🎲 • Outdoor Pizzeria", "🎲 • Artist District",
            "🎲 • Elephant Carousel", "🎲 • Whale Fountain",
            "🎲 • Lifeguard Tower", "🎲 • Rainbow Arch",
            "🎲 • Noodle Shop", "🎲 • New Record Fountain",
            "🎲 • Restaurant", "🎲 • Submarine", "🎲 • Yellow Dog",
            "🎲 • Marine Fence", "🎲 • Admiral's Anchor",
            "🎲 • Seahorse", "🎲 • The Mermaid",
            "🎲 • Fishing Octopus", "🎲 • Pilot Bee",
            "🎲 • Infinite Staircase", "🎲 • Hermit Crab",
            "🎲 • Pier Market", "🎲 • Children's Carousel",
            "🎲 • Jet Ski", "🎲 • Carp Pond", "🎲 • Dovecote",
            "🎲 • Vegetable Cart", "🎲 • Children's Park",
            "🎲 • Pink Water Lily", "🎲 • Catamaran",
            "🎲 • Wind Turbine", "🎲 • Zebra Print",
            "🎲 • Gate of Glory", "🎲 • Golden Fence",
            "🎲 • Picnic Gazebo", "🎲 • Sun Monument",
            "🎲 • Luxury House", "🎲 • Candy Shower Sign",
            "🎲 • Suspension Bridge", "🎲 • Airboat",
            "🎲 • Visit to the Dolphins", "🎲 • Milkshake Pyramid",
            "🎲 • Topiary Contest", "🎲 • Pasta House",
            "🎲 • Medieval Throne", "🎲 • Wild West Merry-Go-Round",
            "🎲 • Traveling Circus", "🎲 • Wild West Playground",
            "🎲 • Stuffed Unicorn", "🎲 • Spring Festival",
            "🎲 • Exotic Snack Bar", "🎲 • Fruit Assortment",
            "🎲 • Floral Fairy Fountain", "🎲 • Rainbow Factory",
            "🎲 • Milkshake Pyramid", "🎲 • Natural Wonder Work of Art",
            "🎲 • Inflatable Challenge", "🎲 • Monster Truck",
            "🎲 • Around the World", "🎲 • Kingdom Center",
            "🎲 • Curlin", "🎲 • Book of Nature",
            "🎲 • The Sea Trotter", "🎲 • Macedonian Parterre",
            "❌ • Return"
        }, nil, "CHOOSE ONE OPTION")
        if MaxDECORT == nil then return end
        if MaxDECORT == 1 then hack("r1DECORT") end
        if MaxDECORT == 2 then hack("r2DECORT") end
        if MaxDECORT == 3 then hack("r3DECORT") end
        if MaxDECORT == 4 then hack("r4DECORT") end
        if MaxDECORT == 5 then hack("r5DECORT") end
        if MaxDECORT == 6 then hack("r6DECORT") end
        if MaxDECORT == 7 then hack("r7DECORT") end
        if MaxDECORT == 8 then hack("r8DECORT") end
        if MaxDECORT == 9 then hack("r9DECORT") end
        if MaxDECORT == 10 then hack("r10DECORT") end
        if MaxDECORT == 11 then hack("r11DECORT") end
        if MaxDECORT == 12 then hack("r12DECORT") end
        if MaxDECORT == 13 then hack("r13DECORT") end
        if MaxDECORT == 14 then hack("r14DECORT") end
        if MaxDECORT == 15 then hack("r15DECORT") end
        if MaxDECORT == 16 then hack("r16DECORT") end
        if MaxDECORT == 17 then hack("r17DECORT") end
        if MaxDECORT == 18 then hack("r18DECORT") end
        if MaxDECORT == 19 then hack("r19DECORT") end
        if MaxDECORT == 20 then hack("r20DECORT") end
        if MaxDECORT == 21 then hack("r21DECORT") end
        if MaxDECORT == 22 then hack("r22DECORT") end
        if MaxDECORT == 23 then hack("r23DECORT") end
        if MaxDECORT == 24 then hack("r24DECORT") end
        if MaxDECORT == 25 then hack("r25DECORT") end
        if MaxDECORT == 26 then hack("r26DECORT") end
        if MaxDECORT == 27 then hack("r27DECORT") end
        if MaxDECORT == 28 then hack("r28DECORT") end
        if MaxDECORT == 29 then hack("r29DECORT") end
        if MaxDECORT == 30 then hack("r30DECORT") end
        if MaxDECORT == 31 then hack("r31DECORT") end
        if MaxDECORT == 32 then hack("r32DECORT") end
        if MaxDECORT == 33 then hack("r33DECORT") end
        if MaxDECORT == 34 then hack("r34DECORT") end
        if MaxDECORT == 35 then hack("r35DECORT") end
        if MaxDECORT == 36 then hack("r36DECORT") end
        if MaxDECORT == 37 then hack("r37DECORT") end
        if MaxDECORT == 38 then hack("r38DECORT") end
        if MaxDECORT == 39 then hack("r39DECORT") end
        if MaxDECORT == 40 then hack("r40DECORT") end
        if MaxDECORT == 41 then hack("r41DECORT") end
        if MaxDECORT == 42 then hack("r42DECORT") end
        if MaxDECORT == 43 then hack("r43DECORT") end
        if MaxDECORT == 44 then hack("r44DECORT") end
        if MaxDECORT == 45 then hack("r45DECORT") end
        if MaxDECORT == 46 then hack("r46DECORT") end
        if MaxDECORT == 47 then hack("r47DECORT") end
        if MaxDECORT == 48 then hack("r48DECORT") end
        if MaxDECORT == 49 then hack("r49DECORT") end
        if MaxDECORT == 50 then hack("r50DECORT") end
        if MaxDECORT == 51 then hack("r51DECORT") end
        if MaxDECORT == 52 then hack("r52DECORT") end
        if MaxDECORT == 53 then hack("r53DECORT") end
        if MaxDECORT == 54 then hack("r54DECORT") end
        if MaxDECORT == 55 then hack("r55DECORT") end
        if MaxDECORT == 56 then hack("r56DECORT") end
        if MaxDECORT == 57 then hack("r57DECORT") end
        if MaxDECORT == 58 then hack("r58DECORT") end
        if MaxDECORT == 59 then hack("r59DECORT") end
        if MaxDECORT == 60 then hack("r60DECORT") end
        if MaxDECORT == 61 then hack("r61DECORT") end
        if MaxDECORT == 62 then hack("r62DECORT") end
        if MaxDECORT == 63 then hack("r63DECORT") end
        if MaxDECORT == 64 then hack("r64DECORT") end
        if MaxDECORT == 65 then menuescolhas2(12) end

    elseif menu_tipo == 120 then
        MaxJTyP = gg.choice({
            "❤ • Cat Love Statue", "❤️ • Care Bear",
            "❤️ • Romantic Date", "❤️ • Love Messenger Statue",
            "❤️ • The Bride and Groom Lived", "❤️ • Doves in Love",
            "❤️ • Heart Floral Bed", "❤️ • Arch of Love",
            "❤️ • Adorable Kitten", "❤️ • Stuffed Rabbit",
            "❤️ • Cupid's Arrow", "❤️ • Lovers' Bench",
            "❤️ • Lovers' Pilot", "❤️ • Flying Hearts",
            "❤️ • Cupid's Eye", "❤️ • Ideal Couple Photocall",
            "❤️ • Mini Park romantic", "❤️ • carriage",
            "❤️ • Bridal Bouquet", "❤️ • Eternal Love",
            "❤️ • Fairytale Rose", "❌ • Return"
        }, nil, "CHOOSE ONE OPTION")
        if MaxJTyP == nil then return end
        if MaxJTyP == 1 then hack("r1p") end
        if MaxJTyP == 2 then hack("r2p") end
        if MaxJTyP == 3 then hack("r3p") end
        if MaxJTyP == 4 then hack("r4p") end
        if MaxJTyP == 5 then hack("r5p") end
        if MaxJTyP == 6 then hack("r6p") end
        if MaxJTyP == 7 then hack("r7p") end
        if MaxJTyP == 8 then hack("r8p") end
        if MaxJTyP == 9 then hack("r9p") end
        if MaxJTyP == 10 then hack("r10p") end
        if MaxJTyP == 11 then hack("r11p") end
        if MaxJTyP == 12 then hack("r12p") end
        if MaxJTyP == 13 then hack("r13p") end
        if MaxJTyP == 14 then hack("r14p") end
        if MaxJTyP == 15 then hack("r15p") end
        if MaxJTyP == 16 then hack("r1664p") end
        if MaxJTyP == 17 then hack("r1665p") end
        if MaxJTyP == 18 then hack("r1666p") end
        if MaxJTyP == 19 then hack("r1667p") end
        if MaxJTyP == 20 then hack("r1668p") end
        if MaxJTyP == 21 then hack("r1669p") end
        if MaxJTyP == 22 then menuescolhas2(12) end

    elseif menu_tipo == 121 then
        MaxJTyM = gg.choice({
            "🎲 • Ice Rink", "🎲 • Christmas Carousel",
            "🎲 • Festive Lamppost", "🎲 • Group of Friends",
            "🎲 • Snowman", "🎲 • Ice Angel",
            "🎲 • Christmas Fence", "🎲 • Snow Globe",
            "🎲 • Lake House", "🎲 • Santa's House",
            "🎲 • Ice Slide", "🎲 • Toboggan Run", "🎲 • Sled Dogs",
            "🎲 • Frozen Tyrannosaurus", "🎲 • Polar Station",
            "🎲 • Cable Car", "🎲 • Ice Reindeer",
            "🎲 • Ice Castle", "🎲 • Snow Globe",
            "🎲 • Frozen Mammoth", "🎲 • Icebreaker Ship",
            "🎲 • Penguin Land", "🎲 • Arctic Glacier",
            "🎲 • Christmas Stocking", "🎲 • Christmas Tree",
            "🎲 • Gift Mountain", "🎲 • Ice Dragon",
            "🎲 • Elf House", "🎲 • Snowman", "🎲 • Christmas Ball",
            "🎲 • Meeting Santa Claus Poster", "🎲 • Winter Sports",
            "🎲 • Santa's Workshop", "🎲 • Sheep Slide",
            "🎲 • Winter Yurt", "🎲 • Skating Squirrels",
            "🎲 • Ice Portal", "🎲 • Polar Explorer",
            "🎲 • Hot Springs", "🎲 • Castle Ice rink with slide",
            "🎲 • Snowy cottage", "🎲 • The turbo sled",
            "🎲 • Flying lanterns", "❌ • Return"
        }, nil, "CHOOSE ONE OPTION")
        if MaxJTyM == nil then return end
        if MaxJTyM == 1 then hack("r17p") end
        if MaxJTyM == 2 then hack("r18p") end
        if MaxJTyM == 3 then hack("r20p") end
        if MaxJTyM == 4 then hack("r21p") end
        if MaxJTyM == 5 then hack("r22p") end
        if MaxJTyM == 6 then hack("r23p") end
        if MaxJTyM == 7 then hack("r24p") end
        if MaxJTyM == 8 then hack("r25p") end
        if MaxJTyM == 9 then hack("r20010p") end
        if MaxJTyM == 10 then hack("r20011p") end
        if MaxJTyM == 11 then hack("r20012p") end
        if MaxJTyM == 12 then hack("r20013p") end
        if MaxJTyM == 13 then hack("r20014p") end
        if MaxJTyM == 14 then hack("r20015p") end
        if MaxJTyM == 15 then hack("r20016p") end
        if MaxJTyM == 16 then hack("r20017p") end
        if MaxJTyM == 17 then hack("r20018p") end
        if MaxJTyM == 18 then hack("r20019p") end
        if MaxJTyM == 19 then hack("r20020p") end
        if MaxJTyM == 20 then hack("r20021p") end
        if MaxJTyM == 21 then hack("r20022p") end
        if MaxJTyM == 22 then hack("r20023p") end
        if MaxJTyM == 23 then hack("r20024p") end
        if MaxJTyM == 24 then hack("r20025p") end
        if MaxJTyM == 25 then hack("r20026p") end
        if MaxJTyM == 26 then hack("r20027p") end
        if MaxJTyM == 27 then hack("r20028p") end
        if MaxJTyM == 28 then hack("r20029p") end
        if MaxJTyM == 29 then hack("r20030p") end
        if MaxJTyM == 30 then hack("r20031p") end
        if MaxJTyM == 31 then hack("r20032p") end
        if MaxJTyM == 32 then hack("r20033p") end
        if MaxJTyM == 33 then hack("r20034p") end
        if MaxJTyM == 34 then hack("r20035p") end
        if MaxJTyM == 35 then hack("r20036p") end
        if MaxJTyM == 36 then hack("r20037p") end
        if MaxJTyM == 37 then hack("r20038p") end
        if MaxJTyM == 38 then hack("r20039p") end
        if MaxJTyM == 39 then hack("r20040p") end
        if MaxJTyM == 40 then hack("r20041p") end
        if MaxJTyM == 41 then hack("r20042p") end
        if MaxJTyM == 42 then hack("r20043p") end
        if MaxJTyM == 43 then hack("r20044p") end
        if MaxJTyM == 44 then menuescolhas2(12) end

    elseif menu_tipo == 123 then
        MaxJTyMTRE = gg.choice({
            "🎲 • Ominous Fountain", "🎲 • Black Cat",
            "🎲 • Witch with Potion", "🎲 • Witcher's Hut",
            "🎲 • Carnivorous Greenhouse", "🎲 • Pumpkin Man",
            "🎲 • Pumpkin Rider", "🎲 • Ghostly Coach",
            "🎲 • Gothic Tower", "🎲 • Werewolf Spectacle",
            "🎲 • Witch on her broom", "❌ • Return"
        }, nil, "CHOOSE ONE OPTION")
        if MaxJTyMTRE == nil then return end
        if MaxJTyMTRE == 1 then hack("r1ko") end
        if MaxJTyMTRE == 2 then hack("r2ko") end
        if MaxJTyMTRE == 3 then hack("r3ko") end
        if MaxJTyMTRE == 4 then hack("r4ko") end
        if MaxJTyMTRE == 5 then hack("r5ko") end
        if MaxJTyMTRE == 6 then hack("r6ko") end
        if MaxJTyMTRE == 7 then hack("r7ko") end
        if MaxJTyMTRE == 8 then hack("r8ko") end
        if MaxJTyMTRE == 9 then hack("r9ko") end
        if MaxJTyMTRE == 10 then hack("r10ko") end
        if MaxJTyMTRE == 11 then hack("r11ko") end
        if MaxJTyMTRE == 12 then menuescolhas2(12) end

    elseif menu_tipo == 124 then
        MaxJTyCFMT = gg.choice({
            "🎲 • The first geneticist", "🎲 • The first tourist",
            "🎲 • The first thinker", "🎲 • The first firefighter",
            "🎲 • The first commander", "🎲 • The first policeman",
            "🎲 • The first musician", "🎲 • The first painter",
            "🎲 • The first soccer player", "🎲 • The first scientist",
            "🎲 • The first balloonist", "❌ • Return"
        }, nil, "CHOOSE ONE OPTION")
        if MaxJTyCFMT == nil then return end
        if MaxJTyCFMT == 1 then hack("r1pDx") end
        if MaxJTyCFMT == 2 then hack("r2pDx") end
        if MaxJTyCFMT == 3 then hack("r3pDx") end
        if MaxJTyCFMT == 4 then hack("r4pDx") end
        if MaxJTyCFMT == 5 then hack("r5pDx") end
        if MaxJTyCFMT == 6 then hack("r6pDx") end
        if MaxJTyCFMT == 7 then hack("r7pDx") end
        if MaxJTyCFMT == 8 then hack("r8pDx") end
        if MaxJTyCFMT == 9 then hack("r9pDx") end
        if MaxJTyCFMT == 10 then hack("r10pDx") end
        if MaxJTyCFMT == 11 then hack("r11pDx") end
        if MaxJTyCFMT == 12 then menuescolhas2(12) end

    elseif menu_tipo == 125 then
        MaxJTUTR = gg.choice({
            "🎲 • Hockey field", "🎲 • Rugby field",
            "🎲 • Eternal rink", "🎲 • Veteran goalkeeper",
            "🎲 • Skatepark", "🎲 • World champion", "❌ • Return"
        }, nil, "CHOOSE ONE OPTION")
        if MaxJTUTR == nil then return end
        if MaxJTUTR == 1 then hack("r1TUTR") end
        if MaxJTUTR == 2 then hack("r2TUTR") end
        if MaxJTUTR == 3 then hack("r3TUTR") end
        if MaxJTUTR == 4 then hack("r4TUTR") end
        if MaxJTUTR == 5 then hack("r5TUTR") end
        if MaxJTUTR == 6 then hack("r6TUTR") end
        if MaxJTUTR == 7 then menuescolhas2(12) end

    elseif menu_tipo == 126 then
        MaxEWQT = gg.choice({
            "🎲 • Flight Simulator", "🎲 • Steam Plane",
            "🎲 • Biplane", "🎲 • Flying Champion",
            "🎲 • Galleon Balloon", "❌ • Return"

        }, nil, "CHOOSE ONE OPTION")
        if MaxEWQT == nil then return end
        if MaxEWQT == 1 then hack("r1EWQT") end
        if MaxEWQT == 2 then hack("r2EWQT") end
        if MaxEWQT == 3 then hack("r3EWQT") end
        if MaxEWQT == 4 then hack("r4EWQT") end
        if MaxEWQT == 5 then hack("r5EWQT") end
        if MaxEWQT == 6 then menuescolhas2(12) end

    elseif menu_tipo == 127 then
        MaxYIUIS = gg.choice({
            "🎲 • Candy House", "🎲 • Candy Mountain",
            "🎲 • Candy Tree", "🎲 • Candy Bridge",
            "🎲 • Marzipan Gate", "❌ • Return"
        }, nil, "CHOOSE ONE OPTION")
        if MaxYIUIS == nil then return end
        if MaxYIUIS == 1 then hack("r1YIUIS") end
        if MaxYIUIS == 2 then hack("r2YIUIS") end
        if MaxYIUIS == 3 then hack("r3YIUIS") end
        if MaxYIUIS == 4 then hack("r2YIUIS") end
        if MaxYIUIS == 5 then hack("r3YIUIS") end
        if MaxYIUIS == 6 then menuescolhas2(12) end
    elseif menu_tipo == 128 then
        MaxPOYUT = gg.choice({
            "🎲 • Lost City Gate", "🎲 • Ancient Ruins",
            "🎲 • Ancestral Statue", "🎲 • Lost City",
            "🎲 • Happy Gorilla", "🎲 • Jungle Cave",
            "🎲 • Ancient Calendar", "❌ • Return"
        }, nil, "CHOOSE ONE OPTION")
        if MaxPOYUT == nil then return end
        if MaxPOYUT == 1 then hack("r1POYUT") end
        if MaxPOYUT == 2 then hack("r2POYUT") end
        if MaxPOYUT == 3 then hack("r3POYUT") end
        if MaxPOYUT == 4 then hack("r4POYUT") end
        if MaxPOYUT == 5 then hack("r5POYUT") end
        if MaxPOYUT == 6 then hack("r6POYUT") end
        if MaxPOYUT == 7 then hack("r7POYUT") end
        if MaxPOYUT == 8 then menuescolhas2(12) end

    elseif menu_tipo == 129 then
        MaxWSFP = gg.choice({
            "🎲 • The Discobolus", "🎲 • Statue of Triumph",
            "🎲 • Dedicated Artists", "🎲 • The Magnificent Five",
            "🎲 • Happy Chefs", "🎲 • Symbol of the New Year",
            "🎲 • Souvenir Shop", "🎲 • Kite Master",
            "🎲 • Street Artist", "🎲 • Fruit Artist",
            "🎲 • The Magnificent Three", "🎲 • Adrenaline attraction",
            "🎲 • Statue of a great leader", "❌ • Return"
        }, nil, "CHOOSE ONE OPTION")
        if MaxWSFP == nil then return end
        if MaxWSFP == 1 then hack("r1WSFP") end
        if MaxWSFP == 2 then hack("r2WSFP") end
        if MaxWSFP == 3 then hack("r3WSFP") end
        if MaxWSFP == 4 then hack("r4WSFP") end
        if MaxWSFP == 5 then hack("r5WSFP") end
        if MaxWSFP == 6 then hack("r6WSFP") end
        if MaxWSFP == 7 then hack("r7WSFP") end
        if MaxWSFP == 8 then hack("r8WSFP") end
        if MaxWSFP == 9 then hack("r9WSFP") end
        if MaxWSFP == 10 then hack("r10WSFP") end
        if MaxWSFP == 11 then hack("r11WSFP") end
        if MaxWSFP == 12 then hack("r12WSFP") end
        if MaxWSFP == 13 then hack("r13WSFP") end
        if MaxWSFP == 14 then menuescolhas2(12) end

    elseif menu_tipo == 130 then
        MaxBHSO = gg.choice({
            "🎲 • Jacaranda", "🎲 • Cactus", "🎲 • Baobab",
            "🎲 • Date Palm", "🎲 • Wisteria", "🎲 • Delonix regia",
            "🎲 • Araguaney", "🎲 • Rhododendron", "🎲 • Gladioli",
            "🎲 • Poppies", "🎲 • Field of Flowers", "❌ • Return"
        }, nil, "CHOOSE ONE OPTION")
        if MaxBHSO == nil then return end
        if MaxBHSO == 1 then hack("r1BHSO") end
        if MaxBHSO == 2 then hack("r2BHSO") end
        if MaxBHSO == 3 then hack("r3BHSO") end
        if MaxBHSO == 4 then hack("r4BHSO") end
        if MaxBHSO == 5 then hack("r5BHSO") end
        if MaxBHSO == 6 then hack("r6BHSO") end
        if MaxBHSO == 7 then hack("r7BHSO") end
        if MaxBHSO == 8 then hack("r8BHSO") end
        if MaxBHSO == 9 then hack("r9BHSO") end
        if MaxBHSO == 10 then hack("r10BHSO") end
        if MaxBHSO == 11 then hack("r11BHSO") end
        if MaxBHSO == 12 then menuescolhas2(12) end
    elseif menu_tipo == 131 then
        MaxVXCS = gg.choice({
            "🎲 • Inflatable Fish", "🎲 • Inflatable Pig",
            "🎲 • Inflatable Whale", "🎲 • Inflatable Cow",
            "🎲 • Inflatable Sheep", "🎲 • Inflatable Bee",
            "🎲 • Inflatable Dragon", "🎲 • Inflatable Elephant",
            "🎲 • Inflatable Panda", "🎲 • Shark Jaw Trampoline",
            "🎲 • Lion Trampoline", "🎲 • Zoo Trampoline",
            "❌ • Return"
        }, nil, "CHOOSE ONE OPTION")
        if MaxVXCS == nil then return end
        if MaxVXCS == 1 then hack("r1VXCS") end
        if MaxVXCS == 2 then hack("r2VXCS") end
        if MaxVXCS == 3 then hack("r3VXCS") end
        if MaxVXCS == 4 then hack("r4VXCS") end
        if MaxVXCS == 5 then hack("r5VXCS") end
        if MaxVXCS == 6 then hack("r6VXCS") end
        if MaxVXCS == 7 then hack("r7VXCS") end
        if MaxVXCS == 8 then hack("r8VXCS") end
        if MaxVXCS == 9 then hack("r9VXCS") end
        if MaxVXCS == 10 then hack("r10VXCS") end
        if MaxVXCS == 11 then hack("r11VXCS") end
        if MaxVXCS == 12 then hack("r12VXCS") end
        if MaxVXCS == 13 then menuescolhas2(12) end

    elseif menu_tipo == 132 then
        MaxTPLKA = gg.choice({
            "🎲 • Land of the Dinosaurs", "🎲 • Spaceport",
            "🎲 • Snowman", "🎲 • Giant Cake",
            "🎲 • Classic Car Collection", "🎲 • Magic School",
            "🎲 • Tree of Lights", "🎲 • Disco District",
            "🎲 • Rabbit Village", "🎲 • Water Village",
            "❌ • Return"
        }, nil, "CHOOSE ONE OPTION")
        if MaxTPLKA == nil then return end
        if MaxTPLKA == 1 then hack("r1TPLKA") end
        if MaxTPLKA == 2 then hack("r2TPLKA") end
        if MaxTPLKA == 3 then hack("r3TPLKA") end
        if MaxTPLKA == 4 then hack("r4TPLKA") end
        if MaxTPLKA == 5 then hack("r5TPLKA") end
        if MaxTPLKA == 6 then hack("r6TPLKA") end
        if MaxTPLKA == 7 then hack("r7TPLKA") end
        if MaxTPLKA == 8 then hack("r8TPLKA") end
        if MaxTPLKA == 9 then hack("r9TPLKA") end
        if MaxTPLKA == 10 then hack("r10TPLKA") end
        if MaxTPLKA == 11 then menuescolhas2(12) end

    elseif menu_tipo == 133 then
        MaxLFGJZ = gg.choice({
            "🎲 • St. Basil's Cathedral", "🎲 • Castle",
            "🎲 • Statue of Liberty", "🎲 • Crater",
            "🎲 • Taj Mahal", "🎲 • Watchtower",
            "🎲 • Petronas Twin Towers", "🎲 • Pizza Tower",
            "🎲 • Temple of Heaven", "🎲 • Notre Dame de Paris",
            "🎲 • Space Needle", "🎲 • Sea Arches", "🎲 • Big Ben",
            "🎲 • Golden Gate Bridge", "🎲 • Thai Temple",
            "🎲 • Burj Khalifa", "🎲 • Pyramid", "🎲 • Yacht",
            "🎲 • Empire State Building", "🎲 • Vintage Boat",
            "🎲 • Eiffel Tower", "🎲 • Space Needle", "🎲 • Flag",
            "🎲 • Sydney Opera House", "🎲 • Triumphal Arch",
            "❌ • Return"
        }, nil, "CHOOSE ONE OPTION")
        if MaxLFGJZ == nil then return end
        if MaxLFGJZ == 1 then hack("r1LFGJZ") end
        if MaxLFGJZ == 2 then hack("r2LFGJZ") end
        if MaxLFGJZ == 3 then hack("r3LFGJZ") end
        if MaxLFGJZ == 4 then hack("r4LFGJZ") end
        if MaxLFGJZ == 5 then hack("r5LFGJZ") end
        if MaxLFGJZ == 6 then hack("r6LFGJZ") end
        if MaxLFGJZ == 7 then hack("r7LFGJZ") end
        if MaxLFGJZ == 8 then hack("r8LFGJZ") end
        if MaxLFGJZ == 9 then hack("r9LFGJZ") end
        if MaxLFGJZ == 10 then hack("r10LFGJZ") end
        if MaxLFGJZ == 11 then hack("r11LFGJZ") end
        if MaxLFGJZ == 12 then hack("r12LFGJZ") end
        if MaxLFGJZ == 13 then hack("r13LFGJZ") end
        if MaxLFGJZ == 14 then hack("r14LFGJZ") end
        if MaxLFGJZ == 15 then hack("r15LFGJZ") end
        if MaxLFGJZ == 16 then hack("r16LFGJZ") end
        if MaxLFGJZ == 17 then hack("r17LFGJZ") end
        if MaxLFGJZ == 18 then hack("r18LFGJZ") end
        if MaxLFGJZ == 19 then hack("r19LFGJZ") end
        if MaxLFGJZ == 20 then hack("r20LFGJZ") end
        if MaxLFGJZ == 21 then hack("r21LFGJZ") end
        if MaxLFGJZ == 22 then hack("r22LFGJZ") end
        if MaxLFGJZ == 23 then hack("r23LFGJZ") end
        if MaxLFGJZ == 24 then hack("r24LFGJZ") end
        if MaxLFGJZ == 25 then hack("r25LFGJZ") end
        if MaxLFGJZ == 26 then menuescolhas2(12) end
    elseif menu_tipo == 134 then
        MaxCHIMN = gg.choice({
            "🎲 • Chinatown", "🎲 • Dragon Dance", "🎲 • x",
            "❌ • Return"
        }, nil, "CHOOSE ONE OPTION")
        if MaxCHIMN == nil then return end
        if MaxCHIMN == 1 then hack("r1CHIMN") end
        if MaxCHIMN == 2 then hack("r2CHIMN") end
        if MaxCHIMN == 3 then hack("r3CHIMN") end
        if MaxCHIMN == 4 then menuescolhas2(12) end

    elseif menu_tipo == 135 then
        MaxFGJZ = gg.choice({
            "🎲 • Florist's House", "🎲 • House of Terror",
            "🎲 • Art Exhibition", "🎲 • Farmers Market",
            "🎲 • Gardening School", "🎲 • Mini Rabbit Zoo",
            "🎲 • Red Lily Pond", "🎲 • Rat with Sack of Coins",
            "🎲 • Aquarist's House", "🎲 • Camp Kitchen",
            "🎲 • Fruit Tribe", "🎲 • Experimental Jet Pack Test",
            "🎲 • Fruit Village", "🎲 • Tuned Cars",
            "🎲 • Outdoor Cinema", "🎲 • Altlantida Exhibition",
            "🎲 • Candy Park", "🎲 • Candy Castle",
            "🎲 • Center Music", "🎲 • Pirate Camp", "🎲 • Yeti",
            "🎲 • UFO Detected", "🎲 • Mother Nature Pool",
            "🎲 • Sunken City", "🎲 • Marine Station",
            "🎲 • Hotel Atlantida", "❌ • Return"
        }, nil, "CHOOSE ONE OPTION")
        if MaxFGJZ == nil then return end
        if MaxFGJZ == 1 then hack("r1LFG") end
        if MaxFGJZ == 2 then hack("r2LFG") end
        if MaxFGJZ == 3 then hack("r3LFG") end
        if MaxFGJZ == 4 then hack("r4LFG") end
        if MaxFGJZ == 5 then hack("r5LFG") end
        if MaxFGJZ == 6 then hack("r6LFG") end
        if MaxFGJZ == 7 then hack("r7LFG") end
        if MaxFGJZ == 8 then hack("r8LFG") end
        if MaxFGJZ == 9 then hack("r9LFG") end
        if MaxFGJZ == 10 then hack("r10LFG") end
        if MaxFGJZ == 11 then hack("r11LFG") end
        if MaxFGJZ == 12 then hack("r12LFG") end
        if MaxFGJZ == 13 then hack("r13LFG") end
        if MaxFGJZ == 14 then hack("r14LFG") end
        if MaxFGJZ == 15 then hack("r15LFG") end
        if MaxFGJZ == 16 then hack("r16LFG") end
        if MaxFGJZ == 17 then hack("r17LFG") end
        if MaxFGJZ == 18 then hack("r18LFG") end
        if MaxFGJZ == 19 then hack("r19LFG") end
        if MaxFGJZ == 20 then hack("r20LFG") end
        if MaxFGJZ == 21 then hack("r21LFG") end
        if MaxFGJZ == 22 then hack("r22LFG") end
        if MaxFGJZ == 23 then hack("r23LFG") end
        if MaxFGJZ == 24 then hack("r24LFG") end
        if MaxFGJZ == 25 then hack("r25LFG") end
        if MaxFGJZ == 26 then hack("r26LFG") end
        if MaxFGJZ == 27 then menuescolhas2(12) end

    elseif menu_tipo == 136 then
        MaTPKi = gg.choice({
            "🎲 • Mechanical Scarecrow",
            "🎲 • Remote Control Car Racing", "🎲 • Fruit Cannon",
            "🎲 • Knife Throwing", "🎲 • Fruit Shooting Range",
            "🎲 • Power Hammer", "🎲 • Pinball",
            "🎲 • Stuffed Animal Machine", "🎲 • Ultimate Console",
            "🎲 • Octopus Merry-Go-Round", "❌ • Return"
        }, nil, "CHOOSE ONE OPTION")
        if MaTPKi == nil then return end
        if MaTPKi == 1 then hack("r1MaTPKi") end
        if MaTPKi == 2 then hack("r2MaTPKi") end
        if MaTPKi == 3 then hack("r3MaTPKi") end
        if MaTPKi == 4 then hack("r4MaTPKi") end
        if MaTPKi == 5 then hack("r5MaTPKi") end
        if MaTPKi == 6 then hack("r6MaTPKi") end
        if MaTPKi == 7 then hack("r7MaTPKi") end
        if MaTPKi == 8 then hack("r8MaTPKi") end
        if MaTPKi == 9 then hack("r9MaTPKi") end
        if MaTPKi == 10 then hack("r10MaTPKi") end
        if MaTPKi == 11 then menuescolhas2(12) end
    elseif menu_tipo == 5360 then
        MNCvSW = gg.choice({
            '🎫 • Turtle Island Queen Expedition',
            '🎫 • Cleopatras Secret Spa Expedition',
            '🎫 • Guardian of the North Expedition',
            '🎫 • Pirate Odyssey Expedition',
            '🎫 • Yeti Megalith Expedition',
            '🎫 • Botanical Amusement Park Expedition',
            '🎫 • Poseidons Kingdom Museum Expedition',
            '🎫 • Institute of Natural Phenomena Expedition',
            '🎫 • Central Park Expedition',
            '🎫 • Chinese Community Center Expedition',
            '🎫 • Rainbow Ecopark Expedition',
            '🎫 • Food Tour Expedition',
            '🎫 • Agricultural Fair Expedition',
            '🎫 • Sports Complex Expedition',
            '🎫 • Penguin Corner Expedition',
            '🎫 • Classic Disco Expedition',
            '🎫 • Craft Fair Grounds Expedition',
            '🎫 • Placid Camp Expedition',
            '🎫 • Beach Party Expedition',
            '🎫 • Heart of Italy Expedition',
            '🎫 • Smart Mansion Expedition',
            '🎫 • Golden Deer Cottage Expedition',
            '🎫 • Ice Lotus Fountain Expedition',
            '🎫 • Classic Theater Expedition',
            '🎫 • Queen Wasp Greenhouse Expedition',
            '🎫 • Space Research Center Expedition',
            '🎫 • Tree Library Expedition',
            '🎫 • Glamping in Nature Expedition',
            '🎫 • Cosmic Cafeteria Expedition',
            '🎫 • Primates Water Park Expedition',
            '🎫 • Eden in the Mountains Expedition',
            '🎫 • Sugary Amusement Park Expedition',
            '🎫 • Halloween Windmill Expedition',
            '🎫 • Expedición Portal de ciberópolis',
            '🎫 • Expedición Oficina del sheriff', '❌ • Return'
        }, nil, 'CHOOSE ONE OPTION')
        if MNCvSW == nil then return end
        if MNCvSW == 1 then hackDecoExpe_1() end
        if MNCvSW == 2 then hackDecoExpe_2() end
        if MNCvSW == 3 then hackDecoExpe_3() end
        if MNCvSW == 4 then hackDecoExpe_4() end
        if MNCvSW == 5 then hackDecoExpe_5() end
        if MNCvSW == 6 then hackDecoExpe_6() end
        if MNCvSW == 7 then hackDecoExpe_7() end
        if MNCvSW == 8 then hackDecoExpe_8() end
        if MNCvSW == 9 then hackDecoExpe_9() end
        if MNCvSW == 10 then hackDecoExpe_10() end
        if MNCvSW == 11 then hackDecoExpe_11() end
        if MNCvSW == 12 then hackDecoExpe_12() end
        if MNCvSW == 13 then hackDecoExpe_13() end
        if MNCvSW == 14 then hackDecoExpe_14() end
        if MNCvSW == 15 then hackDecoExpe_15() end
        if MNCvSW == 16 then hackDecoExpe_16() end
        if MNCvSW == 17 then hackDecoExpe_17() end
        if MNCvSW == 18 then hackDecoExpe_18() end
        if MNCvSW == 19 then hackDecoExpe_19() end
        if MNCvSW == 20 then hackDecoExpe_20() end
        if MNCvSW == 21 then hackDecoExpe_21() end
        if MNCvSW == 22 then hackDecoExpe_22() end
        if MNCvSW == 23 then hackDecoExpe_23() end
        if MNCvSW == 24 then hackDecoExpe_24() end
        if MNCvSW == 25 then hackDecoExpe_25() end
        if MNCvSW == 26 then hackDecoExpe_26() end
        if MNCvSW == 27 then hackDecoExpe_27() end
        if MNCvSW == 28 then hackDecoExpe_28() end
        if MNCvSW == 29 then hackDecoExpe_29() end
        if MNCvSW == 30 then hackDecoExpe_30() end
        if MNCvSW == 31 then hackDecoExpe_31() end
        if MNCvSW == 32 then hackDecoExpe_32() end
        if MNCvSW == 33 then hackDecoExpe_33() end
        if MNCvSW == 34 then hackDecoExpe_34() end
        if MNCvSW == 35 then hackDecoExpe_35() end
        if MNCvSW == 36 then menuescolhas2(12) end

    elseif menu_tipo == 0 then
        PRV = gg.choice({
            "💵 • Helicopter", "💵 • T-Cash", "💵 • Money",
            "❌ • Return"
        }, nil,
                        [[╔════════════════════╗
║ R I S H  G A M I N G ║
╚════════════════════╝]])

        if PRV == nil then return end
        if PRV == 1 then hack11(true) end
        if PRV == 2 then hackTHO("th6") end
        if PRV == 3 then hackTHO("th7") end
        if PRV == 4 then MENUFREE() end

    elseif menu_tipo == 220 then
        FCC = gg.choice({
            "☠️ • Construction ", "☣️ • Barn ", '❌ • Return'
        }, nil,
                        [[╔════════════════════╗
║ R I S H  G A M I N G ║
╚════════════════════╝]])

        if FCC == nil then return end
        if FCC == 1 then HackCons() end
        if FCC == 2 then HackGran() end
        if FCC == 3 then menuescolhas2(1) end

    end

    MenuVisible = -1
end

---- FORJA HACK
function hack2()
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("3600;7200;10800;14400", gg.TYPE_FLOAT)
    gg.refineNumber("3600", gg.TYPE_FLOAT)
    gg.getResults(30)
    gg.editAll('1', gg.TYPE_FLOAT)
    setf(80, 1)
    setf(160, 1)
    setf(240, 1)
    gg.clearResults()
    gg.clearList()
end

---- HELI MONEY HACK
function hack11(isFree)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1885433110;1852403807", gg.TYPE_DWORD)
    gg.refineNumber("1885433110", gg.TYPE_DWORD)
    xmoney = gg.prompt({
        "Amount of cash? [0; 5000]", "Amount of money? [1; 350000]"
    }, {0, 1}, {"number", "number"})
    if xmoney == nil then
        if isFree then
            MENUFREE()
        else
            MENUFREE()
        end
    else
        -- xmoney[1] = tonumber(xmoney[1])
        -- xmoney[2] = tonumber(xmoney[2])
        -- setd(-220, xmoney[1])
        -- setd(-224, 0)
        -- setd(-228, xmoney[2])
        -- setd(-232, 0)
        -- gg.clearResults()
        xmoney[1] = tonumber(xmoney[1])
        xmoney[2] = tonumber(xmoney[2])
        setd(-212, xmoney[1])
        setd(-216, 0)
        setd(-220, xmoney[2])
        setd(-224, 0)
        gg.clearResults()

    end
end

---- HELI AUTO HACK
function hack12()
    gg.alert(
        "Check if the orders on your helicopter have been removed and open GameGuardian again!")
    wait_for_action()
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1;1;16842752;0;1045220557;1053609165;100", gg.TYPE_DWORD)
    gg.refineNumber("16842752", gg.TYPE_DWORD)
    gg.getResults(30)
    setd(-8, 0)
    setd(-4, 0)
    setd(0, 0)
    setd(4, 0)
    setd(8, 0)
    setd(12, 0)
    setd(16, 0)
    gg.clearResults()
    gg.clearList()
end

---- MERCADO HACK
function hack13()
    if marketinf then
        gg.processResume()
        gg.clearResults()
        gg.setVisible(false)
        gg.searchNumber("3600;86400", gg.TYPE_DWORD)
        local table = gg.getResults(30)
        for i = 1, #table do
            table[i]["value"] = 0
            table[i]["freeze"] = true
        end
        gg.addListItems(table)
        gg.setValues(table)
        marketinf = false
    end

    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.alert(
        "Choose a product from the marketplace, enter the quantity of the last one and open GameGuardian again!")
    wait_for_action()
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)

    inputs = gg.prompt({"Last product quantity:"})
    local qtditem = inputs[1] .. "X4"
    gg.searchNumber(qtditem, gg.TYPE_DWORD)

    while gg.getResultsCount() > 2 do
        gg.processResume()
        gg.setVisible(false)
        gg.alert("Please select another product!")
        wait_for_action()
        gg.processResume()
        gg.setVisible(false)

        inputs2 = gg.prompt({[1] = "New quantity of the last product:"},
                            {[1] = "0"}, {[1] = "text"})
        local qtditem2 = inputs2[1] .. "X4"
        gg.refineNumber(qtditem2, gg.TYPE_DWORD)
    end

    if gg.getResultsCount() <= 2 then

        int2 = gg.prompt({"Amount?[50; 500]"}, {1}, {"number"})
        int2[1] = tonumber(int2[1])

        seth(-4, 0)
        seth(0, int2[1])
        seth(4, 0)
        seth(8, 1)
        gg.toast("Success...")
        marketnext = true

        local firstTimeMessage = true

        while marketnext do
            gg.processResume()
            gg.setVisible(false)

            if firstTimeMessage then
                gg.alert(
                    "Pick up the product, choose another product and open GameGuardian!")
                firstTimeMessage = false
            end

            wait_for_action()
            gg.processResume()
            gg.setVisible(false)

            local choice = gg.alert(
                               "Press the button to continue hacking or to stop.",
                               "Finish.", "Continue.")

            if choice == 1 then
                MENUFREE()
                marketnext = false
                gg.clearResults()
            elseif choice == 2 then
                seth(-4, 0)
                seth(0, int2[1])
                seth(4, 0)
                seth(8, 1)
                gg.toast("Success...")
            end
        end
    end
end

---- ANIMAIS HACK
function hack14()
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("1200;3600", gg.TYPE_FLOAT)
    gg.getResults(4)
    gg.editAll('1', gg.TYPE_FLOAT)
    gg.clearResults()
    gg.searchNumber("14400;25200", gg.TYPE_FLOAT)
    gg.getResults(10)
    gg.editAll('1', gg.TYPE_FLOAT)
    gg.clearResults()
    gg.searchNumber("21600", gg.TYPE_FLOAT)
    gg.getResults(10)
    gg.editAll('1', gg.TYPE_FLOAT)
    gg.clearResults()
    gg.clearList()
end
-- 616D5312h;704F6C6Ch;00006E65h;70784518h;42646E61h + 0x38
-- 1.884.253.292
-- 70784518h;42646E61h;6F747475h;0000006Eh;00000000h - 0x2C

function hack255yaNo()
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    -- gg.searchNumber("616D5312h;704F6C6Ch;00006E65h;70784518h;42646E61h", gg.TYPE_DWORD ) --000B0001h;706F7014h;74616C75h;006E6F69h
    -- gg.refineNumber("1884253292", gg.TYPE_DWORD )
    gg.searchNumber("616D5312h;704F6C6Ch;00006E65h;70784518h;42646E61h",
                    gg.TYPE_DWORD) -- 000B0001h;706F7014h;74616C75h;006E6F69h    720897
    gg.refineNumber("1884253292", gg.TYPE_DWORD)
    r = gg.getResults(2)

    if gg.getResultCount() == 1 then
        -- do something
        local t = {}
        t[1] = {}
        t[1].address = r[1].address + 0x38
        t[1].flags = gg.TYPE_DWORD
        t[1].value = 0
        t[1].freeze = true
        gg.setValues(t)
        gg.addListItems(t) -- automaticly saves the list
        gg.alert("hack done 2")
        gg.toast("hack done 2...")
        gg.toast(" ENJOY UNLIMITED ...")
        gg.loadResults(t) -- loading the list
    else
        -- do something else entirely
        gg.alert(
            "Verifica la población necesaria para desbloquear el terreno, luego abre el Gameguardian...")
        gg.toast(
            "Verifica la población necesaria para desbloquear el terreno, luego abre el Gameguardian...")
    end
    gg.clearResults()
end
function hack255()
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    -- gg.searchNumber("616D5312h;704F6C6Ch;00006E65h;70784518h;42646E61h", gg.TYPE_DWORD ) --000B0001h;706F7014h;74616C75h;006E6F69h
    -- gg.refineNumber("1884253292", gg.TYPE_DWORD )
    gg.searchNumber("000B0001h;706F7014h;74616C75h;006E6F69h", gg.TYPE_DWORD) -- 000B0001h;706F7014h;74616C75h;006E6F69h    720897
    gg.refineNumber("000B0001h", gg.TYPE_DWORD)
    r = gg.getResults(2)

    if gg.getResultCount() == 1 then
        -- do something
        local t = {}
        t[1] = {}
        t[1].address = r[1].address + 0x18
        t[1].flags = gg.TYPE_DWORD
        t[1].value = 0
        t[1].freeze = true
        gg.setValues(t)
        gg.addListItems(t) -- automaticly saves the list
        gg.alert("hack done 2")
        gg.toast("hack done 2...")
        gg.toast(" ENJOY UNLIMITED ...")
        gg.loadResults(t) -- loading the list
    else
        -- do something else entirely
        gg.alert(
            "Check the population required to unlock the terrain, then open the Gameguardian...")
        gg.toast(
            "Check the population required to unlock the terrain, then open the Gameguardian...")
    end
    gg.clearResults()
end

function hackAliVacas()
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("776F630Eh;64656566h;43960000h", gg.TYPE_DWORD)
    gg.refineNumber("43960000h", gg.TYPE_DWORD)

    r = gg.getResults(1)
    -- do something
    local t = {}
    t[1] = {}
    t[1].address = r[1].address
    t[1].flags = gg.TYPE_DWORD
    t[1].value = 0
    t[1].freeze = false
    gg.setValues(t)

    local e = {}
    e[1] = {}
    e[1].address = r[1].address + 0x04
    e[1].flags = gg.TYPE_DWORD
    e[1].value = 0
    e[1].freeze = false
    gg.setValues(e)

    local y = {}
    y[1] = {}
    y[1].address = r[1].address + 0x08
    y[1].flags = gg.TYPE_DWORD
    y[1].value = 10
    y[1].freeze = false
    gg.setValues(y)

    local v = {}
    v[1] = {}
    v[1].address = r[1].address + 0x10
    v[1].flags = gg.TYPE_DWORD
    v[1].value = 0
    v[1].freeze = false
    gg.setValues(v)

    local h = {}
    h[1] = {}
    h[1].address = r[1].address + 0x18
    h[1].flags = gg.TYPE_DWORD
    h[1].value = 0
    h[1].freeze = false
    gg.setValues(h)

    local k = {}
    k[1] = {}
    k[1].address = r[1].address + 0x20
    k[1].flags = gg.TYPE_DWORD
    k[1].value = 0
    k[1].freeze = false
    gg.setValues(k)
    gg.clearResults()
end
function hackAliGallinas()
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("69686316h;6E656B63h;64656566h;44160000h", gg.TYPE_DWORD)
    gg.refineNumber("44160000h", gg.TYPE_DWORD)

    r = gg.getResults(1)
    -- do something
    local t = {}
    t[1] = {}
    t[1].address = r[1].address
    t[1].flags = gg.TYPE_DWORD
    t[1].value = 0
    t[1].freeze = false
    gg.setValues(t)

    local e = {}
    e[1] = {}
    e[1].address = r[1].address + 0x04
    e[1].flags = gg.TYPE_DWORD
    e[1].value = 0
    e[1].freeze = false
    gg.setValues(e)

    local y = {}
    y[1] = {}
    y[1].address = r[1].address + 0x08
    y[1].flags = gg.TYPE_DWORD
    y[1].value = 10
    y[1].freeze = false
    gg.setValues(y)

    local v = {}
    v[1] = {}
    v[1].address = r[1].address + 0x10
    v[1].flags = gg.TYPE_DWORD
    v[1].value = 0
    v[1].freeze = false
    gg.setValues(v)

    local h = {}
    h[1] = {}
    h[1].address = r[1].address + 0x18
    h[1].flags = gg.TYPE_DWORD
    h[1].value = 0
    h[1].freeze = false
    gg.setValues(h)

    local k = {}
    k[1] = {}
    k[1].address = r[1].address + 0x20
    k[1].flags = gg.TYPE_DWORD
    k[1].value = 0
    k[1].freeze = false
    gg.setValues(k)
    gg.clearResults()
end
function hackAliOvejas()
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("65687312h;65667065h;00006465h;44960000h", gg.TYPE_DWORD)
    gg.refineNumber("44960000h", gg.TYPE_DWORD)
    r = gg.getResults(1)
    -- do something
    local t = {}
    t[1] = {}
    t[1].address = r[1].address
    t[1].flags = gg.TYPE_DWORD
    t[1].value = 0
    t[1].freeze = false
    gg.setValues(t)
    local e = {}
    e[1] = {}
    e[1].address = r[1].address + 0x04
    e[1].flags = gg.TYPE_DWORD
    e[1].value = 0
    e[1].freeze = false
    gg.setValues(e)

    local y = {}
    y[1] = {}
    y[1].address = r[1].address + 0x08
    y[1].flags = gg.TYPE_DWORD
    y[1].value = 10
    y[1].freeze = false
    gg.setValues(y)

    local v = {}
    v[1] = {}
    v[1].address = r[1].address + 0x10
    v[1].flags = gg.TYPE_DWORD
    v[1].value = 0
    v[1].freeze = false
    gg.setValues(v)

    local h = {}
    h[1] = {}
    h[1].address = r[1].address + 0x18
    h[1].flags = gg.TYPE_DWORD
    h[1].value = 0
    h[1].freeze = false
    gg.setValues(h)

    local k = {}
    k[1] = {}
    k[1].address = r[1].address + 0x20
    k[1].flags = gg.TYPE_DWORD
    k[1].value = 0
    k[1].freeze = false
    gg.setValues(k)
    gg.clearResults()
end
function hack25()
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.alert(
        "Check the population required to unlock the terrain, then open the Gameguardian...")
    wait_for_action()
    gg.processResume()
    gg.setVisible(false)
    -- Primeiro prompt
    ppls = gg.prompt({
        [1] = "¿Cantidad de población para desbloquear la siguiente tierra?"
    }, {[1] = "0"}, {[1] = "text"})
    -- Se o usuário cancelar, voltar para o MENU()
    if ppls == nil then
        MENUFREE() -- Supondo que MENU() seja o nome da função do menu
        return
    end

    local pqsa = ppls[1] ..
                     ";616D5312h;704f6C6Ch;70784518h;42646E61h;6F747475h;0000006Eh"
    gg.searchNumber(pqsa, gg.TYPE_DWORD)
    gg.refineNumber(ppls[1], gg.TYPE_DWORD)
    if gg.getResultsCount() <= 2 then
        gg.processResume()
        gg.setVisible(false)
        local table = gg.getResults(2)
        for i = 1, #table do
            table[i]["value"] = 1
            table[i]["freeze"] = true
        end
        gg.addListItems(table)
        gg.setValues(table)
        gg.toast("Éxito...")
    end
    -- gg.clearResults()
end

---- GOLDPASS HACK
function hack15()
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("6E726520h;00000035h;696B532Ah", gg.TYPE_DWORD)
    gg.refineNumber("696B532Ah", gg.TYPE_DWORD)
    gg.refineAddress('D0')
    setd2(-24, 0)
    setd2(-20, 6000)
    setd2(-8, 1)
    gg.clearResults()
    gg.clearList()
end
function hack15mm()
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("6E72651Ch;00353230h;00000031h", gg.TYPE_DWORD)
    gg.refineNumber("00000031h", gg.TYPE_DWORD)
    gg.refineAddress('D0')
    r = gg.getResults(2)

    -- if gg.getResultCount() == 3 then

    gg.alert("hack done 1")
    gg.toast("hack done 1...")
    -- do something
    local t = {}
    t[2] = {}
    t[2].address = r[2].address - 0x08
    t[2].flags = gg.TYPE_DWORD
    t[2].value = 1
    t[2].freeze = true
    gg.setValues(t)

    local G = {}
    G[2] = {}
    G[2].address = r[2].address - 0x14
    G[2].flags = gg.TYPE_DWORD
    G[2].value = 7000
    G[2].freeze = true
    gg.setValues(G)

    local A = {}
    A[2] = {}
    A[2].address = r[2].address - 0x18
    A[2].flags = gg.TYPE_DWORD
    A[2].value = 0
    A[2].freeze = true
    gg.setValues(A)
    gg.alert("hack done 2")
    gg.toast("hack done 2...")
    gg.clearResults()
    gg.clearList()

    --  setd2(-24, 0)
    -- setd2(-20, 6000)
    -- setd2(-8, 1)
    -- gg.clearResults()
    -- gg.clearList()
end
function hack15x()
    gg.toast("Loading...") -- 696B5326h;69415F6Eh;616C7072h;735F656Eh;65636170h --616C7072h;735F656Eh;65636170h 65726F63h;72616D10h;696B532Ah Skin_Chicken_space 1.937.011.470;1.701.998.435 .erniemars025
    gg.processResume() -- 6E72651Ch;00353230h;00000031h 6E72651Ch;32737261h;00000031h  -- 6E72651Ch;32737261h;00000031h;656B6369h;616D5F6Eh ref 616D5F6Eh 
    gg.clearResults()
    gg.searchNumber("6E72651Ch;00353230h;00000031h", gg.TYPE_DWORD) -- 1852990740;6447474;1768641316
    gg.refineNumber("00000031h", gg.TYPE_DWORD)

    r = gg.getResults(3)

    -- if gg.getResultCount() == 3 then

    gg.alert("hack done 1")
    gg.toast("hack done 1...")
    -- do something
    local t = {}
    t[3] = {}
    t[3].address = r[3].address - 0x08
    t[3].flags = gg.TYPE_DWORD
    t[3].value = 1
    t[3].freeze = true
    gg.setValues(t)

    local G = {}
    G[3] = {}
    G[3].address = r[3].address - 0x14
    G[3].flags = gg.TYPE_DWORD
    G[3].value = 7000
    G[3].freeze = true
    gg.setValues(G)

    local A = {}
    A[3] = {}
    A[3].address = r[3].address - 0x18
    A[3].flags = gg.TYPE_DWORD
    A[3].value = 0
    A[3].freeze = true
    gg.setValues(A)
    gg.alert("hack done 2")
    gg.toast("hack done 2...")
    gg.clearResults()

end
function hackGoldenpass()
    gg.toast("Golden Pass") -- 696B5326h;69415F6Eh;616C7072h;735F656Eh;65636170h --616C7072h;735F656Eh;65636170h 65726F63h;72616D10h;696B532Ah Skin_Chicken_space 1.937.011.470;1.701.998.435 .erniemars025
    gg.processResume() -- 6E72651Ch;00353230h;00000031h 6E72651Ch;32737261h;00000031h  
    gg.clearResults()
    -- gg.setSpeed(2)
    gg.setVisible(false)
    gg.searchNumber("1919500826;1633970292;1852990758;1113548137;1752461929",
                    gg.TYPE_DWORD)
    gg.refineNumber("1852990758", gg.TYPE_DWORD)

    local results = gg.getResults(9999) -- Mengambil semua hasil refine

    if #results > 0 then
        local edits = {}

        for i, v in ipairs(results) do
            local baseAddr = v.address

            -- Baca nilai offset +98 dan +9C
            local checkVals = gg.getValues({
                {address = baseAddr + 0x98, flags = gg.TYPE_DWORD},
                {address = baseAddr + 0x9C, flags = gg.TYPE_DWORD}
            })

            local val98 = checkVals[1].value
            local val9C = checkVals[2].value
            local xorVal = bit32.bxor(val98, val9C)

            -- Filter: hanya edit jika xor <= 710
            if xorVal <= 2000 then
                -- Offset +98, edit dword ke 0 dan freeze
                table.insert(edits, {
                    address = baseAddr + 0x98,
                    flags = gg.TYPE_DWORD,
                    value = 0,
                    freeze = false
                })

                -- Offset +9C, edit ke 710 dan freeze
                table.insert(edits, {
                    address = baseAddr + 0x9C,
                    flags = gg.TYPE_DWORD,
                    value = 2000,
                    freeze = false
                })

                -- Offset +A8 (0x98 + 0x4 + 0xC), edit ke 1 dan freeze
                table.insert(edits, {
                    address = baseAddr + 0xA8,
                    flags = gg.TYPE_DWORD,
                    value = 1,
                    freeze = true
                })
            end
        end

        if #edits > 0 then
            gg.setValues(edits)
            gg.addListItems(edits) -- Menambahkan ke daftar freeze GG
            gg.toast("Golden Aktif (Filtered)!")
        else
            gg.toast("Tidak ada yang memenuhi filter!")
        end

        gg.clearResults()
    else
        gg.toast("Nilai tidak ditemukan!")
    end

end

function hack15c()
    gg.toast("Loading...") -- 696B5326h;69415F6Eh;616C7072h;735F656Eh;65636170h --616C7072h;735F656Eh;65636170h 65726F63h;72616D10h;696B532Ah Skin_Chicken_space 1.937.011.470;1.701.998.435 .erniemars025
    gg.processResume() -- 6E72651Ch;00353230h;00000031h 6E72651Ch;32737261h;00000031h  
    gg.clearResults()
    gg.searchNumber("6E72651Ch;32737261h;00000031h;656B6369h;616D5F6Eh",
                    gg.TYPE_DWORD) -- 1852990740;6447474;1768641316
    gg.refineNumber("616D5F6Eh", gg.TYPE_DWORD)

    r = gg.getResults(1)

    if gg.getResultCount() == 1 then
        -- do something
        local t = {}
        t[1] = {}
        t[1].address = r[1].address - 0x0B
        t[1].flags = gg.TYPE_DWORD
        t[1].value = 1
        t[1].freeze = true
        gg.setValues(t)

        local G = {}
        G[1] = {}
        G[1].address = r[1].address - 0x17
        G[1].flags = gg.TYPE_DWORD
        G[1].value = 7000
        G[1].freeze = true
        gg.setValues(G)

        local A = {}
        A[1] = {}
        A[1].address = r[1].address - 0x1B
        A[1].flags = gg.TYPE_DWORD
        A[1].value = 0
        A[1].freeze = true
        gg.setValues(A)
        gg.alert("hack done 1")
        gg.toast("hack done 1...")
        gg.clearResults()
    elseif gg.getResultCount() == 3 then
        -- do something else
        re = gg.getResults(3)
        local te = {}
        te[3] = {}
        te[3].address = re[3].address - 0x0B
        te[3].flags = gg.TYPE_DWORD
        te[3].value = 1
        te[3].freeze = true
        gg.setValues(te)

        local Ge = {}
        Ge[3] = {}
        Ge[3].address = re[3].address - 0x17
        Ge[3].flags = gg.TYPE_DWORD
        Ge[3].value = 7000
        Ge[3].freeze = true
        gg.setValues(Ge)

        local Ae = {}
        Ae[3] = {}
        Ae[3].address = re[3].address - 0x1B
        Ae[3].flags = gg.TYPE_DWORD
        Ae[3].value = 0
        Ae[3].freeze = true
        gg.setValues(Ae)

        gg.alert("hack done 2")
        gg.toast("hack done 2...")
        gg.clearResults()
    else
        -- do something else entirely
        gg.toast("NO done...")
    end

end
-- return
-- else

-- gg.clearResults()
-- end

---- XP TRIGO HACK
function hack16(isFree)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("120;300", gg.TYPE_FLOAT)
    gg.refineNumber("120", gg.TYPE_FLOAT)
    xps = gg.prompt({[1] = "Desired XP amount? Max: 9000"}, {[1] = "0"},
                    {[1] = "text"})

    if xps == nil then
        if isFree then
            MENUFREE()
        else
            MENUFREE()
        end
    else
        xps[1] = tonumber(xps[1])
        setd(0, 0)
        setd(16, 0)
        setd(20, xps[1])
        gg.clearResults()
        gg.clearList()
    end
end

---- HACK ACADEMIA
function seth(offset, new)
    local table = gg.getResults(30)
    for i = 1, #table do
        table[i]["address"] = table[i]["address"] + offset
        table[i]["flags"] = gg.TYPE_DWORD
        table[i]["value"] = new .. "X4"
        gg.addListItems(table)
        gg.setValues(table)
    end
end

function hack2C()
    gg.toast("Loading...")
    gg.processResume()
    gg.clearList()
    gg.clearResults()
    gg.alert("Check out a factory's time bonus at the industry academy.")
    wait_for_action()
    gg.processResume()
    gg.setVisible(false)

    input = gg.prompt({"Bonus Time", "Island"}, nil, {'number', 'checkbox'})
    if input == nil then
        return MENUFREE() -- Se o usuário cancelar, volta ao MENUFREE()
    end
    local bonus = input[1] .. "X4"
    gg.searchNumber(bonus, gg.TYPE_DWORD)
    while gg.getResultsCount() > 2 do
        gg.processResume()
        gg.setVisible(false)
        gg.alert(
            "Gain 1 one-time bonus level in the factory and open GameGuardian.")
        wait_for_action()
        gg.processResume()
        gg.setVisible(false)
        -- Segunda entrada do usuário
        input2 = gg.prompt({[1] = "New factory time bonus value."}, {[1] = "0"},
                           {[1] = "text"})
        if input2 == nil then
            return MENUFREE() -- Se o usuário cancelar, volta ao MENUFREE()
        end
        local bonus2 = input2[1] .. "X4"
        gg.refineNumber(bonus2, gg.TYPE_DWORD)
    end
    if gg.getResultsCount() <= 3 then
        gg.processResume()
        gg.setVisible(false)
        local table = gg.getResults(2)
        if input[2] == true then
            seth(0, 99)
        else
            seth(0, 100)
        end
        gg.toast("Éxito...")
    end
    gg.clearResults()
end

function HackCons()
    gg.toast("Loading............ construction")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- Molino de halloween
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 1113542739
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = 1953722223
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = 1701146707
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = 1114658148
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = 1684826485
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = 1936158313
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = 0
    v_7[1].freeze = false
    gg.setValues(v_7)

    -- 61702337h 7;00337472h part 3

    -- gg.clearResults()

    hackConstr_18h("rExpe_4")
end

function hackConstr_18h(varcJExpe_4)
    gg.toast("Loading............ ")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)

    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address + 0x1C, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address + 0x20, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    -- local val_3 = {}
    -- val_3[1] = {address = r[1].address + 0x24, flags = gg.TYPE_DWORD}
    -- val_3 = gg.getValues(val_3)  
    local val_4 = {}
    val_4[1] = {address = r[1].address + 0x28, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address + 0x2C, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address + 0x30, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)

    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if varcJExpe_4 == "rExpe_4" then
        setd(-48, 0)
        setd(-44, 100)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, 24)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end

function HackGran()
    gg.toast("Loading............ barn")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- Molino de halloween
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 1113542739
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = 1953722223
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = 1919906899
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = 1130719073
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = 1667330145
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = 7959657
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = 0
    v_7[1].freeze = false
    gg.setValues(v_7)

    -- 61702337h 7;00337472h part 3

    -- gg.clearResults()
    hackGran_1_17h("rExpe_3")
end
function hackGran_1_17h(varcJExpe_3)
    gg.toast("Loading............ ")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)

    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address + 0x1C, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address + 0x20, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    -- local val_3 = {}
    -- val_3[1] = {address = r[1].address + 0x24, flags = gg.TYPE_DWORD}
    -- val_3 = gg.getValues(val_3)  
    local val_4 = {}
    val_4[1] = {address = r[1].address + 0x28, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address + 0x2C, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address + 0x30, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)

    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if varcJExpe_3 == "rExpe_3" then
        setd(-48, 0)
        setd(-44, 2000)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, 23)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end

function Cartel_1(carte_1)
    gg.searchNumber("00000031h;00000020h;74694310h;67695379h;6C00006Eh",
                    gg.TYPE_DWORD)
    gg.refineNumber("32", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26 
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address - 0x08, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address - 0x04, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[1] = {address = r[1].address, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[1] = {address = r[1].address + 0x04, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address + 0x08, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address + 0x0C, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)

    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_1 == "r1MCARTE" then -- Cartel con fuente
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, val_3[1].value)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end

function Cartel_2(carte_2)
    gg.searchNumber("00000031h;00000020h;74694310h;67695379h;6C00006Eh",
                    gg.TYPE_DWORD)
    gg.refineNumber("32", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address + 0x48, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address + 0x4C, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[1] = {address = r[1].address + 0x50, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[1] = {address = r[1].address + 0x54, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address + 0x58, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address + 0x5C, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)

    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_2 == "r2MCARTE" then -- Cartel  Aloha
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, val_3[1].value)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end

function Cartel_3(carte_3)
    gg.searchNumber("00000031h;00000020h;74694310h;67695379h;6C00006Eh",
                    gg.TYPE_DWORD)
    gg.refineNumber("32", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address - 0x58, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address - 0x54, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[1] = {address = r[1].address - 0x50, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[1] = {address = r[1].address - 0x4C, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address - 0x48, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address - 0x44, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_3 == "r3MCARTE" then -- Cartel de aviador
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, val_3[1].value)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end

function Cartel_4(carte_4)
    gg.searchNumber("00000031h;00000020h;74694310h;67695379h;6C00006Eh",
                    gg.TYPE_DWORD)
    gg.refineNumber("32", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address - 0xA8, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address - 0xA4, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[1] = {address = r[1].address - 0xA0, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[1] = {address = r[1].address - 0x9C, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address - 0x98, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address - 0x94, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_4 == "r4MCARTE" then -- Cartel Gran Pantalla
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, val_3[1].value)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end
function Cartel_5(carte_5)
    gg.searchNumber("00000031h;00000020h;74694310h;67695379h;6C00006Eh",
                    gg.TYPE_DWORD)
    gg.refineNumber("32", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address - 0xF8, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address - 0xF4, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[1] = {address = r[1].address - 0xF0, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[1] = {address = r[1].address - 0xEC, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address - 0xE8, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address - 0xE4, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_5 == "r5MCARTE" then -- Cartel Viejo Rancho
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, val_3[1].value)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end
function Cartel_6(carte_6)
    gg.searchNumber("00000031h;00000020h;74694310h;67695379h;6C00006Eh",
                    gg.TYPE_DWORD)
    gg.refineNumber("32", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address - 0x148, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address - 0x144, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[1] = {address = r[1].address - 0x140, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[1] = {address = r[1].address - 0x13C, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address - 0x138, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address - 0x134, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_6 == "r6MCARTE" then -- Cartel Molino
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, val_3[1].value)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end
function Cartel_7(carte_7)
    gg.searchNumber("00000031h;00000020h;74694310h;67695379h;6C00006Eh",
                    gg.TYPE_DWORD)
    gg.refineNumber("32", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address - 0x198, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address - 0x194, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[1] = {address = r[1].address - 0x190, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[1] = {address = r[1].address - 0x18C, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address - 0x188, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address - 0x184, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_7 == "r7MCARTE" then -- Cartel Mecanico
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, val_3[1].value)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end
function Cartel_8(carte_8)
    gg.searchNumber("00000031h;00000020h;74694310h;67695379h;6C00006Eh",
                    gg.TYPE_DWORD)
    gg.refineNumber("32", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address - 0x1E8, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address - 0x1E4, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[1] = {address = r[1].address - 0x1E0, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[1] = {address = r[1].address - 0x1DC, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address - 0x1D8, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address - 0x1D4, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_8 == "r8MCARTE" then -- Cartel Cactus
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, val_3[1].value)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end
function Cartel_9(carte_9)
    gg.searchNumber("00000031h;00000020h;74694310h;67695379h;6C00006Eh",
                    gg.TYPE_DWORD)
    gg.refineNumber("32", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address - 0x238, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address - 0x234, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[1] = {address = r[1].address - 0x230, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[1] = {address = r[1].address - 0x22C, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address - 0x228, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address - 0x224, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_9 == "r9MCARTE" then -- 1 Cartel Artesano
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, val_3[1].value)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end
function Cartel_10(carte_10)
    gg.searchNumber("00000031h;00000020h;74694310h;67695379h;6C00006Eh",
                    gg.TYPE_DWORD)
    gg.refineNumber("32", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address - 0x288, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address - 0x284, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[1] = {address = r[1].address - 0x280, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[1] = {address = r[1].address - 0x27C, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address - 0x278, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address - 0x274, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_10 == "r10MCARTE" then -- 2 Cartel con Flores
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, val_3[1].value)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end
function Cartel_11(carte_11)
    gg.searchNumber("00000031h;00000020h;74694310h;67695379h;6C00006Eh",
                    gg.TYPE_DWORD)
    gg.refineNumber("32", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address - 0x2D8, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address - 0x2D4, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[1] = {address = r[1].address - 0x2D0, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[1] = {address = r[1].address - 0x2CC, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address - 0x2C8, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address - 0x2C4, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_11 == "r11MCARTE" then -- 3 Cartel Impresionante
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, val_3[1].value)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end
function Cartel_12(carte_12)
    gg.searchNumber("00000031h;00000020h;74694310h;67695379h;6C00006Eh",
                    gg.TYPE_DWORD)
    gg.refineNumber("32", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address - 0x328, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address - 0x324, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[1] = {address = r[1].address - 0x320, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[1] = {address = r[1].address - 0x31C, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address - 0x318, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address - 0x314, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_12 == "r12MCARTE" then -- 4 Cartel Musical
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, val_3[1].value)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end
function Cartel_13(carte_13)
    gg.searchNumber("00000031h;00000020h;74694310h;67695379h;6C00006Eh",
                    gg.TYPE_DWORD)
    gg.refineNumber("32", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address - 0x378, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address - 0x374, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[1] = {address = r[1].address - 0x370, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[1] = {address = r[1].address - 0x36C, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address - 0x368, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address - 0x364, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_13 == "r13MCARTE" then -- 5 Cartel Luminoso
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, val_3[1].value)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end
function Cartel_14(carte_14)
    gg.searchNumber("00000031h;00000020h;74694310h;67695379h;6C00006Eh",
                    gg.TYPE_DWORD)
    gg.refineNumber("32", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address - 0x3C8, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address - 0x3C4, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[1] = {address = r[1].address - 0x3C0, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[1] = {address = r[1].address - 0x3BC, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address - 0x3B8, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address - 0x3B4, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_14 == "r14MCARTE" then -- 6 Cartel de Neon
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, val_3[1].value)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end
function Cartel_15(carte_15)
    gg.searchNumber("00000031h;00000020h;74694310h;67695379h;6C00006Eh",
                    gg.TYPE_DWORD)
    gg.refineNumber("32", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address - 0x418, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address - 0x414, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[1] = {address = r[1].address - 0x410, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[1] = {address = r[1].address - 0x40C, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address - 0x408, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address - 0x404, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_15 == "r15MCARTE" then -- 7 Cartel Salvaje Oeste
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, val_3[1].value)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end
function Cartel_16(carte_16)
    gg.searchNumber("00000031h;00000020h;74694310h;67695379h;6C00006Eh",
                    gg.TYPE_DWORD)
    gg.refineNumber("32", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address - 0x468, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address - 0x464, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[1] = {address = r[1].address - 0x460, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[1] = {address = r[1].address - 0x45C, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address - 0x458, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address - 0x454, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_16 == "r16MCARTE" then -- 8 Cartel Navideño
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, val_3[1].value)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end
function Cartel_17(carte_17)
    gg.searchNumber("00000031h;00000020h;74694310h;67695379h;6C00006Eh",
                    gg.TYPE_DWORD)
    gg.refineNumber("32", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address - 0x4B8, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address - 0x4B4, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[1] = {address = r[1].address - 0x4B0, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[1] = {address = r[1].address - 0x4AC, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address - 0x4A8, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address - 0x4A4, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_17 == "r17MCARTE" then -- 9 Cartel Grande de Halloween
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, val_3[1].value)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end
function Cartel_18(carte_18)
    gg.searchNumber("00000031h;00000020h;74694310h;67695379h;6C00006Eh",
                    gg.TYPE_DWORD)
    gg.refineNumber("32", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address - 0x508, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address - 0x504, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[1] = {address = r[1].address - 0x500, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[1] = {address = r[1].address - 0x4FC, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address - 0x4F8, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address - 0x4F4, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_18 == "r18MCARTE" then -- 10 Cartel del Dia de la Ciudad
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, val_3[1].value)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end
function Cartel_19(carte_19)
    gg.searchNumber("00000031h;00000020h;74694310h;67695379h;6C00006Eh",
                    gg.TYPE_DWORD)
    gg.refineNumber("32", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address - 0x558, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address - 0x554, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[1] = {address = r[1].address - 0x550, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[1] = {address = r[1].address - 0x54C, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address - 0x548, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address - 0x544, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_19 == "r19MCARTE" then -- 11 Cartel Granjero
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, val_3[1].value)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end
function Cartel_20(carte_20)
    gg.searchNumber("00000031h;00000020h;74694310h;67695379h;6C00006Eh",
                    gg.TYPE_DWORD)
    gg.refineNumber("32", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address - 0x5A8, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address - 0x5A4, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[1] = {address = r[1].address - 0x5A0, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[1] = {address = r[1].address - 0x59C, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address - 0x598, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address - 0x594, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_20 == "r20MCARTE" then -- 12 Cartel Ciudad de las Luces
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, val_3[1].value)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end
function Cartel_21(carte_21)
    gg.searchNumber("00000031h;00000020h;74694310h;67695379h;6C00006Eh",
                    gg.TYPE_DWORD)
    gg.refineNumber("32", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address - 0x5F8, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address - 0x5F4, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[1] = {address = r[1].address - 0x5F0, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[1] = {address = r[1].address - 0x5EC, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address - 0x5E8, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address - 0x5E4, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_21 == "r21MCARTE" then -- 13 Cartel Ciudad de los Sueños
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, val_3[1].value)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end
function Cartel_22(carte_22)
    gg.searchNumber("00000031h;00000020h;74694310h;67695379h;6C00006Eh",
                    gg.TYPE_DWORD)
    gg.refineNumber("32", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address - 0x648, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address - 0x644, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[1] = {address = r[1].address - 0x640, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[1] = {address = r[1].address - 0x63C, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address - 0x638, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address - 0x634, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_22 == "r22MCARTE" then -- 14 Cartel Ancestral
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, val_3[1].value)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end
function Cartel_23(carte_23)
    gg.searchNumber("00000031h;00000020h;74694310h;67695379h;6C00006Eh",
                    gg.TYPE_DWORD)
    gg.refineNumber("32", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address - 0x698, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address - 0x694, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[1] = {address = r[1].address - 0x690, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[1] = {address = r[1].address - 0x68C, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address - 0x688, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address - 0x684, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_23 == "r23MCARTE" then -- 15 Cartel de Piedra
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, val_3[1].value)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end
function Cartel_24(carte_24)
    gg.searchNumber("00000031h;00000020h;74694310h;67695379h;6C00006Eh",
                    gg.TYPE_DWORD)
    gg.refineNumber("32", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address - 0x6E8, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address - 0x6E4, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[1] = {address = r[1].address - 0x6E0, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[1] = {address = r[1].address - 0x6DC, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address - 0x6D8, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address - 0x6D4, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_24 == "r24MCARTE" then -- 16 Cartel  0
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, val_3[1].value)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end
function Cartel_25(carte_25)
    gg.searchNumber("00000031h;00000020h;74694310h;67695379h;6C00006Eh",
                    gg.TYPE_DWORD)
    gg.refineNumber("32", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address - 0x738, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address - 0x734, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[1] = {address = r[1].address - 0x730, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[1] = {address = r[1].address - 0x72C, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address - 0x728, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address - 0x724, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_25 == "r25MCARTE" then -- 17 Cartel de Pascua
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, val_3[1].value)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end

function Cartel_26(carte_26)
    gg.searchNumber("00000031h;00000020h;74694310h;67695379h;6C00006Eh",
                    gg.TYPE_DWORD)
    gg.refineNumber("32", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address + 0x98, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address + 0x9C, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[1] = {address = r[1].address + 0xA0, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[1] = {address = r[1].address + 0xA4, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address + 0xA8, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address + 0xAC, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_26 == "r26MCARTE" then -- 18  Cartel Paranormal
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, val_3[1].value)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end
function Cartel_27(carte_27)
    gg.searchNumber("00000031h;00000020h;74694310h;67695379h;6C00006Eh",
                    gg.TYPE_DWORD)
    gg.refineNumber("32", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address + 0xE8, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address + 0xEC, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[1] = {address = r[1].address + 0xF0, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[1] = {address = r[1].address + 0xF4, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address + 0xF8, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address + 0xFC, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_27 == "r27MCARTE" then -- 19  Cartel Monstrouso Inflable
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, val_3[1].value)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end
function Cartel_28(carte_28)
    gg.searchNumber("00000031h;00000020h;74694310h;67695379h;6C00006Eh",
                    gg.TYPE_DWORD)
    gg.refineNumber("32", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address + 0x138, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address + 0x13C, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[1] = {address = r[1].address + 0x140, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[1] = {address = r[1].address + 0x144, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address + 0x148, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address + 0x14C, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_28 == "r28MCARTE" then -- 20   Cartel Snowboard
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, val_3[1].value)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end

function Cartel_29(carte_29)
    gg.searchNumber("00000031h;00000020h;74694310h;67695379h;6C00006Eh",
                    gg.TYPE_DWORD)
    gg.refineNumber("32", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address + 0x188, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address + 0x18C, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[1] = {address = r[1].address + 0x190, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[1] = {address = r[1].address + 0x194, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address + 0x198, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address + 0x19C, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_29 == "r29MCARTE" then -- 21  Cartel Mundo Chicle
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, val_3[1].value)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end
function Cartel_30(carte_30)
    gg.searchNumber("00000031h;00000020h;74694310h;67695379h;6C00006Eh",
                    gg.TYPE_DWORD)
    gg.refineNumber("32", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address + 0x1D8, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address + 0x1DC, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[1] = {address = r[1].address + 0x1E0, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[1] = {address = r[1].address + 0x1E4, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address + 0x1E8, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address + 0x1EC, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_30 == "r30MCARTE" then -- 22 Cartel Chiringuito
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, val_3[1].value)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end
function Cartel_31(carte_31)
    gg.searchNumber("00000031h;00000020h;74694310h;67695379h;6C00006Eh",
                    gg.TYPE_DWORD)
    gg.refineNumber("32", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address + 0x228, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address + 0x22C, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[1] = {address = r[1].address + 0x230, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[1] = {address = r[1].address + 0x234, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address + 0x238, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address + 0x23C, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_31 == "r31MCARTE" then -- 23 Cartel Dulce Hogar
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, val_3[1].value)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end
function Cartel_32(carte_32)
    gg.searchNumber("33;26;1953055504;1734955897", gg.TYPE_DWORD)
    gg.refineNumber("26", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(8) -- load items
    local val_1 = {}
    val_1[8] = {address = r[8].address - 0x08, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[8] = {address = r[8].address - 0x04, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[8] = {address = r[8].address, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[8] = {address = r[8].address + 0x04, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[8] = {address = r[8].address + 0x08, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[8] = {address = r[8].address + 0x0C, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)

    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_32 == "r32MCARTE" then -- 24   cartel de Cuento
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[8].value)
        setd(-56, val_5[8].value)
        setd(-60, val_4[8].value)
        setd(-64, val_3[8].value)
        setd(-68, val_2[8].value)
        setd(-72, val_1[8].value)
    end
    gg.clearResults()
    return
end
function Cartel_33(carte_33)
    gg.searchNumber("33;26;1953055504;1734955897", gg.TYPE_DWORD)
    gg.refineNumber("26", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(8) -- load items
    local val_1 = {}
    val_1[8] = {address = r[8].address + 0x48, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[8] = {address = r[8].address + 0x4C, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[8] = {address = r[8].address + 0x50, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[8] = {address = r[8].address + 0x54, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[8] = {address = r[8].address + 0x58, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[8] = {address = r[8].address + 0x5C, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_33 == "r33MCARTE" then -- 25  Cartel Rockero
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[8].value)
        setd(-56, val_5[8].value)
        setd(-60, val_4[8].value)
        setd(-64, val_3[8].value)
        setd(-68, val_2[8].value)
        setd(-72, val_1[8].value)
    end
    gg.clearResults()
    return
end

function Cartel_34(carte_34)
    gg.searchNumber("33;26;1953055504;1734955897", gg.TYPE_DWORD)
    gg.refineNumber("26", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(8) -- load items
    local val_1 = {}
    val_1[8] = {address = r[8].address + 0x98, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[8] = {address = r[8].address + 0x9C, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[8] = {address = r[8].address + 0xA0, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[8] = {address = r[8].address + 0xA4, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[8] = {address = r[8].address + 0xA8, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[8] = {address = r[8].address + 0xAC, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_34 == "r34MCARTE" then -- 26 cartel
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[8].value)
        setd(-56, val_5[8].value)
        setd(-60, val_4[8].value)
        setd(-64, val_3[8].value)
        setd(-68, val_2[8].value)
        setd(-72, val_1[8].value)
    end
    gg.clearResults()
    return
end

function Cartel_35(carte_35)
    gg.searchNumber("33;26;1953055504;1734955897", gg.TYPE_DWORD)
    gg.refineNumber("26", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(8) -- load items
    local val_1 = {}
    val_1[8] = {address = r[8].address + 0xE8, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[8] = {address = r[8].address + 0xEC, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[8] = {address = r[8].address + 0xF0, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[8] = {address = r[8].address + 0xF4, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[8] = {address = r[8].address + 0xF8, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[8] = {address = r[8].address + 0xFC, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_35 == "r35MCARTE" then -- 27  cartel pirata
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[8].value)
        setd(-56, val_5[8].value)
        setd(-60, val_4[8].value)
        setd(-64, val_3[8].value)
        setd(-68, val_2[8].value)
        setd(-72, val_1[8].value)
    end
    gg.clearResults()
    return
end

function Cartel_36(carte_36)
    gg.searchNumber("33;26;1953055504;1734955897", gg.TYPE_DWORD)
    gg.refineNumber("26", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(8) -- load items
    local val_1 = {}
    val_1[8] = {address = r[8].address + 0x138, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[8] = {address = r[8].address + 0x13C, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[8] = {address = r[8].address + 0x140, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[8] = {address = r[8].address + 0x144, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[8] = {address = r[8].address + 0x148, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[8] = {address = r[8].address + 0x14C, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_36 == "r36MCARTE" then -- 28  Cartel navideño
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[8].value)
        setd(-56, val_5[8].value)
        setd(-60, val_4[8].value)
        setd(-64, val_3[8].value)
        setd(-68, val_2[8].value)
        setd(-72, val_1[8].value)
    end
    gg.clearResults()
    return
end

function Cartel_37(carte_37)
    gg.searchNumber("33;26;1953055504;1734955897", gg.TYPE_DWORD)
    gg.refineNumber("26", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(8) -- load items
    local val_1 = {}
    val_1[8] = {address = r[8].address + 0x188, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[8] = {address = r[8].address + 0x18C, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[8] = {address = r[8].address + 0x190, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[8] = {address = r[8].address + 0x194, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[8] = {address = r[8].address + 0x198, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[8] = {address = r[8].address + 0x19C, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_37 == "r37MCARTE" then -- 29  Cartel festivo
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[8].value)
        setd(-56, val_5[8].value)
        setd(-60, val_4[8].value)
        setd(-64, val_3[8].value)
        setd(-68, val_2[8].value)
        setd(-72, val_1[8].value)
    end
    gg.clearResults()
    return
end

function Cartel_38(carte_38)
    gg.searchNumber("33;26;1953055504;1734955897", gg.TYPE_DWORD)
    gg.refineNumber("26", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(8) -- load items
    local val_1 = {}
    val_1[8] = {address = r[8].address + 0x1D8, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[8] = {address = r[8].address + 0x1DC, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[8] = {address = r[8].address + 0x1E0, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[8] = {address = r[8].address + 0x1E4, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[8] = {address = r[8].address + 0x1E8, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[8] = {address = r[8].address + 0x1EC, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_38 == "r38MCARTE" then -- 30  Cartel mistico
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[8].value)
        setd(-56, val_5[8].value)
        setd(-60, val_4[8].value)
        setd(-64, val_3[8].value)
        setd(-68, val_2[8].value)
        setd(-72, val_1[8].value)
    end
    gg.clearResults()
    return
end

function Cartel_39(carte_39)
    gg.searchNumber("33;26;1953055504;1734955897", gg.TYPE_DWORD)
    gg.refineNumber("26", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(8) -- load items
    local val_1 = {}
    val_1[8] = {address = r[8].address + 0x228, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[8] = {address = r[8].address + 0x22C, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[8] = {address = r[8].address + 0x230, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[8] = {address = r[8].address + 0x234, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[8] = {address = r[8].address + 0x238, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[8] = {address = r[8].address + 0x23C, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_39 == "r39MCARTE" then -- 31  Cartel paranormal
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[8].value)
        setd(-56, val_5[8].value)
        setd(-60, val_4[8].value)
        setd(-64, val_3[8].value)
        setd(-68, val_2[8].value)
        setd(-72, val_1[8].value)
    end
    gg.clearResults()
    return
end

function Cartel_40(carte_40)
    gg.searchNumber("33;26;1953055504;1734955897", gg.TYPE_DWORD)
    gg.refineNumber("26", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(8) -- load items
    local val_1 = {}
    val_1[8] = {address = r[8].address + 0x278, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[8] = {address = r[8].address + 0x27C, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[8] = {address = r[8].address + 0x280, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[8] = {address = r[8].address + 0x284, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[8] = {address = r[8].address + 0x288, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[8] = {address = r[8].address + 0x28C, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_40 == "r40MCARTE" then -- 32  Cartel cthutun
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[8].value)
        setd(-56, val_5[8].value)
        setd(-60, val_4[8].value)
        setd(-64, val_3[8].value)
        setd(-68, val_2[8].value)
        setd(-72, val_1[8].value)
    end
    gg.clearResults()
    return
end

function Cartel_41(carte_41)
    gg.searchNumber("33;26;1953055504;1734955897", gg.TYPE_DWORD)
    gg.refineNumber("26", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(8) -- load items
    local val_1 = {}
    val_1[8] = {address = r[8].address + 0x2C8, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[8] = {address = r[8].address + 0x2CC, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[8] = {address = r[8].address + 0x2D0, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[8] = {address = r[8].address + 0x2D4, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[8] = {address = r[8].address + 0x2D8, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[8] = {address = r[8].address + 0x2DC, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_41 == "r41MCARTE" then -- 33  Cartel ciudada navidad
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[8].value)
        setd(-56, val_5[8].value)
        setd(-60, val_4[8].value)
        setd(-64, val_3[8].value)
        setd(-68, val_2[8].value)
        setd(-72, val_1[8].value)
    end
    gg.clearResults()
    return
end
-- PPPPPPPPPPPPPPPPPPPPPP
function Cartel_42(carte_42)
    gg.searchNumber("33;26;1953055504;1734955897", gg.TYPE_DWORD)
    gg.refineNumber("26", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(8) -- load items
    local val_1 = {}
    val_1[8] = {address = r[8].address + 0x318, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[8] = {address = r[8].address + 0x31C, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[8] = {address = r[8].address + 0x320, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[8] = {address = r[8].address + 0x324, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[8] = {address = r[8].address + 0x328, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[8] = {address = r[8].address + 0x32C, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_42 == "r42MCARTE" then -- 34  Cartel  
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[8].value)
        setd(-56, val_5[8].value)
        setd(-60, val_4[8].value)
        setd(-64, val_3[8].value)
        setd(-68, val_2[8].value)
        setd(-72, val_1[8].value)
    end
    gg.clearResults()
    return
end
function Cartel_43(carte_43)
    gg.searchNumber("33;26;1953055504;1734955897", gg.TYPE_DWORD)
    gg.refineNumber("26", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(8) -- load items
    local val_1 = {}
    val_1[8] = {address = r[8].address + 0x368, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[8] = {address = r[8].address + 0x36C, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[8] = {address = r[8].address + 0x370, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[8] = {address = r[8].address + 0x374, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[8] = {address = r[8].address + 0x378, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[8] = {address = r[8].address + 0x37C, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_43 == "r43MCARTE" then -- 35  Cartel  
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[8].value)
        setd(-56, val_5[8].value)
        setd(-60, val_4[8].value)
        setd(-64, val_3[8].value)
        setd(-68, val_2[8].value)
        setd(-72, val_1[8].value)
    end
    gg.clearResults()
    return
end
function Cartel_44(carte_44)
    gg.searchNumber("33;26;1953055504;1734955897", gg.TYPE_DWORD)
    gg.refineNumber("26", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(8) -- load items
    local val_1 = {}
    val_1[8] = {address = r[8].address + 0x3B8, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[8] = {address = r[8].address + 0x3BC, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[8] = {address = r[8].address + 0x3C0, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[8] = {address = r[8].address + 0x3C4, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[8] = {address = r[8].address + 0x3C8, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[8] = {address = r[8].address + 0x3CC, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_44 == "r44MCARTE" then -- 36  Cartel 
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[8].value)
        setd(-56, val_5[8].value)
        setd(-60, val_4[8].value)
        setd(-64, val_3[8].value)
        setd(-68, val_2[8].value)
        setd(-72, val_1[8].value)
    end
    gg.clearResults()
    return
end
function Cartel_45(carte_45)
    gg.searchNumber("33;26;1953055504;1734955897", gg.TYPE_DWORD)
    gg.refineNumber("26", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(8) -- load items
    local val_1 = {}
    val_1[8] = {address = r[8].address + 0x408, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[8] = {address = r[8].address + 0x40C, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[8] = {address = r[8].address + 0x410, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[8] = {address = r[8].address + 0x414, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[8] = {address = r[8].address + 0x418, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[8] = {address = r[8].address + 0x41C, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_45 == "r45MCARTE" then -- 37  Cartel 
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[8].value)
        setd(-56, val_5[8].value)
        setd(-60, val_4[8].value)
        setd(-64, val_3[8].value)
        setd(-68, val_2[8].value)
        setd(-72, val_1[8].value)
    end
    gg.clearResults()
    return
end
function Cartel_46(carte_46)
    gg.searchNumber("33;26;1953055504;1734955897", gg.TYPE_DWORD)
    gg.refineNumber("26", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(8) -- load items
    local val_1 = {}
    val_1[8] = {address = r[8].address + 0x458, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[8] = {address = r[8].address + 0x45C, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[8] = {address = r[8].address + 0x460, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[8] = {address = r[8].address + 0x464, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[8] = {address = r[8].address + 0x468, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[8] = {address = r[8].address + 0x46C, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_46 == "r46MCARTE" then -- 38  Cartel  
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[8].value)
        setd(-56, val_5[8].value)
        setd(-60, val_4[8].value)
        setd(-64, val_3[8].value)
        setd(-68, val_2[8].value)
        setd(-72, val_1[8].value)
    end
    gg.clearResults()
    return
end
function Cartel_47(carte_47)
    gg.searchNumber("33;26;1953055504;1734955897", gg.TYPE_DWORD)
    gg.refineNumber("26", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(8) -- load items
    local val_1 = {}
    val_1[8] = {address = r[8].address + 0x4A8, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[8] = {address = r[8].address + 0x4AC, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[8] = {address = r[8].address + 0x4B0, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[8] = {address = r[8].address + 0x4B4, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[8] = {address = r[8].address + 0x4B8, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[8] = {address = r[8].address + 0x4BC, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_47 == "r47MCARTE" then -- 39  Cartel  
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[8].value)
        setd(-56, val_5[8].value)
        setd(-60, val_4[8].value)
        setd(-64, val_3[8].value)
        setd(-68, val_2[8].value)
        setd(-72, val_1[8].value)
    end
    gg.clearResults()
    return
end
function Cartel_48(carte_48)
    gg.searchNumber("33;26;1953055504;1734955897", gg.TYPE_DWORD)
    gg.refineNumber("26", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(8) -- load items
    local val_1 = {}
    val_1[8] = {address = r[8].address + 0x4F8, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[8] = {address = r[8].address + 0x4FC, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[8] = {address = r[8].address + 0x500, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[8] = {address = r[8].address + 0x504, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[8] = {address = r[8].address + 0x508, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[8] = {address = r[8].address + 0x50C, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_48 == "r48MCARTE" then -- 40  Cartel  
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[8].value)
        setd(-56, val_5[8].value)
        setd(-60, val_4[8].value)
        setd(-64, val_3[8].value)
        setd(-68, val_2[8].value)
        setd(-72, val_1[8].value)
    end
    gg.clearResults()
    return
end
function Cartel_49(carte_49)
    gg.searchNumber("33;26;1953055504;1734955897", gg.TYPE_DWORD)
    gg.refineNumber("26", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(8) -- load items
    local val_1 = {}
    val_1[8] = {address = r[8].address + 0x548, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[8] = {address = r[8].address + 0x54C, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[8] = {address = r[8].address + 0x550, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[8] = {address = r[8].address + 0x554, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[8] = {address = r[8].address + 0x558, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[8] = {address = r[8].address + 0x55C, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_49 == "r49MCARTE" then -- 41  Cartel  
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[8].value)
        setd(-56, val_5[8].value)
        setd(-60, val_4[8].value)
        setd(-64, val_3[8].value)
        setd(-68, val_2[8].value)
        setd(-72, val_1[8].value)
    end
    gg.clearResults()
    return
end
-- aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
function Cartel_50(carte_50)
    gg.searchNumber("33;26;1953055504;1734955897", gg.TYPE_DWORD)
    gg.refineNumber("26", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(8) -- load items
    local val_1 = {}
    val_1[8] = {address = r[8].address - 0x58, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[8] = {address = r[8].address - 0x54, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[8] = {address = r[8].address - 0x50, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[8] = {address = r[8].address - 0x4C, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[8] = {address = r[8].address - 0x48, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[8] = {address = r[8].address - 0x44, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_50 == "r50MCARTE" then -- 42  Cartel   ----------------------------- no
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[8].value)
        setd(-56, val_5[8].value)
        setd(-60, val_4[8].value)
        setd(-64, val_3[8].value)
        setd(-68, val_2[8].value)
        setd(-72, val_1[8].value)
    end
    gg.clearResults()
    return
end
function Cartel_51(carte_51)
    gg.searchNumber("33;26;1953055504;1734955897", gg.TYPE_DWORD)
    gg.refineNumber("26", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(8) -- load items
    local val_1 = {}
    val_1[8] = {address = r[8].address - 0xA8, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[8] = {address = r[8].address - 0xA4, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[8] = {address = r[8].address - 0xA0, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[8] = {address = r[8].address - 0x9C, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[8] = {address = r[8].address - 0x98, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[8] = {address = r[8].address - 0x94, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_51 == "r51MCARTE" then -- 43  Cartel  
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[8].value)
        setd(-56, val_5[8].value)
        setd(-60, val_4[8].value)
        setd(-64, val_3[8].value)
        setd(-68, val_2[8].value)
        setd(-72, val_1[8].value)
    end
    gg.clearResults()
    return
end
function Cartel_52(carte_52)
    gg.searchNumber("33;26;1953055504;1734955897", gg.TYPE_DWORD)
    gg.refineNumber("26", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(8) -- load items
    local val_1 = {}
    val_1[8] = {address = r[8].address - 0xF8, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[8] = {address = r[8].address - 0xF4, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[8] = {address = r[8].address - 0xF0, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[8] = {address = r[8].address - 0xEC, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[8] = {address = r[8].address - 0xE8, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[8] = {address = r[8].address - 0xE4, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_52 == "r52MCARTE" then -- 44  Cartel 
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[8].value)
        setd(-56, val_5[8].value)
        setd(-60, val_4[8].value)
        setd(-64, val_3[8].value)
        setd(-68, val_2[8].value)
        setd(-72, val_1[8].value)
    end
    gg.clearResults()
    return
end
function Cartel_53(carte_53)
    gg.searchNumber("33;26;1953055504;1734955897", gg.TYPE_DWORD)
    gg.refineNumber("26", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(8) -- load items
    local val_1 = {}
    val_1[8] = {address = r[8].address - 0x148, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[8] = {address = r[8].address - 0x144, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[8] = {address = r[8].address - 0x140, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[8] = {address = r[8].address - 0x13C, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[8] = {address = r[8].address - 0x138, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[8] = {address = r[8].address - 0x134, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_53 == "r53MCARTE" then -- 45  Cartel 
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[8].value)
        setd(-56, val_5[8].value)
        setd(-60, val_4[8].value)
        setd(-64, val_3[8].value)
        setd(-68, val_2[8].value)
        setd(-72, val_1[8].value)
    end
    gg.clearResults()
    return
end
function Cartel_54(carte_54)
    gg.searchNumber("33;26;1953055504;1734955897", gg.TYPE_DWORD)
    gg.refineNumber("26", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(8) -- load items
    local val_1 = {}
    val_1[8] = {address = r[8].address - 0x198, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[8] = {address = r[8].address - 0x194, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[8] = {address = r[8].address - 0x190, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[8] = {address = r[8].address - 0x18C, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[8] = {address = r[8].address - 0x188, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[8] = {address = r[8].address - 0x184, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_54 == "r54MCARTE" then -- 46  Cartel  
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[8].value)
        setd(-56, val_5[8].value)
        setd(-60, val_4[8].value)
        setd(-64, val_3[8].value)
        setd(-68, val_2[8].value)
        setd(-72, val_1[8].value)
    end
    gg.clearResults()
    return
end
function Cartel_55(carte_55)
    gg.searchNumber("33;26;1953055504;1734955897", gg.TYPE_DWORD)
    gg.refineNumber("26", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(8) -- load items
    local val_1 = {}
    val_1[8] = {address = r[8].address - 0x1E8, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[8] = {address = r[8].address - 0x1E4, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[8] = {address = r[8].address - 0x1E0, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[8] = {address = r[8].address - 0x1DC, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[8] = {address = r[8].address - 0x1D8, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[8] = {address = r[8].address - 0x1D4, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if carte_41 == "r41MCARTE" then -- 47  Cartel 
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[8].value)
        setd(-56, val_5[8].value)
        setd(-60, val_4[8].value)
        setd(-64, val_3[8].value)
        setd(-68, val_2[8].value)
        setd(-72, val_1[8].value)
    end
    gg.clearResults()
    return
end

-- navidad
function Nvidad_1(NvidadR_1)
    gg.searchNumber("00000031h;00000020h;74694310h;67695379h;6C00006Eh",
                    gg.TYPE_DWORD)
    gg.refineNumber("32", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address - 0x788, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address - 0x784, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[1] = {address = r[1].address - 0x780, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[1] = {address = r[1].address - 0x77C, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address - 0x778, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address - 0x774, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if NvidadR_1 == "r1NvidadR" then -- 18 Tienda de Regalos de Navidad
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, val_3[1].value)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end
function Nvidad_2(NvidadR_2)
    gg.searchNumber("00000031h;00000020h;74694310h;67695379h;6C00006Eh",
                    gg.TYPE_DWORD)
    gg.refineNumber("32", gg.TYPE_DWORD)
    --	33;26;1953055504;1734955897 ref 26
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address - 0x7D8, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address - 0x7D4, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[1] = {address = r[1].address - 0x7D0, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[1] = {address = r[1].address - 0x7CC, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address - 0x7C8, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address - 0x7C4, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if NvidadR_2 == "r2NvidadR" then -- 19 Galleta Relajada  
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, val_3[1].value)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end

function hackTHO(variac)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    ItemPass()
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")

    local int234 = nil
    if variac == "th6" then
        int234 = gg.prompt({"Cantidad? [0; 5000]"}, {1}, {"number"})
        int234[1] = tonumber(int234[1])
    end
    -- TCASH UNLIMITED 1935762184;104;0;0;0;0
    if variac == "th6" then
        setd(-48, 0)
        setd(-44, int234[1])
        setd(-52, "0")
        setd(-56, "0")
        setd(-60, "0")
        setd(-64, "0")
        setd(-68, "104")
        setd(-72, "1935762184")
    elseif variac == "th7" then -- .statue_writer El primer escritor 6174731Ah;5F657574h;74697277h;00007265h;00000000h;00000000h
        setd(-48, 0) -- test 24 Bola de Nieve Bola de Nieve
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00007265h")
        setd(-64, "74697277h")
        setd(-68, "5F657574h")
        setd(-72, "6174731Ah")
    end
    gg.clearResults()
end

-- Regata
function Regata()

    function lompat()
        gg.setVisible(false)
        gg.timeJump("00:01:00:00:00")

    end
    lompat()

    gg.setVisible(false)
    gg.clearResults()

    function hilangkanTask2()

        gg.searchNumber("1633121097", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)

        local res2 = gg.getResults(9999)
        if #res2 > 0 then
            for i, v in ipairs(res2) do
                v.value = 0
                v.freeze = true
                v.flags = gg.TYPE_DWORD
            end
            gg.setValues(res2)
            -- gg.addListItems(res2)
        else
            gg.toast("Tidak ada hasil untuk pencarian kedua.")
        end

        gg.clearResults()
        -- 🔎 Bagian pertama
        local searchString = "1701536084;1935758446;29547;10"
        gg.searchNumber(searchString, gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
        if gg.getResultCount() == 0 then
            gg.toast("Tidak ada hasil pencarian awal.")
        else
            gg.refineNumber("1701536084", gg.TYPE_DWORD)
            local results = gg.getResults(9999)

            if #results > 0 then
                local checkAddr = {}
                for i, res in ipairs(results) do
                    table.insert(checkAddr, {
                        address = res.address - 0x4,
                        flags = gg.TYPE_DWORD
                    })
                end
                checkAddr = gg.getValues(checkAddr)

                local edits = {}
                for i, res in ipairs(results) do
                    if checkAddr[i].value == 10 then
                        table.insert(edits, {
                            address = res.address,
                            flags = gg.TYPE_DWORD,
                            value = 0,
                            freeze = true
                        })
                    end
                end

                if #edits > 0 then
                    gg.setValues(edits)
                    -- gg.addListItems(edits)
                else
                    gg.toast("Tidak ada hasil cocok (bagian pertama).")
                end
            end
        end

    end

    local pilihanAktif = nil
    local lastVisibleTime = 0

    function HOME()
        if pilihanAktif ~= nil then
            matchXorAll(pilihanAktif)
            return
        end

        local choice = gg.choice({"Points 150", "Points 300", "❌ Exit"}, nil,
                                 "🔥 HACK BY DYLUC\nSilakan pilih jumlah points")

        if choice == nil then return end

        if choice == 1 then
            pilihanAktif = 150
            matchXorAll(pilihanAktif)
            pilihanAktif = nil -- reset biar bisa pilih lagi

        elseif choice == 2 then
            pilihanAktif = 300
            matchXorAll(pilihanAktif)
            pilihanAktif = nil -- reset juga

        elseif choice == 3 then
            gg.toast("Keluar...")
            gg.clearList()
            gg.clearResults()
            os.exit()
        end
    end

    function matchXorAll(target_value)

        gg.clearResults()
        gg.setRanges(gg.REGION_C_ALLOC)

        -- Langkah 1: Search & Refine
        gg.searchNumber("1702257942;1868526702;1919247474", gg.TYPE_DWORD)
        gg.refineNumber("1702257942", gg.TYPE_DWORD)

        local results = gg.getResults(9999)
        local validResults = {}
        local addList = {}
        local editList = {}

        -- Nilai valid untuk offset +0x30
        local validOffset30 = {
            [1952533772] = true,
            [1886930198] = true,
            [1919241496] = true
        }

        -- Nilai XOR yang dianggap valid
        local validPoints = {}

        -- Tambahkan angka dari 1 sampai 100
        for i = 1, 100 do validPoints[i] = true end

        -- Tambahkan angka dari 100 sampai 2000
        for i = 100, 2000 do validPoints[i] = true end

        -- Tambahkan angka-angka lainnya secara manual
        local extraPoints = {
            110, 120, 125, 130, 140, 150, 170, 300, 400, 500, 600, 700, 800,
            900, 1000, 1100, 1150
        }

        for _, v in ipairs(extraPoints) do validPoints[v] = true end

        for i, res in ipairs(results) do
            local base = res.address

            -- Ambil nilai dari offset +0x30
            local val30 = gg.getValues({
                {address = base + 0x30, flags = gg.TYPE_DWORD}
            })[1].value

            if validOffset30[val30] then
                -- Lanjutkan proses XOR di offset +0x68 dan +0x6C
                local offsets = {
                    {address = base + 0x98, flags = gg.TYPE_DWORD},
                    {address = base + 0x9C, flags = gg.TYPE_DWORD}
                }

                local values = gg.getValues(offsets)
                local val1 = values[1].value
                local val2 = values[2].value
                local xorResult = bit32.bxor(val1, val2)

                if validPoints[xorResult] then
                    table.insert(validResults, res)

                    -- table.insert(addList, {
                    --     address = base + 0x98,
                    --     flags = gg.TYPE_DWORD,
                    --     value = val1,
                    --     name = "Offset +98"
                    -- })
                    -- table.insert(addList, {
                    --     address = base + 0x9C,
                    --     flags = gg.TYPE_DWORD,
                    --     value = val2,
                    --     name = "Offset +9C"
                    -- })

                    table.insert(editList, {
                        address = base + 0x98,
                        flags = gg.TYPE_DWORD,
                        value = 0
                    })
                    table.insert(editList, {
                        address = base + 0x9C,
                        flags = gg.TYPE_DWORD,
                        value = 0
                    })
                end

                -------------------------------------
                -- BAGIAN 2: TAMBAHAN CEK POINTER +D8 --
                -------------------------------------

                local PointsRegata = {
                    [50] = true,
                    [70] = true,
                    [75] = true,
                    [80] = true,
                    [85] = true,
                    [90] = true,
                    [95] = true,
                    [100] = true,
                    [105] = true,
                    [110] = true,
                    [115] = true,
                    [120] = true,
                    [125] = true,
                    [130] = true,
                    [135] = true,
                    [140] = true,
                    [150] = true
                }

                local pointerAddr = base + 0x120
                local pointerData = gg.getValues({
                    {address = pointerAddr, flags = gg.TYPE_QWORD}
                })
                local pointerValue = pointerData[1].value

                if pointerValue ~= 0 and pointerValue > 0x10000 then
                    local success, values =
                        pcall(gg.getValues, {
                            {address = pointerValue, flags = gg.TYPE_DWORD},
                            {address = pointerValue + 4, flags = gg.TYPE_DWORD}
                        })

                    if success then
                        local pval1 = values[1].value
                        local pval2 = values[2].value
                        local pxor = pval1 ~ pval2

                        if PointsRegata[pxor] then
                            table.insert(editList, {
                                address = pointerValue,
                                flags = gg.TYPE_DWORD,
                                value = 0
                            })
                            table.insert(editList, {
                                address = pointerValue + 4,
                                flags = gg.TYPE_DWORD,
                                value = target_value -- POINT REGATA
                            })

                        else

                        end
                    else

                    end
                else

                end

            end
        end

        if #validResults > 0 then
            gg.loadResults(validResults)
            gg.addListItems(addList)
            gg.setValues(editList)
            -- Jika ingin langsung ubah nilainya:
            -- gg.setValues(editList)

        else

        end
    end
    HOME()
end

-- hackTrEn
function hackTrEn()
    gg.alert("Make it more Start the game or restart the game...")
    gg.toast("Make it more Start the game or restart the game...")
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("1600407924;51", gg.TYPE_DWORD)
    gg.refineNumber("51", gg.TYPE_DWORD)
    r = gg.getResults(1)
    -- do something
    local t = {}
    t[1] = {}
    t[1].address = r[1].address + 0x34 -- 782BF3ADBE80 + es abajo y x4 decimal 
    t[1].flags = gg.TYPE_FLOAT
    t[1].value = 3
    t[1].freeze = false
    gg.setValues(t)
    -- 00000001h;6892D4F9h
    -- 81x4 324 dec a hexa 144 - 4 = 140
    local e = {}
    e[1] = {}
    e[1].address = r[1].address - 0x144
    e[1].flags = gg.TYPE_DWORD
    e[1].value = 1
    e[1].freeze = false
    gg.setValues(e)

    local y = {}
    y[1] = {}
    y[1].address = r[1].address - 0x140
    y[1].flags = gg.TYPE_DWORD
    y[1].value = 1754453241
    y[1].freeze = false
    gg.setValues(y)

    local v = {}
    v[1] = {}
    v[1].address = r[1].address - 0x174
    v[1].flags = gg.TYPE_DWORD
    v[1].value = 0
    v[1].freeze = false
    gg.setValues(v)

    local h = {}
    h[1] = {}
    h[1].address = r[1].address - 0x170
    h[1].flags = gg.TYPE_DWORD
    h[1].value = 500
    h[1].freeze = false
    gg.setValues(h)

    local k_1 = {}
    k_1[1] = {}
    k_1[1].address = r[1].address - 0x18C
    k_1[1].flags = gg.TYPE_DWORD
    k_1[1].value = 1918985488
    k_1[1].freeze = false
    gg.setValues(k_1)

    local k_2 = {}
    k_2[1] = {}
    k_2[1].address = r[1].address - 0x188
    k_2[1].flags = gg.TYPE_DWORD
    k_2[1].value = 1735289202
    k_2[1].freeze = false
    gg.setValues(k_2)

    local k_3 = {}
    k_3[1] = {}
    k_3[1].address = r[1].address - 0x184
    k_3[1].flags = gg.TYPE_DWORD
    k_3[1].value = 115
    k_3[1].freeze = false
    gg.setValues(k_3)
    local k_4 = {}
    k_4[1] = {}
    k_4[1].address = r[1].address - 0x180
    k_4[1].flags = gg.TYPE_DWORD
    k_4[1].value = 0
    k_4[1].freeze = false
    gg.setValues(k_4)

    -- 1634296844 7169380 13407 0 valor 500 diadema

    local e_1 = {}
    e_1[1] = {}
    e_1[1].address = r[1].address - 0x264
    e_1[1].flags = gg.TYPE_DWORD
    e_1[1].value = 1
    e_1[1].freeze = false
    gg.setValues(e_1)

    local x_1 = {}
    x_1[1] = {}
    x_1[1].address = r[1].address - 0x260
    x_1[1].flags = gg.TYPE_DWORD
    x_1[1].value = 1754453241
    x_1[1].freeze = false
    gg.setValues(x_1)

    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = r[1].address - 0x294
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 0
    v_1[1].freeze = false
    gg.setValues(v_1)

    local w_1 = {}
    w_1[1] = {}
    w_1[1].address = r[1].address - 0x290
    w_1[1].flags = gg.TYPE_DWORD
    w_1[1].value = 500
    w_1[1].freeze = false
    gg.setValues(w_1)

    --
    local R_1 = {}
    R_1[1] = {}
    R_1[1].address = r[1].address - 0x2AC
    R_1[1].flags = gg.TYPE_DWORD
    R_1[1].value = 1634296844
    R_1[1].freeze = false
    gg.setValues(R_1)

    local R_2 = {}
    R_2[1] = {}
    R_2[1].address = r[1].address - 0x2A8
    R_2[1].flags = gg.TYPE_DWORD
    R_2[1].value = 7169380
    R_2[1].freeze = false
    gg.setValues(R_2)

    local R_3 = {}
    R_3[1] = {}
    R_3[1].address = r[1].address - 0x2A4
    R_3[1].flags = gg.TYPE_DWORD
    R_3[1].value = 13407
    R_3[1].freeze = false
    gg.setValues(R_3)

    local R_4 = {}
    R_4[1] = {}
    R_4[1].address = r[1].address - 0x2A0
    R_4[1].flags = gg.TYPE_DWORD
    R_4[1].value = 0
    R_4[1].freeze = false
    gg.setValues(R_4)

    -- collar de perlas 800 = 1634037778 1701735538 27491 0

    local e_2 = {}
    e_2[1] = {}
    e_2[1].address = r[1].address - 0x384
    e_2[1].flags = gg.TYPE_DWORD
    e_2[1].value = 1
    e_2[1].freeze = false
    gg.setValues(e_2)

    local x_2 = {}
    x_2[1] = {}
    x_2[1].address = r[1].address - 0x380
    x_2[1].flags = gg.TYPE_DWORD
    x_2[1].value = 1754453241
    x_2[1].freeze = false
    gg.setValues(x_2)

    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = r[1].address - 0x3B4
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = 0
    v_2[1].freeze = false
    gg.setValues(v_2)

    local w_2 = {}
    w_2[1] = {}
    w_2[1].address = r[1].address - 0x3B0
    w_2[1].flags = gg.TYPE_DWORD
    w_2[1].value = 800
    w_2[1].freeze = false
    gg.setValues(w_2)
    --
    local H_1 = {}
    H_1[1] = {}
    H_1[1].address = r[1].address - 0x3CC
    H_1[1].flags = gg.TYPE_DWORD
    H_1[1].value = 1634037778
    H_1[1].freeze = false
    gg.setValues(H_1)

    local H_2 = {}
    H_2[1] = {}
    H_2[1].address = r[1].address - 0x3C8
    H_2[1].flags = gg.TYPE_DWORD
    H_2[1].value = 1701735538
    H_2[1].freeze = false
    gg.setValues(H_2)

    local H_3 = {}
    H_3[1] = {}
    H_3[1].address = r[1].address - 0x3C4
    H_3[1].flags = gg.TYPE_DWORD
    H_3[1].value = 27491
    H_3[1].freeze = false
    gg.setValues(H_3)

    local H_4 = {}
    H_4[1] = {}
    H_4[1].address = r[1].address - 0x3C0
    H_4[1].flags = gg.TYPE_DWORD
    H_4[1].value = 0
    H_4[1].freeze = false
    gg.setValues(R_4)

    -- 1852404232 1953366119 7037696 1677747456 1694523753 28001 anillo 732 poner 550
    local e_3 = {}
    e_3[1] = {}
    e_3[1].address = r[1].address - 0x4A4
    e_3[1].flags = gg.TYPE_DWORD
    e_3[1].value = 1
    e_3[1].freeze = false
    gg.setValues(e_3)

    local x_3 = {}
    x_3[1] = {}
    x_3[1].address = r[1].address - 0x4A0
    x_3[1].flags = gg.TYPE_DWORD
    x_3[1].value = 1754453241
    x_3[1].freeze = false
    gg.setValues(x_3)

    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = r[1].address - 0x4D4
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = 0
    v_3[1].freeze = false
    gg.setValues(v_3)

    local w_3 = {}
    w_3[1] = {}
    w_3[1].address = r[1].address - 0x4D0
    w_3[1].flags = gg.TYPE_DWORD
    w_3[1].value = 550
    w_3[1].freeze = false
    gg.setValues(w_3)
    -- 1852404232 1953366119 7037696 1677747456 1694523753 28001 anillo 732 poner 550
    local Y_1 = {}
    Y_1[1] = {}
    Y_1[1].address = r[1].address - 0x4EC
    Y_1[1].flags = gg.TYPE_DWORD
    Y_1[1].value = 1852404232
    Y_1[1].freeze = false
    gg.setValues(Y_1)

    local Y_2 = {}
    Y_2[1] = {}
    Y_2[1].address = r[1].address - 0x4E8
    Y_2[1].flags = gg.TYPE_DWORD
    Y_2[1].value = 1953366119
    Y_2[1].freeze = false
    gg.setValues(Y_2)

    local Y_3 = {}
    Y_3[1] = {}
    Y_3[1].address = r[1].address - 0x4E4
    Y_3[1].flags = gg.TYPE_DWORD
    Y_3[1].value = 7037696
    Y_3[1].freeze = false
    gg.setValues(Y_3)

    local Y_4 = {}
    Y_4[1] = {}
    Y_4[1].address = r[1].address - 0x4E0
    Y_4[1].flags = gg.TYPE_DWORD
    Y_4[1].value = 1677747456
    Y_4[1].freeze = false
    gg.setValues(Y_4)

    local Y_5 = {}
    Y_5[1] = {}
    Y_5[1].address = r[1].address - 0x4DC
    Y_5[1].flags = gg.TYPE_DWORD
    Y_5[1].value = 1694523753
    Y_5[1].freeze = false
    gg.setValues(Y_5)

    local Y_6 = {}
    Y_6[1] = {}
    Y_6[1].address = r[1].address - 0x4D8
    Y_6[1].flags = gg.TYPE_DWORD
    Y_6[1].value = 28001
    Y_6[1].freeze = false
    gg.setValues(Y_6)

    --

    local e_4 = {}
    e_4[1] = {}
    e_4[1].address = r[1].address - 0x5C4
    e_4[1].flags = gg.TYPE_DWORD
    e_4[1].value = 1
    e_4[1].freeze = false
    gg.setValues(e_4)

    local x_4 = {}
    x_4[1] = {}
    x_4[1].address = r[1].address - 0x5C0
    x_4[1].flags = gg.TYPE_DWORD
    x_4[1].value = 1754453241
    x_4[1].freeze = false
    gg.setValues(x_4)

    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = r[1].address - 0x5F4
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = 0
    v_4[1].freeze = false
    gg.setValues(v_4)

    local w_4 = {}
    w_4[1] = {}
    w_4[1].address = r[1].address - 0x5F0
    w_4[1].flags = gg.TYPE_DWORD
    w_4[1].value = 800
    w_4[1].freeze = false
    gg.setValues(w_4)

    -- pendiente de plata  800 = 1852141582 1953390948 12800 0

    local F_1 = {}
    F_1[1] = {}
    F_1[1].address = r[1].address - 0x60C
    F_1[1].flags = gg.TYPE_DWORD
    F_1[1].value = 1852141582
    F_1[1].freeze = false
    gg.setValues(F_1)

    local F_2 = {}
    F_2[1] = {}
    F_2[1].address = r[1].address - 0x608
    F_2[1].flags = gg.TYPE_DWORD
    F_2[1].value = 1953390948
    F_2[1].freeze = false
    gg.setValues(F_2)

    local F_3 = {}
    F_3[1] = {}
    F_3[1].address = r[1].address - 0x604
    F_3[1].flags = gg.TYPE_DWORD
    F_3[1].value = 12800
    F_3[1].freeze = false
    gg.setValues(F_3)

    local F_4 = {}
    F_4[1] = {}
    F_4[1].address = r[1].address - 0x600
    F_4[1].flags = gg.TYPE_DWORD
    F_4[1].value = 0
    F_4[1].freeze = false
    gg.setValues(F_4)

    local F_5 = {}
    F_5[1] = {}
    F_5[1].address = r[1].address - 0x5FC
    F_5[1].flags = gg.TYPE_DWORD
    F_5[1].value = 0
    F_5[1].freeze = false
    gg.setValues(F_5)

    local F_6 = {}
    F_6[1] = {}
    F_6[1].address = r[1].address - 0x5F8
    F_6[1].flags = gg.TYPE_DWORD
    F_6[1].value = 0
    F_6[1].freeze = false
    gg.setValues(F_6)

    hackTrEn_XP_2()
end

function hackTrEn_XP_2()
    gg.alert("Hacerlo mas Iniciar el juego o reiniciar el juego...")
    gg.toast("Hacerlo mas Iniciar el juego o reiniciar el juego...")
    gg.toast("Cargando...")

    r = gg.getResults(2)
    -- do something
    local t = {}
    t[2] = {}
    t[2].address = r[2].address + 0x34 -- 782BF3ADBE80 + es abajo y x4 decimal 
    t[2].flags = gg.TYPE_FLOAT
    t[2].value = 3
    t[2].freeze = false
    gg.setValues(t)
    -- 00000001h;6892D4F9h
    -- 81x4 324 dec a hexa 144 - 4 = 140
    local e = {}
    e[2] = {}
    e[2].address = r[2].address - 0x144
    e[2].flags = gg.TYPE_DWORD
    e[2].value = 1
    e[2].freeze = false
    gg.setValues(e)

    local y = {}
    y[2] = {}
    y[2].address = r[2].address - 0x140
    y[2].flags = gg.TYPE_DWORD
    y[2].value = 1754453241
    y[2].freeze = false
    gg.setValues(y)

    local v = {}
    v[2] = {}
    v[2].address = r[2].address - 0x174
    v[2].flags = gg.TYPE_DWORD
    v[2].value = 0
    v[2].freeze = false
    gg.setValues(v)

    local h = {}
    h[2] = {}
    h[2].address = r[2].address - 0x170
    h[2].flags = gg.TYPE_DWORD
    h[2].value = 500
    h[2].freeze = false
    gg.setValues(h)
    -- 1634296844 7169380 13407

    local k_1 = {}
    k_1[2] = {}
    k_1[2].address = r[2].address - 0x18C
    k_1[2].flags = gg.TYPE_DWORD
    k_1[2].value = 1634296844
    k_1[2].freeze = false
    gg.setValues(k_1)

    local k_2 = {}
    k_2[2] = {}
    k_2[2].address = r[2].address - 0x188
    k_2[2].flags = gg.TYPE_DWORD
    k_2[2].value = 7169380
    k_2[2].freeze = false
    gg.setValues(k_2)

    local k_3 = {}
    k_3[2] = {}
    k_3[2].address = r[2].address - 0x184
    k_3[2].flags = gg.TYPE_DWORD
    k_3[2].value = 13407
    k_3[2].freeze = false
    gg.setValues(k_3)
    local k_4 = {}
    k_4[2] = {}
    k_4[2].address = r[2].address - 0x180
    k_4[2].flags = gg.TYPE_DWORD
    k_4[2].value = 0
    k_4[2].freeze = false
    gg.setValues(k_4)

    -- 1634296844 7169380 13407 0 valor 500 diadema

    local e_1 = {}
    e_1[2] = {}
    e_1[2].address = r[2].address - 0x264
    e_1[2].flags = gg.TYPE_DWORD
    e_1[2].value = 1
    e_1[2].freeze = false
    gg.setValues(e_1)

    local x_1 = {}
    x_1[2] = {}
    x_1[2].address = r[2].address - 0x260
    x_1[2].flags = gg.TYPE_DWORD
    x_1[2].value = 1754453241
    x_1[2].freeze = false
    gg.setValues(x_1)

    local v_1 = {}
    v_1[2] = {}
    v_1[2].address = r[2].address - 0x294
    v_1[2].flags = gg.TYPE_DWORD
    v_1[2].value = 0
    v_1[2].freeze = false
    gg.setValues(v_1)

    local w_1 = {}
    w_1[2] = {}
    w_1[2].address = r[2].address - 0x290
    w_1[2].flags = gg.TYPE_DWORD
    w_1[2].value = 500
    w_1[2].freeze = false
    gg.setValues(w_1)

    ----1634296844 7169380 13407
    local R_1 = {}
    R_1[2] = {}
    R_1[2].address = r[2].address - 0x2AC
    R_1[2].flags = gg.TYPE_DWORD
    R_1[2].value = 1634296844
    R_1[2].freeze = false
    gg.setValues(R_1)

    local R_2 = {}
    R_2[2] = {}
    R_2[2].address = r[2].address - 0x2A8
    R_2[2].flags = gg.TYPE_DWORD
    R_2[2].value = 7169380
    R_2[2].freeze = false
    gg.setValues(R_2)

    local R_3 = {}
    R_3[2] = {}
    R_3[2].address = r[2].address - 0x2A4
    R_3[2].flags = gg.TYPE_DWORD
    R_3[2].value = 13407
    R_3[2].freeze = false
    gg.setValues(R_3)

    local R_4 = {}
    R_4[2] = {}
    R_4[2].address = r[2].address - 0x2A0
    R_4[2].flags = gg.TYPE_DWORD
    R_4[2].value = 0
    R_4[2].freeze = false
    gg.setValues(R_4)

    --  

    local e_2 = {}
    e_2[2] = {}
    e_2[2].address = r[2].address - 0x384
    e_2[2].flags = gg.TYPE_DWORD
    e_2[2].value = 1
    e_2[2].freeze = false
    gg.setValues(e_2)

    local x_2 = {}
    x_2[2] = {}
    x_2[2].address = r[2].address - 0x380
    x_2[2].flags = gg.TYPE_DWORD
    x_2[2].value = 1754453241
    x_2[2].freeze = false
    gg.setValues(x_2)

    local v_2 = {}
    v_2[2] = {}
    v_2[2].address = r[2].address - 0x3B4
    v_2[2].flags = gg.TYPE_DWORD
    v_2[2].value = 0
    v_2[2].freeze = false
    gg.setValues(v_2)

    local w_2 = {}
    w_2[2] = {}
    w_2[2].address = r[2].address - 0x3B0
    w_2[2].flags = gg.TYPE_DWORD
    w_2[2].value = 500
    w_2[2].freeze = false
    gg.setValues(w_2)
    ----1634296844 7169380 13407
    local H_1 = {}
    H_1[2] = {}
    H_1[2].address = r[2].address - 0x3CC
    H_1[2].flags = gg.TYPE_DWORD
    H_1[2].value = 1634296844
    H_1[2].freeze = false
    gg.setValues(H_1)

    local H_2 = {}
    H_2[2] = {}
    H_2[2].address = r[2].address - 0x3C8
    H_2[2].flags = gg.TYPE_DWORD
    H_2[2].value = 7169380
    H_2[2].freeze = false
    gg.setValues(H_2)

    local H_3 = {}
    H_3[2] = {}
    H_3[2].address = r[2].address - 0x3C4
    H_3[2].flags = gg.TYPE_DWORD
    H_3[2].value = 13407
    H_3[2].freeze = false
    gg.setValues(H_3)

    local H_4 = {}
    H_4[2] = {}
    H_4[2].address = r[2].address - 0x3C0
    H_4[2].flags = gg.TYPE_DWORD
    H_4[2].value = 0
    H_4[2].freeze = false
    gg.setValues(R_4)

    -- 1852404232 1953366119 7037696 1677747456 1694523753 28001 anillo 732 poner 550
    local e_3 = {}
    e_3[2] = {}
    e_3[2].address = r[2].address - 0x4A4
    e_3[2].flags = gg.TYPE_DWORD
    e_3[2].value = 1
    e_3[2].freeze = false
    gg.setValues(e_3)

    local x_3 = {}
    x_3[2] = {}
    x_3[2].address = r[2].address - 0x4A0
    x_3[2].flags = gg.TYPE_DWORD
    x_3[2].value = 1754453241
    x_3[2].freeze = false
    gg.setValues(x_3)

    local v_3 = {}
    v_3[2] = {}
    v_3[2].address = r[2].address - 0x4D4
    v_3[2].flags = gg.TYPE_DWORD
    v_3[2].value = 0
    v_3[2].freeze = false
    gg.setValues(v_3)

    local w_3 = {}
    w_3[2] = {}
    w_3[2].address = r[2].address - 0x4D0
    w_3[2].flags = gg.TYPE_DWORD
    w_3[2].value = 500
    w_3[2].freeze = false
    gg.setValues(w_3)
    ------1634296844 7169380 13407
    local Y_1 = {}
    Y_1[2] = {}
    Y_1[2].address = r[2].address - 0x4EC
    Y_1[2].flags = gg.TYPE_DWORD
    Y_1[2].value = 1634296844
    Y_1[2].freeze = false
    gg.setValues(Y_1)

    local Y_2 = {}
    Y_2[2] = {}
    Y_2[2].address = r[2].address - 0x4E8
    Y_2[2].flags = gg.TYPE_DWORD
    Y_2[2].value = 7169380
    Y_2[2].freeze = false
    gg.setValues(Y_2)

    local Y_3 = {}
    Y_3[2] = {}
    Y_3[2].address = r[2].address - 0x4E4
    Y_3[2].flags = gg.TYPE_DWORD
    Y_3[2].value = 13407
    Y_3[2].freeze = false
    gg.setValues(Y_3)

    local Y_4 = {}
    Y_4[2] = {}
    Y_4[2].address = r[2].address - 0x4E0
    Y_4[2].flags = gg.TYPE_DWORD
    Y_4[2].value = 0
    Y_4[2].freeze = false
    gg.setValues(Y_4)

    local Y_5 = {}
    Y_5[2] = {}
    Y_5[2].address = r[2].address - 0x4DC
    Y_5[2].flags = gg.TYPE_DWORD
    Y_5[2].value = 0
    Y_5[2].freeze = false
    gg.setValues(Y_5)

    local Y_6 = {}
    Y_6[2] = {}
    Y_6[2].address = r[2].address - 0x4D8
    Y_6[2].flags = gg.TYPE_DWORD
    Y_6[2].value = 0
    Y_6[2].freeze = false
    gg.setValues(Y_6)

    --

    local e_4 = {}
    e_4[2] = {}
    e_4[2].address = r[2].address - 0x5C4
    e_4[2].flags = gg.TYPE_DWORD
    e_4[2].value = 1
    e_4[2].freeze = false
    gg.setValues(e_4)

    local x_4 = {}
    x_4[2] = {}
    x_4[2].address = r[2].address - 0x5C0
    x_4[2].flags = gg.TYPE_DWORD
    x_4[2].value = 1754453241
    x_4[2].freeze = false
    gg.setValues(x_4)

    local v_4 = {}
    v_4[2] = {}
    v_4[2].address = r[2].address - 0x5F4
    v_4[2].flags = gg.TYPE_DWORD
    v_4[2].value = 0
    v_4[2].freeze = false
    gg.setValues(v_4)

    local w_4 = {}
    w_4[2] = {}
    w_4[2].address = r[2].address - 0x5F0
    w_4[2].flags = gg.TYPE_DWORD
    w_4[2].value = 500
    w_4[2].freeze = false
    gg.setValues(w_4)

    ------1634296844 7169380 13407

    local F_1 = {}
    F_1[2] = {}
    F_1[2].address = r[2].address - 0x60C
    F_1[2].flags = gg.TYPE_DWORD
    F_1[2].value = 1634296844
    F_1[2].freeze = false
    gg.setValues(F_1)

    local F_2 = {}
    F_2[2] = {}
    F_2[2].address = r[2].address - 0x608
    F_2[2].flags = gg.TYPE_DWORD
    F_2[2].value = 7169380
    F_2[2].freeze = false
    gg.setValues(F_2)

    local F_3 = {}
    F_3[2] = {}
    F_3[2].address = r[2].address - 0x604
    F_3[2].flags = gg.TYPE_DWORD
    F_3[2].value = 13407
    F_3[2].freeze = false
    gg.setValues(F_3)

    local F_4 = {}
    F_4[2] = {}
    F_4[2].address = r[2].address - 0x600
    F_4[2].flags = gg.TYPE_DWORD
    F_4[2].value = 0
    F_4[2].freeze = false
    gg.setValues(F_4)

    local F_5 = {}
    F_5[2] = {}
    F_5[2].address = r[2].address - 0x5FC
    F_5[2].flags = gg.TYPE_DWORD
    F_5[2].value = 0
    F_5[2].freeze = false
    gg.setValues(F_5)

    local F_6 = {}
    F_6[2] = {}
    F_6[2].address = r[2].address - 0x5F8
    F_6[2].flags = gg.TYPE_DWORD
    F_6[2].value = 0
    F_6[2].freeze = false
    gg.setValues(F_6)

    -- gg.clearResults()
    hackTrEn_3()
end

function hackTrEn_1()

    gg.alert("Make it more Start the game or restart the game...")
    gg.toast("Make it more Start the game or restart the game...")
    gg.toast("Loading............ train 1")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("1600407924;51", gg.TYPE_DWORD)
    gg.refineNumber("51", gg.TYPE_DWORD)

    r = gg.getResults(1)
    -- do something
    local t = {}
    t[1] = {}
    t[1].address = r[1].address + 0x34
    t[1].flags = gg.TYPE_FLOAT
    t[1].value = 3
    t[1].freeze = false
    gg.setValues(t)
    -- 00000001h;6892D4F9h

    local e = {}
    e[1] = {}
    e[1].address = r[1].address - 0x144
    e[1].flags = gg.TYPE_DWORD
    e[1].value = 1
    e[1].freeze = false
    gg.setValues(e)

    local y = {}
    y[1] = {}
    y[1].address = r[1].address - 0x140
    y[1].flags = gg.TYPE_DWORD
    y[1].value = 1754453241
    y[1].freeze = false
    gg.setValues(y)

    local v = {}
    v[1] = {}
    v[1].address = r[1].address - 0x174
    v[1].flags = gg.TYPE_DWORD
    v[1].value = 0
    v[1].freeze = false
    gg.setValues(v)

    local h = {}
    h[1] = {}
    h[1].address = r[1].address - 0x170
    h[1].flags = gg.TYPE_DWORD
    h[1].value = 1
    h[1].freeze = false
    gg.setValues(h)

    -- tren 1  trigo 1701345034 1677751393 13151
    local k_1 = {}
    k_1[1] = {}
    k_1[1].address = r[1].address - 0x18C
    k_1[1].flags = gg.TYPE_DWORD
    k_1[1].value = 1701345034
    k_1[1].freeze = false
    gg.setValues(k_1)

    local k_2 = {}
    k_2[1] = {}
    k_2[1].address = r[1].address - 0x188
    k_2[1].flags = gg.TYPE_DWORD
    k_2[1].value = 1677751393
    k_2[1].freeze = false
    gg.setValues(k_2)

    local k_3 = {}
    k_3[1] = {}
    k_3[1].address = r[1].address - 0x184
    k_3[1].flags = gg.TYPE_DWORD
    k_3[1].value = 13151
    k_3[1].freeze = false
    gg.setValues(k_3)
    local k_4 = {}
    k_4[1] = {}
    k_4[1].address = r[1].address - 0x180
    k_4[1].flags = gg.TYPE_DWORD
    k_4[1].value = 0
    k_4[1].freeze = false
    gg.setValues(k_4)

    -- 1634296844 7169380 13407 0 valor 500 diadema

    local e_1 = {}
    e_1[1] = {}
    e_1[1].address = r[1].address - 0x264
    e_1[1].flags = gg.TYPE_DWORD
    e_1[1].value = 1
    e_1[1].freeze = false
    gg.setValues(e_1)

    local x_1 = {}
    x_1[1] = {}
    x_1[1].address = r[1].address - 0x260
    x_1[1].flags = gg.TYPE_DWORD
    x_1[1].value = 1754453241
    x_1[1].freeze = false
    gg.setValues(x_1)

    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = r[1].address - 0x294
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 0
    v_1[1].freeze = false
    gg.setValues(v_1)

    local w_1 = {}
    w_1[1] = {}
    w_1[1].address = r[1].address - 0x290
    w_1[1].flags = gg.TYPE_DWORD
    w_1[1].value = 1
    w_1[1].freeze = false
    gg.setValues(w_1)

    -- tren 2  trigo 1701345034 1677751393 13151
    local R_1 = {}
    R_1[1] = {}
    R_1[1].address = r[1].address - 0x2AC
    R_1[1].flags = gg.TYPE_DWORD
    R_1[1].value = 1701345034
    R_1[1].freeze = false
    gg.setValues(R_1)

    local R_2 = {}
    R_2[1] = {}
    R_2[1].address = r[1].address - 0x2A8
    R_2[1].flags = gg.TYPE_DWORD
    R_2[1].value = 1677751393
    R_2[1].freeze = false
    gg.setValues(R_2)

    local R_3 = {}
    R_3[1] = {}
    R_3[1].address = r[1].address - 0x2A4
    R_3[1].flags = gg.TYPE_DWORD
    R_3[1].value = 13151
    R_3[1].freeze = false
    gg.setValues(R_3)

    local R_4 = {}
    R_4[1] = {}
    R_4[1].address = r[1].address - 0x2A0
    R_4[1].flags = gg.TYPE_DWORD
    R_4[1].value = 0
    R_4[1].freeze = false
    gg.setValues(R_4)

    -- collar de perlas 800 = 1634037778 1701735538 27491 0

    local e_2 = {}
    e_2[1] = {}
    e_2[1].address = r[1].address - 0x384
    e_2[1].flags = gg.TYPE_DWORD
    e_2[1].value = 1
    e_2[1].freeze = false
    gg.setValues(e_2)

    local x_2 = {}
    x_2[1] = {}
    x_2[1].address = r[1].address - 0x380
    x_2[1].flags = gg.TYPE_DWORD
    x_2[1].value = 1754453241
    x_2[1].freeze = false
    gg.setValues(x_2)

    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = r[1].address - 0x3B4
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = 0
    v_2[1].freeze = false
    gg.setValues(v_2)

    local w_2 = {}
    w_2[1] = {}
    w_2[1].address = r[1].address - 0x3B0
    w_2[1].flags = gg.TYPE_DWORD
    w_2[1].value = 1
    w_2[1].freeze = false
    gg.setValues(w_2)
    -- tren 3  trigo 1701345034 1677751393 13151
    local H_1 = {}
    H_1[1] = {}
    H_1[1].address = r[1].address - 0x3CC
    H_1[1].flags = gg.TYPE_DWORD
    H_1[1].value = 1701345034
    H_1[1].freeze = false
    gg.setValues(H_1)

    local H_2 = {}
    H_2[1] = {}
    H_2[1].address = r[1].address - 0x3C8
    H_2[1].flags = gg.TYPE_DWORD
    H_2[1].value = 1677751393
    H_2[1].freeze = false
    gg.setValues(H_2)

    local H_3 = {}
    H_3[1] = {}
    H_3[1].address = r[1].address - 0x3C4
    H_3[1].flags = gg.TYPE_DWORD
    H_3[1].value = 13151
    H_3[1].freeze = false
    gg.setValues(H_3)

    local H_4 = {}
    H_4[1] = {}
    H_4[1].address = r[1].address - 0x3C0
    H_4[1].flags = gg.TYPE_DWORD
    H_4[1].value = 0
    H_4[1].freeze = false
    gg.setValues(R_4)

    -- collar de plata  800 = 1852141582 1953390948 12800 0

    local e_3 = {}
    e_3[1] = {}
    e_3[1].address = r[1].address - 0x4A4
    e_3[1].flags = gg.TYPE_DWORD
    e_3[1].value = 1
    e_3[1].freeze = false
    gg.setValues(e_3)

    local x_3 = {}
    x_3[1] = {}
    x_3[1].address = r[1].address - 0x4A0
    x_3[1].flags = gg.TYPE_DWORD
    x_3[1].value = 1754453241
    x_3[1].freeze = false
    gg.setValues(x_3)

    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = r[1].address - 0x4D4
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = 0
    v_3[1].freeze = false
    gg.setValues(v_3)

    local w_3 = {}
    w_3[1] = {}
    w_3[1].address = r[1].address - 0x4D0
    w_3[1].flags = gg.TYPE_DWORD
    w_3[1].value = 1
    w_3[1].freeze = false
    gg.setValues(w_3)
    -- tren 4  trigo 1701345034 1677751393 13151
    local Y_1 = {}
    Y_1[1] = {}
    Y_1[1].address = r[1].address - 0x4EC
    Y_1[1].flags = gg.TYPE_DWORD
    Y_1[1].value = 1701345034
    Y_1[1].freeze = false
    gg.setValues(Y_1)

    local Y_2 = {}
    Y_2[1] = {}
    Y_2[1].address = r[1].address - 0x4E8
    Y_2[1].flags = gg.TYPE_DWORD
    Y_2[1].value = 1677751393
    Y_2[1].freeze = false
    gg.setValues(Y_2)

    local Y_3 = {}
    Y_3[1] = {}
    Y_3[1].address = r[1].address - 0x4E4
    Y_3[1].flags = gg.TYPE_DWORD
    Y_3[1].value = 13151
    Y_3[1].freeze = false
    gg.setValues(Y_3)

    local Y_4 = {}
    Y_4[1] = {}
    Y_4[1].address = r[1].address - 0x4E0
    Y_4[1].flags = gg.TYPE_DWORD
    Y_4[1].value = 0
    Y_4[1].freeze = false
    gg.setValues(Y_4)

    -- Perfume          800 = 1919250458 1701672294 1953787714 25964

    local e_4 = {}
    e_4[1] = {}
    e_4[1].address = r[1].address - 0x5C4
    e_4[1].flags = gg.TYPE_DWORD
    e_4[1].value = 1
    e_4[1].freeze = false
    gg.setValues(e_4)

    local x_4 = {}
    x_4[1] = {}
    x_4[1].address = r[1].address - 0x5C0
    x_4[1].flags = gg.TYPE_DWORD
    x_4[1].value = 1754453241
    x_4[1].freeze = false
    gg.setValues(x_4)

    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = r[1].address - 0x5F4
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = 0
    v_4[1].freeze = false
    gg.setValues(v_4)

    local w_4 = {}
    w_4[1] = {}
    w_4[1].address = r[1].address - 0x5F0
    w_4[1].flags = gg.TYPE_DWORD
    w_4[1].value = 1
    w_4[1].freeze = false
    gg.setValues(w_4)

    -- tren 5  trigo 1701345034 1677751393 13151
    local F_1 = {}
    F_1[1] = {}
    F_1[1].address = r[1].address - 0x60C
    F_1[1].flags = gg.TYPE_DWORD
    F_1[1].value = 1701345034
    F_1[1].freeze = false
    gg.setValues(F_1)

    local F_2 = {}
    F_2[1] = {}
    F_2[1].address = r[1].address - 0x608
    F_2[1].flags = gg.TYPE_DWORD
    F_2[1].value = 1677751393
    F_2[1].freeze = false
    gg.setValues(F_2)

    local F_3 = {}
    F_3[1] = {}
    F_3[1].address = r[1].address - 0x604
    F_3[1].flags = gg.TYPE_DWORD
    F_3[1].value = 13151
    F_3[1].freeze = false
    gg.setValues(F_3)

    local F_4 = {}
    F_4[1] = {}
    F_4[1].address = r[1].address - 0x600
    F_4[1].flags = gg.TYPE_DWORD
    F_4[1].value = 0
    F_4[1].freeze = false
    gg.setValues(F_4)

    hackTrEn_2()
end

function hackTrEn_2()

    gg.toast("Loading............ train 2")
    -- gg.processResume()
    -- gg.clearResults()
    -- gg.searchNumber("1600407924;51", gg.TYPE_DWORD ) 
    -- gg.refineNumber("51", gg.TYPE_DWORD )

    r = gg.getResults(2)
    -- do something
    local t = {}
    t[2] = {}
    t[2].address = r[2].address + 0x34
    t[2].flags = gg.TYPE_FLOAT
    t[2].value = 3
    t[2].freeze = false
    gg.setValues(t)
    -- 00000001h;6892D4F9h
    -- 81x4 324 dec a hexa 144 - 4 = 140
    local e = {}
    e[2] = {}
    e[2].address = r[2].address - 0x144
    e[2].flags = gg.TYPE_DWORD
    e[2].value = 1
    e[2].freeze = false
    gg.setValues(e)

    local y = {}
    y[2] = {}
    y[2].address = r[2].address - 0x140
    y[2].flags = gg.TYPE_DWORD
    y[2].value = 1754453241
    y[2].freeze = false
    gg.setValues(y)

    local v = {}
    v[2] = {}
    v[2].address = r[2].address - 0x174
    v[2].flags = gg.TYPE_DWORD
    v[2].value = 0
    v[2].freeze = false
    gg.setValues(v)

    local h = {}
    h[2] = {}
    h[2].address = r[2].address - 0x170
    h[2].flags = gg.TYPE_DWORD
    h[2].value = 1
    h[2].freeze = false
    gg.setValues(h)

    -- tren 1  trigo 1701345034 1677751393 13151
    local k_1 = {}
    k_1[2] = {}
    k_1[2].address = r[2].address - 0x18C
    k_1[2].flags = gg.TYPE_DWORD
    k_1[2].value = 1701345034
    k_1[2].freeze = false
    gg.setValues(k_1)

    local k_2 = {}
    k_2[2] = {}
    k_2[2].address = r[2].address - 0x188
    k_2[2].flags = gg.TYPE_DWORD
    k_2[2].value = 1677751393
    k_2[2].freeze = false
    gg.setValues(k_2)

    local k_3 = {}
    k_3[2] = {}
    k_3[2].address = r[2].address - 0x184
    k_3[2].flags = gg.TYPE_DWORD
    k_3[2].value = 13151
    k_3[2].freeze = false
    gg.setValues(k_3)
    local k_4 = {}
    k_4[2] = {}
    k_4[2].address = r[2].address - 0x180
    k_4[2].flags = gg.TYPE_DWORD
    k_4[2].value = 0
    k_4[2].freeze = false
    gg.setValues(k_4)

    -- 1634296844 7169380 13407 0 valor 500 diadema

    local e_1 = {}
    e_1[2] = {}
    e_1[2].address = r[2].address - 0x264
    e_1[2].flags = gg.TYPE_DWORD
    e_1[2].value = 1
    e_1[2].freeze = false
    gg.setValues(e_1)

    local x_1 = {}
    x_1[2] = {}
    x_1[2].address = r[2].address - 0x260
    x_1[2].flags = gg.TYPE_DWORD
    x_1[2].value = 1754453241
    x_1[2].freeze = false
    gg.setValues(x_1)

    local v_1 = {}
    v_1[2] = {}
    v_1[2].address = r[2].address - 0x294
    v_1[2].flags = gg.TYPE_DWORD
    v_1[2].value = 0
    v_1[2].freeze = false
    gg.setValues(v_1)

    local w_1 = {}
    w_1[2] = {}
    w_1[2].address = r[2].address - 0x290
    w_1[2].flags = gg.TYPE_DWORD
    w_1[2].value = 1
    w_1[2].freeze = false
    gg.setValues(w_1)

    -- tren 2  tirgo 1701345034 1677751393 13151
    local R_1 = {}
    R_1[2] = {}
    R_1[2].address = r[2].address - 0x2AC
    R_1[2].flags = gg.TYPE_DWORD
    R_1[2].value = 1701345034
    R_1[2].freeze = false
    gg.setValues(R_1)

    local R_2 = {}
    R_2[2] = {}
    R_2[2].address = r[2].address - 0x2A8
    R_2[2].flags = gg.TYPE_DWORD
    R_2[2].value = 1677751393
    R_2[2].freeze = false
    gg.setValues(R_2)

    local R_3 = {}
    R_3[2] = {}
    R_3[2].address = r[2].address - 0x2A4
    R_3[2].flags = gg.TYPE_DWORD
    R_3[2].value = 13151
    R_3[2].freeze = false
    gg.setValues(R_3)

    local R_4 = {}
    R_4[2] = {}
    R_4[2].address = r[2].address - 0x2A0
    R_4[2].flags = gg.TYPE_DWORD
    R_4[2].value = 0
    R_4[2].freeze = false
    gg.setValues(R_4)

    -- collar de perlas 800 = 1634037778 1701735538 27491 0

    local e_2 = {}
    e_2[2] = {}
    e_2[2].address = r[2].address - 0x384
    e_2[2].flags = gg.TYPE_DWORD
    e_2[2].value = 1
    e_2[2].freeze = false
    gg.setValues(e_2)

    local x_2 = {}
    x_2[2] = {}
    x_2[2].address = r[2].address - 0x380
    x_2[2].flags = gg.TYPE_DWORD
    x_2[2].value = 1754453241
    x_2[2].freeze = false
    gg.setValues(x_2)

    local v_2 = {}
    v_2[2] = {}
    v_2[2].address = r[2].address - 0x3B4
    v_2[2].flags = gg.TYPE_DWORD
    v_2[2].value = 0
    v_2[2].freeze = false
    gg.setValues(v_2)

    local w_2 = {}
    w_2[2] = {}
    w_2[2].address = r[2].address - 0x3B0
    w_2[2].flags = gg.TYPE_DWORD
    w_2[2].value = 1
    w_2[2].freeze = false
    gg.setValues(w_2)
    -- tren 3  trigo 1701345034 1677751393 13151
    local H_1 = {}
    H_1[2] = {}
    H_1[2].address = r[2].address - 0x3CC
    H_1[2].flags = gg.TYPE_DWORD
    H_1[2].value = 1701345034
    H_1[2].freeze = false
    gg.setValues(H_1)

    local H_2 = {}
    H_2[2] = {}
    H_2[2].address = r[2].address - 0x3C8
    H_2[2].flags = gg.TYPE_DWORD
    H_2[2].value = 1677751393
    H_2[2].freeze = false
    gg.setValues(H_2)

    local H_3 = {}
    H_3[2] = {}
    H_3[2].address = r[2].address - 0x3C4
    H_3[2].flags = gg.TYPE_DWORD
    H_3[2].value = 13151
    H_3[2].freeze = false
    gg.setValues(H_3)

    local H_4 = {}
    H_4[2] = {}
    H_4[2].address = r[2].address - 0x3C0
    H_4[2].flags = gg.TYPE_DWORD
    H_4[2].value = 0
    H_4[2].freeze = false
    gg.setValues(R_4)

    -- collar de plata  800 = 1852141582 1953390948 12800 0

    local e_3 = {}
    e_3[2] = {}
    e_3[2].address = r[2].address - 0x4A4
    e_3[2].flags = gg.TYPE_DWORD
    e_3[2].value = 1
    e_3[2].freeze = false
    gg.setValues(e_3)

    local x_3 = {}
    x_3[2] = {}
    x_3[2].address = r[2].address - 0x4A0
    x_3[2].flags = gg.TYPE_DWORD
    x_3[2].value = 1754453241
    x_3[2].freeze = false
    gg.setValues(x_3)

    local v_3 = {}
    v_3[2] = {}
    v_3[2].address = r[2].address - 0x4D4
    v_3[2].flags = gg.TYPE_DWORD
    v_3[2].value = 0
    v_3[2].freeze = false
    gg.setValues(v_3)

    local w_3 = {}
    w_3[2] = {}
    w_3[2].address = r[2].address - 0x4D0
    w_3[2].flags = gg.TYPE_DWORD
    w_3[2].value = 1
    w_3[2].freeze = false
    gg.setValues(w_3)
    -- tren 4  trigo 1701345034 1677751393 13151
    local Y_1 = {}
    Y_1[2] = {}
    Y_1[2].address = r[2].address - 0x4EC
    Y_1[2].flags = gg.TYPE_DWORD
    Y_1[2].value = 1701345034
    Y_1[2].freeze = false
    gg.setValues(Y_1)

    local Y_2 = {}
    Y_2[2] = {}
    Y_2[2].address = r[2].address - 0x4E8
    Y_2[2].flags = gg.TYPE_DWORD
    Y_2[2].value = 1677751393
    Y_2[2].freeze = false
    gg.setValues(Y_2)

    local Y_3 = {}
    Y_3[2] = {}
    Y_3[2].address = r[2].address - 0x4E4
    Y_3[2].flags = gg.TYPE_DWORD
    Y_3[2].value = 13151
    Y_3[2].freeze = false
    gg.setValues(Y_3)

    local Y_4 = {}
    Y_4[2] = {}
    Y_4[2].address = r[2].address - 0x4E0
    Y_4[2].flags = gg.TYPE_DWORD
    Y_4[2].value = 0
    Y_4[2].freeze = false
    gg.setValues(Y_4)

    -- Perfume          800 = 1919250458 1701672294 1953787714 25964

    local e_4 = {}
    e_4[2] = {}
    e_4[2].address = r[2].address - 0x5C4
    e_4[2].flags = gg.TYPE_DWORD
    e_4[2].value = 1
    e_4[2].freeze = false
    gg.setValues(e_4)

    local x_4 = {}
    x_4[2] = {}
    x_4[2].address = r[2].address - 0x5C0
    x_4[2].flags = gg.TYPE_DWORD
    x_4[2].value = 1754453241
    x_4[2].freeze = false
    gg.setValues(x_4)

    local v_4 = {}
    v_4[2] = {}
    v_4[2].address = r[2].address - 0x5F4
    v_4[2].flags = gg.TYPE_DWORD
    v_4[2].value = 0
    v_4[2].freeze = false
    gg.setValues(v_4)

    local w_4 = {}
    w_4[2] = {}
    w_4[2].address = r[2].address - 0x5F0
    w_4[2].flags = gg.TYPE_DWORD
    w_4[2].value = 1
    w_4[2].freeze = false
    gg.setValues(w_4)

    -- tren 5  trigo 1701345034 1677751393 13151
    local F_1 = {}
    F_1[2] = {}
    F_1[2].address = r[2].address - 0x60C
    F_1[2].flags = gg.TYPE_DWORD
    F_1[2].value = 1701345034
    F_1[2].freeze = false
    gg.setValues(F_1)

    local F_2 = {}
    F_2[2] = {}
    F_2[2].address = r[2].address - 0x608
    F_2[2].flags = gg.TYPE_DWORD
    F_2[2].value = 1677751393
    F_2[2].freeze = false
    gg.setValues(F_2)

    local F_3 = {}
    F_3[2] = {}
    F_3[2].address = r[2].address - 0x604
    F_3[2].flags = gg.TYPE_DWORD
    F_3[2].value = 13151
    F_3[2].freeze = false
    gg.setValues(F_3)

    local F_4 = {}
    F_4[2] = {}
    F_4[2].address = r[2].address - 0x600
    F_4[2].flags = gg.TYPE_DWORD
    F_4[2].value = 0
    F_4[2].freeze = false
    gg.setValues(F_4)

    hackTrEn_3()

end

function hackTrEn_3()

    gg.toast("Loading............ train 3")
    -- gg.processResume()
    -- gg.clearResults()
    -- gg.searchNumber("1600407924;51", gg.TYPE_DWORD ) 
    -- gg.refineNumber("51", gg.TYPE_DWORD )

    r = gg.getResults(3)
    -- do something
    local t = {}
    t[3] = {}
    t[3].address = r[3].address + 0x34
    t[3].flags = gg.TYPE_FLOAT
    t[3].value = 3
    t[3].freeze = false
    gg.setValues(t)
    -- 00000001h;6892D4F9h
    -- 81x4 324 dec a hexa 144 - 4 = 140
    local e = {}
    e[3] = {}
    e[3].address = r[3].address - 0x144
    e[3].flags = gg.TYPE_DWORD
    e[3].value = 1
    e[3].freeze = false
    gg.setValues(e)

    local y = {}
    y[3] = {}
    y[3].address = r[3].address - 0x140
    y[3].flags = gg.TYPE_DWORD
    y[3].value = 1754453241
    y[3].freeze = false
    gg.setValues(y)

    local v = {}
    v[3] = {}
    v[3].address = r[3].address - 0x174
    v[3].flags = gg.TYPE_DWORD
    v[3].value = 0
    v[3].freeze = false
    gg.setValues(v)

    local h = {}
    h[3] = {}
    h[3].address = r[3].address - 0x170
    h[3].flags = gg.TYPE_DWORD
    h[3].value = 1
    h[3].freeze = false
    gg.setValues(h)

    -- tren 1  trigo 1701345034 1677751393 13151
    local k_1 = {}
    k_1[3] = {}
    k_1[3].address = r[3].address - 0x18C
    k_1[3].flags = gg.TYPE_DWORD
    k_1[3].value = 1701345034
    k_1[3].freeze = false
    gg.setValues(k_1)

    local k_2 = {}
    k_2[3] = {}
    k_2[3].address = r[3].address - 0x188
    k_2[3].flags = gg.TYPE_DWORD
    k_2[3].value = 1677751393
    k_2[3].freeze = false
    gg.setValues(k_2)

    local k_3 = {}
    k_3[3] = {}
    k_3[3].address = r[3].address - 0x184
    k_3[3].flags = gg.TYPE_DWORD
    k_3[3].value = 13151
    k_3[3].freeze = false
    gg.setValues(k_3)
    local k_4 = {}
    k_4[3] = {}
    k_4[3].address = r[3].address - 0x180
    k_4[3].flags = gg.TYPE_DWORD
    k_4[3].value = 0
    k_4[3].freeze = false
    gg.setValues(k_4)

    -- 1634296844 7169380 13407 0 valor 500 diadema

    local e_1 = {}
    e_1[3] = {}
    e_1[3].address = r[3].address - 0x264
    e_1[3].flags = gg.TYPE_DWORD
    e_1[3].value = 1
    e_1[3].freeze = false
    gg.setValues(e_1)

    local x_1 = {}
    x_1[3] = {}
    x_1[3].address = r[3].address - 0x260
    x_1[3].flags = gg.TYPE_DWORD
    x_1[3].value = 1754453241
    x_1[3].freeze = false
    gg.setValues(x_1)

    local v_1 = {}
    v_1[3] = {}
    v_1[3].address = r[3].address - 0x294
    v_1[3].flags = gg.TYPE_DWORD
    v_1[3].value = 0
    v_1[3].freeze = false
    gg.setValues(v_1)

    local w_1 = {}
    w_1[3] = {}
    w_1[3].address = r[3].address - 0x290
    w_1[3].flags = gg.TYPE_DWORD
    w_1[3].value = 1
    w_1[3].freeze = false
    gg.setValues(w_1)

    -- tren 2  trigo 1701345034 1677751393 13151
    local R_1 = {}
    R_1[3] = {}
    R_1[3].address = r[3].address - 0x2AC
    R_1[3].flags = gg.TYPE_DWORD
    R_1[3].value = 1701345034
    R_1[3].freeze = false
    gg.setValues(R_1)

    local R_2 = {}
    R_2[3] = {}
    R_2[3].address = r[3].address - 0x2A8
    R_2[3].flags = gg.TYPE_DWORD
    R_2[3].value = 1677751393
    R_2[3].freeze = false
    gg.setValues(R_2)

    local R_3 = {}
    R_3[3] = {}
    R_3[3].address = r[3].address - 0x2A4
    R_3[3].flags = gg.TYPE_DWORD
    R_3[3].value = 13151
    R_3[3].freeze = false
    gg.setValues(R_3)

    local R_4 = {}
    R_4[3] = {}
    R_4[3].address = r[3].address - 0x2A0
    R_4[3].flags = gg.TYPE_DWORD
    R_4[3].value = 0
    R_4[3].freeze = false
    gg.setValues(R_4)

    -- collar de perlas 800 = 1634037778 1701735538 27491 0

    local e_2 = {}
    e_2[3] = {}
    e_2[3].address = r[3].address - 0x384
    e_2[3].flags = gg.TYPE_DWORD
    e_2[3].value = 1
    e_2[3].freeze = false
    gg.setValues(e_2)

    local x_2 = {}
    x_2[3] = {}
    x_2[3].address = r[3].address - 0x380
    x_2[3].flags = gg.TYPE_DWORD
    x_2[3].value = 1754453241
    x_2[3].freeze = false
    gg.setValues(x_2)

    local v_2 = {}
    v_2[3] = {}
    v_2[3].address = r[3].address - 0x3B4
    v_2[3].flags = gg.TYPE_DWORD
    v_2[3].value = 0
    v_2[3].freeze = false
    gg.setValues(v_2)

    local w_2 = {}
    w_2[3] = {}
    w_2[3].address = r[3].address - 0x3B0
    w_2[3].flags = gg.TYPE_DWORD
    w_2[3].value = 1
    w_2[3].freeze = false
    gg.setValues(w_2)
    -- tren 3  trigo 1701345034 1677751393 13151
    local H_1 = {}
    H_1[3] = {}
    H_1[3].address = r[3].address - 0x3CC
    H_1[3].flags = gg.TYPE_DWORD
    H_1[3].value = 1701345034
    H_1[3].freeze = false
    gg.setValues(H_1)

    local H_2 = {}
    H_2[3] = {}
    H_2[3].address = r[3].address - 0x3C8
    H_2[3].flags = gg.TYPE_DWORD
    H_2[3].value = 1677751393
    H_2[3].freeze = false
    gg.setValues(H_2)

    local H_3 = {}
    H_3[3] = {}
    H_3[3].address = r[3].address - 0x3C4
    H_3[3].flags = gg.TYPE_DWORD
    H_3[3].value = 13151
    H_3[3].freeze = false
    gg.setValues(H_3)

    local H_4 = {}
    H_4[3] = {}
    H_4[3].address = r[3].address - 0x3C0
    H_4[3].flags = gg.TYPE_DWORD
    H_4[3].value = 0
    H_4[3].freeze = false
    gg.setValues(R_4)

    -- collar de plata  800 = 1852141582 1953390948 12800 0

    local e_3 = {}
    e_3[3] = {}
    e_3[3].address = r[3].address - 0x4A4
    e_3[3].flags = gg.TYPE_DWORD
    e_3[3].value = 1
    e_3[3].freeze = false
    gg.setValues(e_3)

    local x_3 = {}
    x_3[3] = {}
    x_3[3].address = r[3].address - 0x4A0
    x_3[3].flags = gg.TYPE_DWORD
    x_3[3].value = 1754453241
    x_3[3].freeze = false
    gg.setValues(x_3)

    local v_3 = {}
    v_3[3] = {}
    v_3[3].address = r[3].address - 0x4D4
    v_3[3].flags = gg.TYPE_DWORD
    v_3[3].value = 0
    v_3[3].freeze = false
    gg.setValues(v_3)

    local w_3 = {}
    w_3[3] = {}
    w_3[3].address = r[3].address - 0x4D0
    w_3[3].flags = gg.TYPE_DWORD
    w_3[3].value = 1
    w_3[3].freeze = false
    gg.setValues(w_3)
    -- tren 4  trigo 1701345034 1677751393 13151
    local Y_1 = {}
    Y_1[3] = {}
    Y_1[3].address = r[3].address - 0x4EC
    Y_1[3].flags = gg.TYPE_DWORD
    Y_1[3].value = 1701345034
    Y_1[3].freeze = false
    gg.setValues(Y_1)

    local Y_2 = {}
    Y_2[3] = {}
    Y_2[3].address = r[3].address - 0x4E8
    Y_2[3].flags = gg.TYPE_DWORD
    Y_2[3].value = 1677751393
    Y_2[3].freeze = false
    gg.setValues(Y_2)

    local Y_3 = {}
    Y_3[3] = {}
    Y_3[3].address = r[3].address - 0x4E4
    Y_3[3].flags = gg.TYPE_DWORD
    Y_3[3].value = 13151
    Y_3[3].freeze = false
    gg.setValues(Y_3)

    local Y_4 = {}
    Y_4[3] = {}
    Y_4[3].address = r[3].address - 0x4E0
    Y_4[3].flags = gg.TYPE_DWORD
    Y_4[3].value = 0
    Y_4[3].freeze = false
    gg.setValues(Y_4)

    -- Perfume          800 = 1919250458 1701672294 1953787714 25964

    local e_4 = {}
    e_4[3] = {}
    e_4[3].address = r[3].address - 0x5C4
    e_4[3].flags = gg.TYPE_DWORD
    e_4[3].value = 1
    e_4[3].freeze = false
    gg.setValues(e_4)

    local x_4 = {}
    x_4[3] = {}
    x_4[3].address = r[3].address - 0x5C0
    x_4[3].flags = gg.TYPE_DWORD
    x_4[3].value = 1754453241
    x_4[3].freeze = false
    gg.setValues(x_4)

    local v_4 = {}
    v_4[3] = {}
    v_4[3].address = r[3].address - 0x5F4
    v_4[3].flags = gg.TYPE_DWORD
    v_4[3].value = 0
    v_4[3].freeze = false
    gg.setValues(v_4)

    local w_4 = {}
    w_4[3] = {}
    w_4[3].address = r[3].address - 0x5F0
    w_4[3].flags = gg.TYPE_DWORD
    w_4[3].value = 1
    w_4[3].freeze = false
    gg.setValues(w_4)

    -- tren 5  trigo 1701345034 1677751393 13151
    local F_1 = {}
    F_1[3] = {}
    F_1[3].address = r[3].address - 0x60C
    F_1[3].flags = gg.TYPE_DWORD
    F_1[3].value = 1701345034
    F_1[3].freeze = false
    gg.setValues(F_1)

    local F_2 = {}
    F_2[3] = {}
    F_2[3].address = r[3].address - 0x608
    F_2[3].flags = gg.TYPE_DWORD
    F_2[3].value = 1677751393
    F_2[3].freeze = false
    gg.setValues(F_2)

    local F_3 = {}
    F_3[3] = {}
    F_3[3].address = r[3].address - 0x604
    F_3[3].flags = gg.TYPE_DWORD
    F_3[3].value = 13151
    F_3[3].freeze = false
    gg.setValues(F_3)

    local F_4 = {}
    F_4[3] = {}
    F_4[3].address = r[3].address - 0x600
    F_4[3].flags = gg.TYPE_DWORD
    F_4[3].value = 0
    F_4[3].freeze = false
    gg.setValues(F_4)

    gg.clearResults()
end

function hackAvion_xp()

    gg.alert("Make it more Start the game or restart the game...")
    gg.toast("Make it more Start the game or restart the game...")
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("6F676177h;68735F6Eh;5F656B61h;FFFFFFFFh;4F53565Bh",
                    gg.TYPE_DWORD)
    gg.refineNumber("6F676177h", gg.TYPE_DWORD)
    r = gg.getResults(1)
    -- do something
    local t = {}
    t[1] = {}
    t[1].address = r[1].address - 0x58 -- 782BF3ADBE80 + es abajo y x4 decimal 
    t[1].flags = gg.TYPE_DWORD
    t[1].value = 650
    t[1].freeze = false
    gg.setValues(t)
    -- 00000001h;6892D4F9h
    -- 81x4 324 dec a hexa 144 - 4 = 140
    -- 6169640Ch;006D6564h;00000000h;00000000h;00000000h;00000000h diadema de oro
    -- 1634296844 7169380 13407 0 valor 500 diadema

    local e_1 = {}
    e_1[1] = {}
    e_1[1].address = r[1].address - 0x50
    e_1[1].flags = gg.TYPE_DWORD
    e_1[1].value = 1634296844
    e_1[1].freeze = false
    gg.setValues(e_1)

    local p_1 = {}
    p_1[1] = {}
    p_1[1].address = r[1].address - 0x4C
    p_1[1].flags = gg.TYPE_DWORD
    p_1[1].value = 7169380
    p_1[1].freeze = false
    gg.setValues(p_1)

    local o_1 = {}
    o_1[1] = {}
    o_1[1].address = r[1].address - 0x48
    o_1[1].flags = gg.TYPE_DWORD
    o_1[1].value = 13407
    o_1[1].freeze = false
    gg.setValues(o_1)

    local ha_1 = {}
    ha_1[1] = {}
    ha_1[1].address = r[1].address - 0x44
    ha_1[1].flags = gg.TYPE_DWORD
    ha_1[1].value = 0
    ha_1[1].freeze = false
    gg.setValues(ha_1)

    local pa_1 = {}
    pa_1[1] = {}
    pa_1[1].address = r[1].address - 0x40
    pa_1[1].flags = gg.TYPE_DWORD
    pa_1[1].value = 0
    pa_1[1].freeze = false
    gg.setValues(pa_1)

    local ya_1 = {}
    ya_1[1] = {}
    ya_1[1].address = r[1].address - 0x3C
    ya_1[1].flags = gg.TYPE_DWORD
    ya_1[1].value = 0
    ya_1[1].freeze = false
    gg.setValues(ya_1)

    -- Caja 1

    local k_1 = {}
    k_1[1] = {}
    k_1[1].address = r[1].address + 0x48
    k_1[1].flags = gg.TYPE_DWORD
    k_1[1].value = 2
    k_1[1].freeze = false
    gg.setValues(k_1)
    -- 6E697208h;746E0067h;006B6300h;64006500h;65006169h;00006D61h anillo
    -- 1852404232 1953366119 7037696 1677747456 1694523753 28001 anillo
    local k_2 = {}
    k_2[1] = {}
    k_2[1].address = r[1].address + 0x50
    k_2[1].flags = gg.TYPE_DWORD
    k_2[1].value = 1852404232
    k_2[1].freeze = false
    gg.setValues(k_2)

    local k_3 = {}
    k_3[1] = {}
    k_3[1].address = r[1].address + 0x54
    k_3[1].flags = gg.TYPE_DWORD
    k_3[1].value = 1953366119
    k_3[1].freeze = false
    gg.setValues(k_3)
    local k_4 = {}
    k_4[1] = {}
    k_4[1].address = r[1].address + 0x58
    k_4[1].flags = gg.TYPE_DWORD
    k_4[1].value = 7037696
    k_4[1].freeze = false
    gg.setValues(k_4)

    local e_1 = {}
    e_1[1] = {}
    e_1[1].address = r[1].address + 0x5C
    e_1[1].flags = gg.TYPE_DWORD
    e_1[1].value = 1677747456
    e_1[1].freeze = false
    gg.setValues(e_1)

    local x_1 = {}
    x_1[1] = {}
    x_1[1].address = r[1].address + 0x60
    x_1[1].flags = gg.TYPE_DWORD
    x_1[1].value = 1694523753
    x_1[1].freeze = false
    gg.setValues(x_1)

    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = r[1].address + 0x64
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 28001
    v_1[1].freeze = false
    gg.setValues(v_1)
    -- caja 2
    gg.clearResults()
end

function hackTrEnTrebol_1()

    --  gg.alert("Hacerlo mas Iniciar el juego o reiniciar el juego...") 
    --  gg.toast( "Hacerlo mas Iniciar el juego o reiniciar el juego...")  
    gg.toast("Loading............ clover 1")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("1600407924;51", gg.TYPE_DWORD)
    gg.refineNumber("51", gg.TYPE_DWORD)

    r = gg.getResults(1)
    -- do something
    local t = {}
    t[1] = {}
    t[1].address = r[1].address - 0xCC
    t[1].flags = gg.TYPE_DWORD
    t[1].value = 0
    t[1].freeze = true
    gg.setValues(t)
    gg.addListItems(t)
    -- 00000001h;6892D4F9h

    local e = {}
    e[1] = {}
    e[1].address = r[1].address - 0x1EC
    e[1].flags = gg.TYPE_DWORD
    e[1].value = 0
    e[1].freeze = true
    gg.setValues(e)
    gg.addListItems(e)

    local y = {}
    y[1] = {}
    y[1].address = r[1].address - 0x30C
    y[1].flags = gg.TYPE_DWORD
    y[1].value = 0
    y[1].freeze = true
    gg.setValues(y)
    gg.addListItems(y)

    local v = {}
    v[1] = {}
    v[1].address = r[1].address - 0x42C
    v[1].flags = gg.TYPE_DWORD
    v[1].value = 0
    v[1].freeze = true
    gg.setValues(v)
    gg.addListItems(v)

    local h = {}
    h[1] = {}
    h[1].address = r[1].address - 0x54C
    h[1].flags = gg.TYPE_DWORD
    h[1].value = 0
    h[1].freeze = true
    gg.setValues(h)
    gg.addListItems(h)

    hackTrEnTrebol_2()
end
function hackTrEnTrebol_2()

    --  gg.alert("Hacerlo mas Iniciar el juego o reiniciar el juego...") 
    --  gg.toast( "Hacerlo mas Iniciar el juego o reiniciar el juego...")  
    gg.toast("Loading............ clover 2")
    -- gg.processResume()
    -- gg.clearResults()
    -- gg.searchNumber("1600407924;51", gg.TYPE_DWORD ) 
    -- gg.refineNumber("51", gg.TYPE_DWORD )

    r = gg.getResults(2)
    -- do something
    local t = {}
    t[2] = {}
    t[2].address = r[2].address - 0xCC
    t[2].flags = gg.TYPE_DWORD
    t[2].value = 0
    t[2].freeze = true
    gg.setValues(t)
    gg.addListItems(t)
    -- 00000001h;6892D4F9h

    local e = {}
    e[2] = {}
    e[2].address = r[2].address - 0x1EC
    e[2].flags = gg.TYPE_DWORD
    e[2].value = 0
    e[2].freeze = true
    gg.setValues(e)
    gg.addListItems(e)

    local y = {}
    y[2] = {}
    y[2].address = r[2].address - 0x30C
    y[2].flags = gg.TYPE_DWORD
    y[2].value = 0
    y[2].freeze = true
    gg.setValues(y)
    gg.addListItems(y)

    local v = {}
    v[2] = {}
    v[2].address = r[2].address - 0x42C
    v[2].flags = gg.TYPE_DWORD
    v[2].value = 0
    v[2].freeze = true
    gg.setValues(v)
    gg.addListItems(v)

    local h = {}
    h[2] = {}
    h[2].address = r[2].address - 0x54C
    h[2].flags = gg.TYPE_DWORD
    h[2].value = 0
    h[2].freeze = true
    gg.setValues(h)
    gg.addListItems(h)

    hackTrEnTrebol_3()
end
function hackTrEnTrebol_3()

    --  gg.alert("Hacerlo mas Iniciar el juego o reiniciar el juego...") 
    --  gg.toast( "Hacerlo mas Iniciar el juego o reiniciar el juego...")  
    gg.toast("Loading............ clover 3")
    -- gg.processResume()
    -- gg.clearResults()
    -- gg.searchNumber("1600407924;51", gg.TYPE_DWORD ) 
    -- gg.refineNumber("51", gg.TYPE_DWORD )

    r = gg.getResults(3)
    -- do something
    local t = {}
    t[3] = {}
    t[3].address = r[3].address - 0xCC
    t[3].flags = gg.TYPE_DWORD
    t[3].value = 0
    t[3].freeze = true
    gg.setValues(t)
    gg.addListItems(t)
    -- 00000001h;6892D4F9h

    local e = {}
    e[3] = {}
    e[3].address = r[3].address - 0x1EC
    e[3].flags = gg.TYPE_DWORD
    e[3].value = 0
    e[3].freeze = true
    gg.setValues(e)
    gg.addListItems(e)

    local y = {}
    y[3] = {}
    y[3].address = r[3].address - 0x30C
    y[3].flags = gg.TYPE_DWORD
    y[3].value = 0
    y[3].freeze = true
    gg.setValues(y)
    gg.addListItems(y)

    local v = {}
    v[3] = {}
    v[3].address = r[3].address - 0x42C
    v[3].flags = gg.TYPE_DWORD
    v[3].value = 0
    v[3].freeze = true
    gg.setValues(v)
    gg.addListItems(v)

    local h = {}
    h[3] = {}
    h[3].address = r[3].address - 0x54C
    h[3].flags = gg.TYPE_DWORD
    h[3].value = 0
    h[3].freeze = true
    gg.setValues(h)
    gg.addListItems(h)

end
---FFFFFFFFh;6D616E08h
function hackAvion_1()
    gg.alert("Make it more Start the game or restart the game...")
    gg.toast("Make it more Start the game or restart the game...")
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("6F676177h;68735F6Eh;5F656B61h;FFFFFFFFh;4F53565Bh",
                    gg.TYPE_DWORD)
    gg.refineNumber("6F676177h", gg.TYPE_DWORD)
    r = gg.getResults(1)
    -- do something
    local t = {}
    t[1] = {}
    t[1].address = r[1].address + 0x98 -- 782BF3ADBE80 + es abajo y x4 decimal 
    t[1].flags = gg.TYPE_DWORD
    t[1].value = 650
    t[1].freeze = false
    gg.setValues(t)
    -- 00000001h;6892D4F9h
    -- 81x4 324 dec a hexa 144 - 4 = 140
    -- 6169640Ch;006D6564h;00000000h;00000000h;00000000h;00000000h diadema de oro
    -- 1634296844 7169380 13407 0 valor 500 diadema

    local e_1 = {}
    e_1[1] = {}
    e_1[1].address = r[1].address + 0xA0
    e_1[1].flags = gg.TYPE_DWORD
    e_1[1].value = 1634296844
    e_1[1].freeze = false
    gg.setValues(e_1)

    local p_1 = {}
    p_1[1] = {}
    p_1[1].address = r[1].address + 0xA4
    p_1[1].flags = gg.TYPE_DWORD
    p_1[1].value = 7169380
    p_1[1].freeze = false
    gg.setValues(p_1)

    local o_1 = {}
    o_1[1] = {}
    o_1[1].address = r[1].address + 0xA8
    o_1[1].flags = gg.TYPE_DWORD
    o_1[1].value = 13407
    o_1[1].freeze = false
    gg.setValues(o_1)

    local ha_1 = {}
    ha_1[1] = {}
    ha_1[1].address = r[1].address + 0xAC
    ha_1[1].flags = gg.TYPE_DWORD
    ha_1[1].value = 0
    ha_1[1].freeze = false
    gg.setValues(ha_1)

    local pa_1 = {}
    pa_1[1] = {}
    pa_1[1].address = r[1].address + 0xB0
    pa_1[1].flags = gg.TYPE_DWORD
    pa_1[1].value = 0
    pa_1[1].freeze = false
    gg.setValues(pa_1)

    local ya_1 = {}
    ya_1[1] = {}
    ya_1[1].address = r[1].address + 0xB4
    ya_1[1].flags = gg.TYPE_DWORD
    ya_1[1].value = 0
    ya_1[1].freeze = false
    gg.setValues(ya_1)

    -- Caja 1

    local k_1 = {}
    k_1[1] = {}
    k_1[1].address = r[1].address + 0xE8
    k_1[1].flags = gg.TYPE_DWORD
    k_1[1].value = 2
    k_1[1].freeze = false
    gg.setValues(k_1)
    -- 6E697208h;746E0067h;006B6300h;64006500h;65006169h;00006D61h anillo
    -- 1852404232 1953366119 7037696 1677747456 1694523753 28001 anillo
    local k_2 = {}
    k_2[1] = {}
    k_2[1].address = r[1].address + 0xF0
    k_2[1].flags = gg.TYPE_DWORD
    k_2[1].value = 1852404232
    k_2[1].freeze = false
    gg.setValues(k_2)

    local k_3 = {}
    k_3[1] = {}
    k_3[1].address = r[1].address + 0xF4
    k_3[1].flags = gg.TYPE_DWORD
    k_3[1].value = 1953366119
    k_3[1].freeze = false
    gg.setValues(k_3)
    local k_4 = {}
    k_4[1] = {}
    k_4[1].address = r[1].address + 0xF8
    k_4[1].flags = gg.TYPE_DWORD
    k_4[1].value = 7037696
    k_4[1].freeze = false
    gg.setValues(k_4)

    local e_1 = {}
    e_1[1] = {}
    e_1[1].address = r[1].address + 0xFC
    e_1[1].flags = gg.TYPE_DWORD
    e_1[1].value = 1677747456
    e_1[1].freeze = false
    gg.setValues(e_1)

    local x_1 = {}
    x_1[1] = {}
    x_1[1].address = r[1].address + 0x100
    x_1[1].flags = gg.TYPE_DWORD
    x_1[1].value = 1694523753
    x_1[1].freeze = false
    gg.setValues(x_1)

    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = r[1].address + 0x104
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 28001
    v_1[1].freeze = false
    gg.setValues(v_1)
    gg.clearResults()
    -- caja 2
end

function hackPedirAyudaAvion()
    gg.alert("Hacerlo mas Iniciar el juego o reiniciar el juego...")
    gg.toast("Hacerlo mas Iniciar el juego o reiniciar el juego...")
    gg.toast("Cargando...")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber(
        "696F630Ah;0000736Eh;6B6E750Ch;00776F6Eh;72696110h;726F6373h;00000065h",
        gg.TYPE_DWORD)
    gg.refineNumber("696F630Ah", gg.TYPE_DWORD)
    r = gg.getResults(1)
    -- do something
    local t = {}
    t[1] = {}
    t[1].address = r[1].address + 0x308 -- 782BF3ADBE80 + es abajo y x4 decimal 
    t[1].flags = gg.TYPE_DWORD
    t[1].value = 1
    t[1].freeze = false
    gg.setValues(t)

    local e_1 = {}
    e_1[1] = {}
    e_1[1].address = r[1].address + 0x448
    e_1[1].flags = gg.TYPE_DWORD
    e_1[1].value = 1
    e_1[1].freeze = false
    gg.setValues(e_1)

    local p_1 = {}
    p_1[1] = {}
    p_1[1].address = r[1].address + 0x588
    p_1[1].flags = gg.TYPE_DWORD
    p_1[1].value = 1
    p_1[1].freeze = false
    gg.setValues(p_1)

    local o_1 = {}
    o_1[1] = {}
    o_1[1].address = r[1].address + 0x6C8
    o_1[1].flags = gg.TYPE_DWORD
    o_1[1].value = 1
    o_1[1].freeze = false
    gg.setValues(o_1)

    local ha_1 = {}
    ha_1[1] = {}
    ha_1[1].address = r[1].address + 0x808
    ha_1[1].flags = gg.TYPE_DWORD
    ha_1[1].value = 1
    ha_1[1].freeze = false
    gg.setValues(ha_1)

    local pa_1 = {}
    pa_1[1] = {}
    pa_1[1].address = r[1].address - 0xB8
    pa_1[1].flags = gg.TYPE_DWORD
    pa_1[1].value = 1
    pa_1[1].freeze = false
    gg.setValues(pa_1)

    gg.clearResults()

end

function hackAvion_xp_9()

    gg.alert("Hacerlo mas Iniciar el juego o reiniciar el juego...")
    gg.toast("Hacerlo mas Iniciar el juego o reiniciar el juego...")
    gg.toast("Cargando...")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("6F676177h;68735F6Eh;5F656B61h;FFFFFFFFh;4F53565Bh",
                    gg.TYPE_DWORD)
    gg.refineNumber("6F676177h", gg.TYPE_DWORD)
    r = gg.getResults(1)
    -- do something
    local t = {}
    t[1] = {}
    t[1].address = r[1].address - 0x58 -- 782BF3ADBE80 + es abajo y x4 decimal 
    t[1].flags = gg.TYPE_DWORD
    t[1].value = 650
    t[1].freeze = false
    gg.setValues(t)
    -- 00000001h;6892D4F9h
    -- 81x4 324 dec a hexa 144 - 4 = 140
    -- 6169640Ch;006D6564h;00000000h;00000000h;00000000h;00000000h diadema de oro
    -- 1634296844 7169380 13407 0 valor 500 diadema

    local e_1 = {}
    e_1[1] = {}
    e_1[1].address = r[1].address - 0x50
    e_1[1].flags = gg.TYPE_DWORD
    e_1[1].value = 1634296844
    e_1[1].freeze = false
    gg.setValues(e_1)

    local p_1 = {}
    p_1[1] = {}
    p_1[1].address = r[1].address - 0x4C
    p_1[1].flags = gg.TYPE_DWORD
    p_1[1].value = 7169380
    p_1[1].freeze = false
    gg.setValues(p_1)

    local o_1 = {}
    o_1[1] = {}
    o_1[1].address = r[1].address - 0x48
    o_1[1].flags = gg.TYPE_DWORD
    o_1[1].value = 13407
    o_1[1].freeze = false
    gg.setValues(o_1)

    local ha_1 = {}
    ha_1[1] = {}
    ha_1[1].address = r[1].address - 0x44
    ha_1[1].flags = gg.TYPE_DWORD
    ha_1[1].value = 0
    ha_1[1].freeze = false
    gg.setValues(ha_1)

    local pa_1 = {}
    pa_1[1] = {}
    pa_1[1].address = r[1].address - 0x40
    pa_1[1].flags = gg.TYPE_DWORD
    pa_1[1].value = 0
    pa_1[1].freeze = false
    gg.setValues(pa_1)

    local ya_1 = {}
    ya_1[1] = {}
    ya_1[1].address = r[1].address - 0x3C
    ya_1[1].flags = gg.TYPE_DWORD
    ya_1[1].value = 0
    ya_1[1].freeze = false
    gg.setValues(ya_1)

    -- Caja 1

    local k_1 = {}
    k_1[1] = {}
    k_1[1].address = r[1].address + 0x48
    k_1[1].flags = gg.TYPE_DWORD
    k_1[1].value = 650
    k_1[1].freeze = false
    gg.setValues(k_1)
    -- 6E697208h;746E0067h;006B6300h;64006500h;65006169h;00006D61h anillo
    -- 1852404232 1953366119 7037696 1677747456 1694523753 28001 anillo
    -- 6169640Ch;006D6564h;00000000h;00000000h;00000000h;00000000h diadema de oro 1634296844 7169380
    -- 1634296844 7169380 13407 0 valor 500 diadema
    local k_2 = {}
    k_2[1] = {}
    k_2[1].address = r[1].address + 0x50
    k_2[1].flags = gg.TYPE_DWORD
    k_2[1].value = 1634296844
    k_2[1].freeze = false
    gg.setValues(k_2)

    local k_3 = {}
    k_3[1] = {}
    k_3[1].address = r[1].address + 0x54
    k_3[1].flags = gg.TYPE_DWORD
    k_3[1].value = 7169380
    k_3[1].freeze = false
    gg.setValues(k_3)
    local k_4 = {}
    k_4[1] = {}
    k_4[1].address = r[1].address + 0x58
    k_4[1].flags = gg.TYPE_DWORD
    k_4[1].value = 13407
    k_4[1].freeze = false
    gg.setValues(k_4)

    local e_1 = {}
    e_1[1] = {}
    e_1[1].address = r[1].address + 0x5C
    e_1[1].flags = gg.TYPE_DWORD
    e_1[1].value = 0
    e_1[1].freeze = false
    gg.setValues(e_1)

    local x_1 = {}
    x_1[1] = {}
    x_1[1].address = r[1].address + 0x60
    x_1[1].flags = gg.TYPE_DWORD
    x_1[1].value = 0
    x_1[1].freeze = false
    gg.setValues(x_1)

    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = r[1].address + 0x64
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 0
    v_1[1].freeze = false
    gg.setValues(v_1)
    -- caja 2

    local LY_3 = {}
    LY_3[1] = {}
    LY_3[1].address = r[1].address + 0x98
    LY_3[1].flags = gg.TYPE_DWORD
    LY_3[1].value = 650
    LY_3[1].freeze = false
    gg.setValues(LY_3)

    local PF_3 = {}
    PF_3[1] = {}
    PF_3[1].address = r[1].address + 0xA0
    PF_3[1].flags = gg.TYPE_DWORD
    PF_3[1].value = 1634296844
    PF_3[1].freeze = false
    gg.setValues(PF_3)

    local FHJ_3 = {}
    FHJ_3[1] = {}
    FHJ_3[1].address = r[1].address + 0xA4
    FHJ_3[1].flags = gg.TYPE_DWORD
    FHJ_3[1].value = 7169380
    FHJ_3[1].freeze = false
    gg.setValues(FHJ_3)
    local JKL_4 = {}
    JKL_4[1] = {}
    JKL_4[1].address = r[1].address + 0xA8
    JKL_4[1].flags = gg.TYPE_DWORD
    JKL_4[1].value = 13407
    JKL_4[1].freeze = false
    gg.setValues(JKL_4)

    local RTH_1 = {}
    RTH_1[1] = {}
    RTH_1[1].address = r[1].address + 0xAC
    RTH_1[1].flags = gg.TYPE_DWORD
    RTH_1[1].value = 0
    e_1[1].freeze = false
    gg.setValues(RTH_1)

    local UIL_1 = {}
    UIL_1[1] = {}
    UIL_1[1].address = r[1].address + 0xB0
    UIL_1[1].flags = gg.TYPE_DWORD
    UIL_1[1].value = 0
    UIL_1[1].freeze = false
    gg.setValues(UIL_1)

    local JKLY_1 = {}
    JKLY_1[1] = {}
    JKLY_1[1].address = r[1].address + 0xB4
    JKLY_1[1].flags = gg.TYPE_DWORD
    JKLY_1[1].value = 0
    JKLY_1[1].freeze = false
    gg.setValues(JKLY_1)
    gg.clearResults()
end

function hackAvion_1_9()
    gg.alert("Hacerlo mas Iniciar el juego o reiniciar el juego...")
    gg.toast("Hacerlo mas Iniciar el juego o reiniciar el juego...")
    gg.toast("Cargando...")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("6F676177h;68735F6Eh;5F656B61h;FFFFFFFFh;4F53565Bh",
                    gg.TYPE_DWORD)
    gg.refineNumber("6F676177h", gg.TYPE_DWORD)
    r = gg.getResults(1)
    -- do something
    local t = {}
    t[1] = {}
    t[1].address = r[1].address + 0xE8 -- 782BF3ADBE80 + es abajo y x4 decimal 
    t[1].flags = gg.TYPE_DWORD
    t[1].value = 650
    t[1].freeze = false
    gg.setValues(t)
    -- 00000001h;6892D4F9h
    -- 81x4 324 dec a hexa 144 - 4 = 140
    -- 6169640Ch;006D6564h;00000000h;00000000h;00000000h;00000000h diadema de oro
    -- 1634296844 7169380 13407 0 valor 500 diadema

    local e_1 = {}
    e_1[1] = {}
    e_1[1].address = r[1].address + 0xF0
    e_1[1].flags = gg.TYPE_DWORD
    e_1[1].value = 1634296844
    e_1[1].freeze = false
    gg.setValues(e_1)

    local p_1 = {}
    p_1[1] = {}
    p_1[1].address = r[1].address + 0xF4
    p_1[1].flags = gg.TYPE_DWORD
    p_1[1].value = 7169380
    p_1[1].freeze = false
    gg.setValues(p_1)

    local o_1 = {}
    o_1[1] = {}
    o_1[1].address = r[1].address + 0xF8
    o_1[1].flags = gg.TYPE_DWORD
    o_1[1].value = 13407
    o_1[1].freeze = false
    gg.setValues(o_1)

    local ha_1 = {}
    ha_1[1] = {}
    ha_1[1].address = r[1].address + 0xFC
    ha_1[1].flags = gg.TYPE_DWORD
    ha_1[1].value = 0
    ha_1[1].freeze = false
    gg.setValues(ha_1)

    local pa_1 = {}
    pa_1[1] = {}
    pa_1[1].address = r[1].address + 0x100
    pa_1[1].flags = gg.TYPE_DWORD
    pa_1[1].value = 0
    pa_1[1].freeze = false
    gg.setValues(pa_1)

    local ya_1 = {}
    ya_1[1] = {}
    ya_1[1].address = r[1].address + 0x104
    ya_1[1].flags = gg.TYPE_DWORD
    ya_1[1].value = 0
    ya_1[1].freeze = false
    gg.setValues(ya_1)

    -- Caja 1

    local k_1 = {}
    k_1[1] = {}
    k_1[1].address = r[1].address + 0x138
    k_1[1].flags = gg.TYPE_DWORD
    k_1[1].value = 650
    k_1[1].freeze = false
    gg.setValues(k_1)

    -- 1634296844 7169380 13407 0 valor 500 diadema
    local k_2 = {}
    k_2[1] = {}
    k_2[1].address = r[1].address + 0x140
    k_2[1].flags = gg.TYPE_DWORD
    k_2[1].value = 1634296844
    k_2[1].freeze = false
    gg.setValues(k_2)

    local k_3 = {}
    k_3[1] = {}
    k_3[1].address = r[1].address + 0x144
    k_3[1].flags = gg.TYPE_DWORD
    k_3[1].value = 7169380
    k_3[1].freeze = false
    gg.setValues(k_3)
    local k_4 = {}
    k_4[1] = {}
    k_4[1].address = r[1].address + 0x148
    k_4[1].flags = gg.TYPE_DWORD
    k_4[1].value = 13407
    k_4[1].freeze = false
    gg.setValues(k_4)

    local e_1 = {}
    e_1[1] = {}
    e_1[1].address = r[1].address + 0x14C
    e_1[1].flags = gg.TYPE_DWORD
    e_1[1].value = 0
    e_1[1].freeze = false
    gg.setValues(e_1)

    local x_1 = {}
    x_1[1] = {}
    x_1[1].address = r[1].address + 0x150
    x_1[1].flags = gg.TYPE_DWORD
    x_1[1].value = 0
    x_1[1].freeze = false
    gg.setValues(x_1)

    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = r[1].address + 0x154
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 0
    v_1[1].freeze = false
    gg.setValues(v_1)
    gg.clearResults()
    -- caja 2
    local t_2 = {}
    t_2[1] = {}
    t_2[1].address = r[1].address + 0x188
    t_2[1].flags = gg.TYPE_DWORD
    t_2[1].value = 650
    t_2[1].freeze = false
    gg.setValues(t_2)

    local e_2 = {}
    e_2[1] = {}
    e_2[1].address = r[1].address + 0x190
    e_2[1].flags = gg.TYPE_DWORD
    e_2[1].value = 1634296844
    e_2[1].freeze = false
    gg.setValues(e_2)

    local p_2 = {}
    p_2[1] = {}
    p_2[1].address = r[1].address + 0x194
    p_2[1].flags = gg.TYPE_DWORD
    p_2[1].value = 7169380
    p_2[1].freeze = false
    gg.setValues(p_2)

    local o_2 = {}
    o_2[1] = {}
    o_2[1].address = r[1].address + 0x198
    o_2[1].flags = gg.TYPE_DWORD
    o_2[1].value = 13407
    o_2[1].freeze = false
    gg.setValues(o_2)

    local ha_2 = {}
    ha_2[1] = {}
    ha_2[1].address = r[1].address + 0x19C
    ha_2[1].flags = gg.TYPE_DWORD
    ha_2[1].value = 0
    ha_2[1].freeze = false
    gg.setValues(ha_2)

    local pa_2 = {}
    pa_2[1] = {}
    pa_2[1].address = r[1].address + 0x1A0
    pa_2[1].flags = gg.TYPE_DWORD
    pa_2[1].value = 0
    pa_2[1].freeze = false
    gg.setValues(pa_2)

    local ya_2 = {}
    ya_2[1] = {}
    ya_2[1].address = r[1].address + 0x1A4
    ya_2[1].flags = gg.TYPE_DWORD
    ya_2[1].value = 0
    ya_2[1].freeze = false
    gg.setValues(ya_2)
    gg.clearResults()
end

function hackPedirAyudaAvion_9()
    gg.alert("Hacerlo mas Iniciar el juego o reiniciar el juego...")
    gg.toast("Hacerlo mas Iniciar el juego o reiniciar el juego...")
    gg.toast("Cargando...")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber(
        "696F630Ah;0000736Eh;6B6E750Ch;00776F6Eh;72696110h;726F6373h;00000065h",
        gg.TYPE_DWORD)
    gg.refineNumber("696F630Ah", gg.TYPE_DWORD)
    r = gg.getResults(1)
    -- do something
    local t = {}
    t[1] = {}
    t[1].address = r[1].address + 0x308 -- 782BF3ADBE80 + es abajo y x4 decimal 140
    t[1].flags = gg.TYPE_DWORD
    t[1].value = 1
    t[1].freeze = false
    gg.setValues(t)

    local e_1 = {}
    e_1[1] = {}
    e_1[1].address = r[1].address + 0x448
    e_1[1].flags = gg.TYPE_DWORD
    e_1[1].value = 1
    e_1[1].freeze = false
    gg.setValues(e_1)

    local p_1 = {}
    p_1[1] = {}
    p_1[1].address = r[1].address + 0x588
    p_1[1].flags = gg.TYPE_DWORD
    p_1[1].value = 1
    p_1[1].freeze = false
    gg.setValues(p_1)

    local o_1 = {}
    o_1[1] = {}
    o_1[1].address = r[1].address + 0x6C8
    o_1[1].flags = gg.TYPE_DWORD
    o_1[1].value = 1
    o_1[1].freeze = false
    gg.setValues(o_1)

    local ha_1 = {}
    ha_1[1] = {}
    ha_1[1].address = r[1].address + 0x808
    ha_1[1].flags = gg.TYPE_DWORD
    ha_1[1].value = 1
    ha_1[1].freeze = false
    gg.setValues(ha_1)

    local ha_2 = {}
    ha_2[1] = {}
    ha_2[1].address = r[1].address + 0x948
    ha_2[1].flags = gg.TYPE_DWORD
    ha_2[1].value = 1
    ha_2[1].freeze = false
    gg.setValues(ha_2)

    local ha_3 = {}
    ha_3[1] = {}
    ha_3[1].address = r[1].address + 0xA88
    ha_3[1].flags = gg.TYPE_DWORD
    ha_3[1].value = 1
    ha_3[1].freeze = false
    gg.setValues(ha_3)

    local ha_4 = {}
    ha_4[1] = {}
    ha_4[1].address = r[1].address + 0xBC8
    ha_4[1].flags = gg.TYPE_DWORD
    ha_4[1].value = 1
    ha_4[1].freeze = false
    gg.setValues(ha_4)

    local pa_1 = {}
    pa_1[1] = {}
    pa_1[1].address = r[1].address - 0xB8
    pa_1[1].flags = gg.TYPE_DWORD
    pa_1[1].value = 1
    pa_1[1].freeze = false
    gg.setValues(pa_1)

    gg.clearResults()

end

-- LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL
function hackTrEnCarta_1()

    gg.toast("Cargando............  1")
    hackTrEn_1()
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("1600407924;51", gg.TYPE_DWORD)
    gg.refineNumber("51", gg.TYPE_DWORD)

    r = gg.getResults(1)

    local t = {}
    t[1] = {}
    t[1].address = r[1].address - 0xCC
    t[1].flags = gg.TYPE_DWORD
    t[1].value = 0
    t[1].freeze = true
    gg.setValues(t)
    gg.addListItems(t)

    local e = {}
    e[1] = {}
    e[1].address = r[1].address - 0x1EC
    e[1].flags = gg.TYPE_DWORD
    e[1].value = 0
    e[1].freeze = true
    gg.setValues(e)
    gg.addListItems(e)

    local y = {}
    y[1] = {}
    y[1].address = r[1].address - 0x30C
    y[1].flags = gg.TYPE_DWORD
    y[1].value = 0
    y[1].freeze = true
    gg.setValues(y)
    gg.addListItems(y)

    local v = {}
    v[1] = {}
    v[1].address = r[1].address - 0x42C
    v[1].flags = gg.TYPE_DWORD
    v[1].value = 0
    v[1].freeze = true
    gg.setValues(v)
    gg.addListItems(v)

    local h = {}
    h[1] = {}
    h[1].address = r[1].address - 0x54C
    h[1].flags = gg.TYPE_DWORD
    h[1].value = 0
    h[1].freeze = true
    gg.setValues(h)
    gg.addListItems(h)

    hackTrEnCarta_2()
end
function hackTrEnCarta_2()

    gg.toast("Cargando............ 2")

    r = gg.getResults(2)

    local t = {}
    t[2] = {}
    t[2].address = r[2].address - 0xCC
    t[2].flags = gg.TYPE_DWORD
    t[2].value = 0
    t[2].freeze = true
    gg.setValues(t)
    gg.addListItems(t)

    local e = {}
    e[2] = {}
    e[2].address = r[2].address - 0x1EC
    e[2].flags = gg.TYPE_DWORD
    e[2].value = 0
    e[2].freeze = true
    gg.setValues(e)
    gg.addListItems(e)

    local y = {}
    y[2] = {}
    y[2].address = r[2].address - 0x30C
    y[2].flags = gg.TYPE_DWORD
    y[2].value = 0
    y[2].freeze = true
    gg.setValues(y)
    gg.addListItems(y)

    local v = {}
    v[2] = {}
    v[2].address = r[2].address - 0x42C
    v[2].flags = gg.TYPE_DWORD
    v[2].value = 0
    v[2].freeze = true
    gg.setValues(v)
    gg.addListItems(v)

    local h = {}
    h[2] = {}
    h[2].address = r[2].address - 0x54C
    h[2].flags = gg.TYPE_DWORD
    h[2].value = 0
    h[2].freeze = true
    gg.setValues(h)
    gg.addListItems(h)

    hackTrEnCarta_3()
end
function hackTrEnCarta_3()

    gg.toast("Cargando............ 3")

    r = gg.getResults(3)

    local t = {}
    t[3] = {}
    t[3].address = r[3].address - 0xCC
    t[3].flags = gg.TYPE_DWORD
    t[3].value = 0
    t[3].freeze = true
    gg.setValues(t)
    gg.addListItems(t)

    local e = {}
    e[3] = {}
    e[3].address = r[3].address - 0x1EC
    e[3].flags = gg.TYPE_DWORD
    e[3].value = 0
    e[3].freeze = true
    gg.setValues(e)
    gg.addListItems(e)

    local y = {}
    y[3] = {}
    y[3].address = r[3].address - 0x30C
    y[3].flags = gg.TYPE_DWORD
    y[3].value = 0
    y[3].freeze = true
    gg.setValues(y)
    gg.addListItems(y)

    local v = {}
    v[3] = {}
    v[3].address = r[3].address - 0x42C
    v[3].flags = gg.TYPE_DWORD
    v[3].value = 0
    v[3].freeze = true
    gg.setValues(v)
    gg.addListItems(v)

    local h = {}
    h[3] = {}
    h[3].address = r[3].address - 0x54C
    h[3].flags = gg.TYPE_DWORD
    h[3].value = 0
    h[3].freeze = true
    gg.setValues(h)
    gg.addListItems(h)

    hackTrEnCarta_1_1()
end

function hackTrEnCarta_1_1()

    gg.toast("Cargando............  1")
    -- gg.processResume()
    -- gg.clearResults()
    -- gg.searchNumber("1600407924;51", gg.TYPE_DWORD ) 
    -- gg.refineNumber("51", gg.TYPE_DWORD )

    r = gg.getResults(1)
    -- do something  72614316h;505F4364h;316B6361h;00003500h;     72610000h;505F4364h;316B6361h;00003500h
    -- 1918976790  1348420452  829121377 13568   1918959616 1348420452  829121377   13568

    -- 3

    local tName_1 = {}
    tName_1[1] = {}
    tName_1[1].address = r[1].address - 0x13C
    tName_1[1].flags = gg.TYPE_DWORD
    tName_1[1].value = 860374804
    tName_1[1].freeze = false
    gg.setValues(tName_1)
    local tName_2 = {}
    tName_2[1] = {}
    tName_2[1].address = r[1].address - 0x138
    tName_2[1].flags = gg.TYPE_DWORD
    tName_2[1].value = 2017551720
    tName_2[1].freeze = false
    gg.setValues(tName_2)
    local tName_3 = {}
    tName_3[1] = {}
    tName_3[1].address = r[1].address - 0x134
    tName_3[1].flags = gg.TYPE_DWORD
    tName_3[1].value = 6843489
    tName_3[1].freeze = false
    gg.setValues(tName_3)
    -- Name
    -- 3484714h;78416568h;00686C61h 860374804 2017551720  6843489
    local t = {}
    t[1] = {}
    t[1].address = r[1].address - 0xA4
    t[1].flags = gg.TYPE_DWORD
    t[1].value = 1918976790
    t[1].freeze = false
    gg.setValues(t)
    local e = {}
    e[1] = {}
    e[1].address = r[1].address - 0xA0
    e[1].flags = gg.TYPE_DWORD
    e[1].value = 1348420452
    e[1].freeze = false
    gg.setValues(e)
    local y = {}
    y[1] = {}
    y[1].address = r[1].address - 0x9C
    y[1].flags = gg.TYPE_DWORD
    y[1].value = 896230241
    y[1].freeze = false
    gg.setValues(y)
    local v = {}
    v[1] = {}
    v[1].address = r[1].address - 0x98
    v[1].flags = gg.TYPE_DWORD
    v[1].value = 13568
    v[1].freeze = false
    gg.setValues(v)
    ----
    -- 1918976790  1348420452  829121377 13568   1918959616 1348420452  829121377   13568
    local h = {}
    h[1] = {}
    h[1].address = r[1].address - 0x8C
    h[1].flags = gg.TYPE_DWORD
    h[1].value = 1918959616
    h[1].freeze = false
    gg.setValues(h)
    local h_10 = {}
    h_10[1] = {}
    h_10[1].address = r[1].address - 0x88
    h_10[1].flags = gg.TYPE_DWORD
    h_10[1].value = 1348420452
    h_10[1].freeze = false
    gg.setValues(h_10)
    local h_11 = {}
    h_11[1] = {}
    h_11[1].address = r[1].address - 0x84
    h_11[1].flags = gg.TYPE_DWORD
    h_11[1].value = 896230241
    h_11[1].freeze = false
    gg.setValues(h_11)
    local h_12 = {}
    h_12[1] = {}
    h_12[1].address = r[1].address - 0x80
    h_12[1].flags = gg.TYPE_DWORD
    h_12[1].value = 13568
    h_12[1].freeze = false
    gg.setValues(h_12)
    local h_13 = {}
    h_13[1] = {}
    h_13[1].address = r[1].address - 0x164
    h_13[1].flags = gg.TYPE_DWORD
    h_13[1].value = 1
    h_13[1].freeze = false
    gg.setValues(h_13)
    -- 2
    -- 1918976790  1348420452  829121377 13568   1918959616 1348420452  829121377   13568

    local tName_4 = {}
    tName_4[1] = {}
    tName_4[1].address = r[1].address - 0x25C
    tName_4[1].flags = gg.TYPE_DWORD
    tName_4[1].value = 860374804
    tName_4[1].freeze = false
    gg.setValues(tName_4)
    local tName_5 = {}
    tName_5[1] = {}
    tName_5[1].address = r[1].address - 0x258
    tName_5[1].flags = gg.TYPE_DWORD
    tName_5[1].value = 2017551720
    tName_5[1].freeze = false
    gg.setValues(tName_5)
    local tName_6 = {}
    tName_6[1] = {}
    tName_6[1].address = r[1].address - 0x254
    tName_6[1].flags = gg.TYPE_DWORD
    tName_6[1].value = 6843489
    tName_6[1].freeze = false
    gg.setValues(tName_6)
    -- Name

    local h_14 = {}
    h_14[1] = {}
    h_14[1].address = r[1].address - 0x1C4
    h_14[1].flags = gg.TYPE_DWORD
    h_14[1].value = 1918976790
    h_14[1].freeze = false
    gg.setValues(h_14)

    local h_15 = {}
    h_15[1] = {}
    h_15[1].address = r[1].address - 0x1C0
    h_15[1].flags = gg.TYPE_DWORD
    h_15[1].value = 1348420452
    h_15[1].freeze = false
    gg.setValues(h_15)

    local h_16 = {}
    h_16[1] = {}
    h_16[1].address = r[1].address - 0x1BC
    h_16[1].flags = gg.TYPE_DWORD
    h_16[1].value = 896230241
    h_16[1].freeze = false
    gg.setValues(h_16)

    local h_17 = {}
    h_17[1] = {}
    h_17[1].address = r[1].address - 0x1B8
    h_17[1].flags = gg.TYPE_DWORD
    h_17[1].value = 13568
    h_17[1].freeze = false
    gg.setValues(h_17)
    --
    -- 1918976790  1348420452  829121377 13568   1918959616 1348420452  829121377   13568
    local h_18 = {}
    h_18[1] = {}
    h_18[1].address = r[1].address - 0x1AC
    h_18[1].flags = gg.TYPE_DWORD
    h_18[1].value = 1918959616
    h_18[1].freeze = false
    gg.setValues(h_18)

    local h_19 = {}
    h_19[1] = {}
    h_19[1].address = r[1].address - 0x1A8
    h_19[1].flags = gg.TYPE_DWORD
    h_19[1].value = 1348420452
    h_19[1].freeze = false
    gg.setValues(h_19)

    local h_20 = {}
    h_20[1] = {}
    h_20[1].address = r[1].address - 0x1A4
    h_20[1].flags = gg.TYPE_DWORD
    h_20[1].value = 896230241
    h_20[1].freeze = false
    gg.setValues(h_20)

    local h_21 = {}
    h_21[1] = {}
    h_21[1].address = r[1].address - 0x1A0
    h_21[1].flags = gg.TYPE_DWORD
    h_21[1].value = 13568
    h_21[1].freeze = false
    gg.setValues(h_21)

    local h_22 = {}
    h_22[1] = {}
    h_22[1].address = r[1].address - 0x284
    h_22[1].flags = gg.TYPE_DWORD
    h_22[1].value = 1
    h_22[1].freeze = false
    gg.setValues(h_22)

    -- 3
    -- 1918976790  1348420452  829121377 13568   1918959616 1348420452  829121377   13568

    local tName_7 = {}
    tName_7[1] = {}
    tName_7[1].address = r[1].address - 0x37C
    tName_7[1].flags = gg.TYPE_DWORD
    tName_7[1].value = 860374804
    tName_7[1].freeze = false
    gg.setValues(tName_7)
    local tName_8 = {}
    tName_8[1] = {}
    tName_8[1].address = r[1].address - 0x378
    tName_8[1].flags = gg.TYPE_DWORD
    tName_8[1].value = 2017551720
    tName_8[1].freeze = false
    gg.setValues(tName_8)
    local tName_9 = {}
    tName_9[1] = {}
    tName_9[1].address = r[1].address - 0x374
    tName_9[1].flags = gg.TYPE_DWORD
    tName_9[1].value = 6843489
    tName_9[1].freeze = false
    gg.setValues(tName_9)
    -- Name

    local h_23 = {}
    h_23[1] = {}
    h_23[1].address = r[1].address - 0x2E4
    h_23[1].flags = gg.TYPE_DWORD
    h_23[1].value = 1918976790
    h_23[1].freeze = false
    gg.setValues(h_23)

    local h_24 = {}
    h_24[1] = {}
    h_24[1].address = r[1].address - 0x2E0
    h_24[1].flags = gg.TYPE_DWORD
    h_24[1].value = 1348420452
    h_24[1].freeze = false
    gg.setValues(h_24)

    local h_25 = {}
    h_25[1] = {}
    h_25[1].address = r[1].address - 0x2DC
    h_25[1].flags = gg.TYPE_DWORD
    h_25[1].value = 896230241
    h_25[1].freeze = false
    gg.setValues(h_25)

    local h_26 = {}
    h_26[1] = {}
    h_26[1].address = r[1].address - 0x2D8
    h_26[1].flags = gg.TYPE_DWORD
    h_26[1].value = 13568
    h_26[1].freeze = false
    gg.setValues(h_26)
    --
    -- 1918976790  1348420452  829121377 13568   1918959616 1348420452  829121377   13568
    local h_27 = {}
    h_27[1] = {}
    h_27[1].address = r[1].address - 0x2CC
    h_27[1].flags = gg.TYPE_DWORD
    h_27[1].value = 1918959616
    h_27[1].freeze = false
    gg.setValues(h_27)

    local h_28 = {}
    h_28[1] = {}
    h_28[1].address = r[1].address - 0x2C8
    h_28[1].flags = gg.TYPE_DWORD
    h_28[1].value = 1348420452
    h_28[1].freeze = false
    gg.setValues(h_28)

    local h_29 = {}
    h_29[1] = {}
    h_29[1].address = r[1].address - 0x2C4
    h_29[1].flags = gg.TYPE_DWORD
    h_29[1].value = 896230241
    h_29[1].freeze = false
    gg.setValues(h_29)

    local h_30 = {}
    h_30[1] = {}
    h_30[1].address = r[1].address - 0x2C0
    h_30[1].flags = gg.TYPE_DWORD
    h_30[1].value = 13568
    h_30[1].freeze = false
    gg.setValues(h_30)

    local h_31 = {}
    h_31[1] = {}
    h_31[1].address = r[1].address - 0x3A4
    h_31[1].flags = gg.TYPE_DWORD
    h_31[1].value = 1
    h_31[1].freeze = false
    gg.setValues(h_31)
    ---4
    -- 1918976790  1348420452  829121377 13568   1918959616 1348420452  829121377   13568
    local tName_10 = {}
    tName_10[1] = {}
    tName_10[1].address = r[1].address - 0x49C
    tName_10[1].flags = gg.TYPE_DWORD
    tName_10[1].value = 860374804
    tName_10[1].freeze = false
    gg.setValues(tName_10)
    local tName_11 = {}
    tName_11[1] = {}
    tName_11[1].address = r[1].address - 0x498
    tName_11[1].flags = gg.TYPE_DWORD
    tName_11[1].value = 2017551720
    tName_11[1].freeze = false
    gg.setValues(tName_11)
    local tName_12 = {}
    tName_12[1] = {}
    tName_12[1].address = r[1].address - 0x494
    tName_12[1].flags = gg.TYPE_DWORD
    tName_12[1].value = 6843489
    tName_12[1].freeze = false
    gg.setValues(tName_12)
    -- Name
    local h_32 = {}
    h_32[1] = {}
    h_32[1].address = r[1].address - 0x404
    h_32[1].flags = gg.TYPE_DWORD
    h_32[1].value = 1918976790
    h_32[1].freeze = false
    gg.setValues(h_32)

    local h_33 = {}
    h_33[1] = {}
    h_33[1].address = r[1].address - 0x400
    h_33[1].flags = gg.TYPE_DWORD
    h_33[1].value = 1348420452
    h_33[1].freeze = false
    gg.setValues(h_33)

    local h_34 = {}
    h_34[1] = {}
    h_34[1].address = r[1].address - 0x3FC
    h_34[1].flags = gg.TYPE_DWORD
    h_34[1].value = 896230241
    h_34[1].freeze = false
    gg.setValues(h_34)

    local h_35 = {}
    h_35[1] = {}
    h_35[1].address = r[1].address - 0x3F8
    h_35[1].flags = gg.TYPE_DWORD
    h_35[1].value = 13568
    h_35[1].freeze = false
    gg.setValues(h_35)
    --
    -- 1918976790  1348420452  829121377 13568   1918959616 1348420452  829121377   13568
    local h_36 = {}
    h_36[1] = {}
    h_36[1].address = r[1].address - 0x3EC
    h_36[1].flags = gg.TYPE_DWORD
    h_36[1].value = 1918959616
    h_36[1].freeze = false
    gg.setValues(h_36)

    local h_37 = {}
    h_37[1] = {}
    h_37[1].address = r[1].address - 0x3E8
    h_37[1].flags = gg.TYPE_DWORD
    h_37[1].value = 1348420452
    h_37[1].freeze = false
    gg.setValues(h_37)

    local h_38 = {}
    h_38[1] = {}
    h_38[1].address = r[1].address - 0x3E4
    h_38[1].flags = gg.TYPE_DWORD
    h_38[1].value = 896230241
    h_38[1].freeze = false
    gg.setValues(h_38)

    local h_39 = {}
    h_39[1] = {}
    h_39[1].address = r[1].address - 0x3E0
    h_39[1].flags = gg.TYPE_DWORD
    h_39[1].value = 13568
    h_39[1].freeze = false
    gg.setValues(h_39)

    local h_40 = {}
    h_40[1] = {}
    h_40[1].address = r[1].address - 0x4C4
    h_40[1].flags = gg.TYPE_DWORD
    h_40[1].value = 1
    h_40[1].freeze = false
    gg.setValues(h_40)
    -- 5
    local tName_13 = {}
    tName_13[1] = {}
    tName_13[1].address = r[1].address - 0x5BC
    tName_13[1].flags = gg.TYPE_DWORD
    tName_13[1].value = 860374804
    tName_13[1].freeze = false
    gg.setValues(tName_13)
    local tName_14 = {}
    tName_14[1] = {}
    tName_14[1].address = r[1].address - 0x5B8
    tName_14[1].flags = gg.TYPE_DWORD
    tName_14[1].value = 2017551720
    tName_14[1].freeze = false
    gg.setValues(tName_14)
    local tName_15 = {}
    tName_15[1] = {}
    tName_15[1].address = r[1].address - 0x5B4
    tName_15[1].flags = gg.TYPE_DWORD
    tName_15[1].value = 6843489
    tName_15[1].freeze = false
    gg.setValues(tName_15)
    -- Name
    -- 1918976790  1348420452  829121377 13568   1918959616 1348420452  829121377   13568 --72614316h;505F4364h 896230241  505F4364h;356B6361h
    local h_41 = {}
    h_41[1] = {}
    h_41[1].address = r[1].address - 0x524
    h_41[1].flags = gg.TYPE_DWORD
    h_41[1].value = 1918976790
    h_41[1].freeze = false
    gg.setValues(h_41)

    local h_42 = {}
    h_42[1] = {}
    h_42[1].address = r[1].address - 0x520
    h_42[1].flags = gg.TYPE_DWORD
    h_42[1].value = 1348420452
    h_42[1].freeze = false
    gg.setValues(h_42)

    local h_43 = {}
    h_43[1] = {}
    h_43[1].address = r[1].address - 0x51C
    h_43[1].flags = gg.TYPE_DWORD
    h_43[1].value = 896230241
    h_43[1].freeze = false
    gg.setValues(h_43)

    local h_44 = {}
    h_44[1] = {}
    h_44[1].address = r[1].address - 0x518
    h_44[1].flags = gg.TYPE_DWORD
    h_44[1].value = 13568
    h_44[1].freeze = false
    gg.setValues(h_44)
    --
    -- 1918976790  1348420452  829121377 13568   1918959616 1348420452  829121377   13568
    local h_45 = {}
    h_45[1] = {}
    h_45[1].address = r[1].address - 0x50C
    h_45[1].flags = gg.TYPE_DWORD
    h_45[1].value = 1918959616
    h_45[1].freeze = false
    gg.setValues(h_45)

    local h_46 = {}
    h_46[1] = {}
    h_46[1].address = r[1].address - 0x508
    h_46[1].flags = gg.TYPE_DWORD
    h_46[1].value = 1348420452
    h_46[1].freeze = false
    gg.setValues(h_46)

    local h_47 = {}
    h_47[1] = {}
    h_47[1].address = r[1].address - 0x504
    h_47[1].flags = gg.TYPE_DWORD
    h_47[1].value = 896230241
    h_47[1].freeze = false
    gg.setValues(h_47)

    local h_48 = {}
    h_48[1] = {}
    h_48[1].address = r[1].address - 0x500
    h_48[1].flags = gg.TYPE_DWORD
    h_48[1].value = 13568
    h_48[1].freeze = false
    gg.setValues(h_48)

    local h_49 = {}
    h_49[1] = {}
    h_49[1].address = r[1].address - 0x5E4
    h_49[1].flags = gg.TYPE_DWORD
    h_49[1].value = 1
    h_49[1].freeze = false
    gg.setValues(h_49)

    hackTrEnCarta_1_2()
end
function hackTrEnCarta_1_2()

    gg.toast("Cargando............  2")

    r = gg.getResults(2)
    local tName_1 = {}
    tName_1[2] = {}
    tName_1[2].address = r[2].address - 0x13C
    tName_1[2].flags = gg.TYPE_DWORD
    tName_1[2].value = 860374804
    tName_1[2].freeze = false
    gg.setValues(tName_1)
    local tName_2 = {}
    tName_2[2] = {}
    tName_2[2].address = r[2].address - 0x138
    tName_2[2].flags = gg.TYPE_DWORD
    tName_2[2].value = 2017551720
    tName_2[2].freeze = false
    gg.setValues(tName_2)
    local tName_3 = {}
    tName_3[2] = {}
    tName_3[2].address = r[2].address - 0x134
    tName_3[2].flags = gg.TYPE_DWORD
    tName_3[2].value = 6843489
    tName_3[2].freeze = false
    gg.setValues(tName_3)
    -- Name
    -- 3484714h;78416568h;00686C61h 860374804 2017551720  6843489
    local t = {}
    t[2] = {}
    t[2].address = r[2].address - 0xA4
    t[2].flags = gg.TYPE_DWORD
    t[2].value = 1918976790
    t[2].freeze = false
    gg.setValues(t)
    local e = {}
    e[2] = {}
    e[2].address = r[2].address - 0xA0
    e[2].flags = gg.TYPE_DWORD
    e[2].value = 1348420452
    e[2].freeze = false
    gg.setValues(e)
    local y = {}
    y[2] = {}
    y[2].address = r[2].address - 0x9C
    y[2].flags = gg.TYPE_DWORD
    y[2].value = 896230241
    y[2].freeze = false
    gg.setValues(y)
    local v = {}
    v[2] = {}
    v[2].address = r[2].address - 0x98
    v[2].flags = gg.TYPE_DWORD
    v[2].value = 13568
    v[2].freeze = false
    gg.setValues(v)
    ----
    -- 1918976790  1348420452  829121377 13568   1918959616 1348420452  829121377   13568
    local h = {}
    h[2] = {}
    h[2].address = r[2].address - 0x8C
    h[2].flags = gg.TYPE_DWORD
    h[2].value = 1918959616
    h[2].freeze = false
    gg.setValues(h)
    local h_10 = {}
    h_10[2] = {}
    h_10[2].address = r[2].address - 0x88
    h_10[2].flags = gg.TYPE_DWORD
    h_10[2].value = 1348420452
    h_10[2].freeze = false
    gg.setValues(h_10)
    local h_11 = {}
    h_11[2] = {}
    h_11[2].address = r[2].address - 0x84
    h_11[2].flags = gg.TYPE_DWORD
    h_11[2].value = 896230241
    h_11[2].freeze = false
    gg.setValues(h_11)
    local h_12 = {}
    h_12[2] = {}
    h_12[2].address = r[2].address - 0x80
    h_12[2].flags = gg.TYPE_DWORD
    h_12[2].value = 13568
    h_12[2].freeze = false
    gg.setValues(h_12)
    local h_13 = {}
    h_13[2] = {}
    h_13[2].address = r[2].address - 0x164
    h_13[2].flags = gg.TYPE_DWORD
    h_13[2].value = 1
    h_13[2].freeze = false
    gg.setValues(h_13)
    -- 2
    -- 1918976790  1348420452  829121377 13568   1918959616 1348420452  829121377   13568

    local tName_4 = {}
    tName_4[2] = {}
    tName_4[2].address = r[2].address - 0x25C
    tName_4[2].flags = gg.TYPE_DWORD
    tName_4[2].value = 860374804
    tName_4[2].freeze = false
    gg.setValues(tName_4)
    local tName_5 = {}
    tName_5[2] = {}
    tName_5[2].address = r[2].address - 0x258
    tName_5[2].flags = gg.TYPE_DWORD
    tName_5[2].value = 2017551720
    tName_5[2].freeze = false
    gg.setValues(tName_5)
    local tName_6 = {}
    tName_6[2] = {}
    tName_6[2].address = r[2].address - 0x254
    tName_6[2].flags = gg.TYPE_DWORD
    tName_6[2].value = 6843489
    tName_6[2].freeze = false
    gg.setValues(tName_6)
    -- Name

    local h_14 = {}
    h_14[2] = {}
    h_14[2].address = r[2].address - 0x1C4
    h_14[2].flags = gg.TYPE_DWORD
    h_14[2].value = 1918976790
    h_14[2].freeze = false
    gg.setValues(h_14)

    local h_15 = {}
    h_15[2] = {}
    h_15[2].address = r[2].address - 0x1C0
    h_15[2].flags = gg.TYPE_DWORD
    h_15[2].value = 1348420452
    h_15[2].freeze = false
    gg.setValues(h_15)

    local h_16 = {}
    h_16[2] = {}
    h_16[2].address = r[2].address - 0x1BC
    h_16[2].flags = gg.TYPE_DWORD
    h_16[2].value = 896230241
    h_16[2].freeze = false
    gg.setValues(h_16)

    local h_17 = {}
    h_17[2] = {}
    h_17[2].address = r[2].address - 0x1B8
    h_17[2].flags = gg.TYPE_DWORD
    h_17[2].value = 13568
    h_17[2].freeze = false
    gg.setValues(h_17)
    --
    -- 1918976790  1348420452  829121377 13568   1918959616 1348420452  829121377   13568
    local h_18 = {}
    h_18[2] = {}
    h_18[2].address = r[2].address - 0x1AC
    h_18[2].flags = gg.TYPE_DWORD
    h_18[2].value = 1918959616
    h_18[2].freeze = false
    gg.setValues(h_18)

    local h_19 = {}
    h_19[2] = {}
    h_19[2].address = r[2].address - 0x1A8
    h_19[2].flags = gg.TYPE_DWORD
    h_19[2].value = 1348420452
    h_19[2].freeze = false
    gg.setValues(h_19)

    local h_20 = {}
    h_20[2] = {}
    h_20[2].address = r[2].address - 0x1A4
    h_20[2].flags = gg.TYPE_DWORD
    h_20[2].value = 896230241
    h_20[2].freeze = false
    gg.setValues(h_20)

    local h_21 = {}
    h_21[2] = {}
    h_21[2].address = r[2].address - 0x1A0
    h_21[2].flags = gg.TYPE_DWORD
    h_21[2].value = 13568
    h_21[2].freeze = false
    gg.setValues(h_21)

    local h_22 = {}
    h_22[2] = {}
    h_22[2].address = r[2].address - 0x284
    h_22[2].flags = gg.TYPE_DWORD
    h_22[2].value = 1
    h_22[2].freeze = false
    gg.setValues(h_22)

    -- 3
    -- 1918976790  1348420452  829121377 13568   1918959616 1348420452  829121377   13568

    local tName_7 = {}
    tName_7[2] = {}
    tName_7[2].address = r[2].address - 0x37C
    tName_7[2].flags = gg.TYPE_DWORD
    tName_7[2].value = 860374804
    tName_7[2].freeze = false
    gg.setValues(tName_7)
    local tName_8 = {}
    tName_8[2] = {}
    tName_8[2].address = r[2].address - 0x378
    tName_8[2].flags = gg.TYPE_DWORD
    tName_8[2].value = 2017551720
    tName_8[2].freeze = false
    gg.setValues(tName_8)
    local tName_9 = {}
    tName_9[2] = {}
    tName_9[2].address = r[2].address - 0x374
    tName_9[2].flags = gg.TYPE_DWORD
    tName_9[2].value = 6843489
    tName_9[2].freeze = false
    gg.setValues(tName_9)
    -- Name

    local h_23 = {}
    h_23[2] = {}
    h_23[2].address = r[2].address - 0x2E4
    h_23[2].flags = gg.TYPE_DWORD
    h_23[2].value = 1918976790
    h_23[2].freeze = false
    gg.setValues(h_23)

    local h_24 = {}
    h_24[2] = {}
    h_24[2].address = r[2].address - 0x2E0
    h_24[2].flags = gg.TYPE_DWORD
    h_24[2].value = 1348420452
    h_24[2].freeze = false
    gg.setValues(h_24)

    local h_25 = {}
    h_25[2] = {}
    h_25[2].address = r[2].address - 0x2DC
    h_25[2].flags = gg.TYPE_DWORD
    h_25[2].value = 896230241
    h_25[2].freeze = false
    gg.setValues(h_25)

    local h_26 = {}
    h_26[2] = {}
    h_26[2].address = r[2].address - 0x2D8
    h_26[2].flags = gg.TYPE_DWORD
    h_26[2].value = 13568
    h_26[2].freeze = false
    gg.setValues(h_26)
    --
    -- 1918976790  1348420452  829121377 13568   1918959616 1348420452  829121377   13568
    local h_27 = {}
    h_27[2] = {}
    h_27[2].address = r[2].address - 0x2CC
    h_27[2].flags = gg.TYPE_DWORD
    h_27[2].value = 1918959616
    h_27[2].freeze = false
    gg.setValues(h_27)

    local h_28 = {}
    h_28[2] = {}
    h_28[2].address = r[2].address - 0x2C8
    h_28[2].flags = gg.TYPE_DWORD
    h_28[2].value = 1348420452
    h_28[2].freeze = false
    gg.setValues(h_28)

    local h_29 = {}
    h_29[2] = {}
    h_29[2].address = r[2].address - 0x2C4
    h_29[2].flags = gg.TYPE_DWORD
    h_29[2].value = 896230241
    h_29[2].freeze = false
    gg.setValues(h_29)

    local h_30 = {}
    h_30[2] = {}
    h_30[2].address = r[2].address - 0x2C0
    h_30[2].flags = gg.TYPE_DWORD
    h_30[2].value = 13568
    h_30[2].freeze = false
    gg.setValues(h_30)

    local h_31 = {}
    h_31[2] = {}
    h_31[2].address = r[2].address - 0x3A4
    h_31[2].flags = gg.TYPE_DWORD
    h_31[2].value = 1
    h_31[2].freeze = false
    gg.setValues(h_31)
    ---4
    -- 1918976790  1348420452  829121377 13568   1918959616 1348420452  829121377   13568
    local tName_10 = {}
    tName_10[2] = {}
    tName_10[2].address = r[2].address - 0x49C
    tName_10[2].flags = gg.TYPE_DWORD
    tName_10[2].value = 860374804
    tName_10[2].freeze = false
    gg.setValues(tName_10)
    local tName_11 = {}
    tName_11[2] = {}
    tName_11[2].address = r[2].address - 0x498
    tName_11[2].flags = gg.TYPE_DWORD
    tName_11[2].value = 2017551720
    tName_11[2].freeze = false
    gg.setValues(tName_11)
    local tName_12 = {}
    tName_12[2] = {}
    tName_12[2].address = r[2].address - 0x494
    tName_12[2].flags = gg.TYPE_DWORD
    tName_12[2].value = 6843489
    tName_12[2].freeze = false
    gg.setValues(tName_12)
    -- Name
    local h_32 = {}
    h_32[2] = {}
    h_32[2].address = r[2].address - 0x404
    h_32[2].flags = gg.TYPE_DWORD
    h_32[2].value = 1918976790
    h_32[2].freeze = false
    gg.setValues(h_32)

    local h_33 = {}
    h_33[2] = {}
    h_33[2].address = r[2].address - 0x400
    h_33[2].flags = gg.TYPE_DWORD
    h_33[2].value = 1348420452
    h_33[2].freeze = false
    gg.setValues(h_33)

    local h_34 = {}
    h_34[2] = {}
    h_34[2].address = r[2].address - 0x3FC
    h_34[2].flags = gg.TYPE_DWORD
    h_34[2].value = 896230241
    h_34[2].freeze = false
    gg.setValues(h_34)

    local h_35 = {}
    h_35[2] = {}
    h_35[2].address = r[2].address - 0x3F8
    h_35[2].flags = gg.TYPE_DWORD
    h_35[2].value = 13568
    h_35[2].freeze = false
    gg.setValues(h_35)
    --
    -- 1918976790  1348420452  829121377 13568   1918959616 1348420452  829121377   13568
    local h_36 = {}
    h_36[2] = {}
    h_36[2].address = r[2].address - 0x3EC
    h_36[2].flags = gg.TYPE_DWORD
    h_36[2].value = 1918959616
    h_36[2].freeze = false
    gg.setValues(h_36)

    local h_37 = {}
    h_37[2] = {}
    h_37[2].address = r[2].address - 0x3E8
    h_37[2].flags = gg.TYPE_DWORD
    h_37[2].value = 1348420452
    h_37[2].freeze = false
    gg.setValues(h_37)

    local h_38 = {}
    h_38[2] = {}
    h_38[2].address = r[2].address - 0x3E4
    h_38[2].flags = gg.TYPE_DWORD
    h_38[2].value = 896230241
    h_38[2].freeze = false
    gg.setValues(h_38)

    local h_39 = {}
    h_39[2] = {}
    h_39[2].address = r[2].address - 0x3E0
    h_39[2].flags = gg.TYPE_DWORD
    h_39[2].value = 13568
    h_39[2].freeze = false
    gg.setValues(h_39)

    local h_40 = {}
    h_40[2] = {}
    h_40[2].address = r[2].address - 0x4C4
    h_40[2].flags = gg.TYPE_DWORD
    h_40[2].value = 1
    h_40[2].freeze = false
    gg.setValues(h_40)
    -- 5
    local tName_13 = {}
    tName_13[2] = {}
    tName_13[2].address = r[2].address - 0x5BC
    tName_13[2].flags = gg.TYPE_DWORD
    tName_13[2].value = 860374804
    tName_13[2].freeze = false
    gg.setValues(tName_13)
    local tName_14 = {}
    tName_14[2] = {}
    tName_14[2].address = r[2].address - 0x5B8
    tName_14[2].flags = gg.TYPE_DWORD
    tName_14[2].value = 2017551720
    tName_14[2].freeze = false
    gg.setValues(tName_14)
    local tName_15 = {}
    tName_15[2] = {}
    tName_15[2].address = r[2].address - 0x5B4
    tName_15[2].flags = gg.TYPE_DWORD
    tName_15[2].value = 6843489
    tName_15[2].freeze = false
    gg.setValues(tName_15)
    -- Name
    -- 1918976790  1348420452  829121377 13568   1918959616 1348420452  829121377   13568 --72614316h;505F4364h 896230241  505F4364h;356B6361h
    local h_41 = {}
    h_41[2] = {}
    h_41[2].address = r[2].address - 0x524
    h_41[2].flags = gg.TYPE_DWORD
    h_41[2].value = 1918976790
    h_41[2].freeze = false
    gg.setValues(h_41)

    local h_42 = {}
    h_42[2] = {}
    h_42[2].address = r[2].address - 0x520
    h_42[2].flags = gg.TYPE_DWORD
    h_42[2].value = 1348420452
    h_42[2].freeze = false
    gg.setValues(h_42)

    local h_43 = {}
    h_43[2] = {}
    h_43[2].address = r[2].address - 0x51C
    h_43[2].flags = gg.TYPE_DWORD
    h_43[2].value = 896230241
    h_43[2].freeze = false
    gg.setValues(h_43)

    local h_44 = {}
    h_44[2] = {}
    h_44[2].address = r[2].address - 0x518
    h_44[2].flags = gg.TYPE_DWORD
    h_44[2].value = 13568
    h_44[2].freeze = false
    gg.setValues(h_44)
    --
    -- 1918976790  1348420452  829121377 13568   1918959616 1348420452  829121377   13568
    local h_45 = {}
    h_45[2] = {}
    h_45[2].address = r[2].address - 0x50C
    h_45[2].flags = gg.TYPE_DWORD
    h_45[2].value = 1918959616
    h_45[2].freeze = false
    gg.setValues(h_45)

    local h_46 = {}
    h_46[2] = {}
    h_46[2].address = r[2].address - 0x508
    h_46[2].flags = gg.TYPE_DWORD
    h_46[2].value = 1348420452
    h_46[2].freeze = false
    gg.setValues(h_46)

    local h_47 = {}
    h_47[2] = {}
    h_47[2].address = r[2].address - 0x504
    h_47[2].flags = gg.TYPE_DWORD
    h_47[2].value = 896230241
    h_47[2].freeze = false
    gg.setValues(h_47)

    local h_48 = {}
    h_48[2] = {}
    h_48[2].address = r[2].address - 0x500
    h_48[2].flags = gg.TYPE_DWORD
    h_48[2].value = 13568
    h_48[2].freeze = false
    gg.setValues(h_48)

    local h_49 = {}
    h_49[2] = {}
    h_49[2].address = r[2].address - 0x5E4
    h_49[2].flags = gg.TYPE_DWORD
    h_49[2].value = 1
    h_49[2].freeze = false
    gg.setValues(h_49)

    hackTrEnCarta_1_3()
end
function hackTrEnCarta_1_3()

    gg.toast("Cargando............  3")

    r = gg.getResults(3)
    local tName_1 = {}
    tName_1[3] = {}
    tName_1[3].address = r[3].address - 0x13C
    tName_1[3].flags = gg.TYPE_DWORD
    tName_1[3].value = 860374804
    tName_1[3].freeze = false
    gg.setValues(tName_1)
    local tName_2 = {}
    tName_2[3] = {}
    tName_2[3].address = r[3].address - 0x138
    tName_2[3].flags = gg.TYPE_DWORD
    tName_2[3].value = 2017551720
    tName_2[3].freeze = false
    gg.setValues(tName_2)
    local tName_3 = {}
    tName_3[3] = {}
    tName_3[3].address = r[3].address - 0x134
    tName_3[3].flags = gg.TYPE_DWORD
    tName_3[3].value = 6843489
    tName_3[3].freeze = false
    gg.setValues(tName_3)
    -- Name
    -- 3484714h;78416568h;00686C61h 860374804 2017551720  6843489
    local t = {}
    t[3] = {}
    t[3].address = r[3].address - 0xA4
    t[3].flags = gg.TYPE_DWORD
    t[3].value = 1918976790
    t[3].freeze = false
    gg.setValues(t)
    local e = {}
    e[3] = {}
    e[3].address = r[3].address - 0xA0
    e[3].flags = gg.TYPE_DWORD
    e[3].value = 1348420452
    e[3].freeze = false
    gg.setValues(e)
    local y = {}
    y[3] = {}
    y[3].address = r[3].address - 0x9C
    y[3].flags = gg.TYPE_DWORD
    y[3].value = 896230241
    y[3].freeze = false
    gg.setValues(y)
    local v = {}
    v[3] = {}
    v[3].address = r[3].address - 0x98
    v[3].flags = gg.TYPE_DWORD
    v[3].value = 13568
    v[3].freeze = false
    gg.setValues(v)
    ----
    -- 1918976790  1348420452  829121377 13568   1918959616 1348420452  829121377   13568
    local h = {}
    h[3] = {}
    h[3].address = r[3].address - 0x8C
    h[3].flags = gg.TYPE_DWORD
    h[3].value = 1918959616
    h[3].freeze = false
    gg.setValues(h)
    local h_10 = {}
    h_10[3] = {}
    h_10[3].address = r[3].address - 0x88
    h_10[3].flags = gg.TYPE_DWORD
    h_10[3].value = 1348420452
    h_10[3].freeze = false
    gg.setValues(h_10)
    local h_11 = {}
    h_11[3] = {}
    h_11[3].address = r[3].address - 0x84
    h_11[3].flags = gg.TYPE_DWORD
    h_11[3].value = 896230241
    h_11[3].freeze = false
    gg.setValues(h_11)
    local h_12 = {}
    h_12[3] = {}
    h_12[3].address = r[3].address - 0x80
    h_12[3].flags = gg.TYPE_DWORD
    h_12[3].value = 13568
    h_12[3].freeze = false
    gg.setValues(h_12)
    local h_13 = {}
    h_13[3] = {}
    h_13[3].address = r[3].address - 0x164
    h_13[3].flags = gg.TYPE_DWORD
    h_13[3].value = 1
    h_13[3].freeze = false
    gg.setValues(h_13)
    -- 2
    -- 1918976790  1348420452  829121377 13568   1918959616 1348420452  829121377   13568

    local tName_4 = {}
    tName_4[3] = {}
    tName_4[3].address = r[3].address - 0x25C
    tName_4[3].flags = gg.TYPE_DWORD
    tName_4[3].value = 860374804
    tName_4[3].freeze = false
    gg.setValues(tName_4)
    local tName_5 = {}
    tName_5[3] = {}
    tName_5[3].address = r[3].address - 0x258
    tName_5[3].flags = gg.TYPE_DWORD
    tName_5[3].value = 2017551720
    tName_5[3].freeze = false
    gg.setValues(tName_5)
    local tName_6 = {}
    tName_6[3] = {}
    tName_6[3].address = r[3].address - 0x254
    tName_6[3].flags = gg.TYPE_DWORD
    tName_6[3].value = 6843489
    tName_6[3].freeze = false
    gg.setValues(tName_6)
    -- Name

    local h_14 = {}
    h_14[3] = {}
    h_14[3].address = r[3].address - 0x1C4
    h_14[3].flags = gg.TYPE_DWORD
    h_14[3].value = 1918976790
    h_14[3].freeze = false
    gg.setValues(h_14)

    local h_15 = {}
    h_15[3] = {}
    h_15[3].address = r[3].address - 0x1C0
    h_15[3].flags = gg.TYPE_DWORD
    h_15[3].value = 1348420452
    h_15[3].freeze = false
    gg.setValues(h_15)

    local h_16 = {}
    h_16[3] = {}
    h_16[3].address = r[3].address - 0x1BC
    h_16[3].flags = gg.TYPE_DWORD
    h_16[3].value = 896230241
    h_16[3].freeze = false
    gg.setValues(h_16)

    local h_17 = {}
    h_17[3] = {}
    h_17[3].address = r[3].address - 0x1B8
    h_17[3].flags = gg.TYPE_DWORD
    h_17[3].value = 13568
    h_17[3].freeze = false
    gg.setValues(h_17)
    --
    -- 1918976790  1348420452  829121377 13568   1918959616 1348420452  829121377   13568
    local h_18 = {}
    h_18[3] = {}
    h_18[3].address = r[3].address - 0x1AC
    h_18[3].flags = gg.TYPE_DWORD
    h_18[3].value = 1918959616
    h_18[3].freeze = false
    gg.setValues(h_18)

    local h_19 = {}
    h_19[3] = {}
    h_19[3].address = r[3].address - 0x1A8
    h_19[3].flags = gg.TYPE_DWORD
    h_19[3].value = 1348420452
    h_19[3].freeze = false
    gg.setValues(h_19)

    local h_20 = {}
    h_20[3] = {}
    h_20[3].address = r[3].address - 0x1A4
    h_20[3].flags = gg.TYPE_DWORD
    h_20[3].value = 896230241
    h_20[3].freeze = false
    gg.setValues(h_20)

    local h_21 = {}
    h_21[3] = {}
    h_21[3].address = r[3].address - 0x1A0
    h_21[3].flags = gg.TYPE_DWORD
    h_21[3].value = 13568
    h_21[3].freeze = false
    gg.setValues(h_21)

    local h_22 = {}
    h_22[3] = {}
    h_22[3].address = r[3].address - 0x284
    h_22[3].flags = gg.TYPE_DWORD
    h_22[3].value = 1
    h_22[3].freeze = false
    gg.setValues(h_22)

    -- 3
    -- 1918976790  1348420452  829121377 13568   1918959616 1348420452  829121377   13568

    local tName_7 = {}
    tName_7[3] = {}
    tName_7[3].address = r[3].address - 0x37C
    tName_7[3].flags = gg.TYPE_DWORD
    tName_7[3].value = 860374804
    tName_7[3].freeze = false
    gg.setValues(tName_7)
    local tName_8 = {}
    tName_8[3] = {}
    tName_8[3].address = r[3].address - 0x378
    tName_8[3].flags = gg.TYPE_DWORD
    tName_8[3].value = 2017551720
    tName_8[3].freeze = false
    gg.setValues(tName_8)
    local tName_9 = {}
    tName_9[3] = {}
    tName_9[3].address = r[3].address - 0x374
    tName_9[3].flags = gg.TYPE_DWORD
    tName_9[3].value = 6843489
    tName_9[3].freeze = false
    gg.setValues(tName_9)
    -- Name

    local h_23 = {}
    h_23[3] = {}
    h_23[3].address = r[3].address - 0x2E4
    h_23[3].flags = gg.TYPE_DWORD
    h_23[3].value = 1918976790
    h_23[3].freeze = false
    gg.setValues(h_23)

    local h_24 = {}
    h_24[3] = {}
    h_24[3].address = r[3].address - 0x2E0
    h_24[3].flags = gg.TYPE_DWORD
    h_24[3].value = 1348420452
    h_24[3].freeze = false
    gg.setValues(h_24)

    local h_25 = {}
    h_25[3] = {}
    h_25[3].address = r[3].address - 0x2DC
    h_25[3].flags = gg.TYPE_DWORD
    h_25[3].value = 896230241
    h_25[3].freeze = false
    gg.setValues(h_25)

    local h_26 = {}
    h_26[3] = {}
    h_26[3].address = r[3].address - 0x2D8
    h_26[3].flags = gg.TYPE_DWORD
    h_26[3].value = 13568
    h_26[3].freeze = false
    gg.setValues(h_26)
    --
    -- 1918976790  1348420452  829121377 13568   1918959616 1348420452  829121377   13568
    local h_27 = {}
    h_27[3] = {}
    h_27[3].address = r[3].address - 0x2CC
    h_27[3].flags = gg.TYPE_DWORD
    h_27[3].value = 1918959616
    h_27[3].freeze = false
    gg.setValues(h_27)

    local h_28 = {}
    h_28[3] = {}
    h_28[3].address = r[3].address - 0x2C8
    h_28[3].flags = gg.TYPE_DWORD
    h_28[3].value = 1348420452
    h_28[3].freeze = false
    gg.setValues(h_28)

    local h_29 = {}
    h_29[3] = {}
    h_29[3].address = r[3].address - 0x2C4
    h_29[3].flags = gg.TYPE_DWORD
    h_29[3].value = 896230241
    h_29[3].freeze = false
    gg.setValues(h_29)

    local h_30 = {}
    h_30[3] = {}
    h_30[3].address = r[3].address - 0x2C0
    h_30[3].flags = gg.TYPE_DWORD
    h_30[3].value = 13568
    h_30[3].freeze = false
    gg.setValues(h_30)

    local h_31 = {}
    h_31[3] = {}
    h_31[3].address = r[3].address - 0x3A4
    h_31[3].flags = gg.TYPE_DWORD
    h_31[3].value = 1
    h_31[3].freeze = false
    gg.setValues(h_31)
    ---4
    -- 1918976790  1348420452  829121377 13568   1918959616 1348420452  829121377   13568
    local tName_10 = {}
    tName_10[3] = {}
    tName_10[3].address = r[3].address - 0x49C
    tName_10[3].flags = gg.TYPE_DWORD
    tName_10[3].value = 860374804
    tName_10[3].freeze = false
    gg.setValues(tName_10)
    local tName_11 = {}
    tName_11[3] = {}
    tName_11[3].address = r[3].address - 0x498
    tName_11[3].flags = gg.TYPE_DWORD
    tName_11[3].value = 2017551720
    tName_11[3].freeze = false
    gg.setValues(tName_11)
    local tName_12 = {}
    tName_12[3] = {}
    tName_12[3].address = r[3].address - 0x494
    tName_12[3].flags = gg.TYPE_DWORD
    tName_12[3].value = 6843489
    tName_12[3].freeze = false
    gg.setValues(tName_12)
    -- Name
    local h_32 = {}
    h_32[3] = {}
    h_32[3].address = r[3].address - 0x404
    h_32[3].flags = gg.TYPE_DWORD
    h_32[3].value = 1918976790
    h_32[3].freeze = false
    gg.setValues(h_32)

    local h_33 = {}
    h_33[3] = {}
    h_33[3].address = r[3].address - 0x400
    h_33[3].flags = gg.TYPE_DWORD
    h_33[3].value = 1348420452
    h_33[3].freeze = false
    gg.setValues(h_33)

    local h_34 = {}
    h_34[3] = {}
    h_34[3].address = r[3].address - 0x3FC
    h_34[3].flags = gg.TYPE_DWORD
    h_34[3].value = 896230241
    h_34[3].freeze = false
    gg.setValues(h_34)

    local h_35 = {}
    h_35[3] = {}
    h_35[3].address = r[3].address - 0x3F8
    h_35[3].flags = gg.TYPE_DWORD
    h_35[3].value = 13568
    h_35[3].freeze = false
    gg.setValues(h_35)
    --
    -- 1918976790  1348420452  829121377 13568   1918959616 1348420452  829121377   13568
    local h_36 = {}
    h_36[3] = {}
    h_36[3].address = r[3].address - 0x3EC
    h_36[3].flags = gg.TYPE_DWORD
    h_36[3].value = 1918959616
    h_36[3].freeze = false
    gg.setValues(h_36)

    local h_37 = {}
    h_37[3] = {}
    h_37[3].address = r[3].address - 0x3E8
    h_37[3].flags = gg.TYPE_DWORD
    h_37[3].value = 1348420452
    h_37[3].freeze = false
    gg.setValues(h_37)

    local h_38 = {}
    h_38[3] = {}
    h_38[3].address = r[3].address - 0x3E4
    h_38[3].flags = gg.TYPE_DWORD
    h_38[3].value = 896230241
    h_38[3].freeze = false
    gg.setValues(h_38)

    local h_39 = {}
    h_39[3] = {}
    h_39[3].address = r[3].address - 0x3E0
    h_39[3].flags = gg.TYPE_DWORD
    h_39[3].value = 13568
    h_39[3].freeze = false
    gg.setValues(h_39)

    local h_40 = {}
    h_40[3] = {}
    h_40[3].address = r[3].address - 0x4C4
    h_40[3].flags = gg.TYPE_DWORD
    h_40[3].value = 1
    h_40[3].freeze = false
    gg.setValues(h_40)
    -- 5
    local tName_13 = {}
    tName_13[3] = {}
    tName_13[3].address = r[3].address - 0x5BC
    tName_13[3].flags = gg.TYPE_DWORD
    tName_13[3].value = 860374804
    tName_13[3].freeze = false
    gg.setValues(tName_13)
    local tName_14 = {}
    tName_14[3] = {}
    tName_14[3].address = r[3].address - 0x5B8
    tName_14[3].flags = gg.TYPE_DWORD
    tName_14[3].value = 2017551720
    tName_14[3].freeze = false
    gg.setValues(tName_14)
    local tName_15 = {}
    tName_15[3] = {}
    tName_15[3].address = r[3].address - 0x5B4
    tName_15[3].flags = gg.TYPE_DWORD
    tName_15[3].value = 6843489
    tName_15[3].freeze = false
    gg.setValues(tName_15)
    -- Name
    -- 1918976790  1348420452  829121377 13568   1918959616 1348420452  829121377   13568 --72614316h;505F4364h 896230241  505F4364h;356B6361h
    local h_41 = {}
    h_41[3] = {}
    h_41[3].address = r[3].address - 0x524
    h_41[3].flags = gg.TYPE_DWORD
    h_41[3].value = 1918976790
    h_41[3].freeze = false
    gg.setValues(h_41)

    local h_42 = {}
    h_42[3] = {}
    h_42[3].address = r[3].address - 0x520
    h_42[3].flags = gg.TYPE_DWORD
    h_42[3].value = 1348420452
    h_42[3].freeze = false
    gg.setValues(h_42)

    local h_43 = {}
    h_43[3] = {}
    h_43[3].address = r[3].address - 0x51C
    h_43[3].flags = gg.TYPE_DWORD
    h_43[3].value = 896230241
    h_43[3].freeze = false
    gg.setValues(h_43)

    local h_44 = {}
    h_44[3] = {}
    h_44[3].address = r[3].address - 0x518
    h_44[3].flags = gg.TYPE_DWORD
    h_44[3].value = 13568
    h_44[3].freeze = false
    gg.setValues(h_44)
    --
    -- 1918976790  1348420452  829121377 13568   1918959616 1348420452  829121377   13568
    local h_45 = {}
    h_45[3] = {}
    h_45[3].address = r[3].address - 0x50C
    h_45[3].flags = gg.TYPE_DWORD
    h_45[3].value = 1918959616
    h_45[3].freeze = false
    gg.setValues(h_45)

    local h_46 = {}
    h_46[3] = {}
    h_46[3].address = r[3].address - 0x508
    h_46[3].flags = gg.TYPE_DWORD
    h_46[3].value = 1348420452
    h_46[3].freeze = false
    gg.setValues(h_46)

    local h_47 = {}
    h_47[3] = {}
    h_47[3].address = r[3].address - 0x504
    h_47[3].flags = gg.TYPE_DWORD
    h_47[3].value = 896230241
    h_47[3].freeze = false
    gg.setValues(h_47)

    local h_48 = {}
    h_48[3] = {}
    h_48[3].address = r[3].address - 0x500
    h_48[3].flags = gg.TYPE_DWORD
    h_48[3].value = 13568
    h_48[3].freeze = false
    gg.setValues(h_48)

    local h_49 = {}
    h_49[3] = {}
    h_49[3].address = r[3].address - 0x5E4
    h_49[3].flags = gg.TYPE_DWORD
    h_49[3].value = 1
    h_49[3].freeze = false
    gg.setValues(h_49)

end

-- LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL

function hackAvion_Volver()

    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("18000;54000", gg.TYPE_DWORD)
    gg.refineNumber("18000", gg.TYPE_DWORD)

    gg.getResults(2);
    gg.editAll("2", gg.TYPE_DWORD);
    gg.sleep(3000)
    gg.getResults(2);
    gg.editAll("18000", gg.TYPE_DWORD);
    gg.processResume();
    gg.clearResults();
    gg.alert(" Restart the game after...")
    gg.toast("  Restart the game after...")

end

function Name_1()
    gg.toast("Loading............ Name ") -- reina de la isla tortuga 2#part3
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 1348423763
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = 1768320882
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = 1951622508
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = 1600482425
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = 1953719654
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = 1818326633 -- 2
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = 980641024
    v_7[1].freeze = false
    gg.setValues(v_7)
    -- gg.clearResults()
    hackDecoExpe_1_18h("rExpe_4")
end
function Frame_1()
    gg.toast("Loading............ Frame ")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 1348423763
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = 1768320882
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = 1917216108
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = 1600482657
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = 1953719654
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = 1818326633
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = 808534528
    v_7[1].freeze = false
    gg.setValues(v_7)
    local v_8 = {}
    v_8[1] = {}
    v_8[1].address = val[1].address + 0x1C
    v_8[1].flags = gg.TYPE_DWORD
    v_8[1].value = 1110454853
    v_8[1].freeze = false
    gg.setValues(v_8)
    -- gg.clearResults()
    hackDecoExpe_1_18h("rExpe_4")
end

-- todo decoracion Expedition
function hackDecoExpe_1()
    gg.toast("Loading............ Expedition 1") -- reina de la isla tortuga 2#part3
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 1701869637
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = 1769236836
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = 1698983535
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = 1634889571
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = 1852795252
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = 1634738994 -- 2
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = 3372146
    v_7[1].freeze = false
    gg.setValues(v_7)
    -- gg.clearResults()
    hackDecoExpe_1_1("rExpe_1")
end

-- LLLLLLLLLLLLLLll 1

function hackDecoExpe_2()
    gg.toast("Loading............ Expedition 2") -- balneario secreto de cleopatra 6#part1
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 1701869637
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = 1769236836
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = 1698983535
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = 1634889571
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = 1852795252
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = 1634738998 -- 6
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = 3241074
    v_7[1].freeze = false
    gg.setValues(v_7)
    -- gg.clearResults()

    hackDecoExpe_1_1("rExpe_1")
end

-- LLLLLLLLLLLLLLll 2

function hackDecoExpe_3()
    gg.toast("Loading............ Expedition 3") -- guardian del norte 3#part1
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 1701869637
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = 1769236836
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = 1698983535
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = 1634889571
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = 1852795252
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = 1634738995 -- 3
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = 3241074
    v_7[1].freeze = false
    gg.setValues(v_7)
    -- gg.clearResults()

    hackDecoExpe_1_1("rExpe_1")
end
-- LLLLLLLLLLLLLLll 2
function hackDecoExpe_4()
    gg.toast("Loading............ Expedition 4") -- odisea del pirata 4#part1 
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 1701869637
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = 1769236836
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = 1698983535
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = 1634889571
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = 1852795252
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = 1634738996 -- 4
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = 3241074
    v_7[1].freeze = false
    gg.setValues(v_7)
    -- gg.clearResults()

    hackDecoExpe_1_1("rExpe_1")
end
-- LLLLLLLLLLLLLLll 2
function hackDecoExpe_5()
    gg.toast("Loading............ Expedition 5") -- megalito del yeti 5#part1
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 1701869637
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = 1769236836
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = 1698983535
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = 1634889571
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = 1852795252
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = 1634738997 -- 5
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = 3241074
    v_7[1].freeze = false
    gg.setValues(v_7)
    -- gg.clearResults()

    hackDecoExpe_1_1("rExpe_1")
end
-- LLLLLLLLLLLLLLll 2
function hackDecoExpe_6()
    gg.toast("Loading............ Expedition 6")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- parque de atracciones botanico 7#par1
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 1701869637
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = 1769236836
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = 1698983535
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = 1634889571
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = 1852795252
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = 1634738999 -- 6
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = 3241074
    v_7[1].freeze = false
    gg.setValues(v_7)

    -- 61702337h 7;00337472h part 3

    -- gg.clearResults()

    hackDecoExpe_1_1("rExpe_1")
end
-- LLLLLLLLLLLLLLll 2
function hackDecoExpe_7()
    gg.toast("Loading............ Expedition 7")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- Museo del Reino de Poseidon 8#part1
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 1701869637
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = 1769236836
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = 1698983535
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = 1634889571
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = 1852795252
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = 1634739000 -- 8
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = 3241074
    v_7[1].freeze = false
    gg.setValues(v_7)

    -- 61702337h 7;00337472h part 3

    -- gg.clearResults()

    hackDecoExpe_1_1("rExpe_1")
end
-- LLLLLLLLLLLLLLll 2
function hackDecoExpe_8()
    gg.toast("Loading............ Expedition 8")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- Instituto de fenomenos naturales 9#part1
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 1701869637
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = 1769236836
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = 1698983535
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = 1634889571
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = 1852795252
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = 1634739001 -- 9
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = 3241074
    v_7[1].freeze = false
    gg.setValues(v_7)

    -- 61702337h 7;00337472h part 3

    -- gg.clearResults()

    hackDecoExpe_1_1("rExpe_1")
end
-- LLLLLLLLLLLLLLll 2
function hackDecoExpe_9()
    gg.toast("Loading............ Expedition 9")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- Central park 1#part3
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 1735550285
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = 1698968165
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = 1634889571
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = 1852795252
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = 1634738993
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = 3372146
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = 7561581
    v_7[1].freeze = false
    gg.setValues(v_7)

    -- 61702337h 7;00337472h part 3

    -- gg.clearResults()

    hackDecoExpe_1_17h("rExpe_3")
end
-- LLLLLLLLLLLLLLll 2
function hackDecoExpe_10()
    gg.toast("Loading............ Expedition 10")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- Centro comunitario chino 2#part3
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 1735550285
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = 1698968165
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = 1634889571
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = 1852795252
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = 1634738994
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = 3372146
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = 7561581
    v_7[1].freeze = false
    gg.setValues(v_7)

    -- 61702337h 7;00337472h part 3

    -- gg.clearResults()

    hackDecoExpe_1_17h("rExpe_3")
end
-- LLLLLLLLLLLLLLll 2
function hackDecoExpe_11()
    gg.toast("Loading............ Expedition 11")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- Ecoparque del arcoiris 3#par3
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 1735550285
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = 1698968165
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = 1634889571
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = 1852795252
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = 1634738995
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = 3372146
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = 7561581
    v_7[1].freeze = false
    gg.setValues(v_7)

    -- 61702337h 7;00337472h part 3

    -- gg.clearResults()

    hackDecoExpe_1_17h("rExpe_3")
end

-- LLLLLLLLLLLLLLll 2
function hackDecoExpe_12()
    gg.toast("Loading............ Expedition 12")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- Tour gastronomico 4#par3
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 1735550285
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = 1698968165
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = 1634889571
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = 1852795252
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = 1634738996
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = 3372146
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = 7561581
    v_7[1].freeze = false
    gg.setValues(v_7)

    -- 61702337h 7;00337472h part 3

    -- gg.clearResults()

    hackDecoExpe_1_17h("rExpe_3")
end
-- LLLLLLLLLLLLLLll 2
function hackDecoExpe_13()
    gg.toast("Loading............ Expedition 13")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- Feria agricola 5#part3
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 1735550285
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = 1698968165
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = 1634889571
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = 1852795252
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = 1634738997
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = 3306610
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = 7561581
    v_7[1].freeze = false
    gg.setValues(v_7)

    -- 61702337h 7;00337472h part 3

    -- gg.clearResults()

    hackDecoExpe_1_17h("rExpe_3")
end
-- LLLLLLLLLLLLLLll 2
function hackDecoExpe_14()
    gg.toast("Loading............ Expedition 14")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- Complejo deportivo 6#part3
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 1735550285
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = 1698968165
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = 1634889571
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = 1852795252
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = 1634738998
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = 3306610
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = 7561581
    v_7[1].freeze = false
    gg.setValues(v_7)

    -- 61702337h 7;00337472h part 3

    -- gg.clearResults()

    hackDecoExpe_1_17h("rExpe_3")
end
-- LLLLLLLLLLLLLLll 2
function hackDecoExpe_15()
    gg.toast("Loading............ Expedition 15")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- Rincon del pinguino 7#par3
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 1735550285
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = 1698968165
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = 1634889571
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = 1852795252
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = 1634738999
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = 3306610
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = 7561581
    v_7[1].freeze = false
    gg.setValues(v_7)

    -- 61702337h 7;00337472h part 3

    -- gg.clearResults()

    hackDecoExpe_1_17h("rExpe_3")
end
-- LLLLLLLLLLLLLLll 2
function hackDecoExpe_16()
    gg.toast("Loading............ Expedition 16")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- Discoteca clasica 8#par1
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 1735550285
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = 1698968165
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = 1634889571
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = 1852795252
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = 1634739000
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = 3241074
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = 7561581
    v_7[1].freeze = false
    gg.setValues(v_7)

    -- 61702337h 7;00337472h part 3

    -- gg.clearResults()

    hackDecoExpe_1_17h("rExpe_3")
end
-- LLLLLLLLLLLLLLll 2
function hackDecoExpe_17()
    gg.toast("Loading............ Expedition 17")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- Recinto del la feria artesanal 9#par1
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 1735550285
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = 1698968165
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = 1634889571
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = 1852795252
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = 1634739001
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = 3241074
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = 7561581
    v_7[1].freeze = false
    gg.setValues(v_7)

    -- 61702337h 7;00337472h part 3

    -- gg.clearResults()

    hackDecoExpe_1_17h("rExpe_3")
end
-- LLLLLLLLLLLLLLll 2
function hackDecoExpe_18()
    gg.toast("Loading............ Expedition 18")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- Campamento placido 10#par1
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 1735550285
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = 1698968165
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = 1634889571
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = 1852795252
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = 1881354289
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = 829715041
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = 7561581
    v_7[1].freeze = false
    gg.setValues(v_7)

    -- 61702337h 7;00337472h part 3

    -- gg.clearResults()

    hackDecoExpe_1_18h("rExpe_4")
end
-- LLLLLLLLLLLLLLll 2
function hackDecoExpe_19()
    gg.toast("Loading............ Expedition 19")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- Fiesta en la playa 11#part1
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 1735550285
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = 1698968165
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = 1634889571
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = 1852795252
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = 1881354545
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = 829715041
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = 7561581
    v_7[1].freeze = false
    gg.setValues(v_7)

    -- 61702337h 7;00337472h part 3

    -- gg.clearResults()

    hackDecoExpe_1_18h("rExpe_4")
end
-- LLLLLLLLLLLLLLll 2
function hackDecoExpe_20()
    gg.toast("Loading............ Expedition 20")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- El corazon de italia 12#part1
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 1735550285
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = 1698968165
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = 1634889571
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = 1852795252
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = 1881354801
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = 829715041
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = 7561581
    v_7[1].freeze = false
    gg.setValues(v_7)

    -- 61702337h 7;00337472h part 3

    -- gg.clearResults()

    hackDecoExpe_1_18h("rExpe_4")
end
-- LLLLLLLLLLLLLLll 2
function hackDecoExpe_21()
    gg.toast("Loading............ Expedition 21")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- Mansion inteligente 10# repara base ition 21
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 1701869637
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = 1769236836
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = 1698983535
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = 1634889571
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = 1852795252
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = 1881354289
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = 829715041
    v_7[1].freeze = false
    gg.setValues(v_7)

    -- 61702337h 7;00337472h part 3

    -- gg.clearResults()

    hackDecoExpe_1_1ch("rExpe_2")
end
-- LLLLLLLLLLLLLLll 2
function hackDecoExpe_22()
    gg.toast("Loading............ Expedition 22")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- Casa de campo ciervo dorado 11#par1 ion 22
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 1701869637
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = 1769236836
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = 1698983535
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = 1634889571
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = 1852795252
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = 1881354545
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = 829715041
    v_7[1].freeze = false
    gg.setValues(v_7)

    -- 61702337h 7;00337472h part 3

    -- gg.clearResults()

    hackDecoExpe_1_1ch("rExpe_2")
end
-- LLLLLLLLLLLLLLll 2
function hackDecoExpe_23()
    gg.toast("Loading............ Expedition 23")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- Fuente del loto de hielo 12#part1 on 23
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 1701869637
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = 1769236836
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = 1698983535
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = 1634889571
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = 1852795252
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = 1881354801
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = 829715041
    v_7[1].freeze = false
    gg.setValues(v_7)

    -- 61702337h 7;00337472h part 3

    -- gg.clearResults()

    hackDecoExpe_1_1ch("rExpe_2")
end
-- LLLLLLLLLLLLLLll 2
function hackDecoExpe_24()
    gg.toast("Loading............ Expedition 24")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- Teatro clasico 13#pr1 ion 24
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 1701869637
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = 1769236836
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = 1698983535
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = 1634889571
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = 1852795252
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = 1881355057
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = 829715041
    v_7[1].freeze = false
    gg.setValues(v_7)

    -- 61702337h 7;00337472h part 3

    -- gg.clearResults()

    hackDecoExpe_1_1ch("rExpe_2")
end
-- LLLLLLLLLLLLLLll 2
function hackDecoExpe_25()
    gg.toast("Loading............ Expedition 25")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- El invernadero de la reina avispa 14#base reparar ion 25
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 1701869637
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = 1769236836
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = 1698983535
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = 1634889571
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = 1852795252
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = 1881355313
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = 829715041
    v_7[1].freeze = false
    gg.setValues(v_7)

    -- 61702337h 7;00337472h part 3

    -- gg.clearResults()

    hackDecoExpe_1_1ch("rExpe_2")
end
-- LLLLLLLLLLLLLLll 2
function hackDecoExpe_26()
    gg.toast("Loading............ Expedition 26")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- Centro de investigacion espacial 15#base reparar on 26
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 1701869637
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = 1769236836
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = 1698983535
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = 1634889571
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = 1852795252
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = 1881355569
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = 829715041
    v_7[1].freeze = false
    gg.setValues(v_7)

    -- 61702337h 7;00337472h part 3

    -- gg.clearResults()

    hackDecoExpe_1_1ch("rExpe_2")
end
-- LLLLLLLLLLLLLLll 2
function hackDecoExpe_27()
    gg.toast("Loading............ Expedition 27")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- Bliblioteca en el arbol 16#base on 27
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 1701869637
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = 1769236836
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = 1698983535
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = 1634889571
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = 1852795252
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = 1881355825
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = 829715041
    v_7[1].freeze = false
    gg.setValues(v_7)

    -- 61702337h 7;00337472h part 3

    -- gg.clearResults()

    hackDecoExpe_1_1ch("rExpe_2")
end
-- LLLLLLLLLLLLLLll 2
function hackDecoExpe_28()
    gg.toast("Loading............ Expedition 28")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- Glamping en la naturaleza 17#base reparar
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 1701869637
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = 1769236836
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = 1698983535
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = 1634889571
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = 1852795252
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = 1881356081
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = 829715041
    v_7[1].freeze = false
    gg.setValues(v_7)

    -- 61702337h 7;00337472h part 3

    -- gg.clearResults()

    hackDecoExpe_1_1ch("rExpe_2")
end
-- LLLLLLLLLLLLLLll 2
function hackDecoExpe_29()
    gg.toast("Loading............ Expedition 29")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- Cafeteria cosmica 18#base reparar on29
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 1701869637
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = 1769236836
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = 1698983535
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = 1634889571
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = 1852795252
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = 1881356337
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = 829715041
    v_7[1].freeze = false
    gg.setValues(v_7)

    -- 61702337h 7;00337472h part 3

    -- gg.clearResults()

    hackDecoExpe_1_1ch("rExpe_2")
end
-- LLLLLLLLLLLLLLll 2
function hackDecoExpe_30()
    gg.toast("Loading............ Expedition 30")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- Parque acuatico los primates 19#base repara on 30
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 1701869637
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = 1769236836
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = 1698983535
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = 1634889571
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = 1852795252
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = 1881356593
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = 829715041
    v_7[1].freeze = false
    gg.setValues(v_7)

    -- 61702337h 7;00337472h part 3

    -- gg.clearResults()

    hackDecoExpe_1_1ch("rExpe_2")
end
-- LLLLLLLLLLLLLLll 2
function hackDecoExpe_31()
    gg.toast("Loading............ Expedition 31")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- Eden en la montaña 20#base repara on 31
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 1701869637
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = 1769236836
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = 1698983535
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = 1634889571
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = 1852795252
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = 1881354290
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = 829715041
    v_7[1].freeze = false
    gg.setValues(v_7)

    -- 61702337h 7;00337472h part 3

    -- gg.clearResults()

    hackDecoExpe_1_1ch("rExpe_2")
end
-- LLLLLLLLLLLLLLll 2
function hackDecoExpe_32()
    gg.toast("Loading............ Expedition 32")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- Parque de atracciones azucarada 21#base reparar on 21
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 1701869637
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = 1769236836
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = 1698983535
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = 1634889571
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = 1852795252
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = 1881354546
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = 829715041
    v_7[1].freeze = false
    gg.setValues(v_7)

    -- 61702337h 7;00337472h part 3

    -- gg.clearResults()

    hackDecoExpe_1_1ch("rExpe_2")
end
-- LLLLLLLLLLLLLLll 2
function hackDecoExpe_33()
    gg.toast("Loading............ Expedition 33")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- Molino de halloween
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 1701869637
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = 1769236836
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = 1698983535
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = 1634889571
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = 1852795252
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = 1881354802
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = 829715041
    v_7[1].freeze = false
    gg.setValues(v_7)

    -- 61702337h 7;00337472h part 3

    -- gg.clearResults()

    hackDecoExpe_1_1ch("rExpe_2")
end
-- LLLLLLLLLLLLLLll 2
function hackDecoExpe_34()
    gg.toast("Loading............ Expedition 34")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- Portal ciberopolis
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = 1701869637
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = 1769236836
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = 1698983535
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = 1634889571
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = 1852795252
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = 1881355315
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = 829715041
    v_7[1].freeze = false
    gg.setValues(v_7)

    -- 61702337h 7;00337472h part 3

    -- gg.clearResults()

    hackDecoExpe_1_1ch("rExpe_2")
end
-- LLLLLLLLLLLLLLll 2
function hackDecoExpe_35()
    gg.toast("Loading............ Expedition 35")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- oficina del sheriff
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "65707845h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "69746964h"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "65446E6Fh"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "61726F63h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "6E6F6974h"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "70233733h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "31747261h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    -- 61702337h 7;00337472h part 3

    -- gg.clearResults()

    hackDecoExpe_1_1ch("rExpe_2")
end
-- LLLLLLLLLLLLLLll end
function hackDecoExpe_1_1(varcJExpe_1)
    gg.toast("Loading............ ")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)

    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address + 0x1C, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address + 0x20, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    local val_3 = {}
    val_3[1] = {address = r[1].address + 0x24, flags = gg.TYPE_DWORD}
    val_3 = gg.getValues(val_3)
    local val_4 = {}
    val_4[1] = {address = r[1].address + 0x28, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address + 0x2C, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address + 0x30, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)

    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if varcJExpe_1 == "rExpe_1" then
        setd(-48, 0)
        setd(-44, 1)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, val_3[1].value)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end

-- LLLLLLLLLLLLLLll end
function hackDecoExpe_1_1ch(varcJExpe_2)
    gg.toast("Loading............ ")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)

    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address + 0x1C, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address + 0x20, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    -- local val_3 = {}
    -- val_3[1] = {address = r[1].address + 0x24, flags = gg.TYPE_DWORD}
    -- val_3 = gg.getValues(val_3)  
    local val_4 = {}
    val_4[1] = {address = r[1].address + 0x28, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address + 0x2C, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address + 0x30, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)

    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if varcJExpe_2 == "rExpe_2" then
        setd(-48, 0)
        setd(-44, 1)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, 28)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end

-- LLLLLLLLLLLLLLll end
function hackDecoExpe_1_17h(varcJExpe_3)
    gg.toast("Loading............ ")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)

    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address + 0x1C, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address + 0x20, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    -- local val_3 = {}
    -- val_3[1] = {address = r[1].address + 0x24, flags = gg.TYPE_DWORD}
    -- val_3 = gg.getValues(val_3)  
    local val_4 = {}
    val_4[1] = {address = r[1].address + 0x28, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address + 0x2C, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address + 0x30, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)

    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if varcJExpe_3 == "rExpe_3" then
        setd(-48, 0)
        setd(-44, 1)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, 23)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end
-- LLLLLLLLLLLLLLll end
function hackDecoExpe_1_18h(varcJExpe_4)
    gg.toast("Loading............ ")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)

    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address + 0x1C, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address + 0x20, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)
    -- local val_3 = {}
    -- val_3[1] = {address = r[1].address + 0x24, flags = gg.TYPE_DWORD}
    -- val_3 = gg.getValues(val_3)  
    local val_4 = {}
    val_4[1] = {address = r[1].address + 0x28, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address + 0x2C, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address + 0x30, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)

    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if varcJExpe_4 == "rExpe_4" then
        setd(-48, 0)
        setd(-44, 1)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, 24)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end

function hackhelicopter_1()
    gg.toast("Loading............ helicopter")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- helicopter easter 2024
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "5F726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "74736165h"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "30327265h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "00003432h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_1Ah("rExpe_2")
end
function hackhelicopter_2()
    gg.toast("Loading............ helicopter")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- helicopter atlantis
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "5F726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "616C7461h"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "7369746Eh"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "00000000h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_18h("rExpe_2")
end
function hackhelicopter_3()
    gg.toast("Loading............ helicopter")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- helicopter pirata 2024
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "5F726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "61726970h"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "30326574h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "00003432h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_1Ah("rExpe_2")
end
function hackhelicopter_4()
    gg.toast("Loading............ helicopter")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- helicopter cny 2025
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "5F726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "32796E63h"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "00353230h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "00000000h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_17h("rExpe_2")
end
function hackhelicopter_5()
    gg.toast("Loading............ helicopter")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- helicopter masquerade
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "5F726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "7173616Dh"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "61726575h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "72006564h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_1Ah("rExpe_2")
end
function hackhelicopter_6()
    gg.toast("Loading............ helicopter")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- helicopter mars 2025
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "5F726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "7372616Dh"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "35323032h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "746E6500h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_18h("rExpe_2")
end
function hackhelicopter_7()
    gg.toast("Loading............ helicopter")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- helicopter pirate 2024
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "5F726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "61726970h"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "30326574h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "00003432h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_1Ah("rExpe_2")
end
function hackhelicopter_8()
    gg.toast("Loading............ helicopter")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- helicopter sleigh:2
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "5F726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "69656C53h"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "323A6867h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "00000000h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_18h("rExpe_2")
end
function hackhelicopter_9()
    gg.toast("Loading............ helicopter")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- helicopter harvest 
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "5F726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "76726148h"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "00747365h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "C7DE35B8h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_17h("rExpe_2")
end
function hackhelicopter_10()
    gg.toast("Loading............ helicopter")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- cinderella
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "5F726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "646E6963h"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "6C657265h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "B000616Ch"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_1Ah("rExpe_2")
end
function hackhelicopter_11()
    gg.toast("Loading............ helicopter")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- helicopter cinderella
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "5F726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "646E6963h"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "6C657265h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "B000616Ch"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_1Ah("rExpe_2")
end
function hackhelicopter_12()
    gg.toast("Loading............ helicopter")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- helicopter detective
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "5F726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "65746564h"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "76697463h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "A1830065h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_19h("rExpe_2")
end
function hackhelicopter_13()
    gg.toast("Loading............ helicopter")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- helicopter halloween 2023
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "5F726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "6C6C6168h"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "6565776Fh"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "3230326Eh"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_1Dh("rExpe_2")
end

function hackhelicopter_1()
    gg.toast("Loading............ helicopter")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- helicopter easter 2024
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "5F726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "74736165h"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "30327265h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "00003432h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_1Ah("rExpe_2")
end
function hackhelicopter_2()
    gg.toast("Loading............ helicopter")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- helicopter atlantis
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "5F726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "616C7461h"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "7369746Eh"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "00000000h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_18h("rExpe_2")
end
function hackhelicopter_3()
    gg.toast("Loading............ helicopter")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- helicopter pirata 2024
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "5F726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "61726970h"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "30326574h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "00003432h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_1Ah("rExpe_2")
end
function hackhelicopter_4()
    gg.toast("Loading............ helicopter")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- helicopter cny 2025
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "5F726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "32796E63h"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "00353230h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "00000000h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_17h("rExpe_2")
end
function hackhelicopter_5()
    gg.toast("Loading............ helicopter")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- helicopter masquerade
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "5F726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "7173616Dh"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "61726575h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "72006564h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_1Ah("rExpe_2")
end
function hackhelicopter_6()
    gg.toast("Loading............ helicopter")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- helicopter mars 2025
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "5F726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "7372616Dh"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "35323032h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "746E6500h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_18h("rExpe_2")
end

function hackhelicopter_8()
    gg.toast("Loading............ helicopter")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- helicopter sleigh:2
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "5F726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "69656C53h"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "323A6867h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "00000000h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_18h("rExpe_2")
end
function hackhelicopter_9()
    gg.toast("Loading............ helicopter")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- helicopter harvest 
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "5F726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "76726148h"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "00747365h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "C7DE35B8h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_17h("rExpe_2")
end
function hackhelicopter_10()
    gg.toast("Loading............ helicopter")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- helicopter robot:2
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "5F726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "6F626F52h"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "00323A74h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "00000000h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_17h("rExpe_2")
end

function hackhelicopter_12()
    gg.toast("Loading............ helicopter")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- helicopter detective
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "5F726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "65746564h"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "76697463h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "A1830065h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_19h("rExpe_2")
end
function hackhelicopter_13()
    gg.toast("Loading............ helicopter")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- helicopter halloween 2023
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "5F726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "6C6C6168h"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "6565776Fh"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "3230326Eh"
    v_7[1].freeze = false
    gg.setValues(v_7)
    local v_8 = {}
    v_8[1] = {}
    v_8[1].address = val[1].address + 0x1C
    v_8[1].flags = gg.TYPE_DWORD
    v_8[1].value = "61430033h"
    v_8[1].freeze = false
    gg.setValues(v_8)

    hackSkin_1Dh("rExpe_2")
end
function hackhelicopterPlace_1()
    gg.toast("Loading............ helicopter place")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- helicopter place cny 2025
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "50726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "6563616Ch"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "796E635Fh"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "35323032h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_1Ch("rExpe_2")
end
function hackhelicopterPlace_2()
    gg.toast("Loading............ helicopter place")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- helicopter place travel
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "50726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "6563616Ch"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "6172545Fh"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "006C6576h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_1Bh("rExpe_2")
end
function hackhelicopterPlace_3()
    gg.toast("Loading............ helicopter place")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- helicopter place sport
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "50726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "6563616Ch"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "6F70535Fh"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "00007472h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_1Ah("rExpe_2")
end
function hackhelicopterPlace_4()
    gg.toast("Loading............ helicopter place")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- helicopter place ufo
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "50726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "6563616Ch"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "6F66555Fh"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "00006500h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_18h("rExpe_2")
end
function hackhelicopterPlace_5()
    gg.toast("Loading............ helicopter place")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- helicopter place robot
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "50726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "6563616Ch"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "626F525Fh"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "C700746Fh"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_1Ah("rExpe_2")
end
function hackhelicopterPlace_6()
    gg.toast("Loading............ helicopter place")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- helicopter place harvest
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "50726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "6563616Ch"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "7261485Fh"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "74736576h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_1Ch("rExpe_2")
end
function hackhelicopterPlace_7()
    gg.toast("Loading............ helicopter place")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- helicopter place arabic
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "50726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "6563616Ch"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "6172415Fh"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "00636962h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_1Bh("rExpe_2")
end
function hackhelicopterPlace_8()
    gg.toast("Loading............ helicopter place")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- helicopter place Resort
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "50726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "6563616Ch"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "7365525Fh"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "0074726Fh"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_1Bh("rExpe_2")
end
function hackhelicopterPlace_9()
    gg.toast("Loading............ helicopter place")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- helicopter place disco
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "50726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "6563616Ch"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "7369645Fh"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "00006F63h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_1Ah("rExpe_2")
end
function hackhelicopterPlace_10()
    gg.toast("Loading............ helicopter place")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- place brazil
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "50726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "6563616Ch"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "6172625Fh"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "006C697Ah"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_1Bh("rExpe_2")
end
function hackhelicopterPlace_11()
    gg.toast("Loading............ helicopter place")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- place cinderella
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "50726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "6563616Ch"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "6E69635Fh"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "65726564h"
    v_7[1].freeze = false
    gg.setValues(v_7)
    local v_8 = {}
    v_8[1] = {}
    v_8[1].address = val[1].address + 0x1C
    v_8[1].flags = gg.TYPE_DWORD
    v_8[1].value = "00616C6Ch"
    v_8[1].freeze = false
    gg.setValues(v_8)

    hackSkin_1Fh("rExpe_2")
    -- hackSkin_1Bh("rExpe_2")
end

function hackhelicopterPlace_12()
    gg.toast("Loading............ helicopter place")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- helicopter place detective
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "50726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "6563616Ch"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "7465645Fh"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "69746365h"
    v_7[1].freeze = false
    gg.setValues(v_7)
    local v_8 = {}
    v_8[1] = {}
    v_8[1].address = val[1].address + 0x1C
    v_8[1].flags = gg.TYPE_DWORD
    v_8[1].value = "00006576h"
    v_8[1].freeze = false
    gg.setValues(v_8)

    hackSkin_1Eh("rExpe_2")
end
function hackhelicopterPlace_13()
    gg.toast("Loading............ helicopter place")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- helicopter place sleighs
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "50726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "6563616Ch"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "656C535Fh"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "00686769h"
    v_7[1].freeze = false
    gg.setValues(v_7)
    local v_8 = {}
    v_8[1] = {}
    v_8[1].address = val[1].address + 0x1C
    v_8[1].flags = gg.TYPE_DWORD
    v_8[1].value = "00007319h"
    v_8[1].freeze = false
    gg.setValues(v_8)

    hackSkin_1Bh("rExpe_2")
end
function hackhelicopterPlace_14()
    gg.toast("Loading............ helicopter place")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- helicopter place masquerade
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "50726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "6563616Ch"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "73616D5Fh"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "72657571h"
    v_7[1].freeze = false
    gg.setValues(v_7)
    local v_8 = {}
    v_8[1] = {}
    v_8[1].address = val[1].address + 0x1C
    v_8[1].flags = gg.TYPE_DWORD
    v_8[1].value = "00656461h"
    v_8[1].freeze = false
    gg.setValues(v_8)

    hackSkin_1Fh("rExpe_2")
end
function hackhelicopterPlace_15()
    gg.toast("Loading............ helicopter place")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- helicopter place pirate 2024
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "50726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "6563616Ch"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "7269705Fh"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "32657461h"
    v_7[1].freeze = false
    gg.setValues(v_7)
    local v_8 = {}
    v_8[1] = {}
    v_8[1].address = val[1].address + 0x1C
    v_8[1].flags = gg.TYPE_DWORD
    v_8[1].value = "00343230h"
    v_8[1].freeze = false
    gg.setValues(v_8)

    hackSkin_1Fh("rExpe_2")
end
function hackhelicopterPlace_16()
    gg.toast("Loading............ helicopter place")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- helicopter place mars 2025
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "50726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "6563616Ch"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "72616D5Fh"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "32303273h"
    v_7[1].freeze = false
    gg.setValues(v_7)
    local v_8 = {}
    v_8[1] = {}
    v_8[1].address = val[1].address + 0x1C
    v_8[1].flags = gg.TYPE_DWORD
    v_8[1].value = "00740035h"
    v_8[1].freeze = false
    gg.setValues(v_8)

    hackSkin_1Dh("rExpe_2")
end
function hackhelicopterPlace_17()
    gg.toast("Loading............ helicopter place")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- helicopter place easter 2024 
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "50726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "6563616Ch"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "7361655Fh"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "32726574h"
    v_7[1].freeze = false
    gg.setValues(v_7)
    local v_8 = {}
    v_8[1] = {}
    v_8[1].address = val[1].address + 0x1C
    v_8[1].flags = gg.TYPE_DWORD
    v_8[1].value = "00343230h"
    v_8[1].freeze = false
    gg.setValues(v_8)

    hackSkin_1Fh("rExpe_2")
end
function hackhelicopterPlace_18()
    gg.toast("Loading............ helicopter place")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- helicopter place atlantis
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6C65485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "706F6369h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "50726574h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "6563616Ch"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "6C74615Fh"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "69746E61h"
    v_7[1].freeze = false
    gg.setValues(v_7)
    local v_8 = {}
    v_8[1] = {}
    v_8[1].address = val[1].address + 0x1C
    v_8[1].flags = gg.TYPE_DWORD
    v_8[1].value = "00000073h"
    v_8[1].freeze = false
    gg.setValues(v_8)

    hackSkin_1Dh("rExpe_2")
end
function hacktrain_station_1()
    gg.toast("Loading............ train Station")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) --  train Station hellas2025 train
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6172545Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "74536E69h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "6F697461h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "65685F6Eh"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "73616C6Ch"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "35323032h"
    v_7[1].freeze = false
    gg.setValues(v_7)
    hackSkin_1Ch("rExpe_2")

end
function hacktrain_station_2()
    gg.toast("Loading............ train Station")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) --  train station festival
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6172545Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "74536E69h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "6F697461h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "65665F6Eh"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "76697473h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "65006C61h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_1Ah("rExpe_2")
end
function hacktrain_station_3()
    gg.toast("Loading............ train Station")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) --  train station robinHood
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6172545Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "74536E69h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "6F697461h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "6F725F6Eh"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "486E6962h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "00646F6Fh"
    v_7[1].freeze = false
    gg.setValues(v_7)
    hackSkin_1Bh("rExpe_2")

end
function hacktrain_station_4()
    gg.toast("Loading............ train Station")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) --  train station rocknroll
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6172545Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "74536E69h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "6F697461h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "6F725F6Eh"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "726E6B63h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "006C6C6Fh"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_1Bh("rExpe_2")
end
function hacktrain_station_5()
    gg.toast("Loading............ train Station")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) --  train station knight
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6172545Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "74536E69h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "6F697461h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "6E6B5F6Eh"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "74686769h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "00000000h"
    v_7[1].freeze = false
    gg.setValues(v_7)
    hackSkin_18h("rExpe_2")

end
function hacktrain_station_6()
    gg.toast("Loading............ train Station")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) --  train station italy 2024
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6172545Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "74536E69h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "6F697461h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "74695F6Eh"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "32796C61h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "00343230h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_1Bh("rExpe_2")
end
function hacktrain_station_7()
    gg.toast("Loading............ train Station")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) --  train station easter 
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6172545Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "74536E69h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "6F697461h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "61655F6Eh"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "72657473h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "E32B0A00h"
    v_7[1].freeze = false
    gg.setValues(v_7)
    hackSkin_18h("rExpe_2")

end
function hacktrain_station_8()
    gg.toast("Loading............ train Station")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) --  train station wester
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6172545Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "74536E69h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "6F697461h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "65775F6Eh"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "72657473h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "6E6F006Eh"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_19h("rExpe_2")
end
function hacktrain_station_9()
    gg.toast("Loading............ train Station")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) --  train station theatrical
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6172545Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "74536E69h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "6F697461h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "68745F6Eh"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "72746165h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "6C616369h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_1Ch("rExpe_2")
end

function hacktrain_station_10()
    gg.toast("Loading............ train Station")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- train station lunar NY 2022
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6172545Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "74536E69h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "6F697461h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "756C5F6Eh"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "4E72616Eh"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "32303259h"
    v_7[1].freeze = false
    gg.setValues(v_7)
    local v_8 = {}
    v_8[1] = {}
    v_8[1].address = val[1].address + 0x1C
    v_8[1].flags = gg.TYPE_DWORD
    v_8[1].value = "80140032h"
    v_8[1].freeze = false
    gg.setValues(v_8)
    hackSkin_1Dh("rExpe_2")

end
function hacktrain_station_11()
    gg.toast("Loading............ train Station")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- train station halloween 2024
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6172545Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "74536E69h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "6F697461h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "61685F6Eh"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "776F6C6Ch"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "326E6565h"
    v_7[1].freeze = false
    gg.setValues(v_7)
    local v_8 = {}
    v_8[1] = {}
    v_8[1].address = val[1].address + 0x1C
    v_8[1].flags = gg.TYPE_DWORD
    v_8[1].value = "00343230h"
    v_8[1].freeze = false
    gg.setValues(v_8)
    hackSkin_1Fh("rExpe_2")

end
function hacktrain_station_12()
    gg.toast("Loading............ train Station")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- train station prehistoric
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6172545Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "74536E69h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "6F697461h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "72705F6Eh"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "73696865h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "69726F74h"
    v_7[1].freeze = false
    gg.setValues(v_7)
    local v_8 = {}
    v_8[1] = {}
    v_8[1].address = val[1].address + 0x1C
    v_8[1].flags = gg.TYPE_DWORD
    v_8[1].value = "00000063h"
    v_8[1].freeze = false
    gg.setValues(v_8)

    hackSkin_1Dh("rExpe_2")
end
function hacktrain_station_13()
    gg.toast("Loading............ train Station")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- train station christmas 2024
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6172545Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "74536E69h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "6F697461h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "68635F6Eh"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "74736972h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "3273616Dh"
    v_7[1].freeze = false
    gg.setValues(v_7)
    local v_8 = {}
    v_8[1] = {}
    v_8[1].address = val[1].address + 0x1C
    v_8[1].flags = gg.TYPE_DWORD
    v_8[1].value = "00343230h"
    v_8[1].freeze = false
    gg.setValues(v_8)

    hackSkin_1Fh("rExpe_2")
end
function hacktrain_1()
    gg.toast("Loading............ train ")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) --   train chrismas 2024
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6172545Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "635F6E69h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "73697268h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "73616D74h"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "34323032h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "06710000h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_18h("rExpe_2")
end
function hacktrain_2()
    gg.toast("Loading............ train ")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) --   train halloween 2024
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6172545Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "685F6E69h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "6F6C6C61h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "6E656577h"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "34323032h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "73657500h"
    v_7[1].freeze = false
    gg.setValues(v_7)
    hackSkin_18h("rExpe_2")

end
function hackairport_1()
    gg.toast("Loading............ airport ")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) --    airport allinclusive
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "7269415Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "74726F70h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "6C6C615Fh"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "6C636E69h"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "76697375h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "DCED0065h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_19h("rExpe_2")
end
function hackairport_2()
    gg.toast("Loading............ airport ")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) --    airport christmas 2022
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "7269415Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "74726F70h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "7268635Fh"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "6D747369h"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "30327361h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "C7003232h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_1Ah("rExpe_2")
end
function hackairport_3()
    gg.toast("Loading............ airport ")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) --    airport classicmusic
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "7269415Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "74726F70h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "616C635Fh"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "63697373h"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "6973756Dh"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "74730063h"
    v_7[1].freeze = false
    gg.setValues(v_7)
    hackSkin_19h("rExpe_2")

end
function hackairport_4()
    gg.toast("Loading............ airport ")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) --    airport halloween 2021
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "7269415Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "74726F70h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "6C61685Fh"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "65776F6Ch"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "30326E65h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "3E003132h"
    v_7[1].freeze = false
    gg.setValues(v_7)
    hackSkin_1Ah("rExpe_2")

end
function hackairport_5()
    gg.toast("Loading............ airport ")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) --    airport easter 2023
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "7269415Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "74726F70h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "7361655Fh"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "32726574h"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "00333230h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "0000000Ah"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_17h("rExpe_2")

end
function hackairport_6()
    gg.toast("Loading............ airport ")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) --    airport winterSport
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "7269415Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "74726F70h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "6E69775Fh"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "53726574h"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "74726F70h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "72663C00h"
    v_7[1].freeze = false
    gg.setValues(v_7)
    hackSkin_18h("rExpe_2")

end
function hackairplane_1()
    gg.toast("Loading............ airplane ")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) --    airplane allinclusive
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "7269415Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "6E616C70h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "6C615F65h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "636E696Ch"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "6973756Ch"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "DA006576h"
    v_7[1].freeze = false
    gg.setValues(v_7)
    hackSkin_1Ah("rExpe_2")

end
function hackairplane_2()
    gg.toast("Loading............ airplane ")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) --   airplane chrismas 2022 
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "7269415Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "6E616C70h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "68635F65h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "74736972h"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "3273616Dh"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "00323230h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_1Bh("rExpe_2")
end
function hackairplane_3()
    gg.toast("Loading............ airplane ")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) --    airplane halloween 2021
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "7269415Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "6E616C70h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "61685F65h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "776F6C6Ch"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "326E6565h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "00313230h"
    v_7[1].freeze = false
    gg.setValues(v_7)
    hackSkin_1Bh("rExpe_2")

end
function hackairplane_4()
    gg.toast("Loading............ airplane ")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) --    airplane easter 2023
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "7269415Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "6E616C70h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "61655F65h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "72657473h"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "33323032h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "00000000h"
    v_7[1].freeze = false
    gg.setValues(v_7)
    hackSkin_18h("rExpe_2")

end
function hackairplane_5()
    gg.toast("Loading............ airplane ")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) --    airplane winterSport
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "7269415Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "6E616C70h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "69775F65h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "7265746Eh"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "726F7053h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "00000074h"
    v_7[1].freeze = false
    gg.setValues(v_7)
    hackSkin_19h("rExpe_2")

end

function hackairplane_7()
    gg.toast("Loading............ airplane ")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) --  airplane classicmusic  
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "7269415Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "6E616C70h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "6C635F65h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "69737361h"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "73756D63h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "00006369h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_1Ah("rExpe_2")
end
function hackharbor_1()
    gg.toast("Loading............  harbor ")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) --     harbor christmas 2023
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "7261485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "5F726F62h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "69726863h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "616D7473h"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "32303273h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "1A9F0033h"
    v_7[1].freeze = false
    gg.setValues(v_7)
    hackSkin_19h("rExpe_2")

end
function hackharbor_2()
    gg.toast("Loading............  harbor ")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) --     harbor wildwest 2024
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "7261485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "5F726F62h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "646C6977h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "74736577h"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "34323032h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "1A9F0100h"
    v_7[1].freeze = false
    gg.setValues(v_7)
    hackSkin_18h("rExpe_2")

end
function hackharbor_3()
    gg.toast("Loading............  harbor ")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) --     harbor birth day 2024
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "7261485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "5F726F62h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "74726962h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "79616468h"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "34323032h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "00000000h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_18h("rExpe_2")
end
function hackharbor_4()
    gg.toast("Loading............  harbor ")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) --     halloween 2022
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "7261485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "5F726F62h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "6C6C6168h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "6565776Fh"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "3230326Eh"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "72650032h"
    v_7[1].freeze = false
    gg.setValues(v_7)
    hackSkin_19h("rExpe_2")

end
function hackharbor_5()
    gg.toast("Loading............  harbor ")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) --     harbor allinclusive 2025
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "7261485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "5F726F62h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "696C6C61h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "756C636Eh"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "65766973h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "35323032h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_1Ch("rExpe_2")
end

function hackharbor_6()
    gg.toast("Loading............harbor  ")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- puerto harbor valentin day
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "7261485Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "5F726F62h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "656C6176h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "6E69746Eh"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "61447365h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "756E0079h"
    v_7[1].freeze = false
    gg.setValues(v_7)
    local v_8 = {}
    v_8[1] = {}
    v_8[1].address = val[1].address + 0x1C
    v_8[1].flags = gg.TYPE_DWORD
    v_8[1].value = "696C5F73h"
    v_8[1].freeze = false
    gg.setValues(v_8)
    hackSkin_19h("rExpe_2")

end
function hackship_1()
    gg.toast("Loading............   ship")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) --  ship christmas 2023    
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6968535Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "68635F70h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "74736972h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "3273616Dh"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "00333230h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "00000001h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_17h("rExpe_2")
end
function hackship_2()
    gg.toast("Loading............   ship")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) --      ship halloween 2022
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6968535Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "61685F70h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "776F6C6Ch"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "326E6565h"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "00323230h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "6572635Fh"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_17h("rExpe_2")
end
function hackship_3()
    gg.toast("Loading............   ship")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) --      ship allinclusive 2025
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6968535Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "6C615F70h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "636E696Ch"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "6973756Ch"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "30326576h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "20003532h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_1Ah("rExpe_2")
end
function hackship_4()
    gg.toast("Loading............   ship")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) --      ship valentin day
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "6968535Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "61765F70h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "746E656Ch"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "73656E69h"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "00796144h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "73200034h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_17h("rExpe_2")
end
function hackFortress_1()
    gg.toast("Loading............  Fortress ")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) --  Fortress prehistoric    
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "726F465Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "73657274h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "72705F73h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "73696865h"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "69726F74h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "C7DE0063h"
    v_7[1].freeze = false
    gg.setValues(v_7)

    hackSkin_19h("rExpe_2")
end
function hackFortress_2()
    gg.toast("Loading............  Fortress ")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) --    Fortress christmas  
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "726F465Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "73657274h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "68435F73h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "74736972h"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "0073616Dh"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "00000000h"
    v_7[1].freeze = false
    gg.setValues(v_7)
    hackSkin_17h("rExpe_2")

end

function hackFortress_3()
    gg.toast("Loading............ Fortress")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- Fortress halloween 2021_1
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "726F465Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "73657274h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "61485F73h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "776F6C6Ch"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "326E6565h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "5F313230h"
    v_7[1].freeze = false
    gg.setValues(v_7)
    local v_8 = {}
    v_8[1] = {}
    v_8[1].address = val[1].address + 0x1C
    v_8[1].flags = gg.TYPE_DWORD
    v_8[1].value = "00000031h"
    v_8[1].freeze = false
    gg.setValues(v_8)

    hackSkin_1Dh("rExpe_2")
end
function hackFortress_4()
    gg.toast("Loading............ Fortress")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- Fortress halloween 2021_2
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "726F465Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "73657274h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "61485F73h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "776F6C6Ch"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "326E6565h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "5F313230h"
    v_7[1].freeze = false
    gg.setValues(v_7)
    local v_8 = {}
    v_8[1] = {}
    v_8[1].address = val[1].address + 0x1C
    v_8[1].flags = gg.TYPE_DWORD
    v_8[1].value = "00000032h"
    v_8[1].freeze = false
    gg.setValues(v_8)

    hackSkin_1Dh("rExpe_2")
end
function hackFortress_5()
    gg.toast("Loading............ Fortress")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD) -- Fortress halloween 2021_2
    count = gg.getResultsCount()
    val = gg.getResults(count)
    for i, v in ipairs(val) do
        v.address = v.address + 0x2C -- offset where is address storing pointer
        -- set appropiate flag
    end
    val = gg.getValues(val)
    for i, v in ipairs(val) do
        -- v.value = v.value & 0xFFFFFFFF -- needed if game is 32 bit
        v.address = v.value
    end
    gg.loadResults(val)
    local v_1 = {}
    v_1[1] = {}
    v_1[1].address = val[1].address
    v_1[1].flags = gg.TYPE_DWORD
    v_1[1].value = "6E696B53h"
    v_1[1].freeze = false
    gg.setValues(v_1)
    local v_2 = {}
    v_2[1] = {}
    v_2[1].address = val[1].address + 0x04
    v_2[1].flags = gg.TYPE_DWORD
    v_2[1].value = "726F465Fh"
    v_2[1].freeze = false
    gg.setValues(v_2)
    local v_3 = {}
    v_3[1] = {}
    v_3[1].address = val[1].address + 0x08
    v_3[1].flags = gg.TYPE_DWORD
    v_3[1].value = "73657274h"
    v_3[1].freeze = false
    gg.setValues(v_3)
    local v_4 = {}
    v_4[1] = {}
    v_4[1].address = val[1].address + 0x0C
    v_4[1].flags = gg.TYPE_DWORD
    v_4[1].value = "61485F73h"
    v_4[1].freeze = false
    gg.setValues(v_4)
    local v_5 = {}
    v_5[1] = {}
    v_5[1].address = val[1].address + 0x10
    v_5[1].flags = gg.TYPE_DWORD
    v_5[1].value = "776F6C6Ch"
    v_5[1].freeze = false
    gg.setValues(v_5)
    local v_6 = {}
    v_6[1] = {}
    v_6[1].address = val[1].address + 0x14
    v_6[1].flags = gg.TYPE_DWORD
    v_6[1].value = "326E6565h"
    v_6[1].freeze = false
    gg.setValues(v_6)
    local v_7 = {}
    v_7[1] = {}
    v_7[1].address = val[1].address + 0x18
    v_7[1].flags = gg.TYPE_DWORD
    v_7[1].value = "5F313230h"
    v_7[1].freeze = false
    gg.setValues(v_7)
    local v_8 = {}
    v_8[1] = {}
    v_8[1].address = val[1].address + 0x1C
    v_8[1].flags = gg.TYPE_DWORD
    v_8[1].value = "00000033h"
    v_8[1].freeze = false
    gg.setValues(v_8)

    hackSkin_1Dh("rExpe_2")
end
function hackBadg(varith)
    gg.toast("loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    -- Badge
    if varith == "a" then
        setd(-48, 0)
        setd(-44, 1)
        setd(-52, "112")
        setd(-56, "426107464")
        setd(-60, "25971")
        setd(-64, "1633836849")
        setd(-68, "811558247")
        setd(-72, "1684103706")
    elseif varith == "b" then
        setd(-48, 0)
        setd(-44, 1)
        setd(-52, "112")
        setd(-56, "426107464")
        setd(-60, "6581857")
        setd(-64, "1919377201")
        setd(-68, "811558247")
        setd(-72, "1684103708")
    elseif varith == "c" then
        setd(-48, 0)
        setd(-44, 1)
        setd(-52, "112")
        setd(-56, "426049637")
        setd(-60, "1935762015")
        setd(-64, "846618417")
        setd(-68, "811558247")
        setd(-72, "1684103712")
    elseif varith == "d" then
        setd(-48, 0)
        setd(-44, 1)
        setd(-52, "112")
        setd(-56, "419456110")
        setd(-60, "1634887519")
        setd(-64, "846618417")
        setd(-68, "811558247")
        setd(-72, "1684103714")
    elseif varith == "e" then
        setd(-48, 0)
        setd(-44, 1)
        setd(-52, "112")
        setd(-56, "426107464")
        setd(-60, "25971")
        setd(-64, "1633836850")
        setd(-68, "811558247")
        setd(-72, "1684103706")
    elseif varith == "f" then
        setd(-48, 0)
        setd(-44, 1)
        setd(-52, "112")
        setd(-56, "426107464")
        setd(-60, "6581857")
        setd(-64, "1919377202")
        setd(-68, "811558247")
        setd(-72, "1684103708")

    end
    gg.clearResults()
end

function hackSkin_1Fh(varcJExpe_2)
    ItemPass()
    gg.toast("Loading............ ")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address + 0x1C, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address + 0x20, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)

    local val_4 = {}
    val_4[1] = {address = r[1].address + 0x28, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address + 0x2C, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address + 0x30, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)

    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if varcJExpe_2 == "rExpe_2" then
        setd(-48, 0)
        setd(-44, 1)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, 31)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end
function hackSkin_1Eh(varcJExpe_2)
    ItemPass()
    gg.toast("Loading............ ")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address + 0x1C, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address + 0x20, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)

    local val_4 = {}
    val_4[1] = {address = r[1].address + 0x28, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address + 0x2C, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address + 0x30, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)

    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if varcJExpe_2 == "rExpe_2" then
        setd(-48, 0)
        setd(-44, 1)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, 30)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end
function hackSkin_1Dh(varcJExpe_2)
    ItemPass()
    gg.toast("Loading............ ")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address + 0x1C, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address + 0x20, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)

    local val_4 = {}
    val_4[1] = {address = r[1].address + 0x28, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address + 0x2C, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address + 0x30, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)

    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if varcJExpe_2 == "rExpe_2" then
        setd(-48, 0)
        setd(-44, 1)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, 29)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end
function hackSkin_1Ch(varcJExpe_2)
    ItemPass()
    gg.toast("Loading............ ")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address + 0x1C, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address + 0x20, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)

    local val_4 = {}
    val_4[1] = {address = r[1].address + 0x28, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address + 0x2C, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address + 0x30, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)

    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if varcJExpe_2 == "rExpe_2" then
        setd(-48, 0)
        setd(-44, 1)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, 28)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end
function hackSkin_1Bh(varcJExpe_2)
    ItemPass()
    gg.toast("Loading............ ")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address + 0x1C, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address + 0x20, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)

    local val_4 = {}
    val_4[1] = {address = r[1].address + 0x28, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address + 0x2C, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address + 0x30, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)

    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if varcJExpe_2 == "rExpe_2" then
        setd(-48, 0)
        setd(-44, 1)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, 27)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end
function hackSkin_1Ah(varcJExpe_2)
    ItemPass()
    gg.toast("Loading............ ")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address + 0x1C, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address + 0x20, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)

    local val_4 = {}
    val_4[1] = {address = r[1].address + 0x28, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address + 0x2C, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address + 0x30, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)

    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if varcJExpe_2 == "rExpe_2" then
        setd(-48, 0)
        setd(-44, 1)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, 26)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end
function hackSkin_19h(varcJExpe_2)
    ItemPass()
    gg.toast("Loading............ ")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address + 0x1C, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address + 0x20, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)

    local val_4 = {}
    val_4[1] = {address = r[1].address + 0x28, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address + 0x2C, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address + 0x30, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)

    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if varcJExpe_2 == "rExpe_2" then
        setd(-48, 0)
        setd(-44, 1)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, 25)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end
function hackSkin_18h(varcJExpe_2)
    ItemPass()
    gg.toast("Loading............ ")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address + 0x1C, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address + 0x20, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)

    local val_4 = {}
    val_4[1] = {address = r[1].address + 0x28, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address + 0x2C, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address + 0x30, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)

    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if varcJExpe_2 == "rExpe_2" then
        setd(-48, 0)
        setd(-44, 1)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, 24)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end
function hackSkin_17h(varcJExpe_2)
    ItemPass()
    gg.toast("Loading............ ")
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)
    local r = gg.getResults(1) -- load items
    local val_1 = {}
    val_1[1] = {address = r[1].address + 0x1C, flags = gg.TYPE_DWORD}
    val_1 = gg.getValues(val_1) -- refresh items values
    local val_2 = {}
    val_2[1] = {address = r[1].address + 0x20, flags = gg.TYPE_DWORD}
    val_2 = gg.getValues(val_2)

    local val_4 = {}
    val_4[1] = {address = r[1].address + 0x28, flags = gg.TYPE_DWORD}
    val_4 = gg.getValues(val_4)
    local val_5 = {}
    val_5[1] = {address = r[1].address + 0x2C, flags = gg.TYPE_DWORD}
    val_5 = gg.getValues(val_5)
    local val_6 = {}
    val_6[1] = {address = r[1].address + 0x30, flags = gg.TYPE_DWORD}
    val_6 = gg.getValues(val_6)

    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")
    if varcJExpe_2 == "rExpe_2" then
        setd(-48, 0)
        setd(-44, 1)
        setd(-52, val_6[1].value)
        setd(-56, val_5[1].value)
        setd(-60, val_4[1].value)
        setd(-64, 23)
        setd(-68, val_2[1].value)
        setd(-72, val_1[1].value)
    end
    gg.clearResults()
    return
end

---- HACK ITENS GOLDPASS
function hack(variacao)
    gg.toast("Loading...")
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("1599361808;1936025667;116;5;30", gg.TYPE_DWORD)
    gg.refineNumber("30", gg.TYPE_DWORD)
    setd(16, "0")
    setd(20, "0")
    setd(24, "0")
    setd(28, "0")
    setd(32, "0")
    setd(36, "0")

    -- Solicita quantidade apenas se necessário
    local int1 = nil
    if variacao == "lm2" or variacao == "lm02" or variacao == "lm002" or
        variacao == "lm3" or variacao == "lm4" or variacao == "lm5" or variacao ==
        "lm6" or variacao == "g" or variacao == "h" or variacao == "i" or
        variacao == "j" or variacao == "j2" or variacao == "k" or variacao ==
        "k2" or variacao == "l" or variacao == "l2" or variacao == "n" or
        variacao == "m" or variacao == "o" or variacao == "lg1" or variacao ==
        "lg2" or variacao == "lg3" or variacao == "lg4" then
        int1 = gg.prompt({"Amount? [0; 500]"}, {1}, {"number"})
        int1[1] = tonumber(int1[1])
    end

    if variacao == "a" then
        setd(-48, 0)
        setd(-44, 500)
        setd(-52, "0074726Fh")
        setd(-56, "70726941h")
        setd(-60, "6E696172h")
        setd(-64, "5464616Fh")
        setd(-68, "4C6E6F70h")
        setd(-72, "756F432Ch")
    elseif variacao == "b" then
        setd(-48, 0)
        setd(-44, 500)
        setd(-52, "0")
        setd(-56, "0")
        setd(-60, "00006E6Fh")
        setd(-64, "69736E61h")
        setd(-68, "70784565h")
        setd(-72, "6572661Ah")
    elseif variacao == "c" then
        setd(-48, 0)
        setd(-44, 500)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000063h")
        setd(-64, "6E497261h")
        setd(-68, "626D4165h")
        setd(-72, "65726618h")
    elseif variacao == "d" then
        setd(-48, 0)
        setd(-44, 500)
        setd(-52, "00000079h")
        setd(-56, "726F7463h")
        setd(-60, "61466564h")
        setd(-64, "61726770h")
        setd(-68, "556E6F70h")
        setd(-72, "756F4328h")
    elseif variacao == "e" then
        setd(-48, 0)
        setd(-44, 500)
        setd(-52, "1970225956")
        setd(-56, "7235937")
        setd(-60, "1918133604")
        setd(-64, "1634887536")
        setd(-68, "1433300848")
        setd(-72, "1970225956")
    elseif variacao == "f" then
        setd(-48, 0)
        setd(-44, 500)
        setd(-52, "0")
        setd(-56, "1684955500")
        setd(-60, "1934189924")
        setd(-64, "1634887536")
        setd(-68, "1433300848")
        setd(-72, "1970225958")
    elseif variacao == "mm" then
        setd(-48, 0)
        setd(-44, 500)
        setd(-52, "00000000h")
        setd(-56, "00000072h")
        setd(-60, "656C6165h")
        setd(-64, "44657269h")
        setd(-68, "486E6F70h")
        setd(-72, "756F4320h")
        ---- HACK MINA ITENS
    elseif variacao == "g" then
        setd(-48, 0)
        setd(-44, int1[1])
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00000000h")
        setd(-72, "00336D04h")
    elseif variacao == "h" then
        setd(-48, 0)
        setd(-44, int1[1])
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00000000h")
        setd(-72, "00326D04h")
    elseif variacao == "i" then
        setd(-48, 0)
        setd(-44, int1[1])
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00000000h")
        setd(-72, "00316D04h")
        ---- HACK CONSTRUÇÃO ITENS
    elseif variacao == "j" then
        setd(-48, 0)
        setd(-44, int1[1])
        setd(-52, "00000079h")
        setd(-56, "1BFDEA58h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00007373h")
        setd(-72, "616C470Ah")
    elseif variacao == "j2" then
        setd(-48, 0)
        setd(-44, int1[1])
        setd(-52, "00006500h")
        setd(-56, "6C616972h")
        setd(-60, "65006B63h")
        setd(-64, "00720077h")
        setd(-68, "61737265h")
        setd(-72, "776F7010h")
    elseif variacao == "k" then
        setd(-48, 0)
        setd(-44, int1[1])
        setd(-52, "00000078h")
        setd(-56, "722A8208h")
        setd(-60, "00000079h")
        setd(-64, "38DF4A98h")
        setd(-68, "00006B63h")
        setd(-72, "6972420Ah")
    elseif variacao == "k2" then
        setd(-48, 0)
        setd(-44, int1[1])
        setd(-52, "00006500h")
        setd(-56, "6C616972h")
        setd(-60, "65006B63h")
        setd(-64, "0072656Dh")
        setd(-68, "6D61686Bh")
        setd(-72, "63616A14h")
    elseif variacao == "l" then
        setd(-48, 0)
        setd(-44, int1[1])
        setd(-52, "00000079h")
        setd(-56, "23CA6A58h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00006174h")
        setd(-72, "696C500Ah")
    elseif variacao == "l2" then
        setd(-48, 0)
        setd(-44, int1[1])
        setd(-52, "00006500h")
        setd(-56, "6C616972h")
        setd(-60, "65006B63h")
        setd(-64, "00720077h")
        setd(-68, "61006C6Ch")
        setd(-72, "6972640Ah")
        ---- HACK GEMAS ITENS
    elseif variacao == "n" then
        setd(-48, 0)
        setd(-44, int1[1])
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00000031h")
        setd(-72, "6D656708h")
    elseif variacao == "m" then
        setd(-48, 0)
        setd(-44, int1[1])
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00000032h")
        setd(-72, "6D656708h")
    elseif variacao == "o" then
        setd(-48, 0)
        setd(-44, int1[1])
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00000033h")
        setd(-72, "6D656708h")
        ---- FICHAS LOJA REGATA
    elseif variacao == "p" then
        setd(-48, 0)
        setd(-44, 500)
        setd(-52, "0")
        setd(-56, "0")
        setd(-60, "0")
        setd(-64, "00687361h")
        setd(-68, "43617461h")
        setd(-72, "67655214h")
        ---- FICHAS LOJA REGATA
    elseif variacao == "q" then
        setd(-48, 0)
        setd(-44, 500)
        setd(-52, "0")
        setd(-56, "0")
        setd(-60, "0")
        setd(-64, "00687361h")
        setd(-68, "43617461h")
        setd(-72, "67655214h")
        ---- PLANTAÇÕES HACK
    elseif variacao == "x" then
        setd(-48, 0)
        setd(-44, 100)
        setd(-52, 7631717)
        setd(-56, 1987207496)
        setd(-60, 1884644453)
        setd(-64, 1701860212)
        setd(-68, 1936682818)
        setd(-72, 1599099692)
        ---- PLANTAÇÕES HACK
    elseif variacao == "z" then
        setd(-48, 0)
        setd(-44, 1)
        setd(-52, "0000313Ah")
        setd(-56, "522C353Ah")
        setd(-60, "552C3531h")
        setd(-64, "3A432C30h")
        setd(-68, "333A4E6Bh")
        setd(-72, "6365642Ah")
        ---- LINGOTES HACK
    elseif variacao == "lg1" then
        setd(-48, 0)
        setd(-44, int1[1])
        setd(-52, "00000072h")
        setd(-56, "65746E75h")
        setd(-60, "6F436E6Fh")
        setd(-64, "696C6C75h")
        setd(-68, "42657A6Eh")
        setd(-72, "6F724228h")
    elseif variacao == "lg2" then
        setd(-48, 0)
        setd(-44, int1[1])
        setd(-52, "00000072h")
        setd(-56, "65746E75h")
        setd(-60, "6F436E6Fh")
        setd(-64, "696C6C75h")
        setd(-68, "42726576h")
        setd(-72, "6C695328h")
    elseif variacao == "lg3" then
        setd(-48, 0)
        setd(-44, int1[1])
        setd(-52, "00000000h")
        setd(-56, "00726574h")
        setd(-60, "6E756F43h")
        setd(-64, "6E6F696Ch")
        setd(-68, "6C754264h")
        setd(-72, "6C6F4724h")
    elseif variacao == "lg4" then
        setd(-48, 0)
        setd(-44, int1[1])
        setd(-52, "7497076")
        setd(-56, "1853189955")
        setd(-60, "1852795244")
        setd(-64, "1819624045")
        setd(-68, "1970170228")
        setd(-72, "1634488364")
        ---- BOOSTER LAB HACK
    elseif variacao == "lb1" then
        setd(-48, 0)
        setd(-44, 80)
        setd(-52, "00000000h")
        setd(-56, "00007370h")
        setd(-60, "69685370h")
        setd(-64, "55646565h")
        setd(-68, "70537473h")
        setd(-72, "6F6F4222h")
    elseif variacao == "lb2" then
        setd(-48, 0)
        setd(-44, 80)
        setd(-52, "00000000h")
        setd(-56, "00736E69h")
        setd(-60, "61725470h")
        setd(-64, "55646565h")
        setd(-68, "70537473h")
        setd(-72, "6F6F4224h")
    elseif variacao == "lb3" then
        setd(-48, 0)
        setd(-44, 80)
        setd(-52, "0")
        setd(-56, "28007972h")
        setd(-60, "65746C65h")
        setd(-64, "6D53656Dh")
        setd(-68, "69547473h")
        setd(-72, "6F6F4222h")
    elseif variacao == "lb4" then
        setd(-48, 0)
        setd(-44, 80)
        setd(-52, "0")
        setd(-56, "0")
        setd(-60, "74656B72h")
        setd(-64, "614D656Dh")
        setd(-68, "69547473h")
        setd(-72, "6F6F421Eh")
    elseif variacao == "lb5" then
        setd(-48, 0)
        setd(-44, 80)
        setd(-52, "0")
        setd(-56, "283D0079h")
        setd(-60, "726F7463h")
        setd(-64, "6146656Dh")
        setd(-68, "69547473h")
        setd(-72, "6F6F4220h")
    elseif variacao == "lb6" then
        setd(-48, 0)
        setd(-44, 80)
        setd(-52, "0")
        setd(-56, "28007265h")
        setd(-60, "64724F70h")
        setd(-64, "55646565h")
        setd(-68, "70537473h")
        setd(-72, "6F6F4222h")
    elseif variacao == "lb7" then
        setd(-48, 0)
        setd(-44, 80)
        setd(-52, "0")
        setd(-56, "74736576h")
        setd(-60, "72614870h")
        setd(-64, "55646565h")
        setd(-68, "70537473h")
        setd(-72, "6F6F4226h")
    elseif variacao == "lb8" then
        setd(-48, 0)
        setd(-44, 80)
        setd(-52, "0")
        setd(-56, "74736576h")
        setd(-60, "72614874h")
        setd(-64, "6375646Fh")
        setd(-68, "72507473h")
        setd(-72, "6F6F4226h")
    elseif variacao == "lb9" then
        setd(-48, 0)
        setd(-44, 80)
        setd(-52, "0")
        setd(-56, "109")
        setd(-60, "1918977652")
        setd(-64, "1668637807")
        setd(-68, "1917875315")
        setd(-72, "1869562400")
    elseif variacao == "lb10" then
        setd(-48, 0)
        setd(-44, 80)
        setd(-52, "0")
        setd(-56, "0")
        setd(-60, "72656472h")
        setd(-64, "4F79656Eh")
        setd(-68, "6F4D7473h")
        setd(-72, "6F6F421Eh")
    elseif variacao == "lb11" then
        setd(-48, 0)
        setd(-44, 80)
        setd(-52, "0")
        setd(-56, "0")
        setd(-60, "00657461h")
        setd(-64, "6E6F4478h")
        setd(-68, "614D7473h")
        setd(-72, "6F6F421Ch")
    elseif variacao == "lb12" then
        setd(-48, 0)
        setd(-44, 80)
        setd(-52, "0")
        setd(-56, "0")
        setd(-60, "006F6F5Ah")
        setd(-64, "73747261h")
        setd(-68, "65487473h")
        setd(-72, "6F6F421Ch")
    elseif variacao == "lb13" then
        setd(-48, 0)
        setd(-44, 80)
        setd(-52, "0")
        setd(-56, "0079726Fh")
        setd(-60, "74636146h")
        setd(-64, "656C6275h")
        setd(-68, "6F447473h")
        setd(-72, "6F6F4224h")
    elseif variacao == "lb14" then
        setd(-48, 0)
        setd(-44, 80)
        setd(-52, "0")
        setd(-56, "2800736Eh")
        setd(-60, "696F4374h")
        setd(-64, "726F7072h")
        setd(-68, "69417473h")
        setd(-72, "6F6F4222h")
    elseif variacao == "lb15" then
        setd(-48, 0)
        setd(-44, 80)
        setd(-52, "00000074h")
        setd(-56, "73657571h")
        setd(-60, "6552706Ch")
        setd(-64, "65486E61h")
        setd(-68, "6C437473h")
        setd(-72, "6F6F4228h")
    elseif variacao == "lb16" then
        setd(-48, 0)
        setd(-44, 80)
        setd(-52, "73646E61h")
        setd(-56, "6C734979h")
        setd(-60, "74696C69h")
        setd(-64, "6261626Fh")
        setd(-68, "72507473h")
        setd(-72, "6F6F422Eh")
        ---- BOOSTER MINIGAME HACK
    elseif variacao == "lm1" then
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, "0")
        setd(-56, "1701669204")
        setd(-60, "1718511967")
        setd(-64, "1936029289")
        setd(-68, "1278437475")
        setd(-72, "1952533798")
    elseif variacao == "lm2" then
        setd(-48, 0)
        setd(-44, int1[1])
        setd(-52, "0")
        setd(-56, "0")
        setd(-60, "27756")
        setd(-64, "1631745903")
        setd(-68, "1651403105")
        setd(-72, "1379101978")
    elseif variacao == "lm02" then
        setd(-48, 0)
        setd(-44, int1[1])
        setd(-52, "0")
        setd(-56, "0")
        setd(-60, "0")
        setd(-64, "0")
        setd(-68, "00656E69h")
        setd(-72, "4C336D0Ch")
    elseif variacao == "lm002" then
        setd(-48, 0)
        setd(-44, int1[1])
        setd(-52, "0")
        setd(-56, "0")
        setd(-60, "0")
        setd(-64, "0")
        setd(-68, "6450543")
        setd(-72, "1110666508")
    elseif variacao == "lm3" then
        setd(-48, 0)
        setd(-44, int1[1])
        setd(-52, "0")
        setd(-56, "0")
        setd(-60, "7497069")
        setd(-64, "1835100261")
        setd(-68, "1734632812")
        setd(-72, "1395879196")
    elseif variacao == "lm4" then
        setd(-48, 0)
        setd(-44, int1[1])
        setd(-52, "0")
        setd(-56, "0")
        setd(-60, "0")
        setd(-64, "114")
        setd(-68, "1701670241")
        setd(-72, "1211329808")
    elseif variacao == "lm5" then
        setd(-48, 0)
        setd(-44, int1[1])
        setd(-52, "0")
        setd(-56, "0")
        setd(-60, "0")
        setd(-64, "0")
        setd(-68, "1702260588")
        setd(-72, "1194552590")
    elseif variacao == "lm6" then
        setd(-48, 0)
        setd(-44, int1[1])
        setd(-52, "0")
        setd(-56, "121")
        setd(-60, "1735550318")
        setd(-64, "1164865385")
        setd(-68, "1953064037")
        setd(-72, "1886938400")
    elseif variacao == "lm7" then
        setd(-48, 0)
        setd(-44, 864000)
        setd(-52, "0032586Ch")
        setd(-56, "6C416472h")
        setd(-60, "61776552h")
        setd(-64, "79746974h")
        setd(-68, "6E456465h")
        setd(-72, "6D69542Ch")
        ---- VANTAGEM HACK
    elseif variacao == "lv1" then
        setd(-48, 0)
        setd(-44, 5)
        setd(-52, "0")
        setd(-56, "29556")
        setd(-60, "1632464489")
        setd(-64, "1634882676")
        setd(-68, "1936682818")
        setd(-72, "1599099682")
    elseif variacao == "lv2" then
        setd(-48, 0)
        setd(-44, 1)
        setd(-52, "0")
        setd(-56, "00006D75h")
        setd(-60, "696D6572h")
        setd(-64, "50746F6Ch")
        setd(-68, "5362614Ch")
        setd(-72, "5F505322h")
    elseif variacao == "lv3" then
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "0")
        setd(-56, "7564905")
        setd(-60, "1866691173")
        setd(-64, "1685213044")
        setd(-68, "1936682818")
        setd(-72, "1599099684")
    elseif variacao == "lv4" then
        setd(-48, 0)
        setd(-44, 1)
        setd(-52, "0")
        setd(-56, "-1308229523")
        setd(-60, "1969843557")
        setd(-64, "1917875301")
        setd(-68, "1802658125")
        setd(-72, "1599099680")
    elseif variacao == "lv5" then
        setd(-48, 0)
        setd(-44, 1)
        setd(-52, "0")
        setd(-56, "-1308594827")
        setd(-60, "1768777074")
        setd(-64, "1349675329")
        setd(-68, "1684107084")
        setd(-72, "1599099682")
    elseif variacao == "lv6" then
        setd(-48, 0)
        setd(-44, 100)
        setd(-52, "0")
        setd(-56, "7498049")
        setd(-60, "1884644453")
        setd(-64, "1701860212")
        setd(-68, "1936682818")
        setd(-72, "1599099684")
    elseif variacao == "lv9" then
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "3299436")
        setd(-56, "1816224882")
        setd(-60, "1635214674")
        setd(-64, "2037672308")
        setd(-68, "1850041445")
        setd(-72, "1835619372")
    elseif variacao == "lv10" then
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "0")
        setd(-56, "0")
        setd(-60, "0")
        setd(-64, "0")
        setd(-68, "7497078")
        setd(-72, "1869374220")
    elseif variacao == "lv11" then
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "32767")
        setd(-56, "915593664")
        setd(-60, "114")
        setd(-64, "1701669204")
        setd(-68, "1885956947")
        setd(-72, "1599099672")
        -- Skin Castillo
    elseif variacao == "Cas_1" then -- Palacio en la isla Gatsb y3
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00003379h")
        setd(-56, "62737461h")
        setd(-60, "475F7373h")
        setd(-64, "65727472h")
        setd(-68, "6F465F6Eh")
        setd(-72, "696B532Ah")
    elseif variacao == "Cas_2" then -- mansion en la isla Gatsb y2
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00003279h")
        setd(-56, "62737461h")
        setd(-60, "475F7373h")
        setd(-64, "65727472h")
        setd(-68, "6F465F6Eh")
        setd(-72, "696B532Ah")
    elseif variacao == "Cas_3" then -- casa en la isla Gatsb y1
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00003179h")
        setd(-56, "62737461h")
        setd(-60, "475F7373h")
        setd(-64, "65727472h")
        setd(-68, "6F465F6Eh")
        setd(-72, "696B532Ah")
    elseif variacao == "Cas_4" then -- Fuerte pirata e3
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00003365h")
        setd(-56, "74617269h")
        setd(-60, "505F7373h")
        setd(-64, "65727472h")
        setd(-68, "6F465F6Eh")
        setd(-72, "696B532Ah")
    elseif variacao == "Cas_5" then -- base pirata e2
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00003265h")
        setd(-56, "74617269h")
        setd(-60, "505F7373h")
        setd(-64, "65727472h")
        setd(-68, "6F465F6Eh")
        setd(-72, "696B532Ah")
    elseif variacao == "Cas_6" then -- choza pirata e1
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00003165h")
        setd(-56, "74617269h")
        setd(-60, "505F7373h")
        setd(-64, "65727472h")
        setd(-68, "6F465F6Eh")
        setd(-72, "696B532Ah")
    elseif variacao == "Cas_7" then -- pueblo pascua
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000072h")
        setd(-56, "65747361h")
        setd(-60, "655F7373h")
        setd(-64, "65727472h")
        setd(-68, "6F465F6Eh")
        setd(-72, "696B5328h")
    elseif variacao == "Cas_8" then -- la pequeña paris
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "73697261h")
        setd(-60, "705F7373h")
        setd(-64, "65727472h")
        setd(-68, "6F465F6Eh")
        setd(-72, "696B5326h")
    elseif variacao == "Cas_9" then -- isla azteca
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000073h")
        setd(-56, "6365747Ah")
        setd(-60, "615F7373h")
        setd(-64, "65727472h")
        setd(-68, "6F465F6Eh")
        setd(-72, "696B5328h")

        -- 656D614Eh;6C797453h;65665F65h;76697473h;625F6C61h;00006769h
        -- Helicóptero
    elseif variacao == "heli_1" then -- helicleta
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00007472h")
        setd(-56, "6F70535Fh")
        setd(-60, "72657470h")
        setd(-64, "6F63696Ch")
        setd(-68, "65485F6Eh")
        setd(-72, "696B532Ah")
    elseif variacao == "heli_2" then -- robot repartidor
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "0000746Fh")
        setd(-56, "626F525Fh")
        setd(-60, "72657470h")
        setd(-64, "6F63696Ch")
        setd(-68, "65485F6Eh")
        setd(-72, "696B532Ah")
    elseif variacao == "heli_3" then -- trinero del ayudante de papa noel
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00686769h")
        setd(-56, "656C535Fh")
        setd(-60, "72657470h")
        setd(-64, "6F63696Ch")
        setd(-68, "65485F6Eh")
        setd(-72, "696B532Ch")
    elseif variacao == "heli_4" then -- platillo volante 
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "6F66555Fh")
        setd(-60, "72657470h")
        setd(-64, "6F63696Ch")
        setd(-68, "65485F6Eh")
        setd(-72, "696B5326h")
    elseif variacao == "heli_5" then -- alfombra voladora
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00636962h")
        setd(-56, "6172415Fh")
        setd(-60, "72657470h")
        setd(-64, "6F63696Ch")
        setd(-68, "65485F6Eh")
        setd(-72, "696B532Ch")
    elseif variacao == "heli_6" then -- dron tumbona
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "0074726Fh")
        setd(-56, "7365525Fh")
        setd(-60, "72657470h")
        setd(-64, "6F63696Ch")
        setd(-68, "65485F6Eh")
        setd(-72, "696B532Ch")
    elseif variacao == "heli_7" then -- barco volador
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "006C6576h")
        setd(-56, "6172545Fh")
        setd(-60, "72657470h")
        setd(-64, "6F63696Ch")
        setd(-68, "65485F6Eh")
        setd(-72, "696B532Ch")
    elseif variacao == "heli_8" then -- helicotero privado
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00796273h")
        setd(-56, "7461475Fh")
        setd(-60, "72657470h")
        setd(-64, "6F63696Ch")
        setd(-68, "65485F6Eh")
        setd(-72, "696B532Ch")
    elseif variacao == "heli_9" then -- helicoter discotequero
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00006F63h")
        setd(-56, "7369645Fh")
        setd(-60, "72657470h")
        setd(-64, "6F63696Ch")
        setd(-68, "65485F6Eh")
        setd(-72, "696B532Ah")
    elseif variacao == "heli_10" then -- helicoter emplumado
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "006C697Ah") -- 696B532Ch;65485F6Eh;6F63696Ch;72657470h;6172625Fh;006C697Ah helicoter emplumado heli_10
        setd(-56, "6172625Fh")
        setd(-60, "72657470h")
        setd(-64, "6F63696Ch")
        setd(-68, "65485F6Eh")
        setd(-72, "696B532Ch")
        -- Skin Tren
    elseif variacao == "Tre_1" then -- tren navideño
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000073h")
        setd(-56, "616D7473h")
        setd(-60, "69726863h")
        setd(-64, "5F6E6961h")
        setd(-68, "72545F6Eh")
        setd(-72, "696B5328h")
    elseif variacao == "Tre_2" then -- tren fantasma
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00355053h")
        setd(-64, "5F6E6961h")
        setd(-68, "72545F6Eh")
        setd(-72, "696B531Ch")
    elseif variacao == "Tre_3" then -- tren ultraexpreso
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "00000032h")
        setd(-60, "3A325053h")
        setd(-64, "5F6E6961h")
        setd(-68, "72545F6Eh")
        setd(-72, "696B5320h")
    elseif variacao == "Tre_4" then -- Tren Expreso primigenio
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00636972h")
        setd(-56, "6F747369h")
        setd(-60, "68657270h")
        setd(-64, "5F6E6961h")
        setd(-68, "72545F6Eh")
        setd(-72, "696B532Ch")
    elseif variacao == "Tre_5" then -- Tren Pascual expres
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "00007265h")
        setd(-60, "74736165h")
        setd(-64, "5F6E6961h")
        setd(-68, "72545F6Eh")
        setd(-72, "696B5322h")
    elseif variacao == "Tre_6" then -- Tren Teatro expres
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00006C61h")
        setd(-56, "63697274h")
        setd(-60, "61656874h")
        setd(-64, "5F6E6961h")
        setd(-68, "72545F6Eh")
        setd(-72, "696B532Ah")
    elseif variacao == "Tre_7" then -- Tren Dragon
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00323230h")
        setd(-56, "32594E72h")
        setd(-60, "616E756Ch")
        setd(-64, "5F6E6961h")
        setd(-68, "72545F6Eh")
        setd(-72, "696B532Ch")
    elseif variacao == "Tre_8" then -- Tren Astromovil
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "7372616Dh")
        setd(-64, "5F6E6961h")
        setd(-68, "72545F6Eh")
        setd(-72, "696B531Eh")
    elseif variacao == "Tre_9" then -- Tren Vagon de madera
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000064h")
        setd(-56, "6F6F486Eh")
        setd(-60, "69626F72h")
        setd(-64, "5F6E6961h")
        setd(-68, "72545F6Eh")
        setd(-72, "696B5328h")
    elseif variacao == "Tre_10" then -- Tren Musical
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "0000006Ch")
        setd(-56, "6C6F726Eh")
        setd(-60, "6B636F72h")
        setd(-64, "5F6E6961h")
        setd(-68, "72545F6Eh")
        setd(-72, "696B5328h")
    elseif variacao == "Tre_11" then -- Tren Caballeresco
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "00007468h")
        setd(-60, "67696E6Bh")
        setd(-64, "5F6E6961h")
        setd(-68, "72545F6Eh")
        setd(-72, "696B5322h")
    elseif variacao == "Tre_12" then -- Tren Tanvia expres
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000034h")
        setd(-56, "32303279h")
        setd(-60, "6C617469h")
        setd(-64, "5F6E6961h")
        setd(-68, "72545F6Eh")
        setd(-72, "696B5328h")
    elseif variacao == "Tre_13" then -- Tren Disco
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00385053h")
        setd(-64, "5F6E6961h")
        setd(-68, "72545F6Eh")
        setd(-72, "696B531Ch")
    elseif variacao == "Tre_14" then -- Tren Floral
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "6C617669h")
        setd(-60, "74736566h")
        setd(-64, "5F6E6961h")
        setd(-68, "72545F6Eh")
        setd(-72, "696B5326h")
        -- Estación de tren
    elseif variacao == "Esta_1" then -- Estacion portal expreso
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00003250h")
        setd(-56, "535F6E6Fh")
        setd(-60, "69746174h")
        setd(-64, "536E6961h")
        setd(-68, "72545F6Eh")
        setd(-72, "696B532Ah")
    elseif variacao == "Esta_2" then -- Estacion embrujada
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00003550h")
        setd(-56, "535F6E6Fh")
        setd(-60, "69746174h")
        setd(-64, "536E6961h")
        setd(-68, "72545F6Eh")
        setd(-72, "696B532Ah")
    elseif variacao == "Esta_3" then -- Estacion disco 
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00003850h")
        setd(-56, "535F6E6Fh")
        setd(-60, "69746174h")
        setd(-64, "536E6961h")
        setd(-68, "72545F6Eh")
        setd(-72, "696B532Ah")
    elseif variacao == "Esta_4" then -- Estacion espacial
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00737261h")
        setd(-56, "6D5F6E6Fh")
        setd(-60, "69746174h")
        setd(-64, "536E6961h")
        setd(-68, "72545F6Eh")
        setd(-72, "696B532Ch")
        -- Skin Avión
    elseif variacao == "Avio_1" then -- Avion Cohete
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "323A3350h")
        setd(-60, "535F656Eh")
        setd(-64, "616C7072h")
        setd(-68, "69415F6Eh")
        setd(-72, "696B5326h")
    elseif variacao == "Avio_2" then -- Avion Cohete Supercohete
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "00003350h")
        setd(-60, "535F656Eh")
        setd(-64, "616C7072h")
        setd(-68, "69415F6Eh")
        setd(-72, "696B5322h")
    elseif variacao == "Avio_3" then -- Avion Dragon Supersonico
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "323A3750h")
        setd(-60, "535F656Eh")
        setd(-64, "616C7072h")
        setd(-68, "69415F6Eh")
        setd(-72, "696B5326h")
    elseif variacao == "Avio_4" then -- Avion Cohete Espacial
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "65636170h")
        setd(-60, "735F656Eh")
        setd(-64, "616C7072h")
        setd(-68, "69415F6Eh")
        setd(-72, "696B5326h")
    elseif variacao == "Avio_5" then -- Avion Rockero
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "006B636Fh")
        setd(-60, "725F656Eh")
        setd(-64, "616C7072h")
        setd(-68, "69415F6Eh")
        setd(-72, "696B5324h")
    elseif variacao == "Avio_6" then -- Avion Aero Plano
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "6569766Fh")
        setd(-60, "6D5F656Eh")
        setd(-64, "616C7072h")
        setd(-68, "69415F6Eh")
        setd(-72, "696B5326h")
    elseif variacao == "Avio_7" then -- Avion Glaseado
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "74656577h")
        setd(-60, "735F656Eh")
        setd(-64, "616C7072h")
        setd(-68, "69415F6Eh")
        setd(-72, "696B5326h")
    elseif variacao == "Avio_8" then -- Avion de la Suerte
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "0000646Eh")
        setd(-56, "616C6572h")
        setd(-60, "695F656Eh")
        setd(-64, "616C7072h")
        setd(-68, "69415F6Eh")
        setd(-72, "696B532Ah")
    elseif variacao == "Avio_9" then -- Avion Arabigo
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "00626172h")
        setd(-60, "615F656Eh")
        setd(-64, "616C7072h")
        setd(-68, "69415F6Eh")
        setd(-72, "696B5324h")
    elseif variacao == "Avio_10" then -- Avion de Moda
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00006E6Fh")
        setd(-56, "69687361h")
        setd(-60, "665F656Eh")
        setd(-64, "616C7072h")
        setd(-68, "69415F6Eh")
        setd(-72, "696B532Ah")
    elseif variacao == "Avio_11" then -- Aeronave Sigilosa
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "00007970h")
        setd(-60, "735F656Eh")
        setd(-64, "616C7072h")
        setd(-68, "69415F6Eh")
        setd(-72, "696B5322h")

        -- Skin Aeropuerto
    elseif variacao == "Aero_1" then -- Aeropuerto Rockero
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "00006B63h")
        setd(-60, "6F725F74h")
        setd(-64, "726F7072h")
        setd(-68, "69415F6Eh")
        setd(-72, "696B5322h")
    elseif variacao == "Aero_2" then -- Aeropuerto Dulce
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "00746565h")
        setd(-60, "77735F74h")
        setd(-64, "726F7072h")
        setd(-68, "69415F6Eh")
        setd(-72, "696B5324h")
    elseif variacao == "Aero_3" then -- Aeropuerto Cine
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "00656976h")
        setd(-60, "6F6D5F74h")
        setd(-64, "726F7072h")
        setd(-68, "69415F6Eh")
        setd(-72, "696B5324h")
    elseif variacao == "Aero_4" then -- Base Secreta
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "00000079h")
        setd(-60, "70735F74h")
        setd(-64, "726F7072h")
        setd(-68, "69415F6Eh")
        setd(-72, "696B5320h")
    elseif variacao == "Aero_5" then -- Aeropuerto Aero
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "00000033h")
        setd(-60, "50535F74h")
        setd(-64, "726F7072h")
        setd(-68, "69415F6Eh")
        setd(-72, "696B5320h")
    elseif variacao == "Aero_6" then -- Aeropuerto Espacial
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "00656361h")
        setd(-60, "70735F74h")
        setd(-64, "726F7072h")
        setd(-68, "69415F6Eh")
        setd(-72, "696B5324h")
    elseif variacao == "Aero_7" then -- Aeropuerto Festival
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "00000037h")
        setd(-60, "50535F74h")
        setd(-64, "726F7072h")
        setd(-68, "69415F6Eh")
        setd(-72, "696B5320h")
    elseif variacao == "Aero_8" then -- Aeropuerto Tropical
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "00000039h")
        setd(-60, "50535F74h")
        setd(-64, "726F7072h")
        setd(-68, "69415F6Eh")
        setd(-72, "696B5320h")
    elseif variacao == "Aero_9" then -- Aeropuerto Arcoiris
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000064h")
        setd(-56, "6E616C65h")
        setd(-60, "72695F74h")
        setd(-64, "726F7072h")
        setd(-68, "69415F6Eh")
        setd(-72, "696B5328h")
        -- Skin Barcos
    elseif variacao == "Barc_1" then -- barco Crucero
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "00000065h")
        setd(-60, "6C676E75h")
        setd(-64, "6A5F7069h")
        setd(-68, "68535F6Eh")
        setd(-72, "696B5320h")
    elseif variacao == "Barc_2" then -- barco Birreme griego
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "00000073h")
        setd(-60, "616C6C65h")
        setd(-64, "685F7069h")
        setd(-68, "68535F6Eh")
        setd(-72, "696B5320h")
    elseif variacao == "Barc_3" then -- barco Vikingo
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "646F4763h")
        setd(-60, "6964726Fh")
        setd(-64, "6E5F7069h")
        setd(-68, "68535F6Eh")
        setd(-72, "696B5326h")
    elseif variacao == "Barc_4" then -- barco de Vapor
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00343230h")
        setd(-56, "32747365h")
        setd(-60, "77646C69h")
        setd(-64, "775F7069h")
        setd(-68, "68535F6Eh")
        setd(-72, "696B532Ch")
    elseif variacao == "Barc_5" then -- barco Artico
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "00000063h")
        setd(-60, "69746372h")
        setd(-64, "615F7069h")
        setd(-68, "68535F6Eh")
        setd(-72, "696B5320h")
        -- Skin Puertos
    elseif variacao == "Puer_1" then -- puerto Tropical
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "3950535Fh")
        setd(-64, "726F6272h")
        setd(-68, "61485F6Eh")
        setd(-72, "696B531Eh")
    elseif variacao == "Puer_2" then -- puerto Pirata
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "3154535Fh")
        setd(-64, "726F6272h")
        setd(-68, "61485F6Eh")
        setd(-72, "696B531Eh")
    elseif variacao == "Puer_3" then -- puerto Clásico
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "0073616Ch")
        setd(-60, "6C65685Fh")
        setd(-64, "726F6272h")
        setd(-68, "61485F6Eh")
        setd(-72, "696B5324h")
    elseif variacao == "Puer_4" then -- puerto Selvatico
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "00656C67h")
        setd(-60, "6E756A5Fh")
        setd(-64, "726F6272h")
        setd(-68, "61485F6Eh")
        setd(-72, "696B5324h")
    elseif variacao == "Puer_5" then -- puerto Vikingo
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "0000646Fh")
        setd(-56, "47636964h")
        setd(-60, "726F6E5Fh")
        setd(-64, "726F6272h")
        setd(-68, "61485F6Eh")
        setd(-72, "696B532Ah")
        -- Skin Gallinas
    elseif variacao == "Galli_1" then -- gallina Verbenera
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000035h")
        setd(-56, "32303279h")
        setd(-60, "6E635F6Eh")
        setd(-64, "656B6369h")
        setd(-68, "68435F6Eh")
        setd(-72, "696B5328h")
    elseif variacao == "Galli_2" then -- gallina Con quitón
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "73616C6Ch")
        setd(-60, "65685F6Eh")
        setd(-64, "656B6369h")
        setd(-68, "68435F6Eh")
        setd(-72, "696B5326h")
    elseif variacao == "Galli_3" then -- gallina Leprechaun
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000064h")
        setd(-56, "6E616C65h")
        setd(-60, "72695F6Eh")
        setd(-64, "656B6369h")
        setd(-68, "68435F6Eh")
        setd(-72, "696B5328h")
    elseif variacao == "Galli_4" then -- gallina Cumpleañera
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "00746565h")
        setd(-60, "77735F6Eh")
        setd(-64, "656B6369h")
        setd(-68, "68435F6Eh")
        setd(-72, "696B5324h")
    elseif variacao == "Galli_5" then -- gallina Aventurera
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "656C676Eh")
        setd(-60, "756A5F6Eh")
        setd(-64, "656B6369h")
        setd(-68, "68435F6Eh")
        setd(-72, "696B5326h")
    elseif variacao == "Galli_6" then -- gallina Animadora
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "0074726Fh")
        setd(-60, "70735F6Eh")
        setd(-64, "656B6369h")
        setd(-68, "68435F6Eh")
        setd(-72, "696B5324h")
    elseif variacao == "Galli_7" then -- gallina Piloto
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "6C657661h")
        setd(-60, "72745F6Eh")
        setd(-64, "656B6369h")
        setd(-68, "68435F6Eh")
        setd(-72, "696B5326h")
    elseif variacao == "Galli_8" then -- gallina Discotequera
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "006F6373h")
        setd(-60, "69645F6Eh")
        setd(-64, "656B6369h")
        setd(-68, "68435F6Eh")
        setd(-72, "696B5324h")
        -- Skin Vacas
    elseif variacao == "Vaca_1" then -- vaca Corsaria
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "34323032h")
        setd(-60, "65746172h")
        setd(-64, "69705F77h")
        setd(-68, "6F435F6Eh")
        setd(-72, "696B5326h")
    elseif variacao == "Vaca_2" then -- vaca Elegante
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "00343230h")
        setd(-60, "32796C61h")
        setd(-64, "74695F77h")
        setd(-68, "6F435F6Eh")
        setd(-72, "696B5324h")
    elseif variacao == "Vaca_3" then -- vaca Artica
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "63697463h")
        setd(-64, "72615F77h")
        setd(-68, "6F435F6Eh")
        setd(-72, "696B531Eh")
    elseif variacao == "Vaca_4" then -- vaca Verbenera
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00003432h")
        setd(-56, "30327961h")
        setd(-60, "64687472h")
        setd(-64, "69625F77h")
        setd(-68, "6F435F6Eh")
        setd(-72, "696B532Ah")
    elseif variacao == "Vaca_5" then -- vaca Reina de la Atlántida
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "00007369h")
        setd(-60, "746E616Ch")
        setd(-64, "74615F77h")
        setd(-68, "6F435F6Eh")
        setd(-72, "696B5322h")
    elseif variacao == "Vaca_6" then -- vaca Espía
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000079h")
        setd(-64, "70735F77h")
        setd(-68, "6F435F6Eh")
        setd(-72, "696B5318h")
    elseif variacao == "Vaca_7" then -- vaca Pascual
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "34323032h")
        setd(-60, "72657473h")
        setd(-64, "61655F77h")
        setd(-68, "6F435F6Eh")
        setd(-72, "696B5326h")
    elseif variacao == "Vaca_8" then -- vaca Astronauta
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00007372h")
        setd(-64, "616D5F77h")
        setd(-68, "6F435F6Eh")
        setd(-72, "696B531Ah")
    elseif variacao == "Vaca_9" then -- vaca Chupasangre
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00333230h")
        setd(-56, "326E6565h")
        setd(-60, "776F6C6Ch")
        setd(-64, "61685F77h")
        setd(-68, "6F435F6Eh")
        setd(-72, "696B532Ch")
    elseif variacao == "Vaca_10" then -- vaca Alpina
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000074h")
        setd(-56, "726F7053h")
        setd(-60, "7265746Eh")
        setd(-64, "69775F77h")
        setd(-68, "6F435F6Eh")
        setd(-72, "696B5328h")
        -- Skin Ovejas
    elseif variacao == "Ovej_1" then -- oveja Rockera
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "0000006Ch")
        setd(-56, "6C6F726Eh")
        setd(-60, "6B636F72h")
        setd(-64, "5F706565h")
        setd(-68, "68535F6Eh")
        setd(-72, "696B5328h")
    elseif variacao == "Ovej_2" then -- oveja Beeelica
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "00007468h")
        setd(-60, "67696E6Bh")
        setd(-64, "5F706565h")
        setd(-68, "68535F6Eh")
        setd(-72, "696B5322h")
    elseif variacao == "Ovej_3" then -- oveja Egipcia
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "00000074h")
        setd(-60, "70796765h")
        setd(-64, "5F706565h")
        setd(-68, "68535F6Eh")
        setd(-72, "696B5320h")
    elseif variacao == "Ovej_4" then -- oveja Carnavalera
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "00006C69h")
        setd(-60, "7A617262h")
        setd(-64, "5F706565h")
        setd(-68, "68535F6Eh")
        setd(-72, "696B5322h")
    elseif variacao == "Ovej_5" then -- oveja Bandida noble
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000064h")
        setd(-56, "6F6F486Eh")
        setd(-60, "69626F72h")
        setd(-64, "5F706565h")
        setd(-68, "68535F6Eh")
        setd(-72, "696B5328h")
    elseif variacao == "Ovej_6" then -- oveja Cumpleañera
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000000h")
        setd(-56, "00000074h")
        setd(-60, "65657773h")
        setd(-64, "5F706565h")
        setd(-68, "68535F6Eh")
        setd(-72, "696B5320h")
    elseif variacao == "Ovej_7" then -- oveja Investigadora
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000065h")
        setd(-56, "76697463h")
        setd(-60, "65746564h")
        setd(-64, "5F706565h")
        setd(-68, "68535F6Eh")
        setd(-72, "696B5328h")
    elseif variacao == "Ovej_8" then -- oveja Gladiador
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00000064h")
        setd(-56, "6F476369h")
        setd(-60, "64726F6Eh")
        setd(-64, "5F706565h")
        setd(-68, "68535F6Eh")
        setd(-72, "696B5328h")
    elseif variacao == "Ovej_9" then -- oveja De Pascua
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00003332h")
        setd(-56, "30327265h")
        setd(-60, "74736165h")
        setd(-64, "5F706565h")
        setd(-68, "68535F6Eh")
        setd(-72, "696B532Ah")
    elseif variacao == "Ovej_10" then -- oveja Festivalera
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00323230h")
        setd(-56, "32594E72h")
        setd(-60, "616E756Ch")
        setd(-64, "5F706565h")
        setd(-68, "68535F6Eh")
        setd(-72, "696B532Ch")
    elseif variacao == "Ovej_11" then -- oveja De Gala
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00006564h")
        setd(-56, "61726575h")
        setd(-60, "7173616Dh")
        setd(-64, "5F706565h")
        setd(-68, "68535F6Eh")
        setd(-72, "696B532Ah")
        -- Skin cerdo
    elseif variacao == "Cerdj_1" then -- Cerdo Ceremonial
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "00007E94h")
        setd(-56, "5A0643E0h")
        setd(-60, "00000059h")
        setd(-64, "4E435F67h")
        setd(-68, "69505F6Eh")
        setd(-72, "696B5318h")
    elseif variacao == "Cerdj_2" then -- Cerdo Ceremonial
        setd(-48, 0)
        setd(-44, 50)
        setd(-52, "0")
        setd(-56, "0")
        setd(-60, "7954756")
        setd(-64, "1936027241")
        setd(-68, "1635147623")
        setd(-72, "1766874990")
        -- Decoración Valentin  
        --------------------------
    elseif variacao == "r1p" then
        setd(-48, 0) -- test 1 Valentine_cats test 1 Estatua Amor Gatuno
        setd(-44, 5)
        setd(-52, "12") --
        setd(-56, "351650536") --
        setd(-60, "7566433") --
        setd(-64, "1667196270")
        setd(-68, "1769238117")
        setd(-72, "1818318364")
    elseif variacao == "r2p" then
        setd(-48, 0) -- test 2  Valentine_Teddy test 2 Osito Amoroso
        setd(-44, 5)
        setd(-52, "12914")
        setd(-56, "1634034271")
        setd(-60, "2036622437")
        setd(-64, "1415538030")
        setd(-68, "1769238117")
        setd(-72, "1818318378")
    elseif variacao == "r3p" then
        setd(-48, 0) -- test 3 Valentine_serenade test 3 Cita Romantica
        setd(-44, 5)
        setd(-52, "45")
        setd(-56, "6644833")
        setd(-60, "1852142181")
        setd(-64, "1935631726")
        setd(-68, "1769238117")
        setd(-72, "1818318372")
    elseif variacao == "r4p" then
        setd(-48, 0) -- test 4 Valentine_postsheep test 4 Estatua Mensajero Amor
        setd(-44, 5)
        setd(-52, "0")
        setd(-56, "1885693288")
        setd(-60, "1937011567")
        setd(-64, "1885300078")
        setd(-68, "1769238117")
        setd(-72, "1818318374")
    elseif variacao == "r5p" then
        setd(-48, 0) -- test 5 Valentine_justMarried Vivian los novios
        setd(-44, 5)
        setd(-52, "25701")
        setd(-56, "1769108065")
        setd(-60, "1299477365")
        setd(-64, "1784636782")
        setd(-68, "1769238117")
        setd(-72, "1818318378")
    elseif variacao == "r6p" then
        setd(-48, 0) -- test 6 Valentine_pigeons_love test 6 Palomas Enamoradas
        setd(-44, 5)
        setd(-52, "6649455")
        setd(-56, "1818194798")
        setd(-60, "1868916585")
        setd(-64, "1885300078")
        setd(-68, "1769238117")
        setd(-72, "1818318380")
    elseif variacao == "r7p" then
        setd(-48, 0) -- test 7 Valentine_flowerbeb test 7 Cama Floral Corazon
        setd(-44, 5)
        setd(-52, "0")
        setd(-56, "1684365938")
        setd(-60, "1702326124")
        setd(-64, "1717527918")
        setd(-68, "1769238117")
        setd(-72, "1818318374")
    elseif variacao == "r8p" then
        setd(-48, 0) -- test 8 Valentine_lovearch test 8 Arco Del Amor
        setd(-44, 5)
        setd(-52, "29")
        setd(-56, "6841202")
        setd(-60, "1634039407")
        setd(-64, "1818191214")
        setd(-68, "1769238117")
        setd(-72, "1818318372")
    elseif variacao == "r9p" then
        setd(-48, 0) -- test 9 Valentine_plush_cat test 9 Gatito Adorable
        setd(-44, 5)
        setd(-52, "0")
        setd(-56, "1952539487")
        setd(-60, "1752397164")
        setd(-64, "1885300078")
        setd(-68, "1769238117")
        setd(-72, "1818318374")
    elseif variacao == "r10p" then
        setd(-48, 0) -- test 10 Valentine_Bunny test 10 Conejo Peluche
        setd(-44, 5)
        setd(-52, "21")
        setd(-56, "350665152")
        setd(-60, "2037280373")
        setd(-64, "1113548142")
        setd(-68, "1769238117")
        setd(-72, "1818318366")
    elseif variacao == "r11p" then
        setd(-48, 0) -- test 11 Valentine_CupidsArrow test 11 Flecha De Cupido
        setd(-44, 5)
        setd(-52, "30575")
        setd(-56, "1920090483")
        setd(-60, "1684631669")
        setd(-64, "1130325358")
        setd(-68, "1769238117")
        setd(-72, "1818318378")
    elseif variacao == "r12p" then
        setd(-48, 0) -- test 12 Valentine_lovers_bench Banco de Enamorados
        setd(-44, 5)
        setd(-52, "6841198")
        setd(-56, "1700945779")
        setd(-60, "1919252079")
        setd(-64, "1818191214")
        setd(-68, "1769238117")
        setd(-72, "1818318380")
    elseif variacao == "r13p" then
        setd(-48, 0) -- test 13 Piloto Enamorados
        setd(-44, 5)
        setd(-52, "135")
        setd(-56, "352675424")
        setd(-60, "32564")
        setd(-64, "771781479")
        setd(-68, "1852397413")
        setd(-72, "1987013650")
    elseif variacao == "r14p" then
        setd(-48, 0) -- test 14 Corazones Voladores
        setd(-44, 5)
        setd(-52, "00790073h")
        setd(-56, "6E6F6F6Ch")
        setd(-60, "6C614265h")
        setd(-64, "6E69746Eh")
        setd(-68, "656C6156h")
        setd(-72, "796C6628h")
    elseif variacao == "r15p" then
        setd(-48, 0) -- test 15 El Ojo De Cupido
        setd(-44, 5)
        setd(-52, "00790073h")
        setd(-56, "6E006469h")
        setd(-60, "70754365h")
        setd(-64, "6E69746Eh")
        setd(-68, "656C6156h")
        setd(-72, "796C6622h")
    elseif variacao == "r1664p" then
        setd(-48, 0) -- test r1664p photocall paraja ideal
        setd(-44, 5)
        setd(-52, "00000065h")
        setd(-56, "6E69746Eh")
        setd(-60, "656C6176h")
        setd(-64, "5F646E61h")
        setd(-68, "74536F74h")
        setd(-72, "6F687028h")
    elseif variacao == "r1665p" then
        setd(-48, 0) -- test  Miniparque romantico   
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "656E6974h")
        setd(-60, "6E656C61h")
        setd(-64, "765F6565h")
        setd(-68, "72547472h")
        setd(-72, "61656826h")
    elseif variacao == "r1666p" then
        setd(-48, 0) -- test  carroza  
        setd(-44, 5)
        setd(-52, "00007472h")
        setd(-56, "61635F73h")
        setd(-60, "7265766Fh")
        setd(-64, "6C5F656Eh")
        setd(-68, "69746E65h")
        setd(-72, "6C61562Ah")
    elseif variacao == "r1667p" then
        setd(-48, 0) -- test  cespe nupcial  
        setd(-44, 5)
        setd(-52, "0000008Ch")
        setd(-56, "40F74300h")
        setd(-60, "726F6365h")
        setd(-64, "445F4433h")
        setd(-68, "676E6964h")
        setd(-72, "6465571Eh")
    elseif variacao == "r1668p" then
        setd(-48, 0) -- test    amor eterno
        setd(-44, 5)
        setd(-52, "0073646Eh")
        setd(-56, "61486E49h")
        setd(-60, "74726165h")
        setd(-64, "685F656Eh")
        setd(-68, "69746E65h")
        setd(-72, "6C61562Ch")
    elseif variacao == "r1669p" then
        setd(-48, 0) -- test    rosa de cuento
        setd(-44, 5)
        setd(-52, "00000031h")
        setd(-56, "0563F200h")
        setd(-60, "646F6F48h")
        setd(-64, "7265646Eh")
        setd(-68, "55726577h")
        setd(-72, "6F6C661Eh")
        -- Decoración Navideño
    elseif variacao == "r17p" then
        setd(-48, 0) -- test 17 Pista de Hielo
        setd(-44, 5)
        setd(-52, "26478")
        setd(-56, "1769234795")
        setd(-60, "1935631715")
        setd(-64, "1230992225")
        setd(-68, "1836348265")
        setd(-72, "1919435562")
    elseif variacao == "r18p" then
        setd(-48, 0) -- test 18 Carrusel Navideño
        setd(-44, 5)
        setd(-52, "0")
        setd(-56, "520121445")
        setd(-60, "1937076082")
        setd(-64, "1631810401")
        setd(-68, "1836348265")
        setd(-72, "1919435554")
    elseif variacao == "r20p" then
        setd(-48, 0) -- test 20 Farola Festiva
        setd(-44, 5)
        setd(-52, "2")
        setd(-56, "453013106")
        setd(-60, "1702129249")
        setd(-64, "1818194785")
        setd(-68, "1836348265")
        setd(-72, "1919435554")
    elseif variacao == "r21p" then
        setd(-48, 0) -- test 21 Grupo de amigos
        setd(-44, 5)
        setd(-52, "32564")
        setd(-56, "778156544")
        setd(-60, "1701733731")
        setd(-64, "1935635297")
        setd(-68, "1836348265")
        setd(-72, "1919435550")
    elseif variacao == "r22p" then
        setd(-48, 0) -- test 22 Mueño de Nieve
        setd(-44, 5)
        setd(-52, "8")
        setd(-56, "453013089")
        setd(-60, "1836543854")
        setd(-64, "1398764385")
        setd(-68, "1836348265")
        setd(-72, "1919435554")
    elseif variacao == "r23p" then
        setd(-48, 0) -- test 23 Angel de Hielo
        setd(-44, 5)
        setd(-52, "100")
        setd(-56, "459043840")
        setd(-60, "1818584942")
        setd(-64, "1633645409")
        setd(-68, "1836348265")
        setd(-72, "1919435550")
    elseif variacao == "r24p" then
        setd(-48, 0) -- test 24 Valla Navideña
        setd(-44, 5)
        setd(-52, "0")
        setd(-56, "0")
        setd(-60, "1701015141")
        setd(-64, "1717531489")
        setd(-68, "1836348265")
        setd(-72, "1919435550")
    elseif variacao == "r25p" then
        setd(-48, 0) -- test 25 Bola de Nieve Bola de Nieve
        setd(-44, 5)
        setd(-52, "22")
        setd(-56, "7105633")
        setd(-60, "1651994478")
        setd(-64, "1935635297")
        setd(-68, "1836348265")
        setd(-72, "1919443748")
    elseif variacao == "r20010p" then
        setd(-48, 0) -- test casita del lago  
        setd(-44, 5)
        setd(-52, "0000002Ch")
        setd(-56, "74006573h")
        setd(-60, "756F685Fh")
        setd(-64, "656B616Ch")
        setd(-68, "5F797475h")
        setd(-72, "61656222h")
    elseif variacao == "r20011p" then
        setd(-48, 0) -- test la casa de papa noel  
        setd(-44, 5)
        setd(-52, "00006573h")
        setd(-56, "756F485Fh")
        setd(-60, "61746E61h")
        setd(-64, "535F7361h")
        setd(-68, "6D747369h")
        setd(-72, "7268432Ah")
    elseif variacao == "r20012p" then
        setd(-48, 0) -- test tobogan de hielo  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "006E0065h")
        setd(-60, "64696C73h")
        setd(-64, "776F6E73h")
        setd(-68, "5F797475h")
        setd(-72, "61656220h")
    elseif variacao == "r20013p" then
        setd(-48, 0) -- test pista de trineo  
        setd(-44, 5)
        setd(-52, "00000032h")
        setd(-56, "74C466B8h")
        setd(-60, "00006563h")
        setd(-64, "61526867h")
        setd(-68, "69656C73h")
        setd(-72, "626F421Ah")
    elseif variacao == "r20014p" then
        setd(-48, 0) -- test perros de trineo  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00636974h")
        setd(-60, "6372615Fh")
        setd(-64, "73676F64h")
        setd(-68, "5F797475h")
        setd(-72, "61656224h")
    elseif variacao == "r20015p" then
        setd(-48, 0) -- test tiranosaurio congelado  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "006E0065h")
        setd(-60, "64696C73h")
        setd(-64, "776F006Fh")
        setd(-68, "6E69645Fh")
        setd(-72, "65636910h")
    elseif variacao == "r20016p" then
        setd(-48, 0) -- test estacion polar  
        setd(-44, 5)
        setd(-52, "00007700h")
        setd(-56, "6E6F6974h")
        setd(-60, "61745372h")
        setd(-64, "616C6F70h")
        setd(-68, "5F797475h")
        setd(-72, "61656226h")
    elseif variacao == "r20017p" then
        setd(-48, 0) -- test teleferico  
        setd(-44, 5)
        setd(-52, "00726163h")
        setd(-56, "656C6261h")
        setd(-60, "635F7265h")
        setd(-64, "6E6E7572h")
        setd(-68, "5F797475h")
        setd(-72, "6165622Ch")
    elseif variacao == "r20018p" then
        setd(-48, 0) -- test reno de hielo  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "9953F380h")
        setd(-60, "00726565h")
        setd(-64, "44656369h")
        setd(-68, "5F797475h")
        setd(-72, "6165621Ch")
    elseif variacao == "r20019p" then
        setd(-48, 0) -- test castillo de hielo  
        setd(-44, 5)
        setd(-52, "00726163h")
        setd(-56, "6500656Ch")
        setd(-60, "74736163h")
        setd(-64, "5F656369h")
        setd(-68, "5F797475h")
        setd(-72, "61656222h")
    elseif variacao == "r20020p" then
        setd(-48, 0) -- test globo de nieve  
        setd(-44, 5)
        setd(-52, "00007756h")
        setd(-56, "86148AA0h")
        setd(-60, "00000065h")
        setd(-64, "626F6C47h")
        setd(-68, "72616579h")
        setd(-72, "77654E18h")
    elseif variacao == "r20021p" then
        setd(-48, 0) -- test mamut congelado  
        setd(-44, 5)
        setd(-52, "00000066h")
        setd(-56, "74C56EE8h")
        setd(-60, "00336863h")
        setd(-64, "74616D5Fh")
        setd(-68, "68746F6Dh")
        setd(-72, "6D616D1Ch")
    elseif variacao == "r20022p" then
        setd(-48, 0) -- test buque rompehiela  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "99007265h")
        setd(-60, "6B616572h")
        setd(-64, "62656369h")
        setd(-68, "5F797475h")
        setd(-72, "61656222h")
    elseif variacao == "r20023p" then
        setd(-48, 0) -- test pinguilandia  
        setd(-44, 5)
        setd(-52, "00736E69h")
        setd(-56, "75676E65h")
        setd(-60, "50676E69h")
        setd(-64, "74616B73h")
        setd(-68, "5F797475h")
        setd(-72, "6165622Ch")
    elseif variacao == "r20024p" then
        setd(-48, 0) -- test glaciar artico  
        setd(-44, 5)
        setd(-52, "00006575h")
        setd(-56, "74617473h")
        setd(-60, "00677265h")
        setd(-64, "62656369h")
        setd(-68, "5F797475h")
        setd(-72, "6165621Ch")
    elseif variacao == "r20025p" then
        setd(-48, 0) -- test calcetin de navidad  
        setd(-44, 5)
        setd(-52, "00006B63h")
        setd(-56, "6F73746Eh")
        setd(-60, "65736572h")
        setd(-64, "705F7361h")
        setd(-68, "6D747369h")
        setd(-72, "7268432Ah")
    elseif variacao == "r20026p" then
        setd(-48, 0) -- test arbol de navidad  
        setd(-44, 5)
        setd(-52, "00000065h")
        setd(-56, "6572745Fh")
        setd(-60, "6E616272h")
        setd(-64, "555F7361h")
        setd(-68, "6D747369h")
        setd(-72, "72684328h")
    elseif variacao == "r20027p" then
        setd(-48, 0) -- test montaña de regalos  
        setd(-44, 5)
        setd(-52, "00000022h")
        setd(-56, "C2A6AC00h")
        setd(-60, "73746669h")
        setd(-64, "675F7361h")
        setd(-68, "6D747369h")
        setd(-72, "7268431Eh")
    elseif variacao == "r20028p" then
        setd(-48, 0) -- test dragon de hielo  
        setd(-44, 5)
        setd(-52, "00000020h")
        setd(-56, "C2A6AA30h")
        setd(-60, "0000769Ah")
        setd(-64, "EB006E6Fh")
        setd(-68, "67617244h")
        setd(-72, "65636912h")
    elseif variacao == "r20029p" then
        setd(-48, 0) -- test casa del elfo  
        setd(-44, 5)
        setd(-52, "00726570h")
        setd(-56, "6C65685Fh")
        setd(-60, "61746E61h")
        setd(-64, "735F7361h")
        setd(-68, "6D747369h")
        setd(-72, "7268632Ch")
    elseif variacao == "r20030p" then
        setd(-48, 0) -- test muñeco de nieve  
        setd(-44, 5)
        setd(-52, "00000008h")
        setd(-56, "C2006E61h")
        setd(-60, "6D776F6Eh")
        setd(-64, "535F7361h")
        setd(-68, "6D747369h")
        setd(-72, "72684322h")
    elseif variacao == "r20031p" then
        setd(-48, 0) -- test bola de navidad  
        setd(-44, 5)
        setd(-52, "00000055h")
        setd(-56, "C2A69080h")
        setd(-60, "00006C6Ch")
        setd(-64, "61427361h")
        setd(-68, "6D747369h")
        setd(-72, "7268431Ah")
    elseif variacao == "r20032p" then
        setd(-48, 0) -- test cartel reunion con papa noel  
        setd(-44, 5)
        setd(-52, "0000004Bh")
        setd(-56, "C2A6C800h")
        setd(-60, "72656E6Eh")
        setd(-64, "61427361h")
        setd(-68, "6D747369h")
        setd(-72, "7268431Eh")
    elseif variacao == "r20033p" then
        setd(-48, 0) -- test Deportes de invierno
        setd(-44, 5)
        setd(-52, "00000078h")
        setd(-56, "413282B8h")
        setd(-60, "00007DE3h")
        setd(-64, "66760070h")
        setd(-68, "6F68535Fh")
        setd(-72, "696B5310h")
    elseif variacao == "r20034p" then
        setd(-48, 0) -- test Taller de papa noel
        setd(-44, 5)
        setd(-52, "00000078h")
        setd(-56, "41325C08h")
        setd(-60, "00007DE3h")
        setd(-64, "00746669h")
        setd(-68, "475F7265h")
        setd(-72, "766F4314h")
    elseif variacao == "r20035p" then
        setd(-48, 0) -- test Tobogan de la oveja
        setd(-44, 5)
        setd(-52, "00000078h")
        setd(-56, "41328918h")
        setd(-60, "00007DE3h")
        setd(-64, "00656469h")
        setd(-68, "6C537065h")
        setd(-72, "65685314h")
    elseif variacao == "r20036p" then
        setd(-48, 0) -- test Yurta invernal
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "32323032h")
        setd(-60, "73616D78h")
        setd(-64, "5F747275h")
        setd(-68, "59726574h")
        setd(-72, "6E697726h")
    elseif variacao == "r20037p" then
        setd(-48, 0) -- test Ardillas patinadoras
        setd(-44, 5)
        setd(-52, "00323230h")
        setd(-56, "3273616Dh")
        setd(-60, "785F676Eh")
        setd(-64, "6974616Bh")
        setd(-68, "53657275h")
        setd(-72, "6769662Ch")

    elseif variacao == "r20038p" then
        setd(-48, 0) -- test  ;;;;; portal de hielo
        setd(-44, 5)
        setd(-52, "00000067h")
        setd(-56, "05651BC0h")
        setd(-60, "00636974h")
        setd(-64, "6372615Fh")
        setd(-68, "68637241h")
        setd(-72, "6563691Ch")
    elseif variacao == "r20039p" then
        setd(-48, 0) -- test  ;;;;; explorador polar
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "05652200h")
        setd(-60, "63697463h")
        setd(-64, "72615F6Eh")
        setd(-68, "616D7261h")
        setd(-72, "6C6F701Eh")
    elseif variacao == "r20040p" then
        setd(-48, 0) -- test  ;;;;; pozas termales
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "05650033h")
        setd(-60, "68637461h")
        setd(-64, "6D5F676Eh")
        setd(-68, "69727053h")
        setd(-72, "746F6820h")
    elseif variacao == "r20041p" then
        setd(-48, 0) -- test  ;;;;; castillo de hielo con tobogan
        setd(-44, 5)
        setd(-52, "0000005Ch")
        setd(-56, "05652E70h")
        setd(-60, "00000033h")
        setd(-64, "68637461h")
        setd(-68, "6D5F6564h")
        setd(-72, "696C7318h")
    elseif variacao == "r20042p" then
        setd(-48, 0) -- test  ;;;;; casita nevada
        setd(-44, 5)
        setd(-52, "00000069h")
        setd(-56, "05653600h")
        setd(-60, "676E696Dh")
        setd(-64, "6F437361h")
        setd(-68, "6D747369h")
        setd(-72, "7268631Eh")
    elseif variacao == "r20043p" then
        setd(-48, 0) -- test  ;;;;; el turbotrineo de papa noel
        setd(-44, 5)
        setd(-52, "0000006Eh")
        setd(-56, "05006174h")
        setd(-60, "6E61735Fh")
        setd(-64, "65676465h")
        setd(-68, "6C736F62h")
        setd(-72, "72757422h")
    elseif variacao == "r20044p" then
        setd(-48, 0) -- test  ;;;;; farolillos voladores
        setd(-44, 5)
        setd(-52, "00000084h")
        setd(-56, "05650061h")
        setd(-60, "746E6173h")
        setd(-64, "5F6E7265h")
        setd(-68, "746E614Ch")
        setd(-72, "796C6620h")

        -- Decoración Mas_1
    elseif variacao == "r14px" then
        setd(-48, 0) -- test 14  Paseo de la Fama
        setd(-44, 5)
        setd(-52, "120")
        setd(-56, "525400016")
        setd(-60, "32564")
        setd(-64, "771777901")
        setd(-68, "1632001900")
        setd(-72, "1818314770")
    elseif variacao == "r15px" then
        setd(-48, 0) -- test 15 Puente Veneciano
        setd(-44, 5)
        setd(-52, "0")
        setd(-56, "0")
        setd(-60, "25959")
        setd(-64, "1684632130")
        setd(-68, "1601139820")
        setd(-72, "1634292250")
    elseif variacao == "r16px" then
        setd(-48, 0) -- test 16 Estudio de Transformaciones
        setd(-44, 5)
        setd(-52, "140")
        setd(-56, "525336677")
        setd(-60, "1937076045")
        setd(-64, "2036429383")
        setd(-68, "1601073007")
        setd(-72, "1818317600")
        -- Decoración halloween
    elseif variacao == "r1ko" then
        setd(-48, 0) -- test  fuente ominosa  
        setd(-44, 5)
        setd(-52, "00007756h")
        setd(-56, "006E6961h")
        setd(-60, "746E756Fh")
        setd(-64, "665F6E65h")
        setd(-68, "65776F6Ch")
        setd(-72, "6C616824h")
    elseif variacao == "r2ko" then
        setd(-48, 0) -- test  gato negro  
        setd(-44, 5)
        setd(-52, "0000000Ah")
        setd(-56, "CBF32778h")
        setd(-60, "00007461h")
        setd(-64, "635F6E65h")
        setd(-68, "65776F6Ch")
        setd(-72, "6C61681Ah")
    elseif variacao == "r3ko" then
        setd(-48, 0) -- test  bruja con pocion  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "CBF32100h")
        setd(-60, "68637469h")
        setd(-64, "775F6E65h")
        setd(-68, "65776F6Ch")
        setd(-72, "6C61681Eh")
    elseif variacao == "r4ko" then
        setd(-48, 0) -- test  choza del brujo  
        setd(-44, 5)
        setd(-52, "0000008Ch")
        setd(-56, "CC05A470h")
        setd(-60, "00006573h")
        setd(-64, "756F485Fh")
        setd(-68, "6E696B70h")
        setd(-72, "6D75501Ah")
    elseif variacao == "r5ko" then
        setd(-48, 0) -- test  invernadero carnivoro  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "726F7461h")
        setd(-60, "64657250h")
        setd(-64, "5F657375h")
        setd(-68, "6F686E65h")
        setd(-72, "65724726h")
    elseif variacao == "r6ko" then
        setd(-48, 0) -- test  muñeco de calabaza  
        setd(-44, 5)
        setd(-52, "0000000Fh")
        setd(-56, "CBF324E8h")
        setd(-60, "00706D75h")
        setd(-64, "705F6E65h")
        setd(-68, "65776F6Ch")
        setd(-72, "6C61681Ch")
    elseif variacao == "r7ko" then
        setd(-48, 0) -- test  jinite calabezon  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "CC006E61h")
        setd(-60, "6D657372h")
        setd(-64, "6F485F73h")
        setd(-68, "73656C64h")
        setd(-72, "61654822h")
    elseif variacao == "r8ko" then
        setd(-48, 0) -- test  Carroza Fantasmal  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "65676169h")
        setd(-64, "72726143h")
        setd(-68, "796C7473h")
        setd(-72, "6F68671Eh")
    elseif variacao == "r9ko" then
        setd(-48, 0) -- test  torre gotica  
        setd(-44, 5)
        setd(-52, "0000008Ch")
        setd(-56, "CC05B1A0h")
        setd(-60, "00000072h")
        setd(-64, "65776F54h")
        setd(-68, "5F636968h")
        setd(-72, "746F4718h")
    elseif variacao == "r10ko" then
        setd(-48, 0) -- test  espectaculo del hombre lobo  
        setd(-44, 5)
        setd(-52, "0000008Ch")
        setd(-56, "CC059740h")
        setd(-60, "00666C6Fh")
        setd(-64, "77657265h")
        setd(-68, "575F6B6Eh")
        setd(-72, "616C501Ch")
    elseif variacao == "r11ko" then
        setd(-48, 0) -- test  Bruja en su escoba
        setd(-44, 1)
        setd(-52, "00006E65h")
        setd(-56, "65776F6Ch")
        setd(-60, "6C61685Fh")
        setd(-64, "65757461h")
        setd(-68, "74536863h")
        setd(-72, "7469572Ah")
        -- Decoración El primer
    elseif variacao == "r1pDx" then
        setd(-48, 0) -- test    El primer genetista 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "CC007473h")
        setd(-60, "69636974h")
        setd(-64, "656E6567h")
        setd(-68, "5F657574h")
        setd(-72, "61747322h")
    elseif variacao == "r2pDx" then
        setd(-48, 0) -- test El primer turista 
        setd(-44, 5)
        setd(-52, "00000078h")
        setd(-56, "CC610290h")
        setd(-60, "00747369h")
        setd(-64, "72756F74h")
        setd(-68, "5F657574h")
        setd(-72, "6174731Ch")
    elseif variacao == "r3pDx" then
        setd(-48, 0) -- test El primer pensador
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "CC6107B0h")
        setd(-60, "0072656Bh")
        setd(-64, "6E696874h")
        setd(-68, "5F657574h")
        setd(-72, "6174731Ch")
    elseif variacao == "r4pDx" then
        setd(-48, 0) -- test   El primer bombero
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "CC610A78h")
        setd(-60, "006E616Dh")
        setd(-64, "65726966h")
        setd(-68, "5F657574h")
        setd(-72, "6174731Ch")
    elseif variacao == "r5pDx" then
        setd(-48, 0) -- test   El primer comandante
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "CC610D08h")
        setd(-60, "006C6172h")
        setd(-64, "656E6567h")
        setd(-68, "5F657574h")
        setd(-72, "6174731Ch")
    elseif variacao == "r6pDx" then
        setd(-48, 0) -- test   El primer policia
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "CC61006Eh")
        setd(-60, "616D6563h")
        setd(-64, "696C6F70h")
        setd(-68, "5F657574h")
        setd(-72, "61747320h")
    elseif variacao == "r7pDx" then
        setd(-48, 0) -- test  El primer musico
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "CC6114F0h")
        setd(-60, "006E6163h")
        setd(-64, "6973756Dh")
        setd(-68, "5F657574h")
        setd(-72, "6174731Ch")
    elseif variacao == "r8pDx" then
        setd(-48, 0) -- test  El primer pintor
        setd(-44, 5)
        setd(-52, "00000064h")
        setd(-56, "CC611780h")
        setd(-60, "00007473h")
        setd(-64, "69747261h")
        setd(-68, "5F657574h")
        setd(-72, "6174731Ah")
    elseif variacao == "r9pDx" then
        setd(-48, 0) -- test   El primer futbolista
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "CC007265h")
        setd(-60, "6C6C6162h")
        setd(-64, "746F6F66h")
        setd(-68, "5F657574h")
        setd(-72, "61747322h")
    elseif variacao == "r10pDx" then
        setd(-48, 0) -- test  El primer cientifico
        setd(-44, 5)
        setd(-52, "00000064h")
        setd(-56, "006C6168h")
        setd(-60, "74726564h")
        setd(-64, "6E61656Eh")
        setd(-68, "5F657574h")
        setd(-72, "61747324h")
    elseif variacao == "r11pDx" then
        setd(-48, 0) -- test   El primer aeronautico
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "CC60F458h")
        setd(-60, "0000796Fh")
        setd(-64, "62796C66h")
        setd(-68, "5F657574h")
        setd(-72, "6174731Ah")

        -- Decoración Deportes
    elseif variacao == "r1TUTR" then
        setd(-48, 0) -- test    Campo de hockey
        setd(-44, 5)
        setd(-52, "00000017h")
        setd(-56, "0072656Eh")
        setd(-60, "6E75725Fh")
        setd(-64, "646C6569h")
        setd(-68, "4679656Bh")
        setd(-72, "636F6824h")
    elseif variacao == "r2TUTR" then
        setd(-48, 0) -- test    Campo de rugby
        setd(-44, 5)
        setd(-52, "0000006Ch")
        setd(-56, "0079726Fh")
        setd(-60, "74006D75h")
        setd(-64, "69646174h")
        setd(-68, "735F7962h")
        setd(-72, "6775721Ah")
    elseif variacao == "r3TUTR" then
        setd(-48, 0) -- test    Pista eterna
        setd(-44, 5)
        setd(-52, "00000055h")
        setd(-56, "74C40072h")
        setd(-60, "656E6E75h")
        setd(-64, "725F6472h")
        setd(-68, "616F6277h")
        setd(-72, "6F6E7320h")
    elseif variacao == "r4TUTR" then
        setd(-48, 0) -- test    Portero veterano
        setd(-44, 5)
        setd(-52, "00000050h")
        setd(-56, "74007265h")
        setd(-60, "7065656Bh")
        setd(-64, "6C616F47h")
        setd(-68, "5F797475h")
        setd(-72, "61656222h")
    elseif variacao == "r5TUTR" then
        setd(-48, 0) -- test    Skatepark
        setd(-44, 5)
        setd(-52, "00006563h")
        setd(-56, "616C5064h")
        setd(-60, "726F6265h")
        setd(-64, "74656B53h")
        setd(-68, "5F797475h")
        setd(-72, "6165622Ah")
    elseif variacao == "r6TUTR" then
        setd(-48, 0) -- test    Campeon del mundo
        setd(-44, 5)
        setd(-52, "00000050h")
        setd(-56, "00676F44h")
        setd(-60, "6C6C6162h")
        setd(-64, "746F6F46h")
        setd(-68, "5F797475h")
        setd(-72, "61656224h")
        -- Decoración Avion
    elseif variacao == "r1EWQT" then
        setd(-48, 0) -- test   Simulador de vuelo
        setd(-44, 5)
        setd(-52, "00656E61h")
        setd(-56, "6C705F72h")
        setd(-60, "6F74616Ch")
        setd(-64, "756D6973h")
        setd(-68, "5F797475h")
        setd(-72, "6165622Ch")
    elseif variacao == "r2EWQT" then
        setd(-48, 0) -- test   Avion a vapor
        setd(-44, 5)
        setd(-52, "0000724Dh")
        setd(-56, "006D6165h")
        setd(-60, "74735F65h")
        setd(-64, "6E616C70h")
        setd(-68, "5F797475h")
        setd(-72, "61656224h")
    elseif variacao == "r3EWQT" then
        setd(-48, 0) -- test   Biplano
        setd(-44, 5)
        setd(-52, "00006400h")
        setd(-56, "7265706Dh")
        setd(-60, "754A656Ch")
        setd(-64, "64647570h")
        setd(-68, "5F797475h")
        setd(-72, "61656226h")
    elseif variacao == "r4EWQT" then
        setd(-48, 0) -- test   Campeon volador
        setd(-44, 5)
        setd(-52, "00007600h")
        setd(-56, "64726177h")
        setd(-60, "65527466h")
        setd(-64, "61726372h")
        setd(-68, "6941656Eh")
        setd(-72, "616C7026h")
    elseif variacao == "r5EWQT" then
        setd(-48, 0) -- test   Globo galeon 
        setd(-44, 5)
        setd(-52, "00006400h")
        setd(-56, "72007069h")
        setd(-60, "6873676Eh")
        setd(-64, "69796C66h")
        setd(-68, "5F797475h")
        setd(-72, "61656222h")
        -- Decoración Golosinas
    elseif variacao == "r1YIUIS" then
        setd(-48, 0) -- test   Casa de golosinas
        setd(-44, 5)
        setd(-52, "00000073h")
        setd(-56, "00657375h")
        setd(-60, "6F685F79h")
        setd(-64, "646E6163h")
        setd(-68, "5F797475h")
        setd(-72, "61656224h")
    elseif variacao == "r2YIUIS" then
        setd(-48, 0) -- test   Montaña de caramelos
        setd(-44, 5)
        setd(-52, "0000724Dh")
        setd(-56, "79006C6Ch")
        setd(-60, "69685F74h")
        setd(-64, "65657773h")
        setd(-68, "5F797475h")
        setd(-72, "61656222h")
    elseif variacao == "r3YIUIS" then
        setd(-48, 0) -- test   Arbol de caramelos
        setd(-44, 5)
        setd(-52, "0000724Dh")
        setd(-56, "79006565h")
        setd(-60, "72745F79h")
        setd(-64, "646E6163h")
        setd(-68, "5F797475h")
        setd(-72, "61656222h")
    elseif variacao == "r2YIUIS" then
        setd(-48, 0) -- test    Puente caramelos
        setd(-44, 5)
        setd(-52, "00007200h")
        setd(-56, "65676469h")
        setd(-60, "72625F79h")
        setd(-64, "646E6163h")
        setd(-68, "5F797475h")
        setd(-72, "61656226h")
    elseif variacao == "r3YIUIS" then
        setd(-48, 0) -- test   Porton de mazapan	
        setd(-44, 5)
        setd(-52, "00007601h")
        setd(-56, "79473FE0h")
        setd(-60, "00000000h")
        setd(-64, "00657461h")
        setd(-68, "675F7964h")
        setd(-72, "6E616314h")
        -- Decoración Ruinas
    elseif variacao == "r1POYUT" then
        setd(-48, 0) -- test   Puerta de la ciudad perdida
        setd(-44, 5)
        setd(-52, "00000073h")
        setd(-56, "6D757264h")
        setd(-60, "5F746E65h")
        setd(-64, "69636E61h")
        setd(-68, "5F797475h")
        setd(-72, "61656228h")
    elseif variacao == "r2POYUT" then
        setd(-48, 0) -- test   Ruinas antiguas
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "6E776F74h")
        setd(-60, "5F746E65h")
        setd(-64, "69636E61h")
        setd(-68, "5F797475h")
        setd(-72, "61656226h")
    elseif variacao == "r3POYUT" then
        setd(-48, 0) -- test   Estatua ancestral
        setd(-44, 5)
        setd(-52, "00000073h")
        setd(-56, "6D65746Fh")
        setd(-60, "745F656Ch")
        setd(-64, "676E756Ah")
        setd(-68, "5F797475h")
        setd(-72, "61656228h")
    elseif variacao == "r4POYUT" then
        setd(-48, 0) -- test   Ciudad perdida
        setd(-44, 5)
        setd(-52, "00007700h")
        setd(-56, "736E6975h")
        setd(-60, "725F656Ch")
        setd(-64, "676E756Ah")
        setd(-68, "5F797475h")
        setd(-72, "61656226h")
    elseif variacao == "r5POYUT" then
        setd(-48, 0) -- test   Gorila feliz
        setd(-44, 5)
        setd(-52, "00007756h")
        setd(-56, "006B6E6Fh")
        setd(-60, "6D5F656Ch")
        setd(-64, "676E756Ah")
        setd(-68, "5F797475h")
        setd(-72, "61656224h")
    elseif variacao == "r6POYUT" then
        setd(-48, 0) -- test   Cueva selvatica
        setd(-44, 5)
        setd(-52, "0000656Ch")
        setd(-56, "676E756Ah")
        setd(-60, "5F6E695Fh")
        setd(-64, "65766163h")
        setd(-68, "5F797475h")
        setd(-72, "6165622Ah")
    elseif variacao == "r7POYUT" then
        setd(-48, 0) -- test   Calendario antiguo
        setd(-44, 5)
        setd(-52, "0000000Eh")
        setd(-56, "C2A6E170h")
        setd(-60, "00007261h")
        setd(-64, "646E656Ch")
        setd(-68, "61635F61h")
        setd(-72, "79616D1Ah")
        -- Decoración estatuas townshi
    elseif variacao == "r1WSFP" then
        setd(-48, 0) -- test  El discobolo
        setd(-44, 5)
        setd(-52, "0000746Eh")
        setd(-56, "6569636Eh")
        setd(-60, "615F7265h")
        setd(-64, "776F7268h")
        setd(-68, "54737563h")
        setd(-72, "7369642Ah")
    elseif variacao == "r2WSFP" then
        setd(-48, 0) -- test  Estatua de triunfo
        setd(-44, 5)
        setd(-52, "00007601h")
        setd(-56, "8C7E0064h")
        setd(-60, "6169706Dh")
        setd(-64, "796C6F5Fh")
        setd(-68, "776F4373h")
        setd(-72, "696B7320h")
    elseif variacao == "r3WSFP" then
        setd(-48, 0) -- test  Artistas entregados
        setd(-44, 5)
        setd(-52, "00007365h")
        setd(-56, "6275635Fh")
        setd(-60, "676E6972h")
        setd(-64, "6F6C6F63h")
        setd(-68, "5F797475h")
        setd(-72, "6165622Ah")
    elseif variacao == "r4WSFP" then
        setd(-48, 0) -- test  Los cinco magnificos
        setd(-44, 5)
        setd(-52, "00007756h")
        setd(-56, "00746E65h")
        setd(-60, "6D756E6Fh")
        setd(-64, "6D5F7935h")
        setd(-68, "5F797475h")
        setd(-72, "61656224h")
    elseif variacao == "r5WSFP" then
        setd(-48, 0) -- test  Chefs felices
        setd(-44, 5)
        setd(-52, "00000061h")
        setd(-56, "74736170h")
        setd(-60, "5F736C61h")
        setd(-64, "6D696E61h")
        setd(-68, "5F797475h")
        setd(-72, "61656228h")
    elseif variacao == "r6WSFP" then
        setd(-48, 0) -- test  Simbolo de año nuevo
        setd(-44, 5)
        setd(-52, "00007600h")
        setd(-56, "65757461h")
        setd(-60, "74536769h")
        setd(-64, "705F594Eh")
        setd(-68, "6573656Eh")
        setd(-72, "69684326h")
    elseif variacao == "r7WSFP" then
        setd(-48, 0) -- test  Tienda de souvernirs
        setd(-44, 5)
        setd(-52, "00000070h")
        setd(-56, "6F68735Fh")
        setd(-60, "72696E65h")
        setd(-64, "76756F73h")
        setd(-68, "5F797475h")
        setd(-72, "61656228h")
    elseif variacao == "r8WSFP" then
        setd(-48, 0) -- test  Maestro de las cometas
        setd(-44, 5)
        setd(-52, "00006574h")
        setd(-56, "694B6469h")
        setd(-60, "4B5F7974h")
        setd(-64, "75616542h")
        setd(-68, "6C616963h")
        setd(-72, "6570532Ah")
    elseif variacao == "r9WSFP" then
        setd(-48, 0) -- test   Artista callejera
        setd(-44, 5)
        setd(-52, "0000769Ah")
        setd(-56, "EBE1F591h")
        setd(-60, "0000769Ah")
        setd(-64, "F3007473h")
        setd(-68, "69747241h")
        setd(-72, "776F4312h")
    elseif variacao == "r10WSFP" then
        setd(-48, 0) -- test  artista la fruta
        setd(-44, 5)
        setd(-52, "00000058h")
        setd(-56, "05642CF8h")
        setd(-60, "00007000h")
        setd(-64, "6566696Eh")
        setd(-68, "6B5F616Ah")
        setd(-72, "6E696E16h")
    elseif variacao == "r11WSFP" then
        setd(-48, 0) -- test    beauty_3 // para townshi
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "6E6F6C6Ch")
        setd(-64, "61625F33h")
        setd(-68, "5F797475h")
        setd(-72, "6165621Eh")
    elseif variacao == "r12WSFP" then
        setd(-48, 0) -- test    beauty_3 // Atracción adrenalina
        setd(-44, 1)
        setd(-52, "0000008Dh")
        setd(-56, "EA9286E8h")
        setd(-60, "00006575h")
        setd(-64, "74617453h")
        setd(-68, "5F726577h")
        setd(-72, "6F6C461Ah")
    elseif variacao == "r13WSFP" then
        setd(-48, 0) -- test    beauty_3 //  Estatua de gran dirigente
        setd(-44, 1)
        setd(-52, "006E6F69h")
        setd(-56, "7461726Fh")
        setd(-60, "63654465h")
        setd(-64, "6E696E79h")
        setd(-68, "61646874h")
        setd(-72, "7269622Ch")
        -- Decoración Arbol
    elseif variacao == "r1BHSO" then
        setd(-48, 0) -- test    Jacaranda
        setd(-44, 5)
        setd(-52, "00007065h")
        setd(-56, "6C45796Ch")
        setd(-60, "665F7900h")
        setd(-64, "65006164h")
        setd(-68, "6E617261h")
        setd(-72, "6B616A12h")
    elseif variacao == "r2BHSO" then
        setd(-48, 0) -- test    Cactus
        setd(-44, 5)
        setd(-52, "00007065h")
        setd(-56, "6C45796Ch")
        setd(-60, "665F7900h")
        setd(-64, "6564696Ch")
        setd(-68, "00737574h")
        setd(-72, "6361630Ch")
    elseif variacao == "r3BHSO" then
        setd(-48, 0) -- test    Baobab
        setd(-44, 5)
        setd(-52, "00007065h")
        setd(-56, "6C45796Ch")
        setd(-60, "665F7900h")
        setd(-64, "6564696Ch")
        setd(-68, "00626162h")
        setd(-72, "6F61620Ch")
    elseif variacao == "r4BHSO" then
        setd(-48, 0) -- test    Palmera datilera
        setd(-44, 5)
        setd(-52, "00007400h")
        setd(-56, "65006D6Ch")
        setd(-60, "61705F63h")
        setd(-64, "696E6966h")
        setd(-68, "5F797475h")
        setd(-72, "61656222h")
    elseif variacao == "r5BHSO" then
        setd(-48, 0) -- test    Glicina
        setd(-44, 5)
        setd(-52, "00000061h")
        setd(-56, "00656C00h")
        setd(-60, "61697265h")
        setd(-64, "74736977h")
        setd(-68, "5F797475h")
        setd(-72, "6165621Eh")
    elseif variacao == "r6BHSO" then
        setd(-48, 0) -- test    Delonix regia
        setd(-44, 5)
        setd(-52, "00000061h")
        setd(-56, "00656C70h")
        setd(-60, "0078696Eh")
        setd(-64, "6F6C6564h")
        setd(-68, "5F797475h")
        setd(-72, "6165621Ch")
    elseif variacao == "r7BHSO" then
        setd(-48, 0) -- test    Araguaney
        setd(-44, 5)
        setd(-52, "00007372h")
        setd(-56, "65000079h")
        setd(-60, "656E6175h")
        setd(-64, "67617261h")
        setd(-68, "5F797475h")
        setd(-72, "61656220h")
    elseif variacao == "r8BHSO" then
        setd(-48, 0) -- test    Rododendro
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "6E6F7264h")
        setd(-60, "6E65646Fh")
        setd(-64, "646F6872h")
        setd(-68, "5F797475h")
        setd(-72, "61656226h")
    elseif variacao == "r9BHSO" then
        setd(-48, 0) -- test    Gladiolos
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "73756C6Fh")
        setd(-60, "6964616Ch")
        setd(-64, "675F6465h")
        setd(-68, "62726577h")
        setd(-72, "6F6C6626h")
    elseif variacao == "r10BHSO" then
        setd(-48, 0) -- test    Amapolas
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00007365h")
        setd(-60, "6970706Fh")
        setd(-64, "705F6465h")
        setd(-68, "62726577h")
        setd(-72, "6F6C6622h")
    elseif variacao == "r11BHSO" then
        setd(-48, 0) -- test    Campo de flores
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000065h")
        setd(-64, "67646568h")
        setd(-68, "5F726577h")
        setd(-72, "6F6C6618h")
        -- Decoración hinchable 
    elseif variacao == "r1VXCS" then
        setd(-48, 0) -- test   Pez hinchable
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "006E6F6Ch")
        setd(-60, "6C61625Fh")
        setd(-64, "68736966h")
        setd(-68, "5F797475h")
        setd(-72, "61656224h")
    elseif variacao == "r2VXCS" then
        setd(-48, 0) -- test   Cerdo hinchable
        setd(-44, 5)
        setd(-52, "00000067h")
        setd(-56, "6950796Ch")
        setd(-60, "665F7974h")
        setd(-64, "75616542h")
        setd(-68, "6C616963h")
        setd(-72, "65705328h")
    elseif variacao == "r3VXCS" then
        setd(-48, 0) -- test   Ballena hinchable
        setd(-44, 5)
        setd(-52, "00656C61h")
        setd(-56, "6857796Ch")
        setd(-60, "665F7974h")
        setd(-64, "75616542h")
        setd(-68, "6C616963h")
        setd(-72, "6570532Ch")
    elseif variacao == "r4VXCS" then
        setd(-48, 0) -- test   Vaca hinchable
        setd(-44, 5)
        setd(-52, "00000077h")
        setd(-56, "6F43796Ch")
        setd(-60, "665F7974h")
        setd(-64, "75616542h")
        setd(-68, "6C616963h")
        setd(-72, "65705328h")
    elseif variacao == "r5VXCS" then
        setd(-48, 0) -- test   Oveja hinchable
        setd(-44, 5)
        setd(-52, "00706565h")
        setd(-56, "6853796Ch")
        setd(-60, "665F7974h")
        setd(-64, "75616542h")
        setd(-68, "6C616963h")
        setd(-72, "6570532Ch")
    elseif variacao == "r6VXCS" then
        setd(-48, 0) -- test   Abeja hinchable
        setd(-44, 5)
        setd(-52, "00007400h")
        setd(-56, "6573756Fh")
        setd(-60, "685F7972h")
        setd(-64, "7578756Ch")
        setd(-68, "00656542h")
        setd(-72, "796C660Ch")
    elseif variacao == "r7VXCS" then
        setd(-48, 0) -- test   Dragon hinchable
        setd(-44, 5)
        setd(-52, "00007400h")
        setd(-56, "6573756Fh")
        setd(-60, "685F7972h")
        setd(-64, "75006E6Fh")
        setd(-68, "67617244h")
        setd(-72, "796C6612h")
    elseif variacao == "r8VXCS" then
        setd(-48, 0) -- test   Elefante hinchable
        setd(-44, 5)
        setd(-52, "00007065h")
        setd(-56, "6C45796Ch")
        setd(-60, "665F7974h")
        setd(-64, "75616542h")
        setd(-68, "6C616963h")
        setd(-72, "6570532Ah")
    elseif variacao == "r9VXCS" then
        setd(-48, 0) -- test   Panda hinchable
        setd(-44, 5)
        setd(-52, "00007065h")
        setd(-56, "6C45796Ch")
        setd(-60, "665F7900h")
        setd(-64, "65640061h")
        setd(-68, "646E6150h")
        setd(-72, "796C6610h")
    elseif variacao == "r10VXCS" then
        setd(-48, 0) -- test   Trampolin de mandibula de tiburon
        setd(-44, 5)
        setd(-52, "00007065h")
        setd(-56, "6C45796Ch")
        setd(-60, "665F7900h")
        setd(-64, "6564696Ch")
        setd(-68, "735F6B72h")
        setd(-72, "61687316h")
    elseif variacao == "r11VXCS" then
        setd(-48, 0) -- test   Trampolin de leon
        setd(-44, 5)
        setd(-52, "00007065h")
        setd(-56, "6C45796Ch")
        setd(-60, "66006500h")
        setd(-64, "73656469h")
        setd(-68, "6C735F6Eh")
        setd(-72, "6F696C16h")
    elseif variacao == "r12VXCS" then
        setd(-48, 0) -- test   Trampolin de zoo
        setd(-44, 5)
        setd(-52, "00007065h")
        setd(-56, "6C45796Ch")
        setd(-60, "6600656Ch")
        setd(-64, "74736163h")
        setd(-68, "5F6E6F6Fh")
        setd(-72, "6C61621Ah")
        -- Decoración Puzzle
    elseif variacao == "r1TPLKA" then
        setd(-48, 0) -- test    tierra de los dinosaurios
        setd(-44, 5)
        setd(-52, "0000006Ch")
        setd(-56, "61690065h")
        setd(-60, "6C74006Bh")
        setd(-64, "72615063h")
        setd(-68, "69737361h")
        setd(-72, "72754A18h")
    elseif variacao == "r2TPLKA" then
        setd(-48, 0) -- test    puerto espacial
        setd(-44, 5)
        setd(-52, "0000006Ch")
        setd(-56, "61690065h")
        setd(-60, "00616C00h")
        setd(-64, "74656B63h")
        setd(-68, "6F526563h")
        setd(-72, "61705316h")
    elseif variacao == "r3TPLKA" then
        setd(-48, 0) -- test    muñeco de nieve
        setd(-44, 5)
        setd(-52, "00007600h")
        setd(-56, "79656B6Eh")
        setd(-60, "6F6D5F77h")
        setd(-64, "6F6E7300h")
        setd(-68, "6E616D77h")
        setd(-72, "6F6E530Eh")
    elseif variacao == "r4TPLKA" then
        setd(-48, 0) -- test    tarta gigante
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "73736572h")
        setd(-60, "74726F66h")
        setd(-64, "006F0065h")
        setd(-68, "6B614361h")
        setd(-72, "67654D10h")
    elseif variacao == "r5TPLKA" then
        setd(-48, 0) -- test    colecion de coches clasicos
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "73736572h")
        setd(-60, "74726F66h")
        setd(-64, "006F7476h")
        setd(-68, "615F6F72h")
        setd(-72, "74657214h")

    elseif variacao == "r6TPLKA" then
        setd(-48, 0) -- test  hallowen2017 Escuela de magia
        setd(-44, 5)
        setd(-52, "00310072h")
        setd(-56, "00726F63h")
        setd(-60, "65443731h")
        setd(-64, "30326E65h")
        setd(-68, "65776F6Ch")
        setd(-72, "6C614824h")
    elseif variacao == "r7TPLKA" then
        setd(-48, 0) -- test    Árbol de luces
        setd(-44, 5)
        setd(-52, "00310072h")
        setd(-56, "0032316Eh")
        setd(-60, "6F006565h")
        setd(-64, "7254594Eh")
        setd(-68, "6573656Eh")
        setd(-72, "6968431Ah")
    elseif variacao == "r8TPLKA" then
        setd(-48, 0) -- test Barrio disco
        setd(-44, 5)
        setd(-52, "0")
        setd(-56, "0")
        setd(-60, "0")
        setd(-64, "0")
        setd(-68, "0")
        setd(-72, "0")
    elseif variacao == "r9TPLKA" then
        setd(-48, 0) -- test   Villaconejo
        setd(-44, 5)
        setd(-52, "00310072h")
        setd(-56, "00323100h")
        setd(-60, "726F6365h")
        setd(-64, "44373130h")
        setd(-68, "32726574h")
        setd(-72, "7361451Eh")
    elseif variacao == "r10TPLKA" then
        setd(-48, 0) -- test     Villa sobre agua
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "05630039h")
        setd(-60, "5053776Fh")
        setd(-64, "6C61676Eh")
        setd(-68, "75427265h")
        setd(-72, "74615720h")

        -- Decoración Diamantes
    elseif variacao == "r1LFGJZ" then
        setd(-48, 0) -- test    Catedral de san basilio
        setd(-44, 5)
        setd(-52, "2D956CC0h")
        setd(-56, "0000000Bh")
        setd(-60, "0000724Dh")
        setd(-64, "00687461h")
        setd(-68, "435F6C69h")
        setd(-72, "73614214h")
    elseif variacao == "r2LFGJZ" then
        setd(-48, 0) -- test    Castillo
        setd(-44, 5)
        setd(-52, "2D956CC0h")
        setd(-56, "0000000Bh")
        setd(-60, "0000724Dh")
        setd(-64, "8158B1DEh")
        setd(-68, "00656C74h")
        setd(-72, "7361630Ch")
    elseif variacao == "r3LFGJZ" then
        setd(-48, 0) -- test    Estatua de la libertad
        setd(-44, 5)
        setd(-52, "2D956CC0h")
        setd(-56, "0000000Bh")
        setd(-60, "0000724Dh")
        setd(-64, "0031765Fh")
        setd(-68, "6D6F6465h")
        setd(-72, "65726614h")
    elseif variacao == "r4LFGJZ" then
        setd(-48, 0) -- test    Crater
        setd(-44, 5)
        setd(-52, "2D956CC0h")
        setd(-56, "0000000Bh")
        setd(-60, "0000724Dh")
        setd(-64, "8158B1DEh")
        setd(-68, "00726574h")
        setd(-72, "6172630Ch")
    elseif variacao == "r5LFGJZ" then
        setd(-48, 0) -- test    Taj mahal
        setd(-44, 5)
        setd(-52, "2D956CC0h")
        setd(-56, "0000000Bh")
        setd(-60, "00007200h")
        setd(-64, "31765F6Ch")
        setd(-68, "6168616Dh")
        setd(-72, "6A617416h")
    elseif variacao == "r6LFGJZ" then
        setd(-48, 0) -- test    Torre de vigilancia
        setd(-44, 5)
        setd(-52, "2D956CC0h")
        setd(-56, "0000000Bh")
        setd(-60, "0000746Eh")
        setd(-64, "696F705Fh")
        setd(-68, "74756F6Bh")
        setd(-72, "6F6F6C1Ah")
    elseif variacao == "r7LFGJZ" then
        setd(-48, 0) -- test    Torres petronas
        setd(-44, 5)
        setd(-52, "2D956CC0h")
        setd(-56, "0000000Bh")
        setd(-60, "0000724Dh")
        setd(-64, "81580073h")
        setd(-68, "616E6F72h")
        setd(-72, "74657010h")
    elseif variacao == "r8LFGJZ" then
        setd(-48, 0) -- test    La torre de pizza
        setd(-44, 5)
        setd(-52, "2D956CC0h")
        setd(-56, "0000000Bh")
        setd(-60, "00006173h")
        setd(-64, "69505F66h")
        setd(-68, "6F5F7265h")
        setd(-72, "776F541Ah")
    elseif variacao == "r9LFGJZ" then
        setd(-48, 0) -- test    Templo del cielo
        setd(-44, 5)
        setd(-52, "0000724Dh")
        setd(-56, "AA00796Bh")
        setd(-60, "735F6568h")
        setd(-64, "745F666Fh")
        setd(-68, "5F656361h")
        setd(-72, "6C615022h")
    elseif variacao == "r10LFGJZ" then
        setd(-48, 0) -- test    Notre-dame de paris
        setd(-44, 5)
        setd(-52, "00007065h")
        setd(-56, "6C45796Ch")
        setd(-60, "66006500h")
        setd(-64, "00656D61h")
        setd(-68, "445F6572h")
        setd(-72, "746F4E14h")
    elseif variacao == "r11LFGJZ" then
        setd(-48, 0) -- test    Aguja espacial
        setd(-44, 5)
        setd(-52, "2D956CC0h")
        setd(-56, "0000000Bh")
        setd(-60, "0031765Fh")
        setd(-64, "656C6465h")
        setd(-68, "656E6563h")
        setd(-72, "6170731Ch")
    elseif variacao == "r12LFGJZ" then
        setd(-48, 0) -- test    Arcos marinos
        setd(-44, 5)
        setd(-52, "2D956CC0h")
        setd(-56, "0000000Bh")
        setd(-60, "0000724Dh")
        setd(-64, "81580065h")
        setd(-68, "7461675Fh")
        setd(-72, "61657310h")
    elseif variacao == "r13LFGJZ" then
        setd(-48, 0) -- test    Big ben
        setd(-44, 5)
        setd(-52, "2D956CC0h")
        setd(-56, "0000000Bh")
        setd(-60, "0000724Dh")
        setd(-64, "8158B100h")
        setd(-68, "6E61625Fh")
        setd(-72, "6769620Eh")
    elseif variacao == "r14LFGJZ" then
        setd(-48, 0) -- test    Puente golden gate
        setd(-44, 5)
        setd(-52, "2D956CC0h")
        setd(-56, "0000000Bh")
        setd(-60, "00007200h")
        setd(-64, "65746167h")
        setd(-68, "5F6E6564h")
        setd(-72, "6C6F6716h")
    elseif variacao == "r15LFGJZ" then
        setd(-48, 0) -- test    Templo tailandes
        setd(-44, 5)
        setd(-52, "0000724Dh")
        setd(-56, "00656C70h")
        setd(-60, "6D65745Fh")
        setd(-64, "69616874h")
        setd(-68, "5F797475h")
        setd(-72, "61656224h")
    elseif variacao == "r16LFGJZ" then
        setd(-48, 0) -- test    Burj khalifa
        setd(-44, 5)
        setd(-52, "00000061h")
        setd(-56, "66696C61h")
        setd(-60, "685F687Ah")
        setd(-64, "64727562h")
        setd(-68, "5F797475h")
        setd(-72, "61656228h")
    elseif variacao == "r17LFGJZ" then
        setd(-48, 0) -- test    Piramide
        setd(-44, 5)
        setd(-52, "2D956CC0h")
        setd(-56, "0000000Bh")
        setd(-60, "0000724Dh")
        setd(-64, "81580065h")
        setd(-68, "64696D61h")
        setd(-72, "72797010h")
    elseif variacao == "r18LFGJZ" then
        setd(-48, 0) -- test    Yate
        setd(-44, 5)
        setd(-52, "2D956CC0h")
        setd(-56, "0000000Bh")
        setd(-60, "0000724Dh")
        setd(-64, "81006E69h")
        setd(-68, "665F7468h")
        setd(-72, "63617912h")
    elseif variacao == "r19LFGJZ" then
        setd(-48, 0) -- test    Empire state building
        setd(-44, 5)
        setd(-52, "2D956CC0h")
        setd(-56, "00000000h")
        setd(-60, "31765F65h")
        setd(-64, "74617473h")
        setd(-68, "5F657269h")
        setd(-72, "706D651Eh")
    elseif variacao == "r20LFGJZ" then
        setd(-48, 0) -- test    Barco antiguo
        setd(-44, 5)
        setd(-52, "00007601h")
        setd(-56, "00326400h")
        setd(-60, "74616F62h")
        setd(-64, "6C696173h")
        setd(-68, "5F797475h")
        setd(-72, "6165621Eh")
    elseif variacao == "r21LFGJZ" then
        setd(-48, 0) -- test    Torre Eiffel
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "CBB17B60h")
        setd(-60, "00007600h")
        setd(-64, "7265776Fh")
        setd(-68, "745F6C65h")
        setd(-72, "66696516h")
    elseif variacao == "r22LFGJZ" then
        setd(-48, 0) -- test    Aguja espacial
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "CBB1D8F0h")
        setd(-60, "0031765Fh")
        setd(-64, "656C6465h")
        setd(-68, "656E6563h")
        setd(-72, "6170731Ch")
    elseif variacao == "r23LFGJZ" then
        setd(-48, 0) -- test    Bandera
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "CBF27020h")
        setd(-60, "0000769Ah")
        setd(-64, "EC0A2591h")
        setd(-68, "00000067h")
        setd(-72, "616C6608h")
    elseif variacao == "r24LFGJZ" then
        setd(-48, 0) -- test    Opera de sidney
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "CBF30E28h")
        setd(-60, "00000061h")
        setd(-64, "7265706Fh")
        setd(-68, "5F79656Eh")
        setd(-72, "64797318h")
    elseif variacao == "r25LFGJZ" then
        setd(-48, 0) -- test    Arco del triunfo
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "CBF2DEA8h")
        setd(-60, "0000769Ah")
        setd(-64, "EC003574h")
        setd(-68, "6E656D75h")
        setd(-72, "6E6F6D12h")
        -- Decoración China
    elseif variacao == "r1CHIMN" then
        setd(-48, 0) -- test  chinatown
        setd(-44, 5)
        setd(-52, "00726163h")
        setd(-56, "65006E77h")
        setd(-60, "6F745F61h")
        setd(-64, "6E696863h")
        setd(-68, "5F797475h")
        setd(-72, "61656222h")
    elseif variacao == "r2CHIMN" then
        setd(-48, 0) -- test  Danza del dragon
        setd(-44, 5)
        setd(-52, "00007700h")
        setd(-56, "65636E61h")
        setd(-60, "645F6E6Fh")
        setd(-64, "67617264h")
        setd(-68, "5F797475h")
        setd(-72, "61656226h")
        -- Decoración Eventos
    elseif variacao == "r1LFG" then
        setd(-48, 0) -- test   ;;;;; Casa de la florista
        setd(-44, 5)
        setd(-52, "00000055h")
        setd(-56, "056409F0h")
        setd(-60, "00000065h")
        setd(-64, "73756F68h")
        setd(-68, "5F726577h")
        setd(-72, "6F6C6618h")
    elseif variacao == "r2LFG" then
        setd(-48, 0) -- test   ;;;;; Casa del terror
        setd(-44, 5)
        setd(-52, "0000005Ah")
        setd(-56, "05006E65h")
        setd(-60, "65776F6Ch")
        setd(-64, "6C61685Fh")
        setd(-68, "7265626Dh")
        setd(-72, "61686322h")
    elseif variacao == "r3LFG" then
        setd(-48, 0) -- test   ;;;;; Exposicion de arte
        setd(-44, 5)
        setd(-52, "00000064h")
        setd(-56, "05644598h")
        setd(-60, "00007000h")
        setd(-64, "7472615Fh")
        setd(-68, "7972656Ch")
        setd(-72, "6C616716h")
    elseif variacao == "r4LFG" then
        setd(-48, 0) -- test   ;;;;; Mercado agricola
        setd(-44, 5)
        setd(-52, "00000022h")
        setd(-56, "0564D508h")
        setd(-60, "00007000h")
        setd(-64, "65756373h")
        setd(-68, "65725F72h")
        setd(-72, "69616616h")
    elseif variacao == "r5LFG" then
        setd(-48, 0) -- test   ;;;;; Escuela de jardineria
        setd(-44, 5)
        setd(-52, "0000002Ch")
        setd(-56, "05640400h")
        setd(-60, "7372656Eh")
        setd(-64, "65647261h")
        setd(-68, "675F676Eh")
        setd(-72, "756F791Eh")
    elseif variacao == "r6LFG" then
        setd(-48, 0) -- test   ;;;;; Minizoo de conejos
        setd(-44, 5)
        setd(-52, "0000000Fh")
        setd(-56, "05006575h")
        setd(-60, "63736572h")
        setd(-64, "5F6F6F5Ah")
        setd(-68, "74636174h")
        setd(-72, "6E6F6322h")
    elseif variacao == "r7LFG" then
        setd(-48, 0) -- test   ;;;;; Estanque de los nenufares rojos
        setd(-44, 5)
        setd(-52, "0000006Dh")
        setd(-56, "05655988h")
        setd(-60, "0000646Eh")
        setd(-64, "6F507365h")
        setd(-68, "696C694Ch")
        setd(-72, "6465721Ah")
    elseif variacao == "r8LFG" then
        setd(-48, 0) -- test   ;;;;; Rata con saco de monedas
        setd(-44, 5)
        setd(-52, "00000064h")
        setd(-56, "05655FE8h")
        setd(-60, "00706D75h")
        setd(-64, "6A5F6E65h")
        setd(-68, "64726147h")
        setd(-72, "7461721Ch")
    elseif variacao == "r9LFG" then
        setd(-48, 0) -- test   ;;;;; Casa del acuarista
        setd(-44, 5)
        setd(-52, "0000676Eh")
        setd(-56, "69687369h")
        setd(-60, "665F6573h")
        setd(-64, "756F486Dh")
        setd(-68, "75697261h")
        setd(-72, "7571612Ah")
    elseif variacao == "r10LFG" then
        setd(-48, 0) -- test   ;;;;; Cocina de campamento
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "05644C30h")
        setd(-60, "00006B6Eh")
        setd(-64, "616C705Fh")
        setd(-68, "6E656863h")
        setd(-72, "74696B1Ah")
    elseif variacao == "r11LFG" then
        setd(-48, 0) -- test   ;;;;; Tribu fructifera
        setd(-44, 5)
        setd(-52, "00000068h")
        setd(-56, "05659048h")
        setd(-60, "00656C67h")
        setd(-64, "6E756A5Fh")
        setd(-68, "6567616Ch")
        setd(-72, "6C69761Ch")
    elseif variacao == "r12LFG" then
        setd(-48, 0) -- test   ;;;;; Prueba experimental de jet pack
        setd(-44, 5)
        setd(-52, "0000006Bh")
        setd(-56, "05659EF0h")
        setd(-60, "0000656Eh")
        setd(-64, "616C705Fh")
        setd(-68, "6B636170h")
        setd(-72, "74656A1Ah")
    elseif variacao == "r13LFG" then
        setd(-48, 0) -- test   ;;;;; Pueblo la fruta
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "05659600h")
        setd(-60, "6566696Eh")
        setd(-64, "6B5F6B72h")
        setd(-68, "61507469h")
        setd(-72, "7572661Eh")
    elseif variacao == "r14LFG" then
        setd(-48, 0) -- test   ;;;;; Coches tuneados
        setd(-44, 5)
        setd(-52, "0000676Eh")
        setd(-56, "69000065h")
        setd(-60, "75637365h")
        setd(-64, "725F7372h")
        setd(-68, "65646972h")
        setd(-72, "776F6C20h")
    elseif variacao == "r15LFG" then
        setd(-48, 0) -- test   ;;;;; Cine al aire libre
        setd(-44, 5)
        setd(-52, "0000706Fh")
        setd(-56, "6873656Bh")
        setd(-60, "61635F61h")
        setd(-64, "6D656E69h")
        setd(-68, "43746565h")
        setd(-72, "7274732Ah")
    elseif variacao == "r16LFG" then
        setd(-48, 0) -- test   ;;;;; Exposicion altlantida
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "05657C00h")
        setd(-60, "7369746Eh")
        setd(-64, "616C7461h")
        setd(-68, "5F6D7565h")
        setd(-72, "73756D1Eh")
    elseif variacao == "r17LFG" then
        setd(-48, 0) -- test   ;;;;; Parque de golosinas
        setd(-44, 5)
        setd(-52, "0000005Ch")
        setd(-56, "05651560h")
        setd(-60, "00007000h")
        setd(-64, "65636E75h")
        setd(-68, "6F42796Ch")
        setd(-72, "6C656A16h")
    elseif variacao == "r18LFG" then
        setd(-48, 0) -- test   ;;;;; Castillo de golosinas
        setd(-44, 5)
        setd(-52, "0000005Ch")
        setd(-56, "05007869h")
        setd(-60, "6C65685Fh")
        setd(-64, "656C7473h")
        setd(-68, "61437964h")
        setd(-72, "6E616322h")
    elseif variacao == "r19LFG" then
        setd(-48, 0) -- test   ;;;;; Centro de musica
        setd(-44, 5)
        setd(-52, "0000004Ch")
        setd(-56, "00636973h")
        setd(-60, "756D5F72h")
        setd(-64, "65747261h")
        setd(-68, "75516369h")
        setd(-72, "73756D24h")
    elseif variacao == "r20LFG" then
        setd(-48, 0) -- test   ;;;;; Campamento pirata 
        setd(-44, 5)
        setd(-52, "00730073h")
        setd(-56, "65746172h")
        setd(-60, "69705F79h")
        setd(-64, "74726170h")
        setd(-68, "5F797475h")
        setd(-72, "61656228h")
    elseif variacao == "r21LFG" then
        setd(-48, 0) -- test   ;;;;; Yeti 
        setd(-44, 5)
        setd(-52, "0073746Ch")
        setd(-56, "6974735Fh")
        setd(-60, "73746100h")
        setd(-64, "69746579h")
        setd(-68, "5F797475h")
        setd(-72, "61656216h")
    elseif variacao == "r22LFG" then
        setd(-48, 0) -- test  ;;;;; Ovni detectado  
        setd(-44, 5)
        setd(-52, "0073746Ch")
        setd(-56, "6974735Fh")
        setd(-60, "73746162h")
        setd(-64, "006F6675h")
        setd(-68, "5F797475h")
        setd(-72, "61656214h")
    elseif variacao == "r23LFG" then
        setd(-48, 0) -- test   ;;;;; Poza madre la naturaleza
        setd(-44, 5)
        setd(-52, "0000006Eh")
        setd(-56, "05006874h")
        setd(-60, "7261655Fh")
        setd(-64, "72656874h")
        setd(-68, "6F6D5F64h")
        setd(-72, "6E6F7022h")
    elseif variacao == "r24LFG" then
        setd(-48, 0) -- test   ;;;;; Ciudad hundida
        setd(-44, 5)
        setd(-52, "00000073h")
        setd(-56, "69746E61h")
        setd(-60, "6C74615Fh")
        setd(-64, "79676F6Ch")
        setd(-68, "6F656168h")
        setd(-72, "63726128h")
    elseif variacao == "r25LFG" then
        setd(-48, 0) -- test   ;;;;; Estacion marina
        setd(-44, 5)
        setd(-52, "00000076h")
        setd(-56, "05654A00h")
        setd(-60, "65766964h")
        setd(-64, "5F6E6F69h")
        setd(-68, "74617453h")
        setd(-72, "6165731Eh")
    elseif variacao == "r26LFG" then
        setd(-48, 0) -- test   ;;;;; Hotel atlantida 
        setd(-44, 5)
        setd(-52, "00006C65h")
        setd(-56, "746F685Fh")
        setd(-60, "7369746Eh")
        setd(-64, "616C7461h")
        setd(-68, "5F797475h")
        setd(-72, "6165622Ah")
        -- Decoración Niños
    elseif variacao == "r1MaTPKi" then
        setd(-48, 0) -- test  ;;;;; Espantapajaros mecanico
        setd(-44, 5)
        setd(-52, "00000064h")
        setd(-56, "05650138h")
        setd(-60, "0000006Eh")
        setd(-64, "616D7761h")
        setd(-68, "72745368h")
        setd(-72, "63656D18h")
    elseif variacao == "r2MaTPKi" then
        setd(-48, 0) -- test  ;;;;; Carreras de coches telerigidos
        setd(-44, 5)
        setd(-52, "00000068h")
        setd(-56, "05640065h")
        setd(-60, "75637365h")
        setd(-64, "725F6563h")
        setd(-68, "61726F69h")
        setd(-72, "64617220h")
    elseif variacao == "r3MaTPKi" then
        setd(-48, 0) -- test  ;;;;; Cañon de fruta
        setd(-44, 5)
        setd(-52, "0000006Ah")
        setd(-56, "00656669h")
        setd(-60, "6E6B5F67h")
        setd(-64, "6E696369h")
        setd(-68, "6C537469h")
        setd(-72, "75726624h")
    elseif variacao == "r4MaTPKi" then
        setd(-48, 0) -- test  ;;;;; Lanzamiento de cuchillos 
        setd(-44, 5)
        setd(-52, "00736576h")
        setd(-56, "696E6B5Fh")
        setd(-60, "676E6977h")
        setd(-64, "6F726874h")
        setd(-68, "5F797475h")
        setd(-72, "6165622Ch")
    elseif variacao == "r5MaTPKi" then
        setd(-48, 0) -- test  ;;;;; Campo de tiro la fruta
        setd(-44, 5)
        setd(-52, "00000064h")
        setd(-56, "05647E00h")
        setd(-60, "65756373h")
        setd(-64, "65725F67h")
        setd(-68, "6E69746Fh")
        setd(-72, "6F68731Eh")
    elseif variacao == "r6MaTPKi" then
        setd(-48, 0) -- test  ;;;;; Martillo de fuerza
        setd(-44, 5)
        setd(-52, "00000039h")
        setd(-56, "00657563h")
        setd(-60, "7365725Fh")
        setd(-64, "72657465h")
        setd(-68, "6D6F6D61h")
        setd(-72, "6E796424h")
    elseif variacao == "r7MaTPKi" then
        setd(-48, 0) -- test  ;;;;; Pinball
        setd(-44, 5)
        setd(-52, "0000007Dh")
        setd(-56, "0564E828h")
        setd(-60, "00007869h")
        setd(-64, "6C65685Fh")
        setd(-68, "6C6C6162h")
        setd(-72, "6E69701Ah")
    elseif variacao == "r8MaTPKi" then
        setd(-48, 0) -- test  ;;;;; Maquina de peluches
        setd(-44, 5)
        setd(-52, "0000004Bh")
        setd(-56, "05640078h")
        setd(-60, "696C6568h")
        setd(-64, "5F656E69h")
        setd(-68, "6863614Dh")
        setd(-72, "796F7420h")
    elseif variacao == "r9MaTPKi" then
        setd(-48, 0) -- test  ;;;;; Consola por antonomasia
        setd(-44, 5)
        setd(-52, "00000078h")
        setd(-56, "056508D8h")
        setd(-60, "00007869h")
        setd(-64, "6C65685Fh")
        setd(-68, "796F6265h")
        setd(-72, "6D61671Ah")
    elseif variacao == "r10MaTPKi" then
        setd(-48, 0) -- test  ;;;;; Tiovivo pulpo
        setd(-44, 1)
        setd(-52, "0000008Ch")
        setd(-56, "EA920073h")
        setd(-60, "75706F74h")
        setd(-64, "634F5F6Ch")
        setd(-68, "6573756Fh")
        setd(-72, "72614320h")

        -- Decoración 1
    elseif variacao == "r1JTyMT" then
        setd(-48, 0) -- test Planetario al aire libre
        setd(-44, 5)
        setd(-52, "00007700h")
        setd(-56, "6D657473h")
        setd(-60, "79735F72h")
        setd(-64, "616C6F73h")
        setd(-68, "5F797475h")
        setd(-72, "61656226h")
    elseif variacao == "r2JTyMT" then
        setd(-48, 0) -- test Cafeteria con viñedo
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00006472h")
        setd(-64, "6179656Eh")
        setd(-68, "69565F65h")
        setd(-72, "6661431Ah")
    elseif variacao == "r3JTyMT" then
        setd(-48, 0) -- test Elefantes felices
        setd(-44, 5)
        setd(-52, "00007756h")
        setd(-56, "86140073h")
        setd(-60, "746E6168h")
        setd(-64, "70656C65h")
        setd(-68, "5F797475h")
        setd(-72, "61656220h")
    elseif variacao == "r4JTyMT" then
        setd(-48, 0) -- test Yeti   maxibatidora 1
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "0563EA58h")
        setd(-60, "00006566h")
        setd(-64, "696E6B5Fh")
        setd(-68, "7265646Eh")
        setd(-72, "656C621Ah")
    elseif variacao == "r5JTyMT" then
        setd(-48, 0) --   parterre macedoña 1
        setd(-44, 5)
        setd(-52, "00000055h")
        setd(-56, "0563ED00h")
        setd(-60, "6566696Eh")
        setd(-64, "6B5F656Ch")
        setd(-68, "70706165h")
        setd(-72, "6E69701Eh")
    elseif variacao == "r6JTyMT" then
        setd(-48, 0) -- test Danza de los zancos
        setd(-44, 5)
        setd(-52, "0073746Ch")
        setd(-56, "6974735Fh")
        setd(-60, "73746162h")
        setd(-64, "6F726361h")
        setd(-68, "5F797475h")
        setd(-72, "6165622Ch")
    elseif variacao == "r7JTyMT" then
        setd(-48, 0) -- test Monstruo del lago ness
        setd(-44, 5)
        setd(-52, "00000072h")
        setd(-56, "6574736Eh")
        setd(-60, "6F6D5F72h")
        setd(-64, "65746177h")
        setd(-68, "5F797475h")
        setd(-72, "61656228h")
    elseif variacao == "r8JTyMT" then
        setd(-48, 0) -- test Barco encantado
        setd(-44, 5)
        setd(-52, "00007756h")
        setd(-56, "86007069h")
        setd(-60, "68735F74h")
        setd(-64, "736F6867h")
        setd(-68, "5F797475h")
        setd(-72, "61656222h")
    elseif variacao == "r9JTyMT" then
        setd(-48, 0) -- test Diplodocus
        setd(-44, 5)
        setd(-52, "00007756h")
        setd(-56, "86006500h")
        setd(-60, "72756173h")
        setd(-64, "6F6E6964h")
        setd(-68, "5F797475h")
        setd(-72, "6165621Eh")
    elseif variacao == "r10JTyMT" then
        setd(-48, 0) -- test A Galope
        setd(-44, 5)
        setd(-52, "00007756h")
        setd(-56, "86006567h")
        setd(-60, "0068746Fh")
        setd(-64, "6D6D616Dh")
        setd(-68, "5F797475h")
        setd(-72, "6165621Ch")
    elseif variacao == "r11JTyMT" then
        setd(-48, 0) -- test Stonehenge
        setd(-44, 5)
        setd(-52, "00007756h")
        setd(-56, "86006567h")
        setd(-60, "6E656865h")
        setd(-64, "6E6F7473h")
        setd(-68, "5F797475h")
        setd(-72, "61656222h")
    elseif variacao == "r12JTyMT" then
        setd(-48, 0) -- test Cascada
        setd(-44, 5)
        setd(-52, "0000006Ch")
        setd(-56, "6169646Eh")
        setd(-60, "006C6C61h")
        setd(-64, "66726574h")
        setd(-68, "61576C6Ch")
        setd(-72, "616D531Ch")
    elseif variacao == "r13JTyMT" then
        setd(-48, 0) -- test Reloj de arena
        setd(-44, 5)
        setd(-52, "0000006Ch")
        setd(-56, "6169646Eh")
        setd(-60, "75735F65h")
        setd(-64, "6772616Ch")
        setd(-68, "5F797475h")
        setd(-72, "61656228h")
    elseif variacao == "r14JTyMT" then
        setd(-48, 0) -- test Estatua de pavo real
        setd(-44, 5)
        setd(-52, "00006575h")
        setd(-56, "74617473h")
        setd(-60, "5F6B636Fh")
        setd(-64, "63616570h")
        setd(-68, "5F797475h")
        setd(-72, "6165622Ah")
    elseif variacao == "r15JTyMT" then
        setd(-48, 0) -- test Tridente atlante
        setd(-44, 5)
        setd(-52, "00726163h")
        setd(-56, "6500646Eh")
        setd(-60, "61685F73h")
        setd(-64, "616C7461h")
        setd(-68, "5F797475h")
        setd(-72, "61656222h")
    elseif variacao == "r16JTyMT" then
        setd(-48, 0) -- test duendecillos 1
        setd(-44, 5)
        setd(-52, "00000034h")
        setd(-56, "0563F7B0h")
        setd(-60, "00007057h")
        setd(-64, "283FE426h")
        setd(-68, "0073656Dh")
        setd(-72, "6F6E670Ch")
    elseif variacao == "r17JTyMT" then
        setd(-48, 0) -- test Estatua reliquia de mar
        setd(-44, 5)
        setd(-52, "00657574h")
        setd(-56, "6174735Fh")
        setd(-60, "7369746Eh")
        setd(-64, "616C7461h")
        setd(-68, "5F797475h")
        setd(-72, "6165622Ch")
    elseif variacao == "r18JTyMT" then
        setd(-48, 0) -- test Ricon del coral
        setd(-44, 5)
        setd(-52, "00007700h")
        setd(-56, "6E656472h")
        setd(-60, "61675F6Ch")
        setd(-64, "61726F63h")
        setd(-68, "5F797475h")
        setd(-72, "61656226h")
    elseif variacao == "r19JTyMT" then
        setd(-48, 0) -- test Exploradores marinos
        setd(-44, 5)
        setd(-52, "00737265h")
        setd(-56, "68637261h")
        setd(-60, "65736572h")
        setd(-64, "5F616573h")
        setd(-68, "5F797475h")
        setd(-72, "6165622Ch")
    elseif variacao == "r20JTyMT" then
        setd(-48, 0) -- test  hada en nenufar 1   
        setd(-44, 5)
        setd(-52, "0000001Ch")
        setd(-56, "0563FE10h")
        setd(-60, "00007000h")
        setd(-64, "72657461h")
        setd(-68, "775F7972h")
        setd(-72, "69616616h")
    elseif variacao == "r21JTyMT" then
        setd(-48, 0) -- test Guardian del tesoro
        setd(-44, 5)
        setd(-52, "00007700h")
        setd(-56, "6C617665h")
        setd(-60, "6964656Dh")
        setd(-64, "5F6E6F67h")
        setd(-68, "61724468h")
        setd(-72, "63656D26h")
    elseif variacao == "r22JTyMT" then
        setd(-48, 0) -- test Cetreria
        setd(-44, 5)
        setd(-52, "00007700h")
        setd(-56, "6C617665h")
        setd(-60, "00676E69h")
        setd(-64, "746E7568h")
        setd(-68, "5F6E6F63h")
        setd(-72, "6C61661Ch")
    elseif variacao == "r23JTyMT" then
        setd(-48, 0) -- test Barco fantasma
        setd(-44, 5)
        setd(-52, "00000070h")
        setd(-56, "6968735Fh")
        setd(-60, "74736F68h")
        setd(-64, "675F6E65h")
        setd(-68, "65776F6Ch")
        setd(-72, "6C616828h")
    elseif variacao == "r24JTyMT" then
        setd(-48, 0) -- test Planta carnívora
        setd(-44, 5)
        setd(-52, "00000070h")
        setd(-56, "61727479h")
        setd(-60, "6C665F73h")
        setd(-64, "756E6576h")
        setd(-68, "5F797475h")
        setd(-72, "61656228h")
    elseif variacao == "r25JTyMT" then
        setd(-48, 0) -- test   columpio de flores 1
        setd(-44, 5)
        setd(-52, "00000064h")
        setd(-56, "05642038h")
        setd(-60, "00000067h")
        setd(-64, "6E697773h")
        setd(-68, "5F726577h")
        setd(-72, "6F6C6618h")
    elseif variacao == "r26JTyMT" then
        setd(-48, 0) -- test Chiringuito cocoloco
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00726162h")
        setd(-60, "5F74756Eh")
        setd(-64, "6F636F43h")
        setd(-68, "5F797475h")
        setd(-72, "61656224h")
    elseif variacao == "r27JTyMT" then
        setd(-48, 0) -- test Piscina de surf
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "9953006Ch")
        setd(-60, "6F6F705Fh")
        setd(-64, "66726573h")
        setd(-68, "5F797475h")
        setd(-72, "61656220h")
    elseif variacao == "r28JTyMT" then
        setd(-48, 0) -- test Bungalo
        setd(-44, 5)
        setd(-52, "00000073h")
        setd(-56, "65766964h")
        setd(-60, "6C614D65h")
        setd(-64, "73756F68h")
        setd(-68, "5F797475h")
        setd(-72, "61656228h")
    elseif variacao == "r29JTyMT" then
        setd(-48, 0) -- test Balancin palmera
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "99006D6Ch")
        setd(-60, "61705F67h")
        setd(-64, "6E697773h")
        setd(-68, "5F797475h")
        setd(-72, "61656222h")
    elseif variacao == "r30JTyMT" then
        setd(-48, 0) -- test Totem de granjero
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "6D65746Fh")
        setd(-60, "545F7974h")
        setd(-64, "75616542h")
        setd(-68, "6C616963h")
        setd(-72, "65705326h")
    elseif variacao == "r31JTyMT" then
        setd(-48, 0) -- test Taller de escriba
        setd(-44, 5)
        setd(-52, "0000006Ch")
        setd(-56, "61766569h")
        setd(-60, "64656D5Fh")
        setd(-64, "6D756972h")
        setd(-68, "6F747069h")
        setd(-72, "72637328h")
    elseif variacao == "r32JTyMT" then
        setd(-48, 0) -- test Cañon naval
        setd(-44, 5)
        setd(-52, "00006E75h")
        setd(-56, "47706968h")
        setd(-60, "535F7974h")
        setd(-64, "75616542h")
        setd(-68, "6C616963h")
        setd(-72, "6570532Ah")
    elseif variacao == "r33JTyMT" then
        setd(-48, 0) -- test Paleta de flores
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "99530065h")
        setd(-60, "72757470h")
        setd(-64, "6C756353h")
        setd(-68, "65747465h")
        setd(-72, "6C615020h")
    elseif variacao == "r34JTyMT" then
        setd(-48, 0) -- test Grifo magico
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "99531F58h")
        setd(-60, "00006E69h")
        setd(-64, "61746E75h")
        setd(-68, "6F46656Eh")
        setd(-72, "6172431Ah")
    elseif variacao == "r35JTyMT" then
        setd(-48, 0) -- test Fuente musica
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "995321E8h")
        setd(-60, "0000006Eh")
        setd(-64, "6961746Eh")
        setd(-68, "756F4661h")
        setd(-72, "72694C18h")
    elseif variacao == "r36JTyMT" then
        setd(-48, 0) -- test Carrusel gramófono
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "99533348h")
        setd(-60, "00656C65h")
        setd(-64, "73756F72h")
        setd(-68, "61436369h")
        setd(-72, "73754D1Ch")
    elseif variacao == "r37JTyMT" then
        setd(-48, 0) -- test Set de rodaje
        setd(-44, 5)
        setd(-52, "00616D65h")
        setd(-56, "6E69635Fh")
        setd(-60, "6F696475h")
        setd(-64, "74536F66h")
        setd(-68, "556E6F73h")
        setd(-72, "6165732Ch")
    elseif variacao == "r38JTyMT" then
        setd(-48, 0) -- test Fuente pelicula
        setd(-44, 5)
        setd(-52, "0000006Eh")
        setd(-56, "6961746Eh")
        setd(-60, "756F4665h")
        setd(-64, "69766F4Dh")
        setd(-68, "5F797475h")
        setd(-72, "61656228h")
    elseif variacao == "r39JTyMT" then
        setd(-48, 0) -- test Tienda musica
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00706F68h")
        setd(-60, "736B726Fh")
        setd(-64, "57746E65h")
        setd(-68, "6D757274h")
        setd(-72, "736E4924h")
    elseif variacao == "r40JTyMT" then
        setd(-48, 0) -- test Estatua de faraon
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00657574h")
        setd(-60, "61745368h")
        setd(-64, "6F617261h")
        setd(-68, "68507470h")
        setd(-72, "79674524h")
    elseif variacao == "r41JTyMT" then
        setd(-48, 0) -- test Barco papiro
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "99530074h")
        setd(-60, "616F4273h")
        setd(-64, "75727970h")
        setd(-68, "61507470h")
        setd(-72, "79674520h")
    elseif variacao == "r42JTyMT" then
        setd(-48, 0) -- test Caballo de troya
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "746E6569h")
        setd(-60, "636E615Fh")
        setd(-64, "6573726Fh")
        setd(-68, "486E616Ah")
        setd(-72, "6F727426h")
    elseif variacao == "r43JTyMT" then
        setd(-48, 0) -- test Anfiteatro
        setd(-44, 5)
        setd(-52, "00000074h")
        setd(-56, "6E656963h")
        setd(-60, "6E615F6Eh")
        setd(-64, "6F65644Fh")
        setd(-68, "72657461h")
        setd(-72, "65687428h")
    elseif variacao == "r44JTyMT" then
        setd(-48, 0) -- test Caballo arabes
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "65757461h")
        setd(-60, "74735F65h")
        setd(-64, "73726F68h")
        setd(-68, "5F636962h")
        setd(-72, "61726126h")
    elseif variacao == "r45JTyMT" then
        setd(-48, 0) -- test Estanque de cisnes
        setd(-44, 5)
        setd(-52, "00000065h")
        setd(-56, "636E6972h")
        setd(-60, "705F6575h")
        setd(-64, "7400736Eh")
        setd(-68, "61775364h")
        setd(-72, "6E6F7012h")
    elseif variacao == "r46JTyMT" then
        setd(-48, 0) -- test Sauce lloron
        setd(-44, 5)
        setd(-52, "00000065h")
        setd(-56, "636E0072h")
        setd(-60, "00776F6Ch")
        setd(-64, "6C69775Fh")
        setd(-68, "676E6970h")
        setd(-72, "6565771Ch")
    elseif variacao == "r47JTyMT" then
        setd(-48, 0) -- test Arbol caido
        setd(-44, 5)
        setd(-52, "0000006Ch")
        setd(-56, "6169646Eh")
        setd(-60, "75735F00h")
        setd(-64, "65657254h")
        setd(-68, "64657261h")
        setd(-72, "65687316h")
    elseif variacao == "r48JTyMT" then
        setd(-48, 0) -- test Cascada
        setd(-44, 5)
        setd(-52, "0000006Ch")
        setd(-56, "6169646Eh")
        setd(-60, "006C6C61h")
        setd(-64, "66726574h")
        setd(-68, "61576C6Ch")
        setd(-72, "616D531Ch")

    elseif variacao == "r49JTyMT" then
        setd(-48, 0) -- test  Estacion de satelite
        setd(-44, 5)
        setd(-52, "00000078h")
        setd(-56, "41325500h")
        setd(-60, "6E6F6974h")
        setd(-64, "6174535Fh")
        setd(-68, "7463656Eh")
        setd(-72, "6E6F431Eh")
    elseif variacao == "r50JTyMT" then
        setd(-48, 0) -- test  Plazoleta parisina
        setd(-44, 5)
        setd(-52, "00007DE3h")
        setd(-56, "66760591h")
        setd(-60, "00000074h")
        setd(-64, "65657274h")
        setd(-68, "535F7369h")
        setd(-72, "72615018h")
    elseif variacao == "r51JTyMT" then
        setd(-48, 0) -- test  Aparcamiento de bicis
        setd(-44, 5)
        setd(-52, "0000008Ch")
        setd(-56, "4132B038h")
        setd(-60, "0000676Eh")
        setd(-64, "696B7261h")
        setd(-68, "505F656Ch")
        setd(-72, "6379431Ah")
    elseif variacao == "r52JTyMT" then
        setd(-48, 0) -- test  Libreria
        setd(-44, 5)
        setd(-52, "00000078h")
        setd(-56, "4132A340h")
        setd(-60, "00007DE3h")
        setd(-64, "0065726Fh")
        setd(-68, "74535F6Bh")
        setd(-72, "6F6F4214h")
    elseif variacao == "r53JTyMT" then
        setd(-48, 0) -- test  Boutique floral
        setd(-44, 5)
        setd(-52, "0000008Ch")
        setd(-56, "4132C948h")
        setd(-60, "00000065h")
        setd(-64, "726F7453h")
        setd(-68, "5F726577h")
        setd(-72, "6F6C4618h")
    elseif variacao == "r54JTyMT" then
        setd(-48, 0) -- test  Sintetizador gigante
        setd(-44, 5)
        setd(-52, "00000078h")
        setd(-56, "4132CFA8h")
        setd(-60, "00007D00h")
        setd(-64, "656E6563h")
        setd(-68, "535F6369h")
        setd(-72, "73754D16h")

        -- Decoración 2
    elseif variacao == "r1DECORT" then
        setd(-48, 0) -- test Fuente bailarina
        setd(-44, 5)
        setd(-52, "0000006Ch")
        setd(-56, "61690073h")
        setd(-60, "6E696174h")
        setd(-64, "6E756F46h")
        setd(-68, "676E6963h")
        setd(-72, "6E616420h")
    elseif variacao == "r2DECORT" then
        setd(-48, 0) -- test Tobogan acuatico
        setd(-44, 5)
        setd(-52, "0000646Eh")
        setd(-56, "00006564h")
        setd(-60, "696C5372h")
        setd(-64, "65746177h")
        setd(-68, "5F797475h")
        setd(-72, "61656222h")
    elseif variacao == "r3DECORT" then
        setd(-48, 0) -- test Pizzeria al aire libre
        setd(-44, 5)
        setd(-52, "00006174h")
        setd(-56, "7361705Fh")
        setd(-60, "61697265h")
        setd(-64, "7A7A6970h")
        setd(-68, "5F797475h")
        setd(-72, "6165622Ah")
    elseif variacao == "r4DECORT" then
        setd(-48, 0) -- test Distrito del artista
        setd(-44, 5)
        setd(-52, "00007265h")
        setd(-56, "74726175h")
        setd(-60, "715F7473h")
        setd(-64, "69747261h")
        setd(-68, "5F797475h")
        setd(-72, "6165622Ah")
    elseif variacao == "r5DECORT" then
        setd(-48, 0) -- test Tiovivo de elefantes
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "0073746Eh")
        setd(-60, "61687065h")
        setd(-64, "6C655F6Ch")
        setd(-68, "6573756Fh")
        setd(-72, "72616324h")
    elseif variacao == "r6DECORT" then
        setd(-48, 0) -- test Fuente ballena
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "0073746Eh")
        setd(-60, "00656C61h")
        setd(-64, "68775F6Eh")
        setd(-68, "6961746Eh")
        setd(-72, "756F661Ch")
    elseif variacao == "r7DECORT" then
        setd(-48, 0) -- test Torre de socorristas
        setd(-44, 5)
        setd(-52, "0000006Ch")
        setd(-56, "61690065h")
        setd(-60, "6C007475h")
        setd(-64, "685F6472h")
        setd(-68, "61756765h")
        setd(-72, "66696C1Ah")
    elseif variacao == "r8DECORT" then
        setd(-48, 0) -- test Arco arcoiris
        setd(-44, 5)
        setd(-52, "00007600h")
        setd(-56, "79656B6Eh")
        setd(-60, "6F6D5F00h")
        setd(-64, "68637241h")
        setd(-68, "776F626Eh")
        setd(-72, "69615216h")
    elseif variacao == "r9DECORT" then
        setd(-48, 0) -- test Tienda de noodles
        setd(-44, 5)
        setd(-52, "00007600h")
        setd(-56, "79656B6Eh")
        setd(-60, "6F6D5F00h")
        setd(-64, "706F6873h")
        setd(-68, "5F656C64h")
        setd(-72, "6F6F6E16h")
    elseif variacao == "r10DECORT" then
        setd(-48, 0) -- test Fuente de nuevo record
        setd(-44, 5)
        setd(-52, "006E6961h")
        setd(-56, "746E756Fh")
        setd(-60, "46636970h")
        setd(-64, "6D796C4Fh")
        setd(-68, "5F797475h")
        setd(-72, "6165622Ch")
    elseif variacao == "r11DECORT" then
        setd(-48, 0) -- test Restaurante
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "74D782D0h")
        setd(-60, "00746E61h")
        setd(-64, "72756174h")
        setd(-68, "7365725Fh")
        setd(-72, "6F6F7A1Ch")
    elseif variacao == "r12DECORT" then
        setd(-48, 0) -- test Submarino
        setd(-44, 5)
        setd(-52, "00000015h")
        setd(-56, "74C40065h")
        setd(-60, "6E697261h")
        setd(-64, "6D627573h")
        setd(-68, "5F797475h")
        setd(-72, "61656220h")
    elseif variacao == "r13DECORT" then
        setd(-48, 0) -- test Perro amarillo
        setd(-44, 5)
        setd(-52, "00007601h")
        setd(-56, "8C7E1591h")
        setd(-60, "00007601h")
        setd(-64, "00676F44h")
        setd(-68, "6573656Eh")
        setd(-72, "69684314h")
    elseif variacao == "r14DECORT" then
        setd(-48, 0) -- test Valla marinera
        setd(-44, 5)
        setd(-52, "0000005Ah")
        setd(-56, "74C4ECD8h")
        setd(-60, "0065636Eh")
        setd(-64, "65665F65h")
        setd(-68, "636E6546h")
        setd(-72, "6165531Ch")
    elseif variacao == "r15DECORT" then
        setd(-48, 0) -- test Ancla del almirante
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "726F636Eh")
        setd(-60, "615F7974h")
        setd(-64, "75616542h")
        setd(-68, "6C616963h")
        setd(-72, "65705326h")
    elseif variacao == "r16DECORT" then
        setd(-48, 0) -- test Caballito de mar
        setd(-44, 5)
        setd(-52, "00657372h")
        setd(-56, "6F686165h")
        setd(-60, "735F7974h")
        setd(-64, "75616542h")
        setd(-68, "6C616963h")
        setd(-72, "6570532Ch")
    elseif variacao == "r17DECORT" then
        setd(-48, 0) -- test La sirena
        setd(-44, 5)
        setd(-52, "00006469h")
        setd(-56, "616D7265h")
        setd(-60, "6D5F7974h")
        setd(-64, "75616542h")
        setd(-68, "6C616963h")
        setd(-72, "6570532Ah")
    elseif variacao == "r18DECORT" then
        setd(-48, 0) -- test Pulpo pescador
        setd(-44, 5)
        setd(-52, "00007375h")
        setd(-56, "706F7463h")
        setd(-60, "6F5F7974h")
        setd(-64, "75616542h")
        setd(-68, "6C616963h")
        setd(-72, "6570532Ah")
    elseif variacao == "r19DECORT" then
        setd(-48, 0) -- test Abeja piloto
        setd(-44, 5)
        setd(-52, "00746F6Ch")
        setd(-56, "69506565h")
        setd(-60, "425F7974h")
        setd(-64, "75616542h")
        setd(-68, "6C616963h")
        setd(-72, "6570532Ch")
    elseif variacao == "r20DECORT" then
        setd(-48, 0) -- test Escalera infinita
        setd(-44, 5)
        setd(-52, "0000005Ah")
        setd(-56, "74C56B78h")
        setd(-60, "00003368h")
        setd(-64, "6374616Dh")
        setd(-68, "5F737269h")
        setd(-72, "6174731Ah")
    elseif variacao == "r21DECORT" then
        setd(-48, 0) -- test Cangrejo ermitaño
        setd(-44, 5)
        setd(-52, "00000074h")
        setd(-56, "696D7265h")
        setd(-60, "685F7265h")
        setd(-64, "636E6163h")
        setd(-68, "5F797475h")
        setd(-72, "61656228h")
    elseif variacao == "r22DECORT" then
        setd(-48, 0) -- test Mercado embarcadero
        setd(-44, 5)
        setd(-52, "00007601h")
        setd(-56, "0074656Bh")
        setd(-60, "72616D5Fh")
        setd(-64, "68736966h")
        setd(-68, "5F797475h")
        setd(-72, "61656224h")
    elseif variacao == "r23DECORT" then
        setd(-48, 0) -- test Carrusel de niños
        setd(-44, 5)
        setd(-52, "00007372h")
        setd(-56, "65000000h")
        setd(-60, "6C657375h")
        setd(-64, "6F726163h")
        setd(-68, "5F797475h")
        setd(-72, "6165621Eh")
    elseif variacao == "r24DECORT" then
        setd(-48, 0) -- test Moto acuatico
        setd(-44, 5)
        setd(-52, "00007372h")
        setd(-56, "65007466h")
        setd(-60, "61726372h")
        setd(-64, "65746177h")
        setd(-68, "5F797475h")
        setd(-72, "61656222h")
    elseif variacao == "r25DECORT" then
        setd(-48, 0) -- test Estanque de carpas
        setd(-44, 5)
        setd(-52, "00007601h")
        setd(-56, "79473FE0h")
        setd(-60, "00707261h")
        setd(-64, "635F6874h")
        setd(-68, "69775F64h")
        setd(-72, "6E6F701Ch")
    elseif variacao == "r26DECORT" then
        setd(-48, 0) -- test Palomar
        setd(-44, 5)
        setd(-52, "0065746Fh")
        setd(-56, "6365766Fh")
        setd(-60, "445F7974h")
        setd(-64, "75616542h")
        setd(-68, "6C616963h")
        setd(-72, "6570532Ch")
    elseif variacao == "r27DECORT" then
        setd(-48, 0) -- test Carrito de verduras
        setd(-44, 5)
        setd(-52, "00007600h")
        setd(-56, "79726563h")
        setd(-60, "6F72676Eh")
        setd(-64, "65657267h")
        setd(-68, "5F797475h")
        setd(-72, "61656226h")
    elseif variacao == "r28DECORT" then
        setd(-48, 0) -- test Parque de los niños
        setd(-44, 5)
        setd(-52, "00007601h")
        setd(-56, "0032646Eh")
        setd(-60, "756F7267h")
        setd(-64, "79616C70h")
        setd(-68, "5F797475h")
        setd(-72, "61656224h")
    elseif variacao == "r29DECORT" then
        setd(-48, 0) -- test Nenufar rosa
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "74C93000h")
        setd(-60, "325F7372h")
        setd(-64, "65776F6Ch")
        setd(-68, "665F7265h")
        setd(-72, "7461771Eh")
    elseif variacao == "r30DECORT" then
        setd(-48, 0) -- test Catamaran
        setd(-44, 5)
        setd(-52, "00007600h")
        setd(-56, "73006172h")
        setd(-60, "65620079h")
        setd(-64, "6C006E61h")
        setd(-68, "72616D61h")
        setd(-72, "74616B12h")
    elseif variacao == "r31DECORT" then
        setd(-48, 0) -- test Aerogenerador
        setd(-44, 5)
        setd(-52, "00007600h")
        setd(-56, "73006172h")
        setd(-60, "65620079h")
        setd(-64, "6C696D00h")
        setd(-68, "6B617972h")
        setd(-72, "7465760Eh")
    elseif variacao == "r32DECORT" then
        setd(-48, 0) -- test Dibujo de cebra
        setd(-44, 5)
        setd(-52, "0000746Eh")
        setd(-56, "00617262h")
        setd(-60, "657A5F6Bh")
        setd(-64, "6C616863h")
        setd(-68, "5F797475h")
        setd(-72, "61656224h")
    elseif variacao == "r33DECORT" then
        setd(-48, 0) -- test Puerta de la gloria
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "73657461h")
        setd(-60, "675F7972h")
        setd(-64, "7578754Ch")
        setd(-68, "5F797475h")
        setd(-72, "61656226h")
    elseif variacao == "r34DECORT" then
        setd(-48, 0) -- test Valla dorado 
        setd(-44, 5)
        setd(-52, "00007400h")
        setd(-56, "79726563h")
        setd(-60, "6F720065h")
        setd(-64, "636E6566h")
        setd(-68, "5F797275h")
        setd(-72, "78756C18h")
    elseif variacao == "r35DECORT" then
        setd(-48, 0) -- test Glorieta de picnic
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "CC57E280h")
        setd(-60, "0000769Ah")
        setd(-64, "EBB23591h")
        setd(-68, "0063696Eh")
        setd(-72, "6369700Ch")
    elseif variacao == "r36DECORT" then
        setd(-48, 0) -- test Monumento al sol
        setd(-44, 5)
        setd(-52, "0000769Ah")
        setd(-56, "EB006E75h")
        setd(-60, "535F7974h")
        setd(-64, "75616542h")
        setd(-68, "6C616963h")
        setd(-72, "65705322h")
    elseif variacao == "r37DECORT" then
        setd(-48, 0) -- test Casa de lujo
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "6573756Fh")
        setd(-60, "685F7972h")
        setd(-64, "7578756Ch")
        setd(-68, "5F797475h")
        setd(-72, "61656226h")
    elseif variacao == "r38DECORT" then
        setd(-48, 0) -- test Cartel de lluvia de confiti
        setd(-44, 5)
        setd(-52, "0000769Ah")
        setd(-56, "EB3A4591h")
        setd(-60, "00007265h")
        setd(-64, "6E6E6142h")
        setd(-68, "6573656Eh")
        setd(-72, "6968431Ah")
    elseif variacao == "r39DECORT" then
        setd(-48, 0) -- test Puente colgante
        setd(-44, 5)
        setd(-52, "0000001Ch")
        setd(-56, "C2A6CC00h")
        setd(-60, "00656764h")
        setd(-64, "6972625Fh")
        setd(-68, "746E6569h")
        setd(-72, "636E611Ch")
    elseif variacao == "r40DECORT" then
        setd(-48, 0) -- test Hidrodeslizador
        setd(-44, 5)
        setd(-52, "00000055h")
        setd(-56, "C2A6DE38h")
        setd(-60, "00006B6Eh")
        setd(-64, "616C705Fh")
        setd(-68, "74616F62h")
        setd(-72, "7269611Ah")
    elseif variacao == "r41DECORT" then
        setd(-48, 0) -- test Visita a los delfines
        setd(-44, 5)
        setd(-52, "0000769Ah")
        setd(-56, "EBE1F500h")
        setd(-60, "736E6968h")
        setd(-64, "706C6F64h")
        setd(-68, "5F797475h")
        setd(-72, "6165621Eh")
    elseif variacao == "r42DECORT" then
        setd(-48, 0) -- test Piramide de batidos
        setd(-44, 5)
        setd(-52, "00000065h")
        setd(-56, "66696E6Bh")
        setd(-60, "5F64696Dh")
        setd(-64, "61727970h")
        setd(-68, "5F797475h")
        setd(-72, "61656228h")
    elseif variacao == "r43DECORT" then
        setd(-48, 0) -- test Concurso de topiarias
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "6E6F6974h")
        setd(-60, "69746570h")
        setd(-64, "6D6F635Fh")
        setd(-68, "79726169h")
        setd(-72, "706F7426h")
    elseif variacao == "r44DECORT" then
        setd(-48, 0) -- test casa la pasta
        setd(-44, 5)
        setd(-52, "0000002Dh")
        setd(-56, "05630032h")
        setd(-60, "646C6975h")
        setd(-64, "42726F74h")
        setd(-68, "61726F74h")
        setd(-72, "73655220h")
    elseif variacao == "r45DECORT" then
        setd(-48, 0) -- test Trono mediaval
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "6C617665h")
        setd(-60, "6964656Dh")
        setd(-64, "5F6C6C61h")
        setd(-68, "48656E6Fh")
        setd(-72, "72687426h")
    elseif variacao == "r46DECORT" then
        setd(-48, 0) -- test Tiovivo salvaje del oeste
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "006C6573h")
        setd(-64, "756F7261h")
        setd(-68, "435F6573h")
        setd(-72, "726F481Ch")
    elseif variacao == "r47DECORT" then
        setd(-48, 0) -- test Circo itinerante
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00676E69h")
        setd(-64, "706D6143h")
        setd(-68, "5F737563h")
        setd(-72, "7269431Ch")
    elseif variacao == "r48DECORT" then
        setd(-48, 0) -- test Parque infantil salvaje oeste
        setd(-44, 5)
        setd(-52, "0000008Ch")
        setd(-56, "CC0590A8h")
        setd(-60, "00000072h")
        setd(-64, "65776F54h")
        setd(-68, "5F796F62h")
        setd(-72, "776F4318h")
    elseif variacao == "r49DECORT" then
        setd(-48, 0) -- test Unicornio de peluche
        setd(-44, 5)
        setd(-52, "00656E69h")
        setd(-56, "746E656Ch")
        setd(-60, "61765F6Eh")
        setd(-64, "726F6369h")
        setd(-68, "6E556873h")
        setd(-72, "756C702Ch")
    elseif variacao == "r50DECORT" then
        setd(-48, 0) -- test  Fiesta de primavera
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "0000736Eh")
        setd(-64, "6F626269h")
        setd(-68, "52726574h")
        setd(-72, "7361651Ah")
    elseif variacao == "r51DECORT" then
        setd(-48, 0) -- test  Chiringuito exotico
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "CBF5B400h")
        setd(-60, "7261625Fh")
        setd(-64, "79747261h")
        setd(-68, "705F6863h")
        setd(-72, "6165621Eh")
    elseif variacao == "r52DECORT" then
        setd(-48, 0) -- test Surtido de frutas
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "CBF5C200h")
        setd(-60, "78696D5Fh")
        setd(-64, "74697572h")
        setd(-68, "665F6863h")
        setd(-72, "6165621Eh")
    elseif variacao == "r53DECORT" then
        setd(-48, 0) -- test Fuente hada floral
        setd(-44, 5)
        setd(-52, "0000769Ah")
        setd(-56, "00720070h")
        setd(-60, "006E6961h")
        setd(-64, "746E756Fh")
        setd(-68, "465F7972h")
        setd(-72, "6961461Ch")

    elseif variacao == "r54DECORT" then
        setd(-48, 0) -- test  ;;;;; fabrica de arcoiris
        setd(-44, 5)
        setd(-52, "00000043h")
        setd(-56, "05642698h")
        setd(-60, "0000776Fh")
        setd(-64, "626E6961h")
        setd(-68, "725F7964h")
        setd(-72, "6E61631Ah")
    elseif variacao == "r55DECORT" then
        setd(-48, 0) -- test  ;;;;; piramide de batidos
        setd(-44, 5)
        setd(-52, "00000065h")
        setd(-56, "66696E6Bh")
        setd(-60, "5F64696Dh")
        setd(-64, "61727970h")
        setd(-68, "5F797475h")
        setd(-72, "61656228h")
    elseif variacao == "r56DECORT" then
        setd(-48, 0) -- test  ;;;;; obra de arte maravilla natural
        setd(-44, 5)
        setd(-52, "0000003Ah")
        setd(-56, "05640074h")
        setd(-60, "72615F6Eh")
        setd(-64, "6F697461h")
        setd(-68, "6C6C6174h")
        setd(-72, "736E6920h")
    elseif variacao == "r57DECORT" then
        setd(-48, 0) -- test  ;;;;; desafio inchable
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "05007265h")
        setd(-60, "6E6E7572h")
        setd(-64, "5F63696Ch")
        setd(-68, "65486F65h")
        setd(-72, "646F7222h")
    elseif variacao == "r58DECORT" then
        setd(-48, 0) -- test  ;;;;; camion monstruo
        setd(-44, 5)
        setd(-52, "00000017h")
        setd(-56, "05006575h")
        setd(-60, "63736572h")
        setd(-64, "5F726F74h")
        setd(-68, "63617254h")
        setd(-72, "67696222h")
    elseif variacao == "r59DECORT" then
        setd(-48, 0) -- test  ;;;;; la vuelta al mundo
        setd(-44, 5)
        setd(-52, "0000005Ah")
        setd(-56, "00656E61h")
        setd(-60, "6C705F74h")
        setd(-64, "6867696Ch")
        setd(-68, "466C6162h")
        setd(-72, "6F6C6724h")
    elseif variacao == "r60DECORT" then
        setd(-48, 0) -- test  ;;;;; centro del reino
        setd(-44, 5)
        setd(-52, "00000078h")
        setd(-56, "0564FAD8h")
        setd(-60, "00006572h")
        setd(-64, "746E6543h")
        setd(-68, "6D6F6467h")
        setd(-72, "6E694B1Ah")
    elseif variacao == "r61DECORT" then
        setd(-48, 0) -- test  ;;;;; curlin
        setd(-44, 5)
        setd(-52, "00000013h")
        setd(-56, "05650F38h")
        setd(-60, "0072656Eh")
        setd(-64, "6E75725Fh")
        setd(-68, "676E696Ch")
        setd(-72, "7275631Ch")
    elseif variacao == "r62DECORT" then
        setd(-48, 0) -- test  ;;;;; libro de la naturaleza
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "05658200h")
        setd(-60, "656C676Eh")
        setd(-64, "756A5F65h")
        setd(-68, "6572546Bh")
        setd(-72, "6F6F621Eh")
    elseif variacao == "r63DECORT" then
        setd(-48, 0) -- test  ;;;;; el trotamares
        setd(-44, 5)
        setd(-52, "00000065h")
        setd(-56, "74617269h")
        setd(-60, "705F6575h")
        setd(-64, "74617453h")
        setd(-68, "6E696174h")
        setd(-72, "70616328h")
    elseif variacao == "r64DECORT" then
        setd(-48, 0) -- test  ;;;;; parterre macedonia
        setd(-44, 5)
        setd(-52, "00000055h")
        setd(-56, "0563ED00h")
        setd(-60, "6566696Eh")
        setd(-64, "6B5F656Ch")
        setd(-68, "70706165h")
        setd(-72, "6E69701Eh")
        -- Avatar
    elseif variacao == "t1AVATR" then
        setd(-48, 0) -- test  1 año
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00393131h")
        setd(-72, "6176610Ch")
    elseif variacao == "t2AVATR" then
        setd(-48, 0) -- test 2 año 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00303231h")
        setd(-72, "6176610Ch")
    elseif variacao == "t3AVATR" then
        setd(-48, 0) -- test  3 año
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00313231h")
        setd(-72, "6176610Ch")
    elseif variacao == "t4AVATR" then
        setd(-48, 0) -- test  4 año
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00323231h")
        setd(-72, "6176610Ch")
    elseif variacao == "t5AVATR" then
        setd(-48, 0) -- test  5 año
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00333231h")
        setd(-72, "6176610Ch")
    elseif variacao == "t6AVATR" then
        setd(-48, 0) -- test  6 año
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00343531h")
        setd(-72, "6176610Ch")
    elseif variacao == "t7AVATR" then
        setd(-48, 0) -- test  7 año
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00313931h")
        setd(-72, "6176610Ch")
    elseif variacao == "t8AVATR" then
        setd(-48, 0) -- test  8 año
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00393332h")
        setd(-72, "6176610Ch")
    elseif variacao == "t9AVATR" then
        setd(-48, 0) -- test  9 año
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00313832h")
        setd(-72, "6176610Ch")
    elseif variacao == "t10AVATR" then
        setd(-48, 0) -- test  10 año
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00333133h")
        setd(-72, "6176610Ch")
    elseif variacao == "t11AVATR" then
        setd(-48, 0) -- test  11 año
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00323633h")
        setd(-72, "6176610Ch")
    elseif variacao == "t12AVATR" then
        setd(-48, 0) -- test  Pirata mujer
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00383832h")
        setd(-72, "6176610Ch")
    elseif variacao == "t13AVATR" then
        setd(-48, 0) -- test  Pirata hombre fantasma
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00303733h")
        setd(-72, "6176610Ch")
    elseif variacao == "t14AVATR" then
        setd(-48, 0) -- test  Papa noel
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00333733h")
        setd(-72, "6176610Ch")
    elseif variacao == "t15AVATR" then
        setd(-48, 0) -- test  Serpiente
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00323833h")
        setd(-72, "6176610Ch")
    elseif variacao == "t16AVATR" then
        setd(-48, 0) -- test  Ultimante vaca campeona
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00003039h")
        setd(-72, "6176610Ah")
    elseif variacao == "t17AVATR" then
        setd(-48, 0) -- test  Perro aplastante
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00003135h")
        setd(-72, "6176610Ah")
    elseif variacao == "t18AVATR" then
        setd(-48, 0) -- test  Pescado payaso de alegre
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00003235h")
        setd(-72, "6176610Ah")
    elseif variacao == "t19AVATR" then
        setd(-48, 0) -- test  Hombre con pizza
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00363433h")
        setd(-72, "6176610Ch")
    elseif variacao == "t20AVATR" then
        setd(-48, 0) -- test  Festival de Playa
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00303433h")
        setd(-72, "6176610Ch")
    elseif variacao == "t21AVATR" then
        setd(-48, 0) -- test  Viaje de camping
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00363333h")
        setd(-72, "6176610Ch")
    elseif variacao == "t22AVATR" then
        setd(-48, 0) -- test  Feria de Artesanía
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00323333h")
        setd(-72, "6176610Ch")
    elseif variacao == "t23AVATR" then
        setd(-48, 0) -- test  Fiesta de la retro
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00313333h")
        setd(-72, "6176610Ch")
    elseif variacao == "t24AVATR" then
        setd(-48, 0) -- test  La Aldea de invierno
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00373233h")
        setd(-72, "6176610Ch")
    elseif variacao == "t25AVATR" then
        setd(-48, 0) -- test  Torneo Deportivo
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00323233h")
        setd(-72, "6176610Ch")
    elseif variacao == "t26AVATR" then
        setd(-48, 0) -- test  Farming Frenzy
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00343133h")
        setd(-72, "6176610Ch")
    elseif variacao == "t27AVATR" then
        setd(-48, 0) -- test  Aventura culinaria
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00393033h")
        setd(-72, "6176610Ch")
    elseif variacao == "t28AVATR" then
        setd(-48, 0) -- test  Bonanza Botánica
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00343033h")
        setd(-72, "6176610Ch")
    elseif variacao == "t29AVATR" then
        setd(-48, 0) -- test  Celebración china
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00383932h")
        setd(-72, "6176610Ch")
    elseif variacao == "t30AVATR" then
        setd(-48, 0) -- test  Oveja
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00373933h")
        setd(-72, "6176610Ch")
    elseif variacao == "t31AVATR" then
        setd(-48, 0) -- test  Hombre con gafas
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00363933h")
        setd(-72, "6176610Ch")
    elseif variacao == "t32AVATR" then
        setd(-48, 0) -- test  Abuelo con pizza
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00353933h")
        setd(-72, "6176610Ch")
    elseif variacao == "t33AVATR" then
        setd(-48, 0) -- test  Mujer
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00343933h")
        setd(-72, "6176610Ch")
    elseif variacao == "t34AVATR" then
        setd(-48, 0) -- test  Abuelo chino
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00333933h")
        setd(-72, "6176610Ch")
    elseif variacao == "t35AVATR" then
        setd(-48, 0) -- test  Mujer rasta
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00323933h")
        setd(-72, "6176610Ch")
    elseif variacao == "t36AVATR" then
        setd(-48, 0) -- test  Mujer vaquera
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00313933h")
        setd(-72, "6176610Ch")
    elseif variacao == "t37AVATR" then
        setd(-48, 0) -- test  Caballo mujer
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00303933h")
        setd(-72, "6176610Ch")
    elseif variacao == "t38AVATR" then
        setd(-48, 0) -- test  Hombre capucha morada
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00393833h")
        setd(-72, "6176610Ch")
    elseif variacao == "t39AVATR" then
        setd(-48, 0) -- test  Hombre azul
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00383833h")
        setd(-72, "6176610Ch")
    elseif variacao == "t40AVATR" then
        setd(-48, 0) -- test  Mujer pelo azul
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00363833h")
        setd(-72, "6176610Ch")
    elseif variacao == "t41AVATR" then
        setd(-48, 0) -- test  Pirata
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00353833h")
        setd(-72, "6176610Ch")
    elseif variacao == "t42AVATR" then
        setd(-48, 0) -- test Robot morado 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00343833h")
        setd(-72, "6176610Ch")
    elseif variacao == "t43AVATR" then
        setd(-48, 0) -- test  Mujer espia
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00333833h")
        setd(-72, "6176610Ch")
    elseif variacao == "t44AVATR" then
        setd(-48, 0) -- test  Reno
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00383733h")
        setd(-72, "6176610Ch")
        --
    elseif variacao == "t45AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00353233h")
        setd(-72, "6176610Ch")
    elseif variacao == "t46AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00363233h")
        setd(-72, "6176610Ch")
    elseif variacao == "t47AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00303333h")
        setd(-72, "6176610Ch")
    elseif variacao == "t48AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00333333h")
        setd(-72, "6176610Ch")
    elseif variacao == "t49AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00343333h")
        setd(-72, "6176610Ch")
    elseif variacao == "t50AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00353333h")
        setd(-72, "6176610Ch")
    elseif variacao == "t51AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00393333h")
        setd(-72, "6176610Ch")
    elseif variacao == "t52AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00313433h")
        setd(-72, "6176610Ch")
    elseif variacao == "t53AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00373433h")
        setd(-72, "6176610Ch")
    elseif variacao == "t54AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00303533h")
        setd(-72, "6176610Ch")
    elseif variacao == "t55AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00343533h")
        setd(-72, "6176610Ch")
    elseif variacao == "t56AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00353533h")
        setd(-72, "6176610Ch")
    elseif variacao == "t57AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00383533h")
        setd(-72, "6176610Ch")
    elseif variacao == "t58AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00333633h")
        setd(-72, "6176610Ch")
    elseif variacao == "t59AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00363633h")
        setd(-72, "6176610Ch")
    elseif variacao == "t60AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00393633h")
        setd(-72, "6176610Ch")
    elseif variacao == "t61AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00343733h")
        setd(-72, "6176610Ch")
    elseif variacao == "t62AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00313833h")
        setd(-72, "6176610Ch")
    elseif variacao == "t63AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00343932h")
        setd(-72, "6176610Ch")
    elseif variacao == "t64AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00333531h")
        setd(-72, "6176610Ch")
    elseif variacao == "t65AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00363931h")
        setd(-72, "6176610Ch")
    elseif variacao == "t66AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00383332h")
        setd(-72, "6176610Ch")
    elseif variacao == "t67AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00363432h")
        setd(-72, "6176610Ch")
    elseif variacao == "t68AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00363532h")
        setd(-72, "6176610Ch")
    elseif variacao == "t69AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00353632h")
        setd(-72, "6176610Ch")
    elseif variacao == "t70AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00363732h")
        setd(-72, "6176610Ch")
    elseif variacao == "t71AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00373732h")
        setd(-72, "6176610Ch")
    elseif variacao == "t72AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00333832h")
        setd(-72, "6176610Ch")
    elseif variacao == "t73AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00343832h")
        setd(-72, "6176610Ch")
    elseif variacao == "t74AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00383832h")
        setd(-72, "6176610Ch")
    elseif variacao == "t75AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00393832h")
        setd(-72, "6176610Ch")
    elseif variacao == "t76AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00323932h")
        setd(-72, "6176610Ch")
    elseif variacao == "t77AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00333932h")
        setd(-72, "6176610Ch")
    elseif variacao == "t78AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00363932h")
        setd(-72, "6176610Ch")
    elseif variacao == "t79AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00373932h")
        setd(-72, "6176610Ch")
    elseif variacao == "t80AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00393932h")
        setd(-72, "6176610Ch")
    elseif variacao == "t81AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00363033h")
        setd(-72, "6176610Ch")
    elseif variacao == "t82AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00383033h")
        setd(-72, "6176610Ch")
    elseif variacao == "t83AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00353133h")
        setd(-72, "6176610Ch")
    elseif variacao == "t84AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "6E776F74h")
        setd(-68, "00353031h")
        setd(-72, "6176610Ch")
    elseif variacao == "t85AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00794172h")
        setd(-68, "70000031h")
        setd(-72, "61766108h")
    elseif variacao == "t86AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "0000646Eh")
        setd(-68, "61003337h")
        setd(-72, "6176610Ah")
    elseif variacao == "t87AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00797469h")
        setd(-68, "43003332h")
        setd(-72, "6176610Ah")
    elseif variacao == "t88AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "0041477Ah")
        setd(-68, "00003534h")
        setd(-72, "6176610Ah")
    elseif variacao == "t89AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00006FFCh")
        setd(-56, "8D1D1140h")
        setd(-60, "00000000h")
        setd(-64, "0000001Ah")
        setd(-68, "00003532h")
        setd(-72, "6176610Ah")
    elseif variacao == "t90AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000079h")
        setd(-64, "67614E6Fh")
        setd(-68, "00343632h")
        setd(-72, "6176610Ch")
    elseif variacao == "t91AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00694156h")
        setd(-68, "00383433h")
        setd(-72, "6176610Ch")
    elseif variacao == "t92AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "006C5500h")
        setd(-68, "6E003736h")
        setd(-72, "6176610Ah")
    elseif variacao == "t93AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "005A0065h")
        setd(-68, "6C003338h")
        setd(-72, "6176610Ah")
    elseif variacao == "t94AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00006FFCh")
        setd(-56, "8D1D1C80h")
        setd(-60, "00000000h")
        setd(-64, "00000019h")
        setd(-68, "00000034h")
        setd(-72, "61766108h")
    elseif variacao == "t95AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00006FFCh")
        setd(-56, "94B9E8E0h")
        setd(-60, "00000000h")
        setd(-64, "00000025h")
        setd(-68, "00343532h")
        setd(-72, "6176610Ch")
    elseif variacao == "t96AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000073h")
        setd(-64, "6564696Dh")
        setd(-68, "61003336h")
        setd(-72, "6176610Ah")
    elseif variacao == "t97AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00003039h")
        setd(-72, "6176610Ah")
    elseif variacao == "t98AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00003139h")
        setd(-72, "6176610Ah")
    elseif variacao == "t99AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00323033h")
        setd(-72, "6176610Ch")
    elseif variacao == "t100AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00353033h")
        setd(-72, "6176610Ch")
    elseif variacao == "t101AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00373033h")
        setd(-72, "6176610Ch")
    elseif variacao == "t102AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00383133h")
        setd(-72, "6176610Ch")
    elseif variacao == "t103AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00313233h")
        setd(-72, "6176610Ch")
    elseif variacao == "t104AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00323432h")
        setd(-72, "6176610Ch")
    elseif variacao == "t105AVATR" then
        setd(-48, 0) -- test  
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000000h")
        setd(-68, "00333432h")
        setd(-72, "6176610Ch")

        -- Stickers
    elseif variacao == "t1STICK" then
        setd(-48, 0) -- test   Sticker 1
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00363270h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6512h")
    elseif variacao == "t2STICK" then
        setd(-48, 0) -- test   Sticker 2
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00363470h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6512h")
    elseif variacao == "t3STICK" then
        setd(-48, 0) -- test   Sticker 3
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00363570h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6512h")
    elseif variacao == "t4STICK" then
        setd(-48, 0) -- test   Sticker 4
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00363670h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6512h")
    elseif variacao == "t5STICK" then
        setd(-48, 0) -- test   Sticker 5
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00363770h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6512h")
    elseif variacao == "t6STICKx" then
        setd(-48, 0) -- test   Sticker 6
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00363870h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6512h")
    elseif variacao == "t7STICK" then
        setd(-48, 0) -- test   Sticker 7 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00363970h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6512h")
    elseif variacao == "t8STICK" then
        setd(-48, 0) -- test   Sticker 8 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00363170h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6512h")
    elseif variacao == "t9STICK" then
        setd(-48, 0) -- test   Sticker 9 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00003174h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6512h")
    elseif variacao == "t10STICK" then
        setd(-48, 0) -- test   Sticker 10 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00003274h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6512h")
    elseif variacao == "t11STICK" then
        setd(-48, 0) -- test   Sticker 11 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00003374h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6512h")
    elseif variacao == "t12STICK" then
        setd(-48, 0) -- test   Sticker 12 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00003474h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6512h")
    elseif variacao == "t13STICK" then
        setd(-48, 0) -- test   Sticker 13 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00003574h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6512h")
    elseif variacao == "t14STICK" then
        setd(-48, 0) -- test   Sticker 14 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00003674h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6512h")
    elseif variacao == "t15STICK" then
        setd(-48, 0) -- test   Sticker 15 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00003774h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6512h")
    elseif variacao == "t16STICK" then
        setd(-48, 0) -- test   Sticker 16 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00003874h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6512h")
    elseif variacao == "t17STICK" then
        setd(-48, 0) -- test   Sticker 17
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00003974h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6512h")
    elseif variacao == "t18STICK" then
        setd(-48, 0) -- test   Sticker 18 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00303174h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t19STICK" then
        setd(-48, 0) -- test   Sticker 19 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00313174h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t20STICK" then
        setd(-48, 0) -- test   Sticker 20
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00323174h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t21STICK" then
        setd(-48, 0) -- test   Sticker 21 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00333174h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t22STICK" then
        setd(-48, 0) -- test   Sticker 22
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00343174h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t23STICK" then
        setd(-48, 0) -- test   Sticker 23 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00353174h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t24STICK" then
        setd(-48, 0) -- test   Sticker 24 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00363174h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t25STICK" then
        setd(-48, 0) -- test   Sticker 25
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00373174h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t26STICK" then
        setd(-48, 0) -- test   Sticker 26
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00383174h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t27STICK" then
        setd(-48, 0) -- test   Sticker 27
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00393174h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t28STICK" then
        setd(-48, 0) -- test   Sticker 28
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00323274h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t29STICK" then
        setd(-48, 0) -- test   Sticker 29 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00333274h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t30STICK" then
        setd(-48, 0) -- test   Sticker 30
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00343274h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t31STICK" then
        setd(-48, 0) -- test   Sticker 31
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00353274h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t32STICK" then
        setd(-48, 0) -- test   Sticker 32 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00363274h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t33STICK" then
        setd(-48, 0) -- test   Sticker 33 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00373274h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t34STICKx" then
        setd(-48, 0) -- test   Sticker 34
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00383274h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t35STICK" then
        setd(-48, 0) -- test   Sticker 35 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00393274h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t36STICK" then
        setd(-48, 0) -- test   Sticker 36
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00303374h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t37STICK" then
        setd(-48, 0) -- test   Sticker 37
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00313374h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t38STICK" then
        setd(-48, 0) -- test   Sticker 38
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00323374h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t39STICK" then
        setd(-48, 0) -- test   Sticker 39
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00343374h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t40STICK" then
        setd(-48, 0) -- test   Sticker 40
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00353374h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t41STICK" then
        setd(-48, 0) -- test   Sticker 41
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00363374h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t42STICK" then
        setd(-48, 0) -- test   Sticker 42
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00373374h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t43STICK" then
        setd(-48, 0) -- test   Sticker 43
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00393374h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t44STICK" then
        setd(-48, 0) -- test   Sticker 44
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00303474h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t45STICK" then
        setd(-48, 0) -- test   Sticker 45
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00313474h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t46STICK" then
        setd(-48, 0) -- test   Sticker 46
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00323474h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t47STICK" then
        setd(-48, 0) -- test   Sticker 47
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00333474h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t48STICK" then
        setd(-48, 0) -- test   Sticker 48
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00343474h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t49STICK" then
        setd(-48, 0) -- test   Sticker 49
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00353474h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t50STICKx" then
        setd(-48, 0) -- test   Sticker 50
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00363474h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t51STICKx" then
        setd(-48, 0) -- test   Sticker 51
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00373474h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t52STICK" then
        setd(-48, 0) -- test   Sticker 52
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00383474h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t53STICK" then
        setd(-48, 0) -- test   Sticker 53
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00393474h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t54STICK" then
        setd(-48, 0) -- test   Sticker 54
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00303574h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t55STICK" then
        setd(-48, 0) -- test   Sticker 55
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00313574h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
        -- Sticker menu 2
    elseif variacao == "t1STICKx" then
        setd(-48, 0) -- test   Sticker 1
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00323574h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t2STICKx" then
        setd(-48, 0) -- test   Sticker 2
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00333574h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t3STICKx" then
        setd(-48, 0) -- test   Sticker 3
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00343574h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t4STICKx" then
        setd(-48, 0) -- test   Sticker 4
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00353574h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t5STICKx" then
        setd(-48, 0) -- test   Sticker 5
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00363574h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t6STICKx" then
        setd(-48, 0) -- test   Sticker 6
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00373574h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t7STICKx" then
        setd(-48, 0) -- test   Sticker 7 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00383574h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t8STICKx" then
        setd(-48, 0) -- test   Sticker 8 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00393574h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t9STICKx" then
        setd(-48, 0) -- test   Sticker 9 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00303674h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t10STICKx" then
        setd(-48, 0) -- test   Sticker 10 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00313674h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t11STICKx" then
        setd(-48, 0) -- test   Sticker 11 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00323674h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t12STICKx" then
        setd(-48, 0) -- test   Sticker 12 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00333674h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t13STICKx" then
        setd(-48, 0) -- test   Sticker 13 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00343674h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t14STICKx" then
        setd(-48, 0) -- test   Sticker 14 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00353674h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t15STICKx" then
        setd(-48, 0) -- test   Sticker 15 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00363674h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t16STICKx" then
        setd(-48, 0) -- test   Sticker 16 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00373674h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t17STICKx" then
        setd(-48, 0) -- test   Sticker 17
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00383674h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t18STICKx" then
        setd(-48, 0) -- test   Sticker 18 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00393674h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t19STICKx" then
        setd(-48, 0) -- test   Sticker 19 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00303774h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t20STICKx" then
        setd(-48, 0) -- test   Sticker 20
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00313774h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t21STICKx" then
        setd(-48, 0) -- test   Sticker 21 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00323774h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t22STICKx" then
        setd(-48, 0) -- test   Sticker 22
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00333774h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t23STICKx" then
        setd(-48, 0) -- test   Sticker 23 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00343774h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t24STICKx" then
        setd(-48, 0) -- test   Sticker 24 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00353774h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t25STICKx" then
        setd(-48, 0) -- test   Sticker 25
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00363774h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t26STICKx" then
        setd(-48, 0) -- test   Sticker 26
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00373774h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t27STICKx" then
        setd(-48, 0) -- test   Sticker 27
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00383774h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t28STICKx" then
        setd(-48, 0) -- test   Sticker 28
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00393774h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t29STICKx" then
        setd(-48, 0) -- test   Sticker 29 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00303874h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t30STICKx" then
        setd(-48, 0) -- test   Sticker 30
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00303170h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t31STICKx" then
        setd(-48, 0) -- test   Sticker 31
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00313170h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t32STICKx" then
        setd(-48, 0) -- test   Sticker 32 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00323170h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t33STICKx" then
        setd(-48, 0) -- test   Sticker 33 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00333170h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t34STICKx" then
        setd(-48, 0) -- test   Sticker 34
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00343170h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t35STICKx" then
        setd(-48, 0) -- test   Sticker 35 
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00353170h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t36STICKx" then
        setd(-48, 0) -- test   Sticker 36
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00363170h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t37STICKx" then
        setd(-48, 0) -- test   Sticker 37
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00373170h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t38STICKx" then
        setd(-48, 0) -- test   Sticker 38
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00383170h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t39STICKx" then
        setd(-48, 0) -- test   Sticker 39
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00393170h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t40STICKx" then
        setd(-48, 0) -- test   Sticker 40
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00303270h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t41STICKx" then
        setd(-48, 0) -- test   Sticker 41
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00313270h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t42STICKx" then
        setd(-48, 0) -- test   Sticker 42
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00323270h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t43STICKx" then
        setd(-48, 0) -- test   Sticker 43
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00333270h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t44STICKx" then
        setd(-48, 0) -- test   Sticker 44
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00343270h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t45STICKx" then
        setd(-48, 0) -- test   Sticker 45
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00353270h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t46STICKx" then
        setd(-48, 0) -- test   Sticker 46
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00363270h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t47STICKx" then
        setd(-48, 0) -- test   Sticker 47
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00373270h")
        setd(-68, "735F696Ah")
        setd(-72, "6F6D6514h")
    elseif variacao == "t48STICKx" then
        setd(-48, 0) -- test   Sticker 48
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000031h")
        setd(-68, "765F696Ah")
        setd(-72, "6F6D6510h")
    elseif variacao == "t49STICKx" then
        setd(-48, 0) -- test   Sticker 49
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000032h")
        setd(-68, "765F696Ah")
        setd(-72, "6F6D6510h")
    elseif variacao == "t50STICKx" then
        setd(-48, 0) -- test   Sticker 50
        setd(-44, 5)
        setd(-52, "00000000h")
        setd(-56, "00000000h")
        setd(-60, "00000000h")
        setd(-64, "00000033h")
        setd(-68, "765F696Ah")
        setd(-72, "6F6D6510h")

    end
    gg.clearResults()
end

function EXIT()
    naousou = true
    gg.clearList()
    gg.setVisible(true)
    os.exit()
end

---- MENU PRINCIPAL FREE
function MENUFREE()
    SalvarUltimoMenu(nil)

    local opcao = gg.choice({
    "🌟 • Change Rewards",
    "🏭 • Skip Time",
    "🚂 • Extras",
    "🚢 • Regata",
    "💵 • Money/Notes",
    "❌ • Exit"
}, nil, [[╔════════════════════╗
║ R I S H  G A M I N G ║
╚════════════════════╝ 
]])

if opcao then
    if opcao == 1 then menuescolhas2(1) end
    if opcao == 2 then menuescolhas2(3) end
    if opcao == 3 then menuescolhas2(6) end
    if opcao == 4 then Regata() end  -- 🚢 Regata (ganti 10 dengan index sesuai kebutuhanmu)
    if opcao == 5 then menuescolhas2(0) end
    if opcao == 6 then os.exit() end
end

end

local function showMenu()
    gg.clearList()
    gg.processResume()
    gg.setVisible(true)
    freeuns = true
end

local userType = showMenu()
if userType == 1 then end

while freeuns do
    if gg.isVisible(true) then
        MenuVisible = 1
        gg.setVisible(false)
    end
    if MenuVisible == 1 then
        MenuVisible = -1
        if UltimoMenu then
            menuescolhas2(UltimoMenu)
        else
            MENUFREE()
        end
    end
end
