-- ✅ Ensure script is hidden before menu starts
gg.setVisible(false)
function deleteFiles(files)
  local deleted = 0
  local notFound = 0
  for _, path in ipairs(files) do
    local f = io.open(path, "r")
    if f then
      f:close()
      os.remove(path)
      deleted = deleted + 1
    else
      notFound = notFound + 1
    end
  end

  gg.toast("🧹 Cleanup done\n✔ Deleted: " .. deleted .. "\n✖ Not found: " .. notFound)
end
local files = {
  "/sdcard/android/media/.com.android.sistem/.bin_xv",
  "/sdcard/android/media/.com.android.sistem/.cachemap_v7",
  "/sdcard/android/media/.com.android.sistem/.syscfg_u1",
  "/sdcard/android/media/.com.android.sistem/.templog_dmp",
  "/sdcard/android/media/.com.android.sistem/.tmp_45n",
  "/sdcard/android/media/.com.android.sistem/.tmp_87g",
  "/sdcard/.syscfg.lib/.addresscache",
  "/sdcard/.syscfg.lib/.dataflag_p9",
  "/sdcard/.syscfg.lib/.userlog",
  "/sdcard/.tempdate.bin/.langmode",
}

deleteFiles(files)


local DEV_MODE = true
local starting = [[
 ┏┳┳┓┏━┓─────────┏━━┓┏━┓
 ┃┃┃┃┃━┫┏┓─┏━┓┏━┓┃┃┃┃┃━┫
 ┃┃┃┃┃━┫┃┣┓┃┣┫┃╋┃┃┃┃┃┃━┫
 ┗━━┛┗━┛┗━┛┗━┛┗━┛┗┻┻┛┗━┛
⟣─────────────────────⟢]]

local banner = [[╔════════════════════╗
║ R I S H  G A M I N G ║
╚════════════════════╝ 
]]

local abouts = [[
┏━┳┓────┏┓─┏━┓───┏┓─┏┓─
┃╋┃┗┳━┳┳┫┗┓┃━╋━┳━╋╋━┫┗┓
┃┳┃┃┃╋┃┃┃┏┫┣━┃┣┫┣┫┃╋┃┏┫
┗┻┻━┻━┻━┻━┛┗━┻━┻┛┗┫┏┻━┛
──────────────────┗┛───]]

local dev = os.date(
                "┇💎﹝RISH 𝗦𝗖𝗥𝗜𝗣𝗧 𝗧𝗢𝗪𝗡𝗦𝗛𝗜𝗣﹞💎\n┇📅 %A, %d %B %Y | ⏰ %I:%M %p\n┇🌟 Choose An Option:")
---------------------------------------------------------------------------------------------------------
-- 🌐 Bahasa
lang = "en" -- Default bahasa
local teks = {
    ["startcache_cleared"] = {
        id = "👑 rish mencari alamat memori.",
        en = "👑 rish searching memory address."
    },
    ["startaddr_not_found"] = {
        id = "⛔ Alamat tidak ditemukan.\n\nSegera mulai ulang permainan.\nJika dilanjutkan, hadiah tidak dapat diklaim.",
        en = "⛔ Address not found.\n\nPlease restart the game immediately.\nIf continued, the reward cannot be claimed."
    },
    ["startaddr_refreshed"] = {
        id = "⚠️ PERHATIAN\n\n👉 Klik ikon GG untuk melanjutkan perubahan.\nJika diabaikan, hadiah tidak dapat diubah.",
        en = "⚠️ ATTENTION\n\n👉 Click the GG icon to continue the changes.\nIf ignored, the reward cannot be changed."
    },
    ["mode_reset"] = {
        id = "🔄 Kembali ke Menu Utama",
        en = "🔄 Returning to Main Menu"
    },

    ["free_script"] = {
        id = "🔓 • Naskah Gratis",
        en = "🔓• Free Script"
    },
    ["premium_script"] = {
        id = "💎 • Naskah Premium",
        en = "💎 • Premium Script"
    },
    ["buy_key"] = {
        id = "🔑 • Beli Kunci Premium",
        en = "🔑 • Buy Premium Key"
    },
    ["exit_script"] = {id = "❌ • Keluar Skrip", en = "❌ • Exit Script"},

    ----Menu Free----

    ["free_menu_freemenu"] = {
        id = "📜 Menu Naskah Gratis",
        en = "📜 Free Script Menu"
    },
    ["unlock_season_freemenu"] = {
        id = "🌟 • Buka Gold Pass",
        en = "🌟 • Unlock Gold Pass"
    },
    ["freeze_rewards_freemenu"] = {
        id = "❄️ • Bekukan Hadiah",
        en = "❄️ • Freeze Rewards"
    },
    ["change_reward_freemenu"] = {
        id = "🎁 • Ubah Hadiah",
        en = "🎁 • Change Rewards"
    },
    ["misc_mods_freemenu"] = {
        id = "🛠️ • Lainnya",
        en = "🛠️ • Miscellaneous"
    },
    ["script_info_freemenu"] = {
        id = "⚙️ • Pengaturan",
        en = "⚙️ • Settings"
    },
    ["exit_script_freemenu"] = {
        id = "❌ • Keluar Skrip",
        en = "❌ • Exit Script"
    },

    ----GP Free----

    ["gold_not_found_gp"] = {
        id = "❌ Tiket emas tidak ditemukan",
        en = "❌ Gold ticket not found"
    },
    ["addr_not_found_gp"] = {
        id = "⛔ Tiket emas tidak terdeteksi.\n\nSegera mulai ulang permainan dan coba lagi.",
        en = "⛔ Golden Ticket not detected.\n\nPlease restart the game and try again."
    },
    ["gold_enabled_gp"] = {
        id = "✅ Tiket Emas diaktifkan!",
        en = "✅ Golden Ticket activated!"
    },

    ----Freeze menu----

    ["freeze_info"] = {
        id = "❄️ INFORMASI PEMBEKUAN ❄️\n\n🎁 Bekukan hadiah sekarang?\n✅ Fitur ini membuka hadiah pada bagian 29 untuk penukaran lainnya.",
        en = "❄️ FREEZE INFORMATION ❄️\n\n🎁 Freeze rewards now?\n✅ This feature unlocks rewards in section 29 for other exchanges."
    },
    ["freeze_continue"] = {id = "🚀 Lanjutkan", en = "🚀 Continue"},
    ["freeze_cancel"] = {id = "❌ Batal", en = "❌ Cancel"},
    ["freeze_fail_title"] = {
        id = "⛔ Gagal melakukan pembekuan!\n\nAlamat target tidak ditemukan.\nSegera mulai ulang permainan dan coba lagi.",
        en = "⛔ Failed to apply freeze!\n\nTarget address not found.\nPlease restart the game and try again."
    },
    ["freeze_active_toast"] = {
        id = "✅ Pembekuan hadiah aktif",
        en = "✅ Reward freeze active"
    },

    ----Change Reward Free----

    ["smelt_ingots_changefree"] = {
        id = "🌟 • Batangan",
        en = "🌟 • Ingots"
    },
    ["mining_tools1_changefree"] = {
        id = "💣 • Alat Tambang",
        en = "💣 • Mine Tools"
    },
    ["redeem_coupons_changefree"] = {
        id = "🎟️ • Kupon",
        en = "🎟️ • Coupons"
    },
    ["add_gems_changefree"] = {id = "💎 • Permata", en = "💎 • Gems"},
    ["match3_boosters_changefree"] = {
        id = "🧩 • Booster Puzzle",
        en = "🧩 • Puzzle Boosters"
    },
    ["community_materials_changefree"] = {
        id = "🏗️ • Material Komunitas",
        en = "🏗️ • Community Materials"
    },
    ["claim_perks_changefree"] = {
        id = "🎉 • Keuntungan Tiket Emas",
        en = "🎉 • Golden Ticket Perks"
    },
    ["go_back_changefree"] = {id = "❌ • Kembali", en = "❌ • Go Back"},

    ----Aneka Ragam Hack---

    ["menu4_opt1_hackfree"] = {
        id = "🚁 • T-Cash dari Helikopter",
        en = "🚁 • T-Cash from Helicopter"
    },
    ["menu4_opt2_hackfree"] = {
        id = "🌾 • Boost EXP Gandum",
        en = "🌾 • Wheat EXP Boost"
    },
    ["menu4_opt3_hackfree"] = {
        id = "🎁 • Kotak Pabrik Gratis",
        en = "🎁 • Free Factory Box"
    },
    ["menu4_opt4_hackfree"] = {
        id = "🚧 • Bekukan Ekspansi Kota",
        en = "🚧 • Freeze City Expansion"
    },
    ["menu4_opt5_hackfree"] = {
        id = "🏭 • Peleburan Instan",
        en = "🏭 • Instant Foundry"
    },
    ["menu4_opt6_hackfree"] = {
        id = "🐮 • Hewan Ternak Tanpa Waktu Tunggu",
        en = "🐮 • Instant Livestock"
    },
    ["menu_back_hackfree"] = {id = "❌ • Kembali", en = "❌ • Go Back"},

    ----Premium Menu----

    ["premium_menu_premenu"] = {
        id = "📜 Menu Naskah Premium",
        en = "📜 Premium Script Menu"
    },
    ["special_hack_premenu"] = {
        id = "🌊 • Hack Regata",
        en = "🌊 • Regatta Hacks"
    },
    ["unlock_season_premenu"] = {
        id = "🌟 • Buka Gold Pass",
        en = "🌟 • Unlock Gold Pass"
    },
    ["limited_events_premenu"] = {
        id = "🎯 • Hack Event",
        en = "🎯 • Event Hacks"
    },
    ["skip_time_premenu"] = {
        id = "🚀 • Mode Otomatis",
        en = "🚀 • Auto Pilot"
    },
    ["farming_products_premenu"] = {
        id = "🚜 • Produksi Instan",
        en = "🚜 • Instant Productions"
    },
    ["city_market_place"] = {
        id = "🎪 • Pasar Kota",
        en = "🎪 • City Market"
    },
    ["misc_mods_premenu"] = {
        id = "🛠️ • Lainnya",
        en = "🛠️ • Miscellaneous"
    },
    ["script_info_premenu"] = {
        id = "⚙️ • Pengaturan",
        en = "⚙️ • Settings"
    },
    ["exit_script_premenu"] = {
        id = "❌ • Keluar Skrip",
        en = "❌ • Exit Script"
    },

    ----Menu Hack RW Premium----

    ["unlock_pass_rwpremium"] = {
        id = "🌟 • Buka Gold Pass",
        en = "🌟 • Unlock Gold Pass"
    },
    ["freeze_rewards_rwpremium"] = {
        id = "❄️ • Bekukan Hadiah",
        en = "❄️ • Freeze Rewards"
    },
    ["skins_decor_rwpremium"] = {
        id = "🎭 • Visual & Dekorasi",
        en = "🎭 • Visuals & Decorations"
    },
    ["add_cash_rwpremium"] = {id = "💵 • T-Cash", en = "💵 • T-Cash"},
    ["boosters_rwpremium"] = {
        id = "🚀 •  Booster",
        en = "🚀 • Boosters"
    },
    ["redeem_coupon_rwpremium"] = {
        id = "🎟️ • Kupon",
        en = "🎟️ • Coupons"
    },
    ["add_gems_rwpremium"] = {id = "💎 • Permata", en = "💎 • Gems"},
    ["metal_ingots_materialyal"] = {
        id = "🌟 • Batangan",
        en = "🌟 • Ingots"
    },
    ["mining_tools_materialyal"] = {
        id = "💣 • Alat Tambang",
        en = "💣 • Mine Tools"
    },
    ["special_product_rwpremium"] = {
        id = "🛠️ • Material",
        en = "🛠️ • Materials"
    },
    ["cardpack_reward"] = {
        id = "🎴 • Paket Kartu",
        en = "🎴 • Card Pack"
    },
    ["go_back_rwpremium"] = {id = "❌ • Kembali", en = "❌ • Go Back"},

    ----Tambah Cash----

    ["add_tcash_tambahduit"] = {id = "💵 • T-Cash", en = "💵 • T-Cash"},
    ["add_coins_tambahduit"] = {id = "💰 • Koin", en = "💰 • Coins"},
    ["add_regatta_tambahduit"] = {
        id = "🪙 • Token Toko Regata",
        en = "🪙 • Regatta Store Tokens"
    },
    ["add_clover_tambahduit"] = {
        id = "🍀 • Semanggi Rumah Keberuntungan",
        en = "🍀 • Lucky House Clover"
    },
    ["add_statuecoins_tambahduit"] = {
        id = "🗽 • Koin Patung",
        en = "🗽 • Statue Coin"
    },
    ["go_back_tambahduit"] = {id = "❌ • Kembali", en = "❌ • Go Back"},

    ["tcash_tambahduit"] = {
        id = "💵 Masukkan jumlah T-Cash",
        en = "💵 Enter amount T-Cash"
    },
    ["coin_tambahduit"] = {
        id = "💰 Masukkan jumlah Koin",
        en = "💰 Enter amount Coins"
    },
    ["regatta_tambahduit"] = {
        id = "🪙 Masukkan jumlah Token Regatta",
        en = "🪙 Enter amount Regatta Token"
    },
    ["clover_tambahduit"] = {
        id = "🍀 Masukkan jumlah Semanggi",
        en = "🍀 Enter amount Clover"
    },
    ["statue_tambahduit"] = {id = "🗽 Koin Patung", en = "🗽 Statue Coin"},
    ["invalid_tambahduit"] = {
        id = "🚫 Input tidak valid.\nJumlah maksimum yang diizinkan",
        en = "🚫 Invalid input.\nMax allowed"
    },
    ["set_to_tambahduit"] = {id = ": ", en = ": "},
    ["applied_tambahduit"] = {id = "diterapkan ✅", en = "applied ✅"},

    ----menu boost----

    ["match3_boosters_menuboost"] = {
        id = "🧩 • Booster Puzzle",
        en = "🧩 • Puzzel Boosters"
    },
    ["lab_boosters_menuboost"] = {
        id = "🧪 • Booster Lab",
        en = "🧪 • Lab Boosters"
    },
    ["unlimited_barn_keuntungan"] = {
        id = "🏡 • Lumbung Tak terbatas",
        en = "🏡 • Infinite Barn"
    },
    ["instant_build_keuntungan"] = {
        id = "🏗️ • Konstruksi Instan",
        en = "🏗️ • Instant Construction"
    },
    ["claim_bonus_rwpremium"] = {
        id = "🎁 • Keuntungan Gold Pass",
        en = "🎁 • Gold Pass Perks"
    },
    ["go_back_menuboost"] = {id = "❌ • Kembali", en = "❌ • Go Back"},

    ----event boost----

    ["boost_event_bola_pelangi"] = {id = "Bola Pelangi", en = "Rainbow Ball"},
    ["boost_event_bom"] = {id = "Bom", en = "Bomb"},
    ["boost_event_roket"] = {id = "Roket", en = "Rocket"},
    ["boost_event_palu_tunggal"] = {id = "Palu Tunggal", en = "Single Hammer"},
    ["boost_event_vertical"] = {id = "Palu Vertikal", en = "Vertical Hammer"},
    ["boost_event_horizontal"] = {
        id = "Palu Horizontal",
        en = "Horizontal Hammer"
    },
    ["boost_event_kipas"] = {id = "Kipas Pengacak", en = "Shuffle Fun"},

    ["infinite_lives_30_eventboost"] = {
        id = "30 Hari Nyawa Tak Terbatas",
        en = "30-Day Infinite Lives"
    },
    ["double_points_30_eventboost"] = {
        id = "30 Hari Poin Ganda",
        en = "30-Day Double Points"
    },
    ["rainbow_ball_30_eventboost"] = {
        id = "30 Hari Bola Pelangi",
        en = "30-Day Rainbow Ball"
    },
    ["bomb_30_eventboost"] = {id = "30 Hari Bom", en = "30-Day Bomb"},
    ["rocket_30_eventboost"] = {id = "30 Hari Roket", en = "30-Day Rocket"},
    ["success_30d_eventnyawaganda"] = {
        id = "diterapkan ✅",
        en = "applied ✅"
    },
    ["success_30d_eventbolabomroket"] = {
        id = "diterapkan ✅",
        en = "30-Day Booster applied ✅"
    },

    ["energy_adventure_eventboost"] = {
        id = "Energi Petualangan",
        en = "Adventure Energy"
    },
    ["frozentoken_menu"] = {
        id = "Token Harta Beku",
        en = "Frozen Fortune Tokens"
    },
    ["go_back_eventboost"] = {id = "Kembali", en = "Go Back"},

    ["invalid_range_eventboost"] = {
        id = "🚫 Input tidak valid.\nJumlah maksimum yang diizinkan",
        en = "🚫 Invalid input.\nMax allowed"
    },
    ["template_not_found_eventboost"] = {
        id = "❌ Referensi tidak ditemukan.\nTidak dapat menerapkan",
        en = "❌ Reference not found.\nCannot apply"
    },
    ["template_copied_eventboost"] = {
        id = "📋 Template disalin",
        en = "📋 Template copied"
    },
    ["booster_applied_eventboost"] = {id = ":", en = ":"},
    ["success_30d_eventboost"] = {
        id = "Booster 30 Hari diterapkan",
        en = "30-Day Booster applied."
    },

    ["rainbow_amount_eventboost"] = {
        id = "Masukkan jumlah Bola Pelangi",
        en = "Enter Rainbow Ball amount"
    },
    ["bomb_amount_eventboost"] = {
        id = "Masukkan jumlah Bom",
        en = "Enter Bomb amount"
    },
    ["rocket_amount_eventboost"] = {
        id = "Masukkan jumlah Roket",
        en = "Enter Rocket amount"
    },
    ["single_amount_eventboost"] = {
        id = "Masukkan jumlah Palu Tunggal",
        en = "Enter Single Hammer amount"
    },
    ["vertical_amount_eventboost"] = {
        id = "Masukkan jumlah Palu Vertikal",
        en = "Enter Vertical Hammer amount"
    },
    ["horizontal_amount_eventboost"] = {
        id = "Masukkan jumlah Palu Horizontal",
        en = "Enter Horizontal Hammer amount"
    },
    ["fun_amount_eventboost"] = {
        id = "Masukkan jumlah Kipas Pengacak",
        en = "Enter Shuffle Fun amount"
    },

    ["adventure_energy_prompt_eventboost"] = {
        id = "⚡ Masukkan jumlah Energi Petualangan [1–100000]:",
        en = "⚡ Enter Adventure Energy amount [1–100000]:"
    },
    ["invalid_value_energy_eventboost"] = {
        id = "🚫 Input tidak valid.\nJumlah maksimum yang diizinkan\n✅ Min: 1\n✅ Max: 100000",
        en = "🚫 Invalid input.\nMax allowed\n✅ Min: 1\n✅ Max: 100000"
    },
    ["toast_energy_applied_eventboost"] = {
        id = "⚡ Energi Petualangan: %d ✅",
        en = "⚡ Adventure Energy: %d ✅"
    },

    ["frozentoken_input"] = {
        id = "⚓ Masukkan jumlah token harta beku [1–5000]:",
        en = "⚓ Enter frozen fortune tokens amount [1–5000]:"
    },
    ["frozentoken_invalid"] = {
        id = "🚫 Input tidak valid.\nJumlah maksimum yang diizinkan\n✅ Min: 1\n✅ Max: 5000",
        en = "🚫 Invalid input.\nMax allowed\n✅ Min: 1\n✅ Max: 5000"
    },
    ["frozentoken_toast"] = {
        id = "⚓ Token harta beku: %d ✅",
        en = "⚓ Frozen fortune tokens: %d ✅"
    },

    ----lab boost----

    ["profitable_flight_labboost"] = {
        id = "Penerbangan Menguntungkan",
        en = "Profitable Flight"
    },
    ["rich_fields_labboost"] = {id = "Ladang Subur", en = "Rich Fields"},
    ["record_demand_labboost"] = {
        id = "Permintaan Tinggi",
        en = "Record Demand"
    },
    ["busy_trade_labboost"] = {id = "Perdagangan Sibuk", en = "Busy Trade"},
    ["smart_navigation_labboost"] = {
        id = "Navigasi Cerdas",
        en = "Smart Navigation"
    },
    ["active_cooperation_labboost"] = {
        id = "Kerja Sama Aktif",
        en = "Active Cooperation"
    },
    ["efficient_smelting_labboost"] = {
        id = "Peleburan Efisien",
        en = "Efficient Smelting"
    },
    ["vibrant_market_labboost"] = {id = "Pasar Ramai", en = "Vibrant Market"},
    ["high_speed_production_labboost"] = {
        id = "Produksi Kecepatan Tinggi",
        en = "High-Speed Production"
    },
    ["super_harvest_labboost"] = {id = "Panen Super", en = "Super Harvest"},
    ["advanced_farming_labboost"] = {
        id = "Pertanian Lanjutan",
        en = "Advanced Farming"
    },
    ["generous_customers_labboost"] = {
        id = "Pelanggan Dermawan",
        en = "Generous Customers"
    },
    ["see_the_light_labboost"] = {id = "Melihat Cahaya", en = "See the Light"},
    ["shortcut_labboost"] = {id = "Jalur Pintas", en = "Shortcut"},
    ["extra_hands_labboost"] = {
        id = "Bantuan Tambahan",
        en = "Extra Pair of Hands"
    },
    ["spacious_barn_labboost"] = {id = "Lumbung Luas", en = "Spacious Barn"},
    ["large_request_labboost"] = {id = "Permintaan Besar", en = "Large Request"},
    ["favorable_voyage_labboost"] = {
        id = "Pelayaran Menguntungkan",
        en = "Favorable Voyage"
    },
    ["go_back_labboost"] = {id = "Kembali", en = "Go Back"},

    ["enter_amount_labboost"] = {id = "Masukkan jumlah", en = "Enter amount"},
    ["invalid_input_labboost"] = {
        id = "🚫 Input tidak valid.\nJumlah maksimum yang diizinkan\n✅ Min: 1\n✅ Max: 500",
        en = "🚫 Invalid input.\nMax allowed\n✅ Min: 1\n✅ Max: 500"
    },
    ["invalid_amount_labboost"] = {
        id = "🚫 Input tidak valid.\nJumlah maksimum yang diizinkan\n✅ Min: 1\n✅ Max: 500",
        en = "🚫 Invalid input.\nMax allowed\n✅ Min: 1\n✅ Max: 500"
    },
    ["ref_not_found_labboost"] = {
        id = "❌ Referensi tidak ditemukan. Tidak dapat menerapkan ",
        en = "❌ Reference not found. Cannot apply "
    },
    ["unnamed_booster_labboost"] = {
        id = "Pelayaran Menguntungkan",
        en = "Favorable Voyage"
    },

    -- Alias/shortcut (lab1–lab17) → diseragamkan

    ["lab1_labboost"] = {
        id = "Penerbangan Menguntungkan",
        en = "Profitable Flight"
    },
    ["lab2_labboost"] = {id = "Ladang Subur", en = "Rich Fields"},
    ["lab3_labboost"] = {id = "Permintaan Tinggi", en = "Record Demand"},
    ["lab4_labboost"] = {id = "Perdagangan Sibuk", en = "Busy Trade"},
    ["lab5_labboost"] = {id = "Navigasi Cerdas", en = "Smart Navigation"},
    ["lab6_labboost"] = {id = "Kerja Sama Aktif", en = "Active Cooperation"},
    ["lab7_labboost"] = {id = "Peleburan Efisien", en = "Efficient Smelting"},
    ["lab8_labboost"] = {id = "Pasar Ramai", en = "Vibrant Market"},
    ["lab9_labboost"] = {
        id = "Produksi Kecepatan Tinggi",
        en = "High-Speed Production"
    },
    ["lab10_labboost"] = {id = "Panen Super", en = "Super Harvest"},
    ["lab11_labboost"] = {id = "Pertanian Lanjutan", en = "Advanced Farming"},
    ["lab12_labboost"] = {id = "Pelanggan Dermawan", en = "Generous Customers"},
    ["lab13_labboost"] = {id = "Melihat Cahaya", en = "See the Light"},
    ["lab14_labboost"] = {id = "Jalur Pintas", en = "Shortcut"},
    ["lab15_labboost"] = {id = "Bantuan Tambahan", en = "Extra Pair of Hands"},
    ["lab16_labboost"] = {id = "Lumbung Luas", en = "Spacious Barn"},
    ["lab17_labboost"] = {id = "Permintaan Besar", en = "Large Request"},

    ["perk_unlimited_barn_keuntungan"] = {
        id = "Lumbung Tak terbatas",
        en = "Infinite Barn"
    },
    ["perk_instant_building_keuntungan"] = {
        id = "Konstruksi Instan",
        en = "Instant Construction"
    },
    ["enter_barn_boost_keuntungan"] = {
        id = "Masukkan persentase boost lumbung (1-20000):",
        en = "Enter barn boost percentage (1-20000):"
    },
    ["source_not_found_keuntungan"] = {
        id = "❌ Data tidak ditemukan.\nSilakan mulai ulang permainan dan coba kembali.",
        en = "❌ Data not found.\nPlease restart the game and try again."
    },
    ["perk_applied_keuntunganbost"] = {
        id = "Booster diterapkan!",
        en = "Boosters applied!"
    },

    ---tunjangan----

    ["express_plane_keuntungan"] = {
        id = "✈️ • Pesawat Instan",
        en = "✈️ • Instant Plane"
    },
    ["instant_crop_keuntungan"] = {
        id = "🌱 • Penanaman Instan",
        en = "🌱 • Instant Planting"
    },
    ["fast_farm_keuntungan"] = {
        id = "🐄 • Produksi Hewan Instan",
        en = "🐄 • Instant Animal Production"
    },
    ["train_booster_keuntungan"] = {
        id = "⏱️ • Booster Waktu Kereta",
        en = "⏱️ • Train Time Booster"
    },
    ["double_train_keuntungan"] = {
        id = "🚃 • Muatan Kereta 2×",
        en = "🚃 • 2× Train Cargo"
    },
    ["go_back_keuntungan"] = {id = "❌ • Kembali", en = "❌ • Go Back"},

    ["perk_express_plane_keuntungan"] = {
        id = "Pesawat Instan",
        en = "Instant Plane"
    },
    ["perk_instant_crop_keuntungan"] = {
        id = "Penanaman Instan",
        en = "Instant Planting"
    },
    ["perk_rapid_farm_keuntungan"] = {
        id = "Produksi Hewan Instan",
        en = "Rapid Farm Production"
    },
    ["perk_train_boost_keuntungan"] = {
        id = "Booster Waktu Kereta",
        en = "Train Time Booster"
    },
    ["perk_double_train_keuntungan"] = {
        id = "Muatan Kereta 2×",
        en = "2× Train Cargo"
    },
    ["perk_applied_keuntungan"] = {
        id = "perk berhasil diterapkan!",
        en = "perk applied!"
    },

    ----kuponpon----

    ["coupon_loader_kuponpon"] = {
        id = "Kupon Pengisian Barang",
        en = "Loader Coupon"
    },
    ["coupon_dealer_kuponpon"] = {
        id = "Kupon Sewa Pedagang",
        en = "Hire Dealer Coupon"
    },
    ["coupon_barn_kuponpon"] = {
        id = "Kupon Upgrade Lumbung",
        en = "Barn Upgrade Coupon"
    },
    ["coupon_city_kuponpon"] = {
        id = "Kupon Perluasan Kota",
        en = "City Expansion Coupon"
    },
    ["coupon_factory_kuponpon"] = {
        id = "Kupon Upgrade Pabrik",
        en = "Factory Upgrade Coupon"
    },
    ["coupon_train_kuponpon"] = {
        id = "Kupon Upgrade Kereta",
        en = "Train Upgrade Coupon"
    },
    ["coupon_island_kuponpon"] = {
        id = "Kupon Upgrade Pulau",
        en = "Island Upgrade Coupon"
    },
    ["back_kuponpon"] = {id = "Kembali", en = "Go Back"},

    ["loader_coupon_kuponpon"] = {
        id = "Masukkan jumlah Kupon Pengisian Barang",
        en = "Enter Loader Coupon amount"
    },
    ["dealer_coupon_kuponpon"] = {
        id = "Masukkan jumlah Kupon Sewa Pedagang",
        en = "Enter Hire Dealer Coupon amount"
    },
    ["barn_coupon_kuponpon"] = {
        id = "Masukkan jumlah Kupon Upgrade Lumbung",
        en = "Enter Barn Upgrade Coupon amount"
    },
    ["city_coupon_kuponpon"] = {
        id = "Masukkan jumlah Kupon Perluasan Kota",
        en = "Enter City Expansion Coupon amount"
    },
    ["factory_coupon_kuponpon"] = {
        id = "Masukkan jumlah Kupon Upgrade Pabrik",
        en = "Enter Factory Upgrade Coupon amount"
    },
    ["train_coupon_kuponpon"] = {
        id = "Masukkan jumlah Kupon Upgrade Kereta",
        en = "Enter Train Upgrade Coupon amount"
    },
    ["island_coupon_kuponpon"] = {
        id = "Masukkan jumlah Kupon Upgrade Pulau",
        en = "Enter Island Upgrade Coupon amount"
    },
    ["invalid_range_kuponpon"] = {
        id = "🚫 Input tidak valid.\nJumlah maksimum yang diizinkan",
        en = "🚫 Invalid input.\nMax allowed"
    },

    ["Loader Coupon_kuponpon"] = {
        id = "Kupon Pengisian Barang",
        en = "Loader Coupon"
    },
    ["Hire Dealer Coupon_kuponpon"] = {
        id = "Kupon Sewa Pedagang",
        en = "Hire Dealer Coupon"
    },
    ["Barn Upgrade Coupon_kuponpon"] = {
        id = "Kupon Upgrade Lumbung",
        en = "Barn Upgrade Coupon"
    },
    ["City Expansion Coupon_kuponpon"] = {
        id = "Kupon Perluasan Kota",
        en = "City Expansion Coupon"
    },
    ["Factory Upgrade Coupon_kuponpon"] = {
        id = "Kupon Upgrade Pabrik",
        en = "Factory Upgrade Coupon"
    },
    ["Train Upgrade Coupon_kuponpon"] = {
        id = "Kupon Upgrade Kereta",
        en = "Train Upgrade Coupon"
    },
    ["Island Upgrade Coupon_kuponpon"] = {
        id = "Kupon Upgrade Pulau",
        en = "Island Upgrade Coupon"
    },

    ----gem----

    ["orange_gem_gemgem"] = {id = "Permata Jingga", en = "Orange Gem"},
    ["green_gem_gemgem"] = {id = "Permata Hijau", en = "Green Gem"},
    ["red_gem_gemgem"] = {id = "Permata Merah", en = "Red Gem"},
    ["go_back_gemgem"] = {id = "Kembali", en = "Go Back"},

    ["invalid_input_gemgem"] = {
        id = "🚫 Input tidak valid.\nJumlah maksimum yang diizinkan",
        en = "🚫 Invalid input.\nMax allowed"
    },
    ["enter_amount_gemgem"] = {id = "Masukkan jumlah", en = "Enter amount of"},
    ["reward_set_gemgem"] = {id = ":", en = ":"},
    ["orange_gem_gemgem"] = {id = "Permata Jingga", en = "Orange Gem"},
    ["green_gem_gemgem"] = {id = "Permata Hijau", en = "Green Gem"},
    ["red_gem_gemgem"] = {id = "Permata Merah", en = "Red Gem"},

    ----batangan----

    ["bronze_ingot_batangtang"] = {
        id = "Batangan Perunggu",
        en = "Bronze Ingot"
    },
    ["silver_ingot_batangtang"] = {id = "Batangan Perak", en = "Silver Ingot"},
    ["gold_ingot_batangtang"] = {id = "Batangan Emas", en = "Gold Ingot"},
    ["platinum_ingot_batangtang"] = {
        id = "Batangan Platinum",
        en = "Platinum Ingot"
    },
    ["go_back_batangtang"] = {id = "Kembali", en = "Go Back"},

    ["enter_amount_batangtang"] = {id = "Masukkan jumlah", en = "Enter amount"},
    ["invalid_input_batangtang"] = {
        id = "🚫 Input tidak valid.\nJumlah maksimum yang diizinkan",
        en = "🚫 Invalid input.\nMax allowed"
    },
    ["set_to_batangtang"] = {id = ":", en = ":"},
    ["bronze_batangtang"] = {id = "Batang Perunggu", en = "Bronze Ingots"},
    ["silver_batangtang"] = {id = "Batang Perak", en = "Silver Ingots"},
    ["gold_batangtang"] = {id = "Batang Emas", en = "Gold Ingots"},
    ["platinum_batangtang"] = {id = "Batang Platinum", en = "Platinum Ingots"},

    ----gali----

    ["pickaxe_macul"] = {id = "Beliung", en = "Pickaxe"},
    ["tntpele_macul"] = {id = "TNT Peledak", en = "Explosive TNT"},
    ["dynamite_macul"] = {id = "Dinamit", en = "Dynamite"},
    ["x2_ore_bonus_macul"] = {
        id = "Bonus Bijih ×2 (30 Hari)",
        en = "×2 Ore Bonus (30 Days)"
    },
    ["go_back_macul"] = {id = "Kembali", en = "Go Back"},

    ["mining_prompt_macul"] = {id = "Masukkan jumlah", en = "Enter amount"},
    ["invalid_input_macul"] = {
        id = "🚫 Input tidak valid.\nJumlah maksimum yang diizinkan",
        en = "🚫 Invalid input.\nMax allowed"
    },
    ["success_bonus_macul"] = {id = "berhasil!", en = "successfully!"},
    ["pickaxes_macul"] = {id = "Beliung", en = "Pickaxes"},
    ["tnt_macul"] = {id = "TNT Peledak", en = "Explosive TNT"},
    ["dynamite_macul"] = {id = "Dinamit", en = "Dynamite"},
    ["ore_bonus_macul"] = {
        id = "Bonus Tambang ×2 (30 Hari)",
        en = "30-Day ×2 Ore Bonus"
    },

    ----material----

    ["community_tools_materialyal"] = {
        id = "Alat Komunitas",
        en = "Community Tools"
    },
    ["barn_tools_materialyal"] = {
        id = "Alat Upgrade Lumbung",
        en = "Barn Upgrade Tools"
    },
    ["expansion_tools_materialyal"] = {
        id = "Alat Perluasan Kota",
        en = "City Expansion Tools"
    },
    ["go_back_materialyal"] = {id = "Kembali", en = "Go Back"},

    ["glass_matdung"] = {id = "Kaca", en = "Glass"},
    ["bricks_matdung"] = {id = "Bata", en = "Bricks"},
    ["slab_matdung"] = {id = "Lempengan", en = "Slab"},
    ["jackhammer_matdung"] = {id = "Bor Beton", en = "Jackhammer"},
    ["electric_saw_matdung"] = {id = "Gergaji Listrik", en = "Electric Saw"},
    ["drill_matdung"] = {id = "Bor", en = "Drill"},
    ["back_matdung"] = {id = "Kembali", en = "Go Back"},

    ["input_construct_matdung"] = {
        id = "Masukkan jumlah {label} [1–{max}]:",
        en = "Enter {label} amount [1–{max}]:"
    },
    ["invalid_input_matdung"] = {
        id = "🚫 Input tidak valid.\nJumlah maksimum yang diizinkan",
        en = "🚫 Invalid input.\nMax allowed"
    },
    ["reward_set_matdung"] = {
        id = "{emoji} {label}: {amount} ✅",
        en = "{emoji} {label}: {amount} ✅"
    },
    ["glass_matdung"] = {id = "Kaca", en = "Glass"},
    ["bricks_matdung"] = {id = "Batu Bata", en = "Bricks"},
    ["slabs_matdung"] = {id = "Lempengan", en = "Slabs"},
    ["jackhammer_matdung"] = {id = "Bor Beton", en = "Jackhammer"},
    ["saw_matdung"] = {id = "Gergaji Listrik", en = "Electric Saw"},
    ["drill_matdung"] = {id = "Bor", en = "Drill"},

    ----alat gudang----

    ["hammer_gudangdang"] = {id = "Palu", en = "Hammer"},
    ["nail_gudangdang"] = {id = "Paku", en = "Nail"},
    ["red_paint_gudangdang"] = {id = "Cat Merah", en = "Red Paint"},
    ["go_back_gudangdang"] = {id = "Kembali", en = "Go Back"},

    ["hammers_gudangdang"] = {id = "Palu", en = "Hammers"},
    ["nails_gudangdang"] = {id = "Paku", en = "Nails"},
    ["red_paint_gudangdang"] = {id = "Cat Merah", en = "Red Paint"},
    ["enter_amount_gudangdang"] = {
        id = "Masukkan jumlah ",
        en = "Enter amount "
    },
    ["invalid_input_gudangdang"] = {
        id = "🚫 Input tidak valid.\nJumlah maksimum yang diizinkan",
        en = "🚫 Invalid input.\nMax allowed"
    },
    ["barn_reward_set_gudangdang"] = {id = ":", en = ":"},

    ----alat luas----

    ["saw_waswas"] = {id = "Gergaji", en = "Saw"},
    ["axe_waswas"] = {id = "Kapak", en = "Axe"},
    ["shovel_waswas"] = {id = "Sekop", en = "Shovel"},
    ["go_back_waswas"] = {id = "Kembali", en = "Go Back"},

    ["enter_amount_waswas"] = {id = "Masukkan jumlah ", en = "Enter amount "},
    ["invalid_input_waswas"] = {
        id = "🚫 Input tidak valid.\nJumlah maksimum yang diizinkan",
        en = "🚫 Invalid input.\nMax allowed"
    },
    ["reward_set_waswas"] = {id = ":", en = ":"},
    ["saw_waswas"] = {id = "Gergaji", en = "Saw"},
    ["axe_waswas"] = {id = "Kapak", en = "Axe"},
    ["shovel_waswas"] = {id = "Sekop", en = "Shovel"},

    ----spesial menu----

    ["vip_regatta_task"] = {
        id = "💎 • Tugas VIP",
        en = "💎 • VIP Tasks"
    },
    ["auto_finish_task"] = {
        id = "👻 • Tugas Otomatis",
        en = "👻 • Automatic Task"
    },
    ["edit_regatta_points"] = {
        id = "🌟 • Poin Regata",
        en = "🌟 • Regatta Points"
    },
    ["back_main_menu_spesial"] = {
        id = "❌ • Kembali",
        en = "❌ • Go Back"
    },

    ----regata menu----

    ["title_pilih_poin"] = {
        id = "🎯 Pilih jumlah poin regata:",
        en = "🎯 Select regatta point amount:"
    },
    ["vipedit150"] = {id = "⭐ Regata Poin 150", en = "⭐ Regatta Points 150"},
    ["vipedit200"] = {id = "⭐ Regata Poin 200", en = "⭐ Regatta Points 200"},
    ["vipedit300"] = {id = "⭐ Regata Poin 300", en = "⭐ Regatta Points 300"},
    ["alert_tidak_ditemukan"] = {
        id = "❌ Tidak ditemukan blok regata.",
        en = "❌ No regatta block found."
    },
    ["alert_tidak_valid"] = {
        id = "⛔ Tidak ada blok regata yang valid.",
        en = "⛔ No valid regatta block found."
    },
    ["alert_berhasil_prefix"] = {
        id = "✅ Jumlah blok regata diperbarui:",
        en = "✅ Regatta blocks updated:"
    },
    ["alert_berhasil_suffix"] = {
        id = "⭐ Poin diperbarui:",
        en = "⭐ Updated points:"
    },
    ["toast_berhasil"] = {
        id = "🎉 Tugas regata diperbarui!",
        en = "🎉 Regatta tasks updated!"
    },

    ["regata_failed"] = {
        id = "⚠️ Tidak dapat menyelesaikan tugas regata.\n\n💡 Silakan ambil atau mulai tugas regata terlebih dahulu di dalam game, lalu jalankan kembali skrip ini.",
        en = "⚠️ Unable to complete regatta task.\n\n💡 Please start or pick a regatta task in the game first, then run this script again."
    },
    ["regata_done"] = {id = "🎉 Tugas selesai!", en = "🎉 Tasks complate!"},

    ["pilih_poin"] = {
        id = "🎯 Pilih jumlah poin regata:",
        en = "🎯 Select regatta point amount:"
    },
    ["edit150"] = {id = "⭐ Tugas Poin 150", en = "⭐ Tasks Points 150"},
    ["edit200"] = {id = "⭐ Tugas Poin 200", en = "⭐ Tasks Points 200"},
    ["edit300"] = {id = "⭐ Tugas Poin 300", en = "⭐ Tasks Points 300"},
    ["gagal_regata"] = {
        id = "⚠️ Tidak dapat mengedit poin tugas regata.\n\n💡 Silakan mulai atau ambil tugas regata terlebih dahulu.",
        en = "⚠️ Unable to edit regatta task points.\n\n💡 Please start or take a regatta task first."
    },
    ["sukses"] = {
        id = "⭐ Poin tugas diperbarui: ",
        en = "⭐ Updated points tasks: "
    },

    ----menu event----

    ["menu2_levelup_puzzle"] = {
        id = "🧩 • Menaikkan Level Teka-teki",
        en = "🧩 • Increase Puzzle Level"
    },
    ["menu2_weekly_contest"] = {
        id = "🏁 • Poin Kompetisi Mingguan",
        en = "🏁 • Weekly Contest Points"
    },
    ["menu2_erni_cup"] = {
        id = "🏆 • Poin Piala Ernie",
        en = "🏆 • Ernie's Cup Points"
    },
    ["menu2_ruler_the_mine"] = {
        id = "💵 • Penguasa Tambang",
        en = "💵 • Ruler of the Mine"
    },
    ["menu2_treasure_pirate"] = {
        id = "🏴‍☠️ • Sembunyikan Kartu Hitam Bajak Laut",
        en = "🏴‍☠️ • Hide Pirate Black Card"
    },
    ["menu2_send_goldcard"] = {
        id = "🌟 • Kirim Kartu Emas Tanpa Batas",
        en = "🌟 • Send Gold Card Unlimited"
    },
    ["menu2_duplicate_card"] = {
        id = "🔁 • Duplikat Kartu",
        en = "🔁 • Duplicate Cards"
    },
    ["menu2_frozen_poin"] = {
        id = "⚓ • Menambah Poin Harta Beku",
        en = "⚓ • Increase Frozen Fortune Points"
    },
    ["menu_back_menuipen"] = {id = "❌ • Kembali", en = "❌ • Go Back"},

    ["input_level_puzzel"] = {
        id = "🧩 Masukkan level puzzle yang ingin ditingkatkan:",
        en = "🧩 Enter the puzzle level to increase:"
    },
    ["level_puzzle_not_found"] = {
        id = "❌ Data level puzzle tidak ditemukan!\n\nSilakan mulai ulang permainan dan coba lagi.",
        en = "❌ Puzzle level data not found!\n\nPlease restart the game and try again."
    },
    ["level_puzzle_invalid"] = {
        id = "⛔ Data level puzzle valid tidak ditemukan!\n\nSilakan mulai ulang permainan dan coba lagi.",
        en = "⛔ Valid puzzle level data not found!\n\nPlease restart the game and try again."
    },
    ["level_puzzle_success"] = {
        id = "✅ Level puzzle berhasil ditingkatkan",
        en = "✅ Puzzle level successfully increased"
    },

    ["input_weekly_point"] = {
        id = "🏁 Masukkan poin kompetisi mingguan:",
        en = "🏁 Enter weekly competition points:"
    },
    ["ernie_not_found"] = {
        id = "❌ Data Ernie Cup tidak ditemukan!\n\nSilahkan mulai ulang permainan dan coba lagi.",
        en = "❌ Ernie Cup data not found!\n\nPlease restart the game and try again."
    },
    ["ernie_invalid"] = {
        id = "⛔ Data Ernie Cup valid tidak ditemukan!\n\nSilahkan mulai ulang permainan dan coba lagi.",
        en = "⛔ Valid Ernie Cup data not found!\n\nPlease restart the game and try again."
    },
    ["point_success"] = {
        id = "✅ Poin berhasil ditambahkan",
        en = "✅ Points successfully added"
    },

    ["ernie_input"] = {
        id = "🏆 Masukkan poin Ernie Cup:",
        en = "🏆 Enter Ernie Cup points:"
    },
    ["ernie_notfound"] = {
        id = "❌ Data Ernie Cup tidak ditemukan!\n\nSilakan mulai ulang permainan dan coba lagi.",
        en = "❌ Ernie Cup data not found!\n\nPlease restart the game and try again."
    },
    ["ernie_notvalid"] = {
        id = "⛔ Data Ernie Cup valid tidak ditemukan!\n\nSilakan mulai ulang permainan dan coba lagi.",
        en = "⛔ Valid Ernie Cup data not found!\n\nPlease restart the game and try again."
    },
    ["ernie_success"] = {
        id = "✅ Poin berhasil ditambahkan",
        en = "✅ Points successfully added"
    },

    ["Etamwarn_event_not_claimed"] = {
        id = "⚠️ Script ini hanya bekerja jika hadiah 'Penguasa Tambang' belum pernah diambil sama sekali.\n\nJika kamu sudah pernah mendapatkannya, maka script tidak akan berfungsi.",
        en = "⚠️ This script only works if the 'Mine Ruler' reward has never been claimed.\n\nIf you've already claimed it before, the script will not work."
    },
    ["Etamno_data_found"] = {
        id = "❌ Data acara 'Penguasa Tambang' tidak ditemukan.\n\n🔁 Silakan restart game dan coba lagi.",
        en = "❌ 'Mine Ruler' event data not found.\n\n🔁 Please restart the game and try again."
    },
    ["Etamno_target"] = {
        id = "⛔ Data 'Penguasa Tambang' tidak ditemukan.\n\n📝 Pastikan event masih aktif dan belum pernah diselesaikan.",
        en = "⛔ 'Mine Ruler' data not found.\n\n📝 Make sure the event is still active and has never been completed."
    },
    ["Etamsuccess_alert"] = {
        id = "✅ Edit berhasil diterapkan!\n\n📌 Ambil 1 ore untuk mengaktifkan auto-mining.",
        en = "✅ Edit applied successfully!\n\n📌 Mine 1 ore to activate auto-mining."
    },
    ["Etamsuccess_toast"] = {
        id = "🎉 Penguasa Tambang berhasil diupdate!",
        en = "🎉 Mine Ruler updated successfully!"
    },

    ["dataNotFound_bajak"] = {
        id = "❌ Harta Karun Bajak Laut tidak ditemukan!\n\nSilakan restart game dan coba lagi.",
        en = "❌ Pirate Treasure not found!\n\nPlease restart the game and try again."
    },
    ["toastFreeze_bajak"] = {
        id = "🏴‍☠️ Freeze Harta Karun Bajak Laut diterapkan pada entri!",
        en = "🏴‍☠️ Pirate Treasure freeze applied to entries!"
    },

    ["goldcard_notfound"] = {
        id = "❌ Data Kirim Kartu Emas tidak ditemukan.\n\nSilakan mulai ulang permainan dan coba lagi.",
        en = "❌ Gold Card Send Data not found.\n\nPlease restart the game and try again."
    },
    ["goldcard_notverify"] = {
        id = "⛔ Data Kirim Kartu Emas valid tidak dapat ditemukan!\n\nSilahkan mulai ulang permainan dan coba lagi.",
        en = "⛔ Valid Gold Card Send data not found.\n\nPlease restart the game and try again."
    },
    ["goldcard_success"] = {
        id = "✅ Gold Card sekarang bisa dikirim!",
        en = "✅ Gold Cards are now sendable!"
    },

    ["noDataFound_sendcard"] = {
        id = "❌ Data kirim kartu tanpa batas tidak ditemukan.\n\nSilakan restart game dan coba lagi.",
        en = "❌ Unlimited Card Sending data not found.\n\nPlease restart the game and try again."
    },
    ["baseNotFound_sendcard"] = {
        id = "⛔ Pengiriman Kartu Tanpa Batas valid tidak ditemukan.\n\nMulai ulang permainan dan coba lagi.",
        en = "⛔ Unlimited Card Sending valid not found.\n\nPelease restart the game and try again."
    },
    ["success_sendcard"] = {
        id = "✅ Kirim Kartu Emas tanpa batas berhasil diaktifkan!",
        en = "✅ Unlimited Gold Card sending is now active!"
    },

    ["duplikat_title"] = {
        id = "🃏 Pilih Jumlah Kartu",
        en = "🃏 Select Card Amount"
    },
    ["duplikat_opt_50"] = {
        id = "✨ Set kartu ke 50",
        en = "✨ Set cards to 50"
    },
    ["duplikat_opt_100"] = {
        id = "✨ Set kartu ke 100",
        en = "✨ Set cards to 100"
    },
    ["duplikat_opt_500"] = {
        id = "✨ Set kartu ke 500",
        en = "✨ Set cards to 500"
    },

    ["duplikat_not_found"] = {
        id = "❌ Data kartu tidak ditemukan.\nPastikan halaman kartu sedang dibuka.",
        en = "❌ Card data not found.\nMake sure the card page is open."
    },
    ["duplikat_invalid"] = {
        id = "⚠️ Kartu valid tidak ditemukan.",
        en = "⚠️ No valid cards found."
    },
    ["duplikat_success"] = {
        id = "✅ Duplikat kartu berhasil : 🃏 ",
        en = "✅ Card duplication successful : 🃏 "
    },

    ["menu2_input"] = {
        id = "⚓ Masukkan jumlah poin yang TERLIHAT:",
        en = "⚓ Enter the VISIBLE point amount:"
    },
    ["menu2_invalid"] = {
        id = "⛔ Nilai tidak valid!\n\nMinimal: 5\nMaksimal: 55000",
        en = "⛔ Invalid value!\n\n✅ Minimum: 5\n✅ Maximum: 55000"
    },
    ["menu2_notfound"] = {
        id = "❌ Data Harta Beku tidak ditemukan!\n\nRestart game lalu coba lagi.",
        en = "❌ Frozen Fortune data not found!\n\nRestart the game and try again."
    },
    ["menu2_novalid"] = {
        id = "⛔ Data valid tidak ditemukan!\n\nPastikan jumlah poin yang dimasukkan benar.",
        en = "⛔ No valid data found!\n\nPlease make sure the entered point amount is correct."
    },
    ["menu2_success"] = {
        id = "✅ Poin Frozen Fortune berhasil",
        en = "✅ Frozen Fortune points updated successfully"
    },

    ----skip time----

    ["shipBoost_aripal"] = {
        id = "🚢 • Pulau Instan",
        en = "🚢 • Instant Islands"
    },
    ["cargoAuto1_aripal"] = {
        id = "✈️ • Pesawat Otomatis",
        en = "✈️ • Auto Plane"
    },
    ["heliAuto_aripal"] = {
        id = "🚁 • Helikopter Otomatis",
        en = "🚁 • Auto Helicopter"
    },
    ["trainBoost11_aripal"] = {
        id = "🚂 • Kedatangan Kereta Instan",
        en = "🚂 • Instant Train Arrival"
    },
    ["go_back_skiptime"] = {id = "❌ • Kembali", en = "❌ • Go Back"},

    ["pulau_no_data"] = {
        id = "❌ Data kapal instan tidak ditemukan.\n\nSilakan mulai ulang permainan dan coba lagi.",
        en = "❌ Instant ship data not found.\n\nPlease restart the game and try again."
    },
    ["pulau_invalid"] = {
        id = "⛔ Data instan kapal valid tidak ditemukan.\n\nSilakan mulai ulang permainan dan coba lagi.",
        en = "⛔ Valid instant ship data not found.\n\nPlease restart the game and try again."
    },
    ["pulau_success"] = {
        id = "🛳️ Pulau instan diaktifkan!",
        en = "🛳️ Instant island activated!"
    },

    ["no_data"] = {
        id = "❌ Tidak ada data pesawat otomatis ditemukan.\n\nSilakan mulai ulang permainan dan coba lagi.",
        en = "❌ Automatic plane data not found.\n\nPlease restart the game and try again."
    },
    ["no_valid"] = {
        id = "⛔ Nilai pesawat otomatis valid tidak ditemukan.\n\nSilakan mulai ulang permainan dan coba lagi.",
        en = "⛔ Valid automatic plane value not found.\n\nPlease restart the game and try again."
    },
    ["activated"] = {
        id = "✈️ pesawat otomatis diaktifkan!",
        en = "✈️ Automatic plane activated!"
    },

    ["helikopter_not_found"] = {
        id = "❌ Data helikopter tanpa produk tidak ditemukan.\nSilahkan mulai ulang permainan dan coba lagi.",
        en = "❌ Helicopter without product data not found.\nPlease restart the game and try again."
    },
    ["helikopter_invalid"] = {
        id = "⛔ Data helikopter tanpa produk valir tidak ditemukan.\nSilahkan mulai ulang permainan dan coba lagi.",
        en = "⛔ Invalid helicopter without product data not found.\nPlease restart the game and try again."
    },
    ["helikopter_success"] = {
        id = "✅ Helikopter tanpa produk sukses!",
        en = "✅ Helicopter without product patched successfully!"
    },

    ["train_prompt_kreta"] = {
        id = {
            "⏰ Jam Kereta [1;5]", "⏱️ Menit Kereta [0;55]",
            "❄️ Bekukan Gerbong Kereta"
        },
        en = {
            "⏰ Train Hours [1;5]", "⏱️ Train Minutes [0;55]",
            "❄️ Freeze Train Carriage"
        }
    },
    ["cancelled_kreta"] = {id = "⚠️ Dibatalkan.", en = "⚠️ Cancelled."},
    ["invalid_input_kreta"] = {
        id = "❌ Input tidak valid.\n\nMasukkan waktu antara 1–5 jam dan 0–55 menit.",
        en = "❌ Invalid input.\n\nEnter valid time between 1–5 hours and 0–55 minutes."
    },
    ["no_timer_kreta"] = {
        id = "❌ Timer Kereta tidak ditemukan.\nCoba sesuaikan waktu atau restart game.",
        en = "❌ No Train Timer found.\nTry adjusting time or restart the game."
    },
    ["success_msg_kreta"] = {id = "✅ Sukses!\n\n", en = "✅ Success!\n\n"},
    ["train_updated_kreta"] = {
        id = "✅ Kereta diperbarui.",
        en = "✅ Train updated."
    },
    ["train_timer_frozen_kreta"] = {
        id = "🚂 Timer kereta dibekukan selama ",
        en = "🚂 Train timer frozen for "
    },
    ["carriage_frozen_kreta"] = {
        id = "\n❄️ Gerbong juga dibekukan.",
        en = "\n❄️ Carriages also frozen."
    },

    ----menu produk----

    ["no_feed_timer_skiptime"] = {
        id = "🏭 • Pabrik Pakan Instan",
        en = "🏭 • Instant Feed Mill"
    },
    ["no_farm_timer_skiptime"] = {
        id = "🐮 • Hewan Ternak Tanpa Waktu Tunggu",
        en = "🐮 • Instant Animal"
    },
    ["instant_foundry_skiptime"] = {
        id = "🏭 • Peleburan Instan",
        en = "🏭 • Instant Foundry"
    },
    ["no_request_delay_skiptime"] = {
        id = "⏱️ • Permintaan Tanpa Penundaan",
        en = "⏱️ • Instant Requests"
    },
    ["more_requests_menupenambah"] = {
        id = "📬 • Permintaan Lebih Banyak",
        en = "📬 • Extra Requests"
    },
    ["extra_ship_menupenambah"] = {
        id = "📦 • Tambahan Barang Kapal",
        en = "📦 • Extra Ship Items"
    },
    ["back_menupenambah"] = {id = "❌ • Kembali", en = "❌ • Go Back"},

    ["feed_select_title"] = {
        id = "🐄 Pilih jumlah pakan ternak",
        en = "🐄 Select animal feed amount"
    },
    ["feed_50"] = {id = "🐄 50 Pakan", en = "🐄 50 Feed"},
    ["feed_100"] = {id = "🐄 100 Pakan", en = "🐄 100 Feed"},
    ["feed_500"] = {id = "🐄 500 Pakan", en = "🐄 500 Feed"},
    ["feed_not_found"] = {
        id = "❌ Data pakan ternak tidak ditemukan.\n\nSilakan masuk ke kandang hewan lalu coba lagi.",
        en = "❌ Animal feed data not found.\n\nPlease enter the animal barn and try again."
    },
    ["feed_not_valid"] = {
        id = "⛔ Data pakan ternak valid tidak ditemukan.\n\nSilakan mulai ulang permainan dan coba lagi.",
        en = "⛔ Valid animal feed data not found.\n\nPlease restart the game and try again."
    },
    ["feed_success"] = {
        id = "🐄 Pakan ternak instan berhasil!",
        en = "🐄 Instant animal feed applied successfully!"
    },

    ["animal_instant_not_found"] = {
        id = "❌ Data instan produksi hewan tidak ditemukan.\n\nSilakan masuk ke kandang hewan lalu coba lagi.",
        en = "❌ Instant animal production data not found.\n\nPlease enter the animal barn and try again."
    },
    ["animal_instant_not_valid"] = {
        id = "⛔ Data instan produksi hewan yang valid tidak ditemukan.\n\nSilakan mulai ulang game dan coba lagi.",
        en = "⛔ Valid instant animal production data not found.\n\nPlease restart the game and try again."
    },
    ["animal_instant_success"] = {
        id = "🐮 Instan hewan produksi berhasil!",
        en = "🐮 Instant animal production successfully!"
    },

    ["foundry_not_found"] = {
        id = "❌ Data foundry tidak ditemukan.\n\nSilakan masuk ke pabrik foundry lalu coba lagi.",
        en = "❌ Foundry data not found.\n\nPlease enter the foundry factory and try again."
    },
    ["foundry_invalid"] = {
        id = "⛔ Data foundry valid tidak ditemukan.\n\nSilakan mulai ulang permainan dan coba lagi.",
        en = "⛔ Valid foundry data not found.\n\nPlease restart the game and try again."
    },
    ["foundry_success"] = {
        id = "✅ Foundry instan berhasil diaktifkan!",
        en = "✅ Instant foundry activated!"
    },

    ["request_not_found"] = {
        id = "❌ Data permintaan instan tidak ditemukan.\n\nSilakan mulai ulang permainan dan coba lagi.",
        en = "❌ Instant Request data not found.\n\nPlease restart the game and try again."
    },
    ["request_invalid"] = {
        id = "⛔ Nilai permintaan instan yang valid tidak ditemukan.\n\nSilakan mulai ulang permainan dan coba lagi.",
        en = "⛔ No valid Instant Request value found.\n\nPlease restart the game and try again."
    },
    ["request_success"] = {
        id = "⏱️ Request Instant aktif!",
        en = "⏱️ Instant Request activated!"
    },

    ["cow_hew"] = {id = "🐄  Sapi", en = "🐄  Cow"},
    ["chicken_hew"] = {id = "🐔  Ayam", en = "🐔  Chicken"},
    ["sheep_hew"] = {id = "🐑  Domba", en = "🐑  Sheep"},
    ["bee_hew"] = {id = "🐝  Lebah", en = "🐝  Bee"},
    ["pig_hew"] = {id = "🐖  Babi", en = "🐖  Pig"},
    ["mushroom_hew"] = {id = "🍄  Jamur", en = "🍄  Mushroom"},

    ["select_crop"] = {
        id = "🌿 Pilih tanaman untuk diubah",
        en = "🌿 Select crops to modify"
    },
    ["enter_crop_amount"] = {
        id = "📦 Masukkan jumlah tanaman [1 - 500]:",
        en = "📦 Enter crop amount [1 - 500]:"
    },
    ["invalid_crop_amount"] = {
        id = "🚫 Input tidak valid.\nJumlah maksimum yang diizinkan\n✅ Min: 1\n✅ Max: 500",
        en = "🚫 Invalid input.\nMax allowed\n✅ Min: 1\n✅ Max: 500"
    },
    ["not_found"] = {id = "❌ Tidak ditemukan:", en = "❌ Not found:"},
    ["set_to"] = {id = "diset ke", en = "set to"},

    ["crop_wheat"] = {id = "🌾 Gandum", en = "🌾 Wheat"},
    ["crop_corn"] = {id = "🌽 Jagung", en = "🌽 Corn"},
    ["crop_carrot"] = {id = "🥕 Wortel", en = "🥕 Carrot"},
    ["crop_sugar"] = {id = "🍬 Tebu", en = "🍬 Sugarcane"},
    ["crop_cotton"] = {id = "☁️ Kapas", en = "☁️ Cotton"},
    ["crop_strawberry"] = {id = "🍓 Stroberi", en = "🍓 Strawberry"},
    ["crop_tomato"] = {id = "🍅 Tomat", en = "🍅 Tomato"},
    ["crop_pine"] = {id = "🌲 Pohon Pinus", en = "🌲 Pine Tree"},
    ["crop_potato"] = {id = "🥔 Kentang", en = "🥔 Potato"},
    ["crop_cacao"] = {id = "🍫 Kakao", en = "🍫 Cacao"},
    ["crop_rubber"] = {id = "🌳 Pohon Karet", en = "🌳 Rubber Tree"},
    ["crop_silk"] = {id = "🧵 Pohon Sutra", en = "🧵 Silk Tree"},
    ["crop_chili"] = {id = "🌶️ Cabai", en = "🌶️ Chili"},
    ["crop_rice"] = {id = "🌾 Padi", en = "🌾 Rice"},
    ["crop_rose"] = {id = "🌹 Mawar", en = "🌹 Rose"},
    ["crop_jasmine"] = {id = "🌼 Melati", en = "🌼 Jasmine"},
    ["crop_coffee"] = {id = "🌰 Tanaman Kopi", en = "🌰 Coffee"},
    ["crop_peanut"] = {id = "🥜 Tanaman Kacang", en = "🥜 Peanut"},
    ["crop_tea"] = {id = "🌿 Tanaman Teh", en = "🌿 Tea Plant"},
    ["crop_apple"] = {id = "🍎 Apel", en = "🍎 Apple"},
    ["crop_mint"] = {id = "🍃 Mint", en = "🍃 Mint"},
    ["crop_soy"] = {id = "🫘 Kedelai", en = "🫘 Soybean"},
    ["crop_cork"] = {id = "🍂 Pohon Gabus", en = "🍂 Cork Tree"},
    ["crop_lavender"] = {id = "🪻 Lavender", en = "🪻 Lavender"},

    ["ship_warning"] = {
        id = "⚠️ PERHATIAN!\n\nJangan meninggalkan layar Produk Kapal selama proses berlangsung.\n\nSetelah proses selesai, segera ambil produk kapal sebelum keluar dari layar agar jumlah tidak kembali ke awal.",
        en = "⚠️ WARNING!\n\nDo not leave the Ship Product screen while the process is running.\n\nAfter the process is complete, immediately collect the ship products before leaving the screen to prevent the amount from resetting."
    },
    ["ship_choose_amount"] = {
        id = "📦 Pilih jumlah produk kapal",
        en = "📦 Select ship product amount"
    },
    ["ship_not_found"] = {
        id = "❌ Data Produk Kapal tidak ditemukan.\n\nSilakan restart game,\nbuka layar Produk Kapal,\nlalu jalankan fitur ini kembali.",
        en = "❌ Ship Product data not found.\n\nPlease restart the game,\nopen the Ship Product screen,\nand run this feature again."
    },
    ["ship_success"] = {
        id = "✅ Produk Kapal berhasil diset ke ",
        en = "✅ Ship products successfully set to "
    },

    ----city marketplace----

    ["market_quantity_marketplace"] = {
        id = "🍟 • Jumlah Produk",
        en = "🍟 • Product Quantity"
    },
    ["market_unlim_marketplace"] = {
        id = "📦 • Tambah Kotak Pasar",
        en = "📦 • Increase Market Boxes"
    },
    ["no_dealer_rest_marketplace"] = {
        id = "🕚 • Dealer Tanpa Istirahat",
        en = "🕚 • Dealer Without Rest"
    },
    ["dealer_rent_marketplace"] = {
        id = "🧔 • Perpanjang Sewa Dealer",
        en = "🧔 • Extend Dealer Rental"
    },

    ["quantityproduk_input"] = {
        id = "🍟 Masukkan jumlah produk (50 - 1000):",
        en = "🍟 Enter product quantity (50 - 1000):"
    },
    ["quantityproduk_invalid"] = {
        id = "🚫 Input tidak valid.\nJumlah maksimum yang diizinkan\n✅ Min: 50\n✅ Max: 1000",
        en = "🚫 Invalid input.\nMax allowed\n✅ Min: 50\n✅ Max: 1000"
    },
    ["quantityproduk_not_found"] = {
        id = "❌ Data Dealer tidak ditemukan.\nSilakan mulai ulang permainan dan coba lagi.",
        en = "❌ Dealer data not found.\nPlease restart the game and try again."
    },
    ["quantityproduk_not_valid"] = {
        id = "⛔ Data Dealer valid tidak ditemukan.\nSilakan mulai ulang permainan dan coba lagi.",
        en = "⛔ Valid Dealer data not found.\nPlease restart the game and try again."
    },
    ["quantityproduk_success"] = {
        id = "✅ Jumlah produk berhasil diubah!",
        en = "✅ Product quantity successfully updated!"
    },

    ["prompt_market_boxes"] = {
        id = "📦 Masukkan jumlah kotak pasar (10–2000):",
        en = "📦 Enter number of market boxes (10–2000):"
    },
    ["invalid_input_market"] = {
        id = "🚫 Input tidak valid.\nJumlah maksimum yang diizinkan\n✅ Min: 10\n✅ Max: 2000",
        en = "🚫 Invalid input.\nMax allowed\n✅ Min: 10\n✅ Max: 2000"
    },
    ["data_not_found_market"] = {
        id = "❌ Data kotak pasar tidak ditemukan.\nSilakan mulai ulang permainan dan coba lagi.",
        en = "❌ Market box data not found.\nPlease restart the game and try again."
    },
    ["no_valid_offset_market"] = {
        id = "⛔ Data kotak pasar yang valid tidak ditemukan.\n\nSilakan mulai ulang permainan dan coba lagi.",
        en = "⛔ Market box data not detected.\n\nPlease restart the game and try again."
    },
    ["toast_success_market"] = {id = "✅ Sukses", en = "✅ Success"},
    ["alert_success_market_1"] = {
        id = "📦 Jumlah kotak pasar telah diatur ke ",
        en = "📦 Number of market boxes set to "
    },
    ["alert_success_market_2"] = {
        id = ".\nKeluar dari pasar dan buka kembali untuk melihat perubahan.",
        en = ".\nExit and reopen the market to see the change."
    },

    ["dealer_cd_not_found"] = {
        id = "❌ Data cooldown Dealer tidak ditemukan.\n\nSilakan mulai ulang permainan dan coba lagi.",
        en = "❌ Dealer cooldown data not found.\n\nPlease restart the game and try again."
    },
    ["dealer_cd_invalid"] = {
        id = "⛔ Cooldown Dealer valid tidak ditemukan.\n\nCoba masuk ulang ke Market.",
        en = "⛔ Valid Dealer cooldown not found.\n\nPlease re-enter the Market and try again."
    },
    ["dealer_cd_freeze_success"] = {
        id = "🛒 Cooldown Dealer berhasil dibekukan!\nDealer sekarang tanpa waktu istirahat.",
        en = "🛒 Dealer cooldown successfully frozen!\nDealer now has no waiting time."
    },
    ["dealer_cd_success"] = {id = "✅ Sukses", en = "✅ Success"},

    ["dealer_duration_title"] = {
        id = "⏳ Pilih Durasi Sewa Dealer",
        en = "⏳ Select Dealer Rental Duration"
    },
    ["dealer_30_days"] = {id = "🗓️ 30 Hari", en = "🗓️ 30 Days"},
    ["dealer_6_months"] = {id = "📆 6 Bulan", en = "📆 6 Months"},
    ["dealer_1_year"] = {id = "📅 1 Tahun", en = "📅 1 Year"},

    ["dealer_data_not_found"] = {
        id = "❌ Data Dealer tidak ditemukan.\nSilakan mulai ulang permainan dan coba lagi.",
        en = "❌ Dealer data not found.\nPlease restart the game and try again."
    },
    ["dealer_valid_not_found"] = {
        id = "⛔ Data Dealer valid tidak ditemukan.\nSilakan mulai ulang permainan dan coba lagi.",
        en = "⛔ Valid Dealer data not found.\nPlease restart the game and try again."
    },
    ["dealer_update_success"] = {
        id = "✅ Sewa Dealer berhasil diperbarui.\nSilakan keluar dari menu Dealer lalu buka kembali.",
        en = "✅ Dealer rental successfully updated.\nPlease exit the Dealer menu and open it again."
    },
    ["dealer_active_toast"] = {
        id = "📦 Dealer Aktif!",
        en = "📦 Dealer Active!"
    },

    ----menu ragam----

    ["industry_boost_gamragam"] = {
        id = "🏭 • Akademi Industri",
        en = "🏭 • Industry Academy"
    },
    ["heli_tcash_gamragam"] = {
        id = "🚁 • T-Cash dari Helikopter",
        en = "🚁 • T-Cash from Helicopter"
    },
    ["wheat_exp_menupenambah"] = {
        id = "🌱 • Boost EXP Gandum",
        en = "🌱 • Wheat EXP Boost"
    },
    ["free_boxes_gamragam"] = {
        id = "🎁 • Kotak Pabrik Gratis",
        en = "🎁 • Free Factory Box"
    },
    ["build_no_tools_gamragam"] = {
        id = "👷‍♀️ • Komunitas Tanpa Alat",
        en = "👷‍♀️ • Community Without Tools"
    },
    ["freeze_expansion_gamragam"] = {
        id = "🚧 • Bekukan Ekspansi Kota",
        en = "🚧 • Freeze City Expansion"
    },
    ["unlimited_likes"] = {
        id = "👍 • Like Kota Tanpa Batas",
        en = "👍 • Unlimited City Likes"
    },
    ["back_gamragam"] = {id = "❌ • Kembali", en = "❌ • Go Back"},

    ["alert_star_brik"] = {
        id = "🌟 Pilih level bintang di industri",
        en = "🌟 Select the star level in the industry"
    },
    ["prompt_star_brik"] = {
        id = "🔢 Masukkan nomor level bintang [2–53]:",
        en = "🔢 Enter star level number [2–53]:"
    },
    ["prompt_value_brik"] = {
        id = "🕑 Masukkan nilai cooldown [99;100]",
        en = "🕑 Cooldown value [99;100]"
    },
    ["err_star_brik"] = {
        id = "🚫 Level bintang tidak valid (harus 2–53).",
        en = "🚫 Invalid star level (must be 2–53)."
    },
    ["err_value_brik"] = {
        id = "❌ Nilai cooldown tidak valid (harus 99 atau 100).",
        en = "❌ Invalid star value (must be 99 or 100)."
    },
    ["not_found_brik"] = {
        id = "❌ Pola tidak ditemukan",
        en = "❌ Pattern not found"
    },
    ["patched_brik"] = {
        id = "✅ Pola berhasil diubah",
        en = "✅ Pattern successfully set"
    },

    ["retasheliprompt_koin"] = {
        id = "💰 Masukkan jumlah Koin : [1;99999]",
        en = "💰 Enter Coin amount : [1;99999]"
    },
    ["retasheliprompt_cash"] = {
        id = "💵 Masukkan jumlah Cash : [0;999]",
        en = "💵 Enter Cash amount : [0;999]"
    },
    ["retasheliprompt_exp"] = {
        id = "⭐ Masukkan jumlah EXP (tanpa batas) :",
        en = "⭐ Enter EXP amount (no limit) :"
    },
    ["retasheliminimal_satu"] = {
        id = "🚫 Masukkan minimal satu nilai untuk diproses.",
        en = "🚫 Enter at least one value to process."
    },
    ["retashelidata_tidak_ditemukan"] = {
        id = "❌ Data tidak ditemukan.\n\nSilakan coba kembali atau restart permainan terlebih dahulu.",
        en = "❌ Data not found.\n\nPlease try again or restart the game first."
    },
    ["retashelitidak_valid"] = {
        id = "⛔ Tidak ditemukan data yang valid.\nSilakan restart permainan dan coba lagi.",
        en = "⛔ No valid data found.\nPlease restart the game and try again."
    },
    ["retashelisukses"] = {
        id = "🎉 Coin, Cash, dan EXP berhasil ditambahkan!",
        en = "🎉 Coin, Cash, and EXP successfully added!"
    },

    ["ganmasukkan_exp"] = {
        id = "🌾 Masukkan jumlah EXP yang ingin ditambahkan:",
        en = "🌾 Enter the amount of EXP to add:"
    },
    ["gandata_tidak_ditemukan"] = {
        id = "❌ Data tidak ditemukan.\n\nSilakan coba kembali atau restart permainan terlebih dahulu.",
        en = "❌ Data not found.\n\nPlease try again or restart the game first."
    },
    ["gantidak_ada_valid"] = {
        id = "⚠️ Tidak ditemukan data EXP yang valid.\nSilakan coba lagi.",
        en = "⚠️ No valid EXP data found.\nPlease try again."
    },
    ["ganexp_sukses"] = {
        id = "🎉 EXP berhasil ditambahkan: 🌾 ",
        en = "🎉 EXP successfully added: 🌾 "
    },

    ["pabrik_enter_cash"] = {
        id = "💸 Masukkan jumlah Uang Tunai yang terlihat di pabrik:",
        en = "💸 Enter the Cash amount visible in the factory:"
    },
    ["pabrik_not_found"] = {
        id = "❌ Data tidak ditemukan.\nSilakan restart game lalu coba kembali.",
        en = "❌ Data not found.\nPlease restart the game and try again."
    },
    ["pabrik_no_match"] = {
        id = "⛔ Tidak ditemukan data pabrik yang cocok.\nPastikan nilai cash benar.",
        en = "⛔ No matching factory data found.\nPlease verify the cash value."
    },
    ["pabrik_success"] = {
        id = "✅ Pabrik gratis aktif.",
        en = "✅ Free factory activated."
    },

    ["gekomdata_tidak_ditemukan"] = {
        id = "❌ Data tidak ditemukan.\n\nSilakan coba kembali atau restart permainan terlebih dahulu.",
        en = "❌ Data not found.\n\nPlease try again or restart the game first."
    },
    ["gekomtidak_valid"] = {
        id = "⛔ Tidak ditemukan data komunitas yang valid.",
        en = "⛔ No valid community data found."
    },
    ["gekomkomunitas_sukses_alert"] = {
        id = "✅ Komunitas berhasil diperbarui.\n\nSilakan restart permainan untuk melihat perubahannya.",
        en = "✅ Community updated successfully.\n\nPlease restart the game to see the changes."
    },
    ["gekomkomunitas_sukses_toast"] = {
        id = "🎉 Komunitas berhasil diperbarui!",
        en = "🎉 Community updated successfully!"
    },

    ["perluasan_not_found"] = {
        id = "❌ Data tidak ditemukan.\nSilakan restart game lalu coba kembali.",
        en = "❌ Data not found.\nPlease restart the game and try again."
    },
    ["perluasan_no_match"] = {
        id = "⛔ Tidak ditemukan data perluasan yang cocok.",
        en = "⛔ No matching expansion data found."
    },
    ["perluasan_success"] = {
        id = "✅ Perluasan tanpa population aktif.",
        en = "✅ Expansion without population activated."
    },

    ["alert_boom_likes"] = {
        id = "❌ Data Boom Like tidak ditemukan.\n\nSilakan restart game lalu coba lagi.",
        en = "❌ Boom Like data not found.\n\nPlease restart the game and try again."
    },
    ["toast_boom_likes"] = {
        id = "💖 Like tanpa batas berhasil diaktifkan!",
        en = "💖 Infinite Like successfully activated!"
    },

    -------------------------------------------------------------------------------------------

    ["rangememorymenu"] = {
        id = "🔍 Pilih Rentang Memori",
        en = "🔍 Select Memory Range"
    },

    ["about_script"] = {
        id = "📖 • Panduan Naskah",
        en = "📖 • Script Guide"
    },
    ["contact_dev"] = {
        id = "📞 • Hubungi Penjual",
        en = "📞 • Contact The Seller"
    },
    ["reset_default"] = {
        id = "🔁 • Kembali ke Menu Awal",
        en = "🔁 • Back to Main Menu"
    },
    ["change_lang"] = {
        id = "🌐 • Ubah Bahasa",
        en = "🌐 • Change Language"
    },
    ["rangememory"] = {
        id = "🔍 • Pilih Rentang Memori",
        en = "🔍 • Select Memory Range"
    },
    ["go_back"] = {id = "❌ • Kembali", en = "❌ • Go Back"},

    ["select_lang"] = {id = "🌐 Pilih Bahasa:", en = "🌐 Choose Language:"},
    ["lang_set"] = {
        id = "✅ Bahasa diatur ke: Indonesia",
        en = "✅ Language set to: English"
    },

    ["premium_info"] = {
        id = [[
┏━━━━｢💎𝗣𝗥𝗘𝗠𝗜𝗨𝗠   𝗔𝗖𝗖𝗘𝗦𝗦💎｣━━━━┓
┃🚀ɴɪᴋᴍᴀᴛɪ ꜱᴇᴍᴜᴀ ꜰɪᴛᴜʀ ᴛᴀɴᴘᴀ ʙᴀᴛᴀꜱ!🚀
┗━━━━━━━━━━━━━━━━━━━━━━━━━━┛

🌟 Keuntungan Premium:
• 🌊 Regatta otomatis selesai
• 👍 Like kota tanpa batas
• 📦 Slot pasar tambahan
• 🎭 Semua skin lama terbuka
• 🏞️ 200+ Dekorasi eksklusif
• 🤖 Stiker obrolan koop
• 💝 Bingkai & Nama warna pink
• 🚀 Booster Match-3 lengkap
• 🧪 Booster Laboratorium lengkap
• 🏡 Booster Lumbung tanpa batas
• ✨ ...dan masih banyak lagi!
──────────────────────────
💵 Harga:
🇮🇩 IDR 415.000

📆 Masa Aktif:
♾️ 1 tahun
──────────────────────────
📩 Hubungi Penjual:
💬 Telegram: @a_nnour


]],
        en = [[
┏━━━━｢💎𝗣𝗥𝗘𝗠𝗜𝗨𝗠   𝗔𝗖𝗖𝗘𝗦𝗦💎｣━━━━┓
┃🚀ᴇɴᴊᴏʏ ᴀʟʟ ꜰᴇᴀᴛᴜʀᴇꜱ ᴡɪᴛʜ ɴᴏ ʟɪᴍɪᴛꜱ!🚀
┗━━━━━━━━━━━━━━━━━━━━━━━━━━┛

🌟 Premium Benefits:
• 🌊 Auto Regatta completion
• 👍 Unlimited city likes
• 📦 Extra market slots
• 🎭 All legacy skins unlocked
• 🏞️ 200+ Exclusive decorations
• 🤖 Coop chat stickers
• 💝 Pink name & frame color
• 🚀 Complete Match-3 boosters
• 🧪 Complete Laboratory boosters
• 🏡 Unlimited Barn boosters
• ✨ ...and much more!
──────────────────────────
💵 Price:
🇺🇸 USD 45$

📆 Duration:
♾️ 1 YEARS Access
──────────────────────────
📩 Contact The Seller:
💬 Telegram: @a_nnour

📢 Telegram Channel (Info & Updates):
📨 ｢Rish｣ • Official Channel
]]
    },
    ["btn_back"] = {id = "❌ Kembali", en = "❌ Go Back"},
    ["btn_tele"] = {id = "📩 Telegram", en = "📩 Telegram"},
    ["btn_wa"] = {id = "📢 Telegram Channel", en = "📢 Telegram Channel"},
    ["toast_back"] = {
        id = "↩️ Kembali ke menu sebelumnya",
        en = "↩️ Back to previous menu"
    },
    ["toast_tele"] = {
        id = "✅ Username Telegram berhasil disalin!",
        en = "✅ Telegram username copied!"
    },
    ["toast_wa"] = {
        id = "✅ Link Telegram berhasil disalin!",
        en = "✅ Telegram link copied!"
    },

    ["about_msg"] = {
        id = [[
┏━━━━━━｢‼️𝗜𝗡𝗙𝗢    𝗡𝗔𝗦𝗞𝗔𝗛‼️｣━━━━━━┓
┃📖Rish ꜱᴄʀɪᴘᴛ — ᴘᴀɴᴅᴜᴀɴ & ᴘᴇʀɪɴɢᴀᴛᴀɴ📖
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

⚠️ PERINGATAN PENTING
Gunakan script ini dengan bijak. Kami tidak bertanggung jawab atas konsekuensi penggunaan yang melanggar ketentuan permainan termasuk banned permanen.

💸 Batas T-Cash
• Disarankan: maksimal 10.000 T-Cash per akun.  
• Ingin top-up lebih besar? Pertimbangkan risiko banned permanen.
• Toleransi pengisian maksimal 25.000 T-Cash melebihi toleransi berisiko kena banned.

🏡 Peningkatan Lumbung (Barn Upgrade)
• Lakukan peningkatan sesuai panduan resmi (salin link untuk melihat panduan upgrade).  
• Upgrade berlebih atau tidak sesuai risiko deteksi dan banned.

🤝 Global Co-op
• Bergabung dengan koop papan atas (global) tidak diwajibkan.  
• Bergabung pada kelompok yang berisiko tinggi dapat meningkatkan kemungkinan banned.

🔧 Jika fitur tidak bekerja
• Coba restart game 1–3 kali.  
• Masih bermasalah? Hubungi Pemilik melalui menu Kontak di dalam script.

📌 Catatan Tambahan
• Gunakan akun cadangan untuk percobaan.  
• Hindari aktivitas yang jelas melanggar aturan permainan.

🙏 Terima kasih
Terima kasih sudah menggunakan rish Script. Gunakan secara bijak.
]],
        en = [[
┏━━━━｢‼️𝗦𝗖𝗥𝗜𝗣𝗧   𝗜𝗡𝗙𝗢‼️｣━━━━━┓
┃📖Rish ꜱᴄʀɪᴘᴛ — ɢᴜɪᴅᴇ & ᴡᴀʀɴɪɴɢ📖
┗━━━━━━━━━━━━━━━━━━━━━━━┛

⚠️ IMPORTANT WARNING
Use this script responsibly. We are not responsible for any consequences, including permanent bans, due to violating game policies.

💸 T-Cash Limit
• Recommended: maximum 10,000 T-Cash per account.  
• Want more top-up? Consider the risk of a permanent ban.  
• Exceeding 25,000 T-Cash tolerance may lead to permanent ban.

🏡 Barn Upgrade
• Follow the official upgrade guide (copy link below to view).  
• Excessive or irregular upgrades increase detection and ban risk.

🤝 Global Co-op
• Joining top (global) co-ops is not mandatory.  
• Joining high-risk groups increases ban likelihood.

🔧 If features don’t work
• Try restarting the game 1–3 times.  
• Still not working? Contact the Owner through the in-script Contact menu.

📌 Additional Notes
• Use a backup account for testing.  
• Avoid any clearly rule-breaking actions.

🙏 Thank You
Thank you for using rish Script. Use it responsibly.
]]
    },
    ["back_btn"] = {id = "❌ Kembali", en = "❌ Go Back"},
    ["barn_table"] = {id = "🏡 Tabel lumbung", en = "🏡 Barn table"},
    ["copied_link"] = {
        id = "✅ Link berhasil disalin!",
        en = "✅ Link copied successfully!"
    },

    ["thank_you_exit"] = {
        id = "👋 Terima kasih telah menggunakan script ini.\n✨ Semoga harimu menyenangkan!",
        en = "👋 Thank you for using this script.\n✨ Have a great day!"
    }
}
function _(k) return teks[k] and teks[k][lang] or k end

function saveLang()
    local file = io.open("/sdcard/.tempdata.bin/.langmode", "w")
    if file then
        file:write(lang)
        file:close()
    end
end

function loadLang()
    local file = io.open("/sdcard/.tempdata.bin/.langmode", "r")
    if file then
        local content = file:read("*l")
        if content == "id" or content == "en" then lang = content end
        file:close()
    end
end

-- ⏳ Panggil saat awal
loadLang()

-- 📁 Global config
local configFile = "/sdcard/Android/media/.com.android.sistem/.templog_dmp"
local menuMode, menuRunning = nil, false

-- 📥 Load saved mode
function loadMode()
    local file = io.open(configFile, "r")
    if file then
        local mode = file:read("*l")
        file:close()

        if mode == "free" or mode == "premium" then
            menuMode = mode
        else
            menuMode = "premium" -- ✅ default
        end
    else
        menuMode = "premium" -- ✅ default pertama kali
    end
end


-- 💾 Save mode
function saveMode(mode)
    local file = io.open(configFile, "w")
    if file then
        file:write(mode or "")
        file:close()
    end
end

-- 🔁 Reset mode
function resetMode()
    menuMode = nil
    saveMode(nil)
    gg.toast(_("mode_reset"))
end

-- ✅ Jalankan pengecekan alamat
if type(getAddr) == "function" then
    local addr = getAddr()
    if addr then
        -- 🔧 Tambahkan patching memori di sini jika diperlukan
    else
    end
else
end

function mainMenu()
    local welkam = starting
    local menu = gg.choice({
        _("free_script"), _("premium_script"), _("buy_key"), _("exit_script")
    }, nil, welkam)

    if menu == 1 then
        menuMode = "free"
        saveMode(menuMode)
        freekey()
    elseif menu == 2 then
        menuMode = "premium"
        saveMode(menuMode)
        Main()
    elseif menu == 3 then
        buykey()
    elseif menu == 4 then
        exit()
    end
end

-- 🌐 Feature Status Setup
local on, off = " ✓ ", ""
local cstatus_featureX = off

function toggle_featureX(silent)
    cstatus_featureX = (cstatus_featureX == off) and on or off
    if not silent then
        if cstatus_featureX == on then
            gg.alert("❄️ Freeze feature is now ON ✅")
        else
            gg.toast("🔥 Freeze feature is now OFF ❌")
        end
    end
end

-- 🔓 Free Script Menu
local freezeFlagAddr = 0x20000000 -- Gunakan alamat kosong/aman

function setFreezeFlag(value)
    gg.setValues({
        {address = freezeFlagAddr, flags = gg.TYPE_DWORD, value = value}
    })
end

function getFreezeFlag()
    local v = gg.getValues({{address = freezeFlagAddr, flags = gg.TYPE_DWORD}})
    return v[1].value == 1
end

rangesSelected = false

function pilihRanges()
    while true do
        local r = gg.choice({
            "🔹 Ca: Alloc", "🔹 O: Other", "🔹 A: Anonymous",
            "🔹 Ca: Alloc + Other", "🔹 Ca: Alloc + Anonymous",
            "🔹 Ca: Alloc + Other + Anonymous"
        }, nil, _("rangememorymenu"))

        -- ❌ Jika user cancel → tutup menu, tunggu klik GG lagi
        if r == nil then return false end

        if r == 1 then
            gg.setRanges(gg.REGION_C_ALLOC)
        elseif r == 2 then
            gg.setRanges(gg.REGION_OTHER)
        elseif r == 3 then
            gg.setRanges(gg.REGION_ANONYMOUS)
        elseif r == 4 then
            gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_OTHER)
        elseif r == 5 then
            gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS)
        elseif r == 6 then
            gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_OTHER |
                             gg.REGION_ANONYMOUS)
        end

        rangesSelected = true
        return true
    end
end

function freekey()
    -- 🔐 Wajib pilih range dulu
    if not rangesSelected then
        local ok = pilihRanges()
        if not ok then
            return -- ⛔ stop total, menu free tidak muncul
        end
    end

    menuRunning = true
    while menuRunning and menuMode == "free" do
        local menuList = {
            _("unlock_season_freemenu"),
            _("freeze_rewards_freemenu") .. " " .. cstatus_featureX
        }

        local idxChangeReward = nil
        if rewardVisible then
            table.insert(menuList, _("change_reward_freemenu"))
            idxChangeReward = #menuList
        end

        local idxMisc = #menuList + 1
        table.insert(menuList, _("misc_mods_freemenu"))

        local idxInfo = #menuList + 1
        table.insert(menuList, _("script_info_freemenu"))

        local idxExit = #menuList + 1
        table.insert(menuList, _("exit_script_freemenu"))

        local menu = gg.choice(menuList, nil, _("free_menu_freemenu"))
        if not menu then break end

        if menu == 1 then
            menue1()
        elseif menu == 2 then
            menue2()
        elseif idxChangeReward and menu == idxChangeReward then
            menue3()
        elseif menu == idxMisc then
            menue4()
        elseif menu == idxInfo then
            menu6()
        elseif menu == idxExit then
            exit()
            menuRunning = false
            break
        else
        end
    end
    menuRunning = false
end

function menue3()
    local title = banner
    local menu = gg.choice({
        _("smelt_ingots_changefree"), _("mining_tools1_changefree"),
        _("redeem_coupons_changefree"), _("add_gems_changefree"),
        _("match3_boosters_changefree"), _("community_materials_changefree"),
        _("claim_perks_changefree"), _("go_back_changefree")
    }, nil, title)

    if not menu then return end

    local actions = {rw1, rw2, rw3, rw4, rw5, rw6, rw7, rw8, freekey}
    if actions[menu] then
        actions[menu]()
    else
    end
end

function menue4()
    local title = banner
    local menu = gg.choice({
        _("menu4_opt2_hackfree"),
        _("menu4_opt3_hackfree"), _("menu4_opt4_hackfree"),
        _("menu4_opt5_hackfree"), _("menu4_opt6_hackfree"),
        _("menu_back_hackfree")
    }, nil, title)

    if not menu then return end

    local actions = {
    
        oder2, -- Wheat EXP
        oder3, -- Factory Boxes
        oder4, -- Land Expansion
        oder5, -- Furnace Speedup
        oder6, -- Farm Production
        freekey -- Back
    }

    if actions[menu] then
        actions[menu]()
    else
        return
    end

    if menu ~= 8 then
        while not gg.isVisible(true) do end
        gg.setVisible(false)
        menue4()
    end
end
-- 🔧 DEV MODE
-- true  = langsung masuk menu (login dilewati)
-- false = login normal
local DEV_MODE = true

-- 💎 Premium Script Menu
function Main()

    -- 🔐 Wajib pilih range dulu
    if not rangesSelected then
        local ok = pilihRanges()
        if not ok then return end
    end

    menuRunning = true
    while menuRunning and menuMode == "premium" do

        -- ==============================================
        -- 📁 Lokasi File
        -- ==============================================
        local passFile = "/sdcard/Android/media/.com.android.sistem/.syscfg_u1"
        local permCodeFile = "/sdcard/Android/media/.com.android.sistem/.bin_xv"
        local expiredDevicesFile =
            "/sdcard/Android/media/.com.android.sistem/.tmp_87g"

        -- ==============================================
        -- ⚙️ CONFIG EXPIRED USER
        -- ==============================================
        local expiredUserID = 10
        local expiredCode = "523971"
        local expireDate = "2026-02-03"

        -- ==============================================
        -- 🚫 LOGIN SYSTEM (DILEWATI JIKA DEV MODE)
        -- ==============================================
        local loginOK = false

        if not DEV_MODE then

            -- 🎲 Random ID
            local function randomID()
                local r = ""
                for i = 1, 16 do r = r .. math.random(0, 9) end
                return r
            end

            -- 🔒 Hash
            local function hash(str)
                local h = 0
                for i = 1, #str do
                    h = (h * 31 + str:byte(i)) % 1000000007
                end
                return tostring(h)
            end

            -- 📅 Expired checker
            local function isExpiredDate()
                local y, m, d = expireDate:match("(%d+)-(%d+)-(%d+)")
                local exp = os.time {
                    year = y,
                    month = m,
                    day = d,
                    hour = 23,
                    min = 59,
                    sec = 59
                }
                return os.time() > exp
            end

            local function getDaysLeft(date)
                local y, m, d = date:match("(%d+)-(%d+)-(%d+)")
                local t = os.time {
                    year = y,
                    month = m,
                    day = d,
                    hour = 23,
                    min = 59,
                    sec = 59
                }
                return math.floor((t - os.time()) / 86400)
            end

            -- 📥 Permanent code
            local f = io.open(permCodeFile, "r")
            local permanentCode = f and f:read("*a") or nil
            if f then f:close() end

            if not permanentCode then
                gg.alert("❌ Permanent code not found.")
                resetMode()
                os.exit()
            end

            local expectedHash = hash(permanentCode)

            -- 📂 Permanent devices
            local permanentDevices = {}
            local pf = io.open(passFile, "r")
            if pf then
                for l in pf:lines() do
                    permanentDevices[#permanentDevices + 1] = l
                end
                pf:close()
            end

            local function isPermanentDeviceRegistered(h)
                for _, v in ipairs(permanentDevices) do
                    if v == h then return true end
                end
                return false
            end

            -- 📂 Expired devices
            local expiredDevices = {}
            local ef = io.open(expiredDevicesFile, "r")
            if ef then
                for l in ef:lines() do
                    expiredDevices[#expiredDevices + 1] = l
                end
                ef:close()
            end

            local function expiredDeviceMatch(prefix)
                for _, id in ipairs(expiredDevices) do
                    if id:sub(1, #prefix) == prefix then
                        return true
                    end
                end
                return false
            end

            local expiredPrefix = hash(permanentCode .. expiredCode)

            local function showLoginInfo(mode)
                gg.toast("Login success: " .. mode)
            end

            -- 🔐 AUTO LOGIN
            if isPermanentDeviceRegistered(expectedHash) then
                loginOK = true
            end

            if not loginOK and expiredDeviceMatch(expiredPrefix) then
                if isExpiredDate() then
                    gg.alert("⛔ License expired")
                else
                    loginOK = true
                end
            end

            -- 🔐 MANUAL LOGIN
            while not loginOK do
                local i = gg.prompt({"🔐 Enter Code"}, {""}, {"text"})
                if not i then os.exit() end

                if i[1] == permanentCode then
                    if not isPermanentDeviceRegistered(expectedHash) then
                        local w = io.open(passFile, "a")
                        if w then
                            w:write(expectedHash .. "\n")
                            w:close()
                        end
                    end
                    showLoginInfo("Permanent")
                    loginOK = true

                elseif i[1] == expiredCode then
                    if isExpiredDate() then
                        gg.alert("⛔ Expired")
                    else
                        local id = expiredPrefix .. randomID()
                        local w = io.open(expiredDevicesFile, "a")
                        if w then
                            w:write(id .. "\n")
                            w:close()
                        end
                        showLoginInfo("Expired")
                        loginOK = true
                    end
                else
                    gg.alert("❌ Invalid code")
                end
            end

        else
            -- 🔓 DEV MODE
            loginOK = true
        end

        local menu = gg.choice({
            _("special_hack_premenu"), -- 🔹 Menu baru di atas limited_events
            _("unlock_season_premenu"), _("limited_events_premenu"),
            _("skip_time_premenu"), -- 🔹 Menu baru di bawah limited_events (sudah ada)
            _("farming_products_premenu"), _("city_market_place"),
            _("misc_mods_premenu"), _("script_info_premenu"),
            _("exit_script_premenu")
        }, nil, _("premium_menu_premenu"))

        if menu == nil then break end
        if menu == 2 then
            menu1()
        elseif menu == 1 then
            Regata() -- 🔹 Fungsi untuk special hack
        elseif menu == 3 then
            menu2()
        elseif menu == 4 then
            menu7() -- 🔹 Skip waktu
        elseif menu == 5 then
            menu3()
        elseif menu == 6 then
            menumarketplace()
        elseif menu == 7 then
            menu4()
        elseif menu == 8 then
            menu6()
        elseif menu == 9 then
            exit()
            menuRunning = false
        else
        end
        break
    end
    menuRunning = false
end

rewardVisible = rewardVisible or false -- bersifat sementara (reset tiap restart)

function menu1()
    local title = banner
    local menuList = {
        _("unlock_pass_rwpremium"), -- 1
        _("freeze_rewards_rwpremium") .. cstatus_featureX -- 2
    }

    if rewardVisible then
        table.insert(menuList, _("skins_decor_rwpremium")) -- 3
        table.insert(menuList, _("add_cash_rwpremium")) -- 4
        table.insert(menuList, _("boosters_rwpremium")) -- 5
        table.insert(menuList, _("redeem_coupon_rwpremium")) -- 6
        table.insert(menuList, _("add_gems_rwpremium")) -- 7
        table.insert(menuList, _("metal_ingots_materialyal")) -- 8
        table.insert(menuList, _("mining_tools_materialyal")) -- 9
        table.insert(menuList, _("special_product_rwpremium")) -- 10
        table.insert(menuList, _("cardpack_reward")) -- 11
    end

    table.insert(menuList, _("go_back_rwpremium")) -- 10 (atau 3 jika rewardVisible = false)

    local menu = gg.choice(menuList, nil, title)

    if not menu then
        return -- ⛔ Stop di sini, jangan lanjut ke loop
    end

    if menu == 1 then
        gp1()
    elseif menu == 2 then
        gp2()
    elseif rewardVisible and menu == 3 then
        gp3()
    elseif rewardVisible and menu == 4 then
        gp4()
    elseif rewardVisible and menu == 5 then
        gp5()
    elseif rewardVisible and menu == 6 then
        gp6()
    elseif rewardVisible and menu == 7 then
        gp7()
    elseif rewardVisible and menu == 8 then
        gp8()
    elseif rewardVisible and menu == 9 then
        gp9()
    elseif rewardVisible and menu == 10 then
        gp10()
    elseif rewardVisible and menu == 11 then
        gp11()
    elseif (not rewardVisible and menu == 3) or (rewardVisible and menu == 12) then
        Main()
        return
    else
        return
    end

    -- 🔁 Hanya lanjut loop jika opsi valid dijalankan
    while true do
        if gg.isVisible(true) then
            gg.setVisible(false)
            menu1()
            break
        end
    end
end

-- 🌟 Unlock Season Pass
function menue1() gp1("free") end

function gp1(caller)
    gg.setVisible(false)
    gg.clearResults()

    -- 🔍 Cari QWORD utama
    gg.searchNumber("6875698586322892050", gg.TYPE_QWORD)
    local hasil = gg.getResults(100) -- ambil lebih banyak hasil untuk keamanan

    if #hasil == 0 then return gg.alert(_("gold_not_found_gp")) end

    local kandidat = {}

    -- 🧩 Filter hasil berdasarkan offset +0x48 == 690
    for i, res in ipairs(hasil) do
        local check = gg.getValues({
            {address = res.address + 0x48, flags = gg.TYPE_DWORD}
        })
        if check and check[1] and check[1].value == 700 then
            table.insert(kandidat, res)
        end
    end

    if #kandidat == 0 then return gg.alert(_("addr_not_found_gp")) end

    -- 🔁 Siapkan daftar edit untuk SEMUA kandidat
    local edits = {}
    for _, t in ipairs(kandidat) do
        local base = t.address
        table.insert(edits,
                     {address = base + 0x118, flags = gg.TYPE_DWORD, value = 0})
        table.insert(edits, {
            address = base + 0x11C,
            flags = gg.TYPE_DWORD,
            value = 651
        }) -- kode Gold Pass
        table.insert(edits,
                     {address = base + 0x128, flags = gg.TYPE_DWORD, value = 1})
    end

    -- 🛠 Terapkan perubahan
    gg.setValues(edits)

    -- ✅ Info ke user
    gg.toast(_("gold_enabled_gp"))
end

-- ❄️ Freeze Rewards
function menue2() gp2("free") end

function gp2(caller)
    if cstatus_featureX == off then
        local confirm = gg.alert(_("freeze_info"), _("freeze_continue"),
                                 _("freeze_cancel"))

        if confirm ~= 1 then return end
        cstatus_featureX = on
        rewardVisible = true
    end

    -- 📁 Cache Setup
    local folder = "/sdcard/.syscfg.lib/"
    local fileItem = folder .. ".itemcache"
    local fileAddr = folder .. ".addresscache"

    -- 🧹 Delete File Safely
    local function deleteFile(path) pcall(function() os.remove(path) end) end

    -- 📍 Get Cached or New Address
    function getAddr()
        local cacheInvalid = false
        local cachedAddr
        local file = io.open(fileAddr, "r")

        if file then
            cachedAddr = tonumber(file:read("*l") or "")
            file:close()
        end

        if cachedAddr then
            local check = gg.getValues({
                {address = cachedAddr, flags = gg.TYPE_DWORD}
            })
            if check and check[1] and check[1].value == 29 then
                return cachedAddr
            else
                deleteFile(fileAddr)
                deleteFile(fileItem)
                gg.toast(_("startcache_cleared"))
                cacheInvalid = true
            end
        end

        gg.clearResults()
        gg.searchNumber("28;29;1970225960::849", gg.TYPE_DWORD)
        gg.refineNumber("29", gg.TYPE_DWORD)
        local results = gg.getResults(1)

        if #results == 0 then
            gg.alert(_("startaddr_not_found"))
            return nil
        end

        local newAddr = results[1].address
        local fileSave = io.open(fileAddr, "w")
        if fileSave then
            fileSave:write(newAddr)
            fileSave:close()
        end

        if cacheInvalid then
            gg.alert(_("startaddr_refreshed"))
            while not gg.isVisible(true) do gg.sleep(200) end
            gg.setVisible(false)
        end

        return newAddr
    end

    gg.clearResults()

    -- 🔍 Cari pola utama
    gg.searchNumber("5507461923117941548", gg.TYPE_QWORD)
    local hasil = gg.getResults(1000)

    if #hasil == 0 then return gg.alert(_("freeze_fail_title")) end

    local readList = {}
    for i, res in ipairs(hasil) do
        readList[#readList + 1] = {
            address = res.address + 0x38C,
            flags = gg.TYPE_DWORD
        }
    end

    -- 🔥 Hanya 1 kali pemanggilan, bukan ribuan!
    local readResult = gg.getValues(readList)

    -- 🔍 Filter kandidat berdasarkan nilai offset
    local kandidat = {}
    for i, val in ipairs(readResult) do
        if val.value == 27491 then table.insert(kandidat, hasil[i]) end
    end

    if #kandidat == 0 then return end

    local freezeItems = {}

    for _, target in ipairs(kandidat) do
        freezeItems[#freezeItems + 1] = {
            address = target.address - 8,
            flags = gg.TYPE_DWORD,
            value = 0,
            freeze = true
        }
        freezeItems[#freezeItems + 1] = {
            address = target.address - 12,
            flags = gg.TYPE_DWORD,
            value = 0,
            freeze = true
        }
        freezeItems[#freezeItems + 1] = {
            address = target.address - 16,
            flags = gg.TYPE_DWORD,
            value = 0,
            freeze = true
        }
    end

    gg.addListItems(freezeItems)

    gg.toast(_("freeze_active_toast"))
    gg.clearResults()
end

function gp4() -- 💰 Currency Menu
    local indev = dev
    local menu = gg.choice({
        _("add_tcash_tambahduit"), _("add_coins_tambahduit"),
        _("add_regatta_tambahduit"), _("add_clover_tambahduit"),
        _("add_statuecoins_tambahduit"), _("go_back_tambahduit")
    }, nil, indev)

    if menu == nil then return end

    local actions = {
        cash1, -- 💵 T-Cash
        cash2, -- 💰 Coins
        cash3, -- 🪙 Regatta Token
        cash4, -- 🍀 Clover
        cash5, -- 🗽 Statue Coins
        menu1 -- ❌ Back
    }

    if actions[menu] then
        actions[menu]()
    else
        return
    end

    -- Kembali ke menu Currency jika belum memilih "Back"
    if menu ~= 6 then
        while true do
            if gg.isVisible(true) then
                gg.setVisible(false)
                gp4()
                break
            end
        end
    end
end

-- 🔄 Apply Reward Using Cached Address
function applyCurrencyReward(key, pattern, promptRange, fixedAmount)
    local label = _(key)
    local addr = getAddr()
    if not addr then return end

    local amount = fixedAmount
    if not amount and promptRange then
        local min, max = promptRange[1], promptRange[2]
        local input = gg.prompt({label .. " [" .. min .. "–" .. max .. "]:"},
                                nil, {"number"})
        amount = tonumber(input and input[1])

        -- ❌ Input kosong atau bukan angka
        if not amount then return end

        -- ❌ Input di luar batas min–max
        if amount < min or amount > max then
            gg.alert(_("invalid_tambahduit") .. "\n✅ Min: " .. min ..
                         "\n✅ Max: " .. max)
            return
        end
    end

    local edits = {}
    for _, v in ipairs(pattern) do
        table.insert(edits, {
            address = addr + v[1],
            flags = gg.TYPE_DWORD,
            value = v[2]
        })
    end
    if amount then
        table.insert(edits, {
            address = addr + 0x2C,
            flags = gg.TYPE_DWORD,
            value = amount
        })
    end
    gg.setValues(edits)
    gg.toast(label ..
                 (amount and (_("set_to_tambahduit") .. amount .. " ✅") or
                     _("applied_tambahduit")))
end

function cash1()
    applyCurrencyReward("tcash_tambahduit", {
        {0x10, 0x73616308}, {0x14, 0x68}, {0x18, 0}, {0x1C, 0}, {0x20, 0},
        {0x24, 0}, {0x28, 0}
    }, {1, 25000})
end

function cash2()
    applyCurrencyReward("coin_tambahduit", {
        {0x10, 0x696F630A}, {0x14, 0x736E}, {0x18, 0}, {0x1C, 0}, {0x20, 0},
        {0x24, 0}, {0x28, 0}
    }, {1, 999999})
end

function cash3()
    applyCurrencyReward("regatta_tambahduit", {
        {0x10, 0x67655214}, {0x14, 0x43617461}, {0x18, 0x687361}, {0x1C, 0},
        {0x20, 0}, {0x24, 0}, {0x28, 0}
    }, {1, 2000})
end

function cash4()
    applyCurrencyReward("clover_tambahduit", {
        {0x10, 0x6F6C630C}, {0x14, 0x726576}, {0x18, 0}, {0x1C, 0}, {0x20, 0},
        {0x24, 0}, {0x28, 0}
    }, {1, 50})
end

function cash5()
    applyCurrencyReward("statue_tambahduit", {
        {0x10, 1635021594}, {0x14, 1600484724}, {0x18, 1953067639},
        {0x1C, 29285}, {0x20, 0}, {0x24, 0}, {0x28, 0}
    }, nil, 1)
end

function gp5()
    local title = banner
    local menu = gg.choice({
        _("match3_boosters_menuboost"), _("lab_boosters_menuboost"),
        _("unlimited_barn_keuntungan"), _("instant_build_keuntungan"),
        _("claim_bonus_rwpremium"), _("go_back_menuboost")
    }, nil, title)

    if not menu then return end

    local actions = {
        boost1, boost2, boost3, boost4, boost5, menu1 -- index 19: kembali ke menu utama booster
    }

    if actions[menu] then
        actions[menu]()
        if menu >= 1 and menu <= 5 then
            -- opsional: efek visual atau suara bisa ditambahkan di sini
        end
    else
    end

    -- Re-show the menu unless user chose "Back"
    if menu ~= 6 then
        while true do
            if gg.isVisible(true) then
                gg.setVisible(false)
                gp5()
                break
            end
        end
    end
end

-- ✅ Alias rw5 untuk Free Script
function rw5() boost1("free") end
function boost1(caller)
    local indev = dev
    local menu, actions = {}, {}

    -- Booster Umum (Free & Premium)
    table.insert(menu, "🌈 • " .. _("boost_event_bola_pelangi"))
    table.insert(actions, booster1)
    table.insert(menu, "💣 • " .. _("boost_event_bom"))
    table.insert(actions, booster2)
    table.insert(menu, "🚀 • " .. _("boost_event_roket"))
    table.insert(actions, booster3)

    -- Booster Tambahan (Premium Only)
    if caller ~= "free" then
        table.insert(menu, "🔨 • " .. _("boost_event_palu_tunggal"))
        table.insert(actions, booster4)
        table.insert(menu, "⬇️ • " .. _("boost_event_vertical"))
        table.insert(actions, booster5)
        table.insert(menu, "➡️ • " .. _("boost_event_horizontal"))
        table.insert(actions, booster6)
        table.insert(menu, "🪭 • " .. _("boost_event_kipas"))
        table.insert(actions, booster7)
        table.insert(menu, "❤️ • " .. _("infinite_lives_30_eventboost"))
        table.insert(actions, booster8)
        table.insert(menu, "✨ • " .. _("double_points_30_eventboost"))
        table.insert(actions, booster9)
        table.insert(menu, "🌈 • " .. _("rainbow_ball_30_eventboost"))
        table.insert(actions, booster10)
        table.insert(menu, "💣 • " .. _("bomb_30_eventboost"))
        table.insert(actions, booster11)
        table.insert(menu, "🚀 • " .. _("rocket_30_eventboost"))
        table.insert(actions, booster12)
        table.insert(menu, "⚡ • " .. _("energy_adventure_eventboost"))
        table.insert(actions, booster13)
        table.insert(menu, "⚓ • " .. _("frozentoken_menu"))
        table.insert(actions, booster14)
    end

    table.insert(menu, "❌ • " .. _("go_back_eventboost"))

    local choice = gg.choice(menu, nil, indev)
    if not choice then return end

    if choice == #menu then
        if caller == "free" then
            menue3()
        else
            gp5()
        end
        return
    end

    local selected = actions[choice]
    if selected then
        selected(caller)
    else
    end

    while true do
        if gg.isVisible(true) then
            gg.setVisible(false)
            boost1(caller)
            break
        end
    end
end

-- 🔧 Booster biasa dengan input jumlah
local function patchBooster(emoji, name, promptKey, hexData, caller)
    local addr = getAddr()
    if not addr then return end

    local maxLimit = (caller == "free") and 500 or 5000
    local min = 1

    local input = gg.prompt({
        emoji .. " " .. _(promptKey) .. " [" .. min .. "–" .. maxLimit .. "]:"
    }, nil, {"number"})
    local amount = tonumber(input and input[1])

    if not amount then return end

    if amount < min or amount > maxLimit then
        gg.alert(_("invalid_range_eventboost") .. "\n✅ Min: " .. min ..
                     "\n✅ Max: " .. maxLimit)
        return
    end

    local patch = {}
    for _, v in ipairs(hexData) do
        table.insert(patch, {
            address = addr + v[1],
            flags = gg.TYPE_DWORD,
            value = v[2]
        })
    end

    table.insert(patch,
                 {address = addr + 0x2C, flags = gg.TYPE_DWORD, value = amount})

    gg.setValues(patch)
    gg.toast(emoji .. " " .. name .. "" .. _("booster_applied_eventboost") ..
                 " " .. amount .. " ✅")
end

local function patchTimedBooster(emoji, name, hexData)
    local addr = getAddr()
    if not addr then return end

    local patch = {}
    for _, v in ipairs(hexData) do
        table.insert(patch, {
            address = addr + v[1],
            flags = gg.TYPE_DWORD,
            value = v[2]
        })
    end

    gg.setValues(patch)
    gg.toast(emoji .. " " .. name .. " " .. _("success_30d_eventnyawaganda"))
end

-- 🔁 Booster dengan template salin
local function copyPatchTemplate(offset)
    gg.clearResults()
    gg.searchNumber("1701669204;23;28;23;1446210844::433", gg.TYPE_DWORD)
    gg.refineNumber("28", gg.TYPE_DWORD)
    local ref = gg.getResults(1)
    if #ref == 0 then return nil end

    local base = ref[1].address + offset
    local copied = {}
    for i = 0, 5 do
        table.insert(copied, {address = base + i * 4, flags = gg.TYPE_DWORD})
    end
    return gg.getValues(copied)
end

-- 🔁 Booster dengan template salin
local function apply30DayBooster(emoji, name, offset)
    local copied = copyPatchTemplate(offset)
    if not copied then
        gg.alert(_("template_not_found_eventboost") .. " " .. name)
        return
    end

    gg.toast(_("template_copied_eventboost") .. " " .. name)

    local target = getAddr()
    if not target then return end

    local addr = target + 0x10
    local patch = {}
    for i, v in ipairs(copied) do
        table.insert(patch, {
            address = addr + (i - 1) * 4,
            flags = gg.TYPE_DWORD,
            value = v.value
        })
    end

    local extra = {{0x18, 0}, {0x1C, 2592000}}
    for _, e in ipairs(extra) do
        table.insert(patch, {
            address = addr + e[1],
            flags = gg.TYPE_DWORD,
            value = e[2]
        })
    end

    gg.setValues(patch)
    gg.toast(emoji .. " " .. name .. " " .. _("success_30d_eventbolabomroket"))
end

-- ✅ Booster Functions
function booster1(caller)
    patchBooster("🌈", _("boost_event_bola_pelangi"),
                 "rainbow_amount_eventboost", {
        {0x10, 1379101978}, {0x14, 1651403105}, {0x18, 1631745903},
        {0x1C, 27756}, {0x20, 0}, {0x24, 0}, {0x28, 0}
    }, caller)
end
function booster2(caller)
    patchBooster("💣", _("boost_event_bom"), "bomb_amount_eventboost", {
        {0x10, 1110666508}, {0x14, 6450543}, {0x18, 0}, {0x1C, 0}, {0x20, 0},
        {0x24, 0}, {0x28, 0}
    }, caller)
end
function booster3(caller)
    patchBooster("??", _("boost_event_roket"), "rocket_amount_eventboost", {
        {0x10, 1278438668}, {0x14, 6647401}, {0x18, 0}, {0x1C, 0}, {0x20, 0},
        {0x24, 0}, {0x28, 0}
    }, caller)
end

function booster4(caller)
    patchBooster("🔨", _("boost_event_palu_tunggal"),
                 "single_amount_eventboost", {
        {0x10, 1295215888}, {0x14, 1701604449}, {0x18, 1835073652},
        {0x1C, 7497069}, {0x20, 295108729}, {0x24, 120}, {0x28, 0}
    }, caller)
end
function booster5(caller)
    patchBooster("⬇️", _("boost_event_vertical"),
                 "vertical_amount_eventboost", {
        {0x10, 1446210844}, {0x14, 1769239141}, {0x18, 1282171235},
        {0x1C, 6647401}, {0x20, 295108709}, {0x24, 120}, {0x28, 0}
    }, caller)
end
function booster6(caller)
    patchBooster("➡️", _("boost_event_horizontal"),
                 "horizontal_amount_eventboost", {
        {0x10, 1211329824}, {0x14, 2053730927}, {0x18, 1635020399},
        {0x1C, 1852394604}, {0x20, 295108709}, {0x24, 120}, {0x28, 0}
    }, caller)
end
function booster7(caller)
    patchBooster("🪭", _("boost_event_kipas"), "fun_amount_eventboost", {
        {0x10, 1379101974}, {0x14, 1969779557}, {0x18, 1701602918},
        {0x1C, 6647296}, {0x20, 295108709}, {0x24, 120}, {0x28, 0}
    }, caller)
end

function booster8()
    patchTimedBooster("❤️", _("infinite_lives_30_eventboost"), {
        {0x10, 1952533798}, {0x14, 1278437475}, {0x18, 1936029289},
        {0x1C, 1718511967}, {0x20, 1701669204}, {0x24, 0}, {0x28, 0},
        {0x2C, 2592000}
    })
end
function booster9()
    patchTimedBooster("✨", _("double_points_30_eventboost"), {
        {0x10, 1835619372}, {0x14, 1850041445}, {0x18, 2037672308},
        {0x1C, 1635214674}, {0x20, 1816224882}, {0x24, 3299436}, {0x28, 0},
        {0x2C, 2592000}
    })
end

function booster10()
    apply30DayBooster("🌈", _("rainbow_ball_30_eventboost"), -0x8)
end
function booster11() apply30DayBooster("💣", _("bomb_30_eventboost"), -0x78) end
function booster12() apply30DayBooster("🚀", _("rocket_30_eventboost"), 0x68) end

function booster13()
    local addr = getAddr()
    if not addr then return end

    local prompt = gg.prompt({_("adventure_energy_prompt_eventboost")}, nil,
                             {"number"})

    -- Cegah error kalau prompt dibatalkan
    if not prompt then return end

    local energy = tonumber(prompt[1])

    -- Validasi angka
    if not energy or energy < 1 or energy > 100000 then
        gg.alert(_("invalid_value_energy_eventboost"))
        return
    end

    local patch = {
        1886938400, 1953064037, 1164865385, 1735550318, 121, 0, 0, energy
    }
    local edits = {}
    for i = 0, #patch - 1 do
        table.insert(edits, {
            address = addr + 0x10 + i * 4,
            flags = gg.TYPE_DWORD,
            value = patch[i + 1]
        })
    end
    gg.setValues(edits)
    gg.toast(string.format(_("toast_energy_applied_eventboost"), energy))
end

function booster14()
    local addr = getAddr()
    if not addr then return end

    local prompt = gg.prompt({_("frozentoken_input")}, nil, {"number"})

    -- Cegah error kalau prompt dibatalkan
    if not prompt then return end

    local energy = tonumber(prompt[1])

    -- Validasi angka
    if not energy or energy < 1 or energy > 5000 then
        gg.alert(_("frozentoken_invalid"))
        return
    end

    local patch = {
        1634878494, 1315860327, 1416917861, 1852140399, 0, 0, 0, energy
    }
    local edits = {}
    for i = 0, #patch - 1 do
        table.insert(edits, {
            address = addr + 0x10 + i * 4,
            flags = gg.TYPE_DWORD,
            value = patch[i + 1]
        })
    end
    gg.setValues(edits)
    gg.toast(string.format(_("frozentoken_toast"), energy))
end

function boost2()
    local indev = dev
    local menu = gg.choice({
        "✈️ • " .. _("profitable_flight_labboost"),
        "🌾 • " .. _("rich_fields_labboost"),
        "📈 • " .. _("record_demand_labboost"),
        "🚚 • " .. _("busy_trade_labboost"),
        "🧭 • " .. _("smart_navigation_labboost"),
        "🤝 • " .. _("active_cooperation_labboost"),
        "🔥 • " .. _("efficient_smelting_labboost"),
        "🛒 • " .. _("vibrant_market_labboost"),
        "⚙️ • " .. _("high_speed_production_labboost"),
        "🌽 • " .. _("super_harvest_labboost"),
        "🌾 • " .. _("advanced_farming_labboost"),
        "💰 • " .. _("generous_customers_labboost"),
        "💡 • " .. _("see_the_light_labboost"),
        "🚀 • " .. _("shortcut_labboost"),
        "🙌 • " .. _("extra_hands_labboost"),
        "🏡 • " .. _("spacious_barn_labboost"),
        "📦 • " .. _("large_request_labboost"),
        "⛵ • " .. _("favorable_voyage_labboost"),
        "❌ • " .. _("go_back_labboost")
    }, nil, indev)

    if not menu then return end

    local actions = {
        lab1, lab2, lab3, lab4, lab5, lab6, lab7, lab8, lab9, lab10, lab11,
        lab12, lab13, lab14, lab15, lab16, lab17, lab18, gp5 -- index 19: kembali ke menu utama booster
    }

    if actions[menu] then
        actions[menu]()
        if menu >= 1 and menu <= 18 then
            -- opsional: efek visual atau suara bisa ditambahkan di sini
        end
    else
    end

    -- Re-show the menu unless user chose "Back"
    if menu ~= 19 then
        while true do
            if gg.isVisible(true) then
                gg.setVisible(false)
                boost2()
                break
            end
        end
    end
end

-- 🧱 Booster Lab: Modular Patch Functfunction applyLabBooster(label, emoji, name)
function applyLabBooster(label, emoji, name)
    local addr = getAddr()
    if not addr then return end

    local prompt = gg.prompt({
        emoji .. " " .. _("enter_amount_labboost") .. " " .. name ..
            " [1–500]:"
    }, nil, {"number"})

    if not prompt then return end

    local amt = tonumber(prompt[1])
    if not amt or amt < 1 or amt > 500 then
        gg.alert(_("invalid_input_labboost"))
        return
    end

    local patch = {}
    for i, val in ipairs(label) do
        table.insert(patch, {
            address = addr + 0x10 + (i - 1) * 4,
            flags = 4,
            value = val
        })
    end

    table.insert(patch, {address = addr + 0x28, flags = 4, value = 0}) -- duration
    table.insert(patch, {address = addr + 0x2C, flags = 4, value = amt}) -- amount

    gg.setValues(patch)
    gg.toast(emoji .. " " .. name .. ": " .. amt .. " ✅")
end

-- 🧬 Copy Template for Lab18
local function copyPatchTemplate(offset)
    gg.clearResults()
    gg.searchNumber("1701081679;1919906915;49;23::", gg.TYPE_DWORD)
    gg.refineNumber("23", gg.TYPE_DWORD)
    local ref = gg.getResults(1)
    if #ref == 0 then return nil end

    local base = ref[1].address + offset
    local copied = {}
    for i = 0, 5 do
        table.insert(copied, {address = base + i * 4, flags = gg.TYPE_DWORD})
    end
    return gg.getValues(copied)
end

function lab18(name, offset)
    name = name or _("unnamed_booster_labboost")
    offset = offset or -0x8

    local copied = copyPatchTemplate(offset)
    if not copied then
        gg.alert(_("ref_not_found_labboost", name))
        return
    end

    gg.alert("📋 " .. name .. " template copied")

    local addr = getAddr()
    if not addr then return end
    addr = addr + 0x10

    local patch = {}
    for i, v in ipairs(copied) do
        patch[i] = {
            address = addr + (i - 1) * 4,
            value = v.value,
            flags = gg.TYPE_DWORD
        }
    end

    patch[7] = {address = addr + 6 * 4, value = 0, flags = gg.TYPE_DWORD} -- duration

    local input = gg.prompt({"⛵ " .. _("enter_amount_labboost")}, nil,
                            {"number"})
    local val = tonumber(input and input[1])
    if not val or val < 1 or val > 500 then
        gg.alert(_("invalid_amount_labboost"))
        return
    end

    patch[8] = {address = addr + 7 * 4, value = val, flags = gg.TYPE_DWORD}

    gg.setValues(patch)
    gg.toast("⛵ " .. name .. ": " .. val .. " ✅")
end

-- 🧪 Booster Lab Functions (lab1 to lab17)
function lab1()
    applyLabBooster({
        0x6F6F4222, 0x69417473, 0x726F7072, 0x696F4374, 0x0000736E, 0x00000000
    }, "✈️", _("lab1_labboost"))
end
function lab2()
    applyLabBooster({
        0x6F6F4226, 0x70537473, 0x55646565, 0x72614870, 0x74736576, 0x00000000
    }, "🌾", _("lab2_labboost"))
end
function lab3()
    applyLabBooster({
        0x6F6F4222, 0x70537473, 0x55646565, 0x64724F70, 0x00007265, 0x00000000
    }, "📈", _("lab3_labboost"))
end
function lab4()
    applyLabBooster({
        0x6F6F4224, 0x70537473, 0x55646565, 0x61654470, 0x0072656C, 0x00000000
    }, "🚚", _("lab4_labboost"))
end
function lab5()
    applyLabBooster({
        0x6F6F4222, 0x70537473, 0x55646565, 0x69685370, 0x00007370, 0x00000000
    }, "🧭", _("lab5_labboost"))
end
function lab6()
    applyLabBooster({
        0x6F6F4228, 0x6C437473, 0x65486E61, 0x6552706C, 0x73657571, 0x00000074
    }, "🤝", _("lab6_labboost"))
end
function lab7()
    applyLabBooster({
        0x6F6F4222, 0x69547473, 0x6D53656D, 0x65746C65, 0x00007972, 0x00000000
    }, "🔥", _("lab7_labboost"))
end
function lab8()
    applyLabBooster({
        0x6F6F421E, 0x69547473, 0x614D656D, 0x74656B72, 0x00000000, 0x00000000
    }, "🛒", _("lab8_labboost"))
end
function lab9()
    applyLabBooster({
        0x6F6F4220, 0x69547473, 0x6146656D, 0x726F7463, 0x00000079, 0x00000000
    }, "⚙️", _("lab9_labboost"))
end
function lab10()
    applyLabBooster({
        0x6F6F4226, 0x72507473, 0x6375646F, 0x72614874, 0x74736576, 0x00000000
    }, "🌽", _("lab10_labboost"))
end
function lab11()
    applyLabBooster({
        0x6F6F4220, 0x72507473, 0x6375646F, 0x72614674, 0x0000006D, 0x00000000
    }, "🌾", _("lab11_labboost"))
end
function lab12()
    applyLabBooster({
        0x6F6F421E, 0x6F4D7473, 0x4F79656E, 0x72656472, 0x00000000, 0x00000000
    }, "💰", _("lab12_labboost"))
end
function lab13()
    applyLabBooster({
        0x6F6F4220, 0x614C7473, 0x7265746E, 0x6E694D6E, 0x00000065, 0x00000000
    }, "💡", _("lab13_labboost"))
end
function lab14()
    applyLabBooster({
        0x6F6F4224, 0x70537473, 0x55646565, 0x61725470, 0x00736E69, 0x00000000
    }, "🚀", _("lab14_labboost"))
end
function lab15()
    applyLabBooster({
        0x6F6F4224, 0x6F447473, 0x656C6275, 0x74636146, 0x0079726F, 0x00000000
    }, "🙌", _("lab15_labboost"))
end
function lab16()
    applyLabBooster({
        0x6F6F4228, 0x74537473, 0x6761726F, 0x70614365, 0x74696361, 0x00000079
    }, "🏡", _("lab16_labboost"))
end
function lab17()
    applyLabBooster({
        0x6F6F421C, 0x614D7473, 0x6E6F4478, 0x00657461, 0x74696361, 0x00000079
    }, "📦", _("lab17_labboost"))
end

function applyCopiedPerk(labelKey, emoji, matchValue, extraValues, customInput)
    gg.clearResults()
    gg.searchNumber("1852793872;1600484449;23;24::201", gg.TYPE_DWORD)
    gg.refineNumber(matchValue, gg.TYPE_DWORD)
    local src = gg.getResults(1)
    if #src == 0 then
        gg.alert(_ "source_not_found_keuntungan")
        return
    end

    local base = src[1].address - 0x8
    local copy = {}
    for i = 0, 5 do
        table.insert(copy, {address = base + i * 4, flags = gg.TYPE_DWORD})
    end
    copy = gg.getValues(copy)

    local tgt = getAddr()
    if not tgt then return end

    local addr = tgt + 0x10
    local newValues = {}

    for i, val in ipairs(copy) do
        table.insert(newValues, {
            address = addr + (i - 1) * 4,
            value = val.value,
            flags = gg.TYPE_DWORD
        })
    end

    for _, v in ipairs(extraValues or {}) do
        table.insert(newValues, {
            address = addr + v.offset,
            value = v.value,
            flags = gg.TYPE_DWORD
        })
    end

    if customInput then
        local input = gg.prompt({emoji .. " " .. _(customInput.prompt)}, nil,
                                {"number"})
        if not input then return end
        local amount = tonumber(input[1])
        if not amount or amount < customInput.min or amount > customInput.max then
            gg.alert("🚫 " .. _(customInput.prompt))
            return
        end
        table.insert(newValues, {
            address = addr + customInput.offset,
            value = amount,
            flags = gg.TYPE_DWORD
        })
    end

    gg.setValues(newValues)
    gg.toast(emoji .. " " .. _(labelKey) .. " " ..
                 _("perk_applied_keuntunganbost"))
end

function boost3()
    applyCopiedPerk("perk_unlimited_barn_keuntungan", "🏡", 23,
                    {{offset = 24, value = 0}}, {
        prompt = "enter_barn_boost_keuntungan",
        offset = 28,
        min = 1,
        max = 20000
    })
end

function boost4()
    applyCopiedPerk("perk_instant_building_keuntungan", "🏗️", 24,
                    {{offset = 24, value = 0}, {offset = 28, value = 100}})
end

-- 🔹 Fungsi menu rw7
function rw7() boost5("free") end

-- 🔹 Fungsi utama gp9 dengan multi bahasa
function boost5(caller)
    local indev = dev
    local isPremium = (caller ~= "free")

    -- Susun menu sesuai status premium
    local menuLabels = {
        _("express_plane_keuntungan"), _("instant_crop_keuntungan"),
        _("fast_farm_keuntungan"), _("train_booster_keuntungan"),
        _("double_train_keuntungan"), _("go_back_keuntungan")
    }
    local menu = gg.choice(menuLabels, nil, indev)
    if not menu then return end

    local actions = {
        perk1, -- Express Plane
        perk2, -- Instant Crop
        perk3, perk4, -- Fast Farm
        perk5, perk6
    }

    if menu >= 1 and menu <= #actions then
        actions[menu](caller)
    elseif menu == #menuLabels then
        if caller == "free" then
            menue3()
        else
            gp5()
        end
        return
    else
        return
    end

    if menu ~= #menuLabels then
        while true do
            if gg.isVisible(true) then
                gg.setVisible(false)
                boost5(caller)
                break
            end
        end
    end
end

-- 📌 Fungsi umum apply perk
function applyPerk(labelKey, emoji, values)
    local base = getAddr()
    if not base then return end

    local addrList = {}
    for _, item in ipairs(values) do
        table.insert(addrList, {
            address = base + item.offset,
            flags = gg.TYPE_DWORD,
            value = item.value
        })
    end

    gg.setValues(addrList)
    gg.toast(emoji .. " " .. _(labelKey) .. " " .. _("perk_applied_keuntungan"))
end

-- 📌 Perk functions multi bahasa
function perk1()
    applyPerk("perk_express_plane_keuntungan", "✈️", {
        {offset = 0x10, value = 1599099684},
        {offset = 0x14, value = 1936682818},
        {offset = 0x18, value = 1701860212},
        {offset = 0x1C, value = 1884644453}, {offset = 0x20, value = 7498049},
        {offset = 0x24, value = 7631717}, {offset = 0x28, value = 0},
        {offset = 0x2C, value = 100}
    })
end

function perk2()
    applyPerk("perk_instant_crop_keuntungan", "🌾", {
        {offset = 0x10, value = 1599099692},
        {offset = 0x14, value = 1936682818},
        {offset = 0x18, value = 1701860212},
        {offset = 0x1C, value = 1884644453},
        {offset = 0x20, value = 1987207496}, {offset = 0x24, value = 7631717},
        {offset = 0x28, value = 0}, {offset = 0x2C, value = 100}
    })
end

function perk3()
    applyPerk("perk_rapid_farm_keuntungan", "🐄", {
        {offset = 0x10, value = 1599099688},
        {offset = 0x14, value = 1936682818},
        {offset = 0x18, value = 1701860212},
        {offset = 0x1C, value = 1884644453},
        {offset = 0x20, value = 1836212550}, {offset = 0x24, value = 7602291},
        {offset = 0x28, value = 0}, {offset = 0x2C, value = 100}
    })
end

function perk4()
    applyPerk("perk_train_boost_keuntungan", "🚆", {
        {offset = 0x10, value = 0x5F50532A},
        {offset = 0x14, value = 0x736F6F42},
        {offset = 0x18, value = 0x65705374},
        {offset = 0x1C, value = 0x70556465},
        {offset = 0x20, value = 0x69617254},
        {offset = 0x24, value = 0x0000736E}, {offset = 0x28, value = 0},
        {offset = 0x2C, value = 3}
    })
end

function perk5()
    applyPerk("perk_double_train_keuntungan", "🚃", {
        {offset = 0x10, value = 0x5F505322},
        {offset = 0x14, value = 0x736F6F42},
        {offset = 0x18, value = 0x61725474},
        {offset = 0x1C, value = 0x614D6E69},
        {offset = 0x20, value = 0x4A007374},
        {offset = 0x24, value = 0x00000078}, {offset = 0x28, value = 0},
        {offset = 0x2C, value = 3}
    })
end

-- ✅ Alias rw3() untuk akses dari menue3
function rw3() gp6("free") end

-- ✅ Menu Kupon Utama (dipakai juga di gp8)
function gp6(caller)
    local indev = dev
    local menu = gg.choice({
        "🚚 • " .. _("coupon_loader_kuponpon"),
        "🧑‍💼 • " .. _("coupon_dealer_kuponpon"),
        "🏡 • " .. _("coupon_barn_kuponpon"),
        "🌆 • " .. _("coupon_city_kuponpon"),
        "🏭 • " .. _("coupon_factory_kuponpon"),
        "🚆 • " .. _("coupon_train_kuponpon"),
        "🏝️ • " .. _("coupon_island_kuponpon"),
        "❌ • " .. _("back_kuponpon")
    }, nil, indev)

    if not menu then return end

    local actions = {kupon1, kupon2, kupon3, kupon4, kupon5, kupon6, kupon7}

    if menu >= 1 and menu <= 7 then
        actions[menu](caller)
    elseif menu == 8 then
        if caller == "free" then
            menue3()
        else
            menu1()
        end
        return
    else
        return
    end

    -- ✅ Tampilkan ulang jika bukan 'Back'
    if menu ~= 8 then
        while true do
            if gg.isVisible(true) then
                gg.setVisible(false)
                gp6(caller)
                break
            end
        end
    end
end

-- 🧱 Fungsi Modular Apply Kupon
function applyCoupon(label, emoji, promptKey, maxAmount, caller, offsets)
    local addr = getAddr()
    if not addr then return end

    if caller == "free" and maxAmount > 500 then maxAmount = 500 end

    local prompt = gg.prompt({
        emoji .. " " .. _(promptKey) .. " [1–" .. maxAmount .. "]:"
    }, nil, {"number"})
    local amt = tonumber(prompt and prompt[1])

    -- ❌ Tidak memasukkan angka
    if not amt then return end

    -- ❌ Melebihi batas 1–maxAmount
    if amt < 1 or amt > maxAmount then
        gg.alert(_("invalid_range_kuponpon") .. "\n✅ Min: 1\n✅ Max: " ..
                     maxAmount)
        return
    end

    local edits = {}
    for k, v in pairs(offsets) do
        edits[#edits + 1] = {
            address = addr + k,
            flags = gg.TYPE_DWORD,
            value = (v == "AMT") and amt or v
        }
    end

    gg.setValues(edits)
    gg.toast(emoji .. " " .. _(label) .. ": " .. amt .. " ✅")
end

-- 🎟️ Kupon-Kupon
function kupon1(caller)
    applyCoupon("Loader Coupon", "🚚", "loader_coupon_kuponpon", 25000,
                caller, {
        [0x10] = 1970225964,
        [0x14] = 1282305904,
        [0x18] = 1415864687,
        [0x1C] = 1852399986,
        [0x20] = 1886546241,
        [0x24] = 7631471,
        [0x28] = 0,
        [0x2C] = "AMT"
    })
end

function kupon2(caller)
    applyCoupon("Hire Dealer Coupon", "🧑‍💼", "dealer_coupon_kuponpon",
                10000, caller, {
        [0x10] = 0x756F4320,
        [0x14] = 0x486E6F70,
        [0x18] = 0x44657269,
        [0x1C] = 0x656C6165,
        [0x20] = 0x00000072,
        [0x24] = 0,
        [0x28] = 0,
        [0x2C] = "AMT"
    })
end

function kupon3(caller)
    applyCoupon("Barn Upgrade Coupon", "🏡", "barn_coupon_kuponpon", 5000,
                caller, {
        [0x10] = 1701996056,
        [0x14] = 1651327333,
        [0x18] = 1850307169,
        [0x1C] = 99,
        [0x20] = 0,
        [0x24] = 0,
        [0x28] = 0,
        [0x2C] = "AMT"
    })
end

function kupon4(caller)
    applyCoupon("City Expansion Coupon", "🌆", "city_coupon_kuponpon", 5000,
                caller, {
        [0x10] = 1701996058,
        [0x14] = 1886930277,
        [0x18] = 1769172577,
        [0x1C] = 28271,
        [0x20] = 0,
        [0x24] = 0,
        [0x28] = 0,
        [0x2C] = "AMT"
    })
end

function kupon5(caller)
    applyCoupon("Factory Upgrade Coupon", "🏭", "factory_coupon_kuponpon",
                5000, caller, {
        [0x10] = 1970225960,
        [0x14] = 1433300848,
        [0x18] = 1634887536,
        [0x1C] = 1632003428,
        [0x20] = 1919906915,
        [0x24] = 121,
        [0x28] = 0,
        [0x2C] = "AMT"
    })
end

function kupon6(caller)
    applyCoupon("Train Upgrade Coupon", "🚆", "train_coupon_kuponpon", 5000,
                caller, {
        [0x10] = 1970225956,
        [0x14] = 1433300848,
        [0x18] = 1634887536,
        [0x1C] = 1918133604,
        [0x20] = 7235937,
        [0x24] = 120,
        [0x28] = 0,
        [0x2C] = "AMT"
    })
end

function kupon7(caller)
    applyCoupon("Island Upgrade Coupon", "🏝️", "island_coupon_kuponpon",
                5000, caller, {
        [0x10] = 1970225958,
        [0x14] = 1433300848,
        [0x18] = 1634887536,
        [0x1C] = 1934189924,
        [0x20] = 1684955500,
        [0x24] = 0,
        [0x28] = 0,
        [0x2C] = "AMT"
    })
end

-- ✅ Alias rw3() untuk akses dari menue3
function rw4() gp7("free") end

function gp7(caller)
    local indev = dev
    local menu = gg.choice({
        "🟧 • " .. _("orange_gem_gemgem"),
        "🟩 • " .. _("green_gem_gemgem"),
        "🟥 • " .. _("red_gem_gemgem"), "❌ • " .. _("go_back_gemgem")
    }, nil, indev)

    if not menu then return end

    local actions = {gem1, gem2, gem3}
    if menu >= 1 and menu <= 3 then
        actions[menu]()
    elseif menu == 4 then
        if caller == "free" then
            menue3()
        else
            menu1()
        end
        return
    else
        return
    end

    if menu ~= 4 then
        while true do
            if gg.isVisible(true) then
                gg.setVisible(false)
                gp7(caller)
                break
            end
        end
    end
end

-- 💎 Modular Gem Reward Function (dengan batasan free max 100)
function applyGemReward(label, emoji, gemId, caller)
    local base = getAddr()
    if not base then return end

    local maxValue = (caller == "free") and 100 or 10000
    local minValue = 1

    local promptText = string.format("%s %s %s [%d–%d]:", emoji,
                                     _("enter_amount_gemgem"), label, minValue,
                                     maxValue)
    local p = gg.prompt({promptText}, nil, {"number"})
    local val = tonumber(p and p[1])

    -- ❌ Tidak ada input
    if not val then return end

    -- ❌ Input kurang dari min atau lebih dari max
    if val < minValue or val > maxValue then
        gg.alert(_("invalid_input_gemgem") .. "\n✅ Min: " .. minValue ..
                     "\n✅ Max: " .. maxValue)
        return
    end

    local a = {}
    local function dw(offset, v)
        table.insert(a, {
            address = base + offset,
            flags = gg.TYPE_DWORD,
            value = v
        })
    end

    dw(0x10, 1835362056)
    dw(0x14, gemId)
    for _, o in ipairs({0x18, 0x1C, 0x20, 0x24, 0x28}) do dw(o, 0) end
    dw(0x2C, val)

    gg.setValues(a)
    gg.toast(string.format("%s %s %s %s ✅", emoji, label,
                           _("reward_set_gemgem"), val))
end

-- 🔸 Specific Gem Wrappers
function gem1(caller) applyGemReward(_("orange_gem_gemgem"), "🟧", 49, caller) end
function gem2(caller) applyGemReward(_("green_gem_gemgem"), "🟩", 50, caller) end
function gem3(caller) applyGemReward(_("red_gem_gemgem"), "🟥", 51, caller) end

-- ✅ Alias rw2 untuk Free Script
function rw1() gp8("free") end

function gp8(caller)
    local indev = dev
    _G.ingotCaller = caller -- Simpan caller secara global

    local menu = gg.choice({
        "🥉 • " .. _("bronze_ingot_batangtang"),
        "🥈 • " .. _("silver_ingot_batangtang"),
        "🥇 • " .. _("gold_ingot_batangtang"),
        "🏅 • " .. _("platinum_ingot_batangtang"),
        "❌ • " .. _("go_back_batangtang")
    }, nil, indev)

    if menu == nil then return end

    local actions = {batang1, batang2, batang3, batang4}

    if menu >= 1 and menu <= 4 then
        actions[menu]()
    elseif menu == 5 then
        -- Kembali ke menu sesuai asal
        if caller == "free" then
            menue3()
        else
            menu1()
        end
        return
    else
        return
    end

    -- Tampilkan ulang jika bukan tombol "Go Back"
    while true do
        if gg.isVisible(true) then
            gg.setVisible(false)
            gp8(caller)
            break
        end
    end
end

-- ✅ Fungsi utama untuk memberi reward Ingot
function applyIngotReward(labelKey, emoji, hexes)
    local base = getAddr()
    if not base then return end

    local maxval = (_G.ingotCaller == "free") and 100 or 5000
    local minval = 1

    local prompt = gg.prompt({
        emoji .. " " .. _("enter_amount_batangtang") .. " " .. _(labelKey) ..
            " [" .. minval .. "–" .. maxval .. "]:"
    }, nil, {"number"})

    local val = tonumber(prompt and prompt[1])

    -- ❌ Tidak ada input
    if not val then return end

    -- ❌ Di luar batas
    if val < minval or val > maxval then
        gg.alert(_("invalid_input_batangtang") .. "\n✅ Min: " .. minval ..
                     "\n✅ Max: " .. maxval)
        return
    end

    local a, offsets = {}, {0x10, 0x14, 0x18, 0x1C, 0x20, 0x24}
    for i, v in ipairs(hexes) do
        a[#a + 1] = {
            address = base + offsets[i],
            flags = gg.TYPE_DWORD,
            value = v
        }
    end

    -- Patch tambahan
    local patch = {{0x28, 0}, {0x2C, val}}
    for _, v in ipairs(patch) do
        a[#a + 1] = {address = base + v[1], flags = gg.TYPE_DWORD, value = v[2]}
    end

    gg.setValues(a)
    gg.toast(
        emoji .. " " .. _(labelKey) .. " " .. _("set_to_batangtang") .. " " ..
            val .. " ✅")
end

-- ✅ Fungsi-fungsi ingot individual
function batang1()
    applyIngotReward(_("bronze_batangtang"), "🥉", {
        0x6F724228, 0x42657A6E, 0x696C6C75, 0x6F436E6F, 0x65746E75, 0x00000072
    })
end

function batang2()
    applyIngotReward(_("silver_batangtang"), "🥈", {
        0x6C695328, 0x42726576, 0x696C6C75, 0x6F436E6F, 0x65746E75, 0x00000072
    })
end

function batang3()
    applyIngotReward(_("gold_batangtang"), "🥇", {
        0x6C6F4724, 0x6C754264, 0x6E6F696C, 0x6E756F43, 0x00726574, 0x00000000
    })
end

function batang4()
    applyIngotReward(_("platinum_batangtang"), "🏅", {
        0x616C502C, 0x756E6974, 0x6C75426D, 0x6E6F696C, 0x6E756F43, 0x00726574
    })
end

-- ✅ Alias rw2() untuk akses dari menue3
function rw2() gp9("free") end

-- ✅ tools2 juga dipakai di gp8
function gp9(caller)
    local indev = dev
    local options, actions = {}, {}

    -- Tambahkan item normal
    table.insert(options, "⛏️ • " .. _("pickaxe_macul"))
    table.insert(actions, altam1)
    table.insert(options, "💣 • " .. _("tntpele_macul"))
    table.insert(actions, altam2)
    table.insert(options, "🧨 • " .. _("dynamite_macul"))
    table.insert(actions, altam3)

    -- Bonus hanya untuk premium
    if caller ~= "free" then
        table.insert(options, "🔁 • " .. _("x2_ore_bonus_macul"))
        table.insert(actions, altam4)
    end

    table.insert(options, "❌ • " .. _("go_back_macul"))

    local subMenu = gg.choice(options, nil, indev)

    if subMenu == nil then return end

    if subMenu >= 1 and subMenu <= #actions then
        actions[subMenu](caller)
    elseif subMenu == #options then
        if caller == "free" then
            menue3()
        else
            menu1()
        end
        return
    else
        return
    end

    -- Auto refresh menu
    while true do
        if gg.isVisible(true) then
            gg.setVisible(false)
            gp9(caller)
            break
        end
    end
end

-- 🎯 Modular Mining Tools Reward
function applyMiningReward(label, emoji, itemId, caller, duration)
    local base = getAddr()
    if not base then return end

    local edits = {}
    local val

    local function dw(off, v)
        table.insert(edits,
                     {address = base + off, flags = gg.TYPE_DWORD, value = v})
    end

    if duration then
        -- 30-Day Bonus Patch
        dw(0x10, 1835619372)
        dw(0x14, 1850041445)
        dw(0x18, 2037672308)
        dw(0x1C, 1635214674)
        dw(0x20, 1766679666)
        dw(0x24, itemId)
        dw(0x28, 0)
        dw(0x2C, duration)
        val = duration
    else

        local max = (caller == "free") and 500 or 25000
        local min = 1

        local input = gg.prompt({
            emoji .. " " .. _("mining_prompt_macul") .. " " .. label .. " [" ..
                min .. "–" .. max .. "]:"
        }, nil, {"number"})

        val = tonumber(input and input[1])

        -- ❌ Tidak ada input
        if not val then return end

        -- ❌ Input di luar range
        if val < min or val > max then
            gg.alert(_("invalid_input_macul") .. "\n✅ Min: " .. min ..
                         "\n✅ Max: " .. max)
            return
        end

        -- Normal Item Patch
        dw(0x10, itemId)
        for i = 0x14, 0x28, 4 do dw(i, 0) end
        dw(0x2C, val)
    end

    gg.setValues(edits)

    if duration then
        gg.toast(emoji .. " " .. label .. " " .. _("success_bonus_macul"))
    else
        gg.toast(emoji .. " " .. label .. ": " .. val .. " ✅")
    end
end

-- 🧱 Modular Calls
function altam1(caller)
    applyMiningReward(_("pickaxes_macul"), "⛏️", 3304708, caller)
end
function altam2(caller)
    applyMiningReward(_("tnt_macul"), "💣", 3239172, caller)
end
function altam3(caller)
    applyMiningReward(_("dynamite_macul"), "🧨", 3370244, caller)
end
function altam4(caller)
    applyMiningReward(_("ore_bonus_macul"), "🔁", 3237230, caller, 2592000)
end

function gp10()
    local title = banner
    local menu = gg.choice({
        "🧰 • " .. _("community_tools_materialyal"),
        "🏡 • " .. _("barn_tools_materialyal"),
        "🚧 • " .. _("expansion_tools_materialyal"),
        "❌ • " .. _("go_back_materialyal")
    }, nil, title)

    if menu == nil then
        return
    elseif menu == 1 then
        tools1()
    elseif menu == 2 then
        tools2()
    elseif menu == 3 then
        tools3()
    elseif menu == 4 then
        menu1()
    else
    end
end

-- ✅ Alias rw7() untuk akses dari menue3
function rw6() tools1("free") end

-- ✅ tools3 digunakan di gp8
function tools1(caller)
    local indev = dev
    local menu = gg.choice({
        "🪟 • " .. _("glass_matdung"), "🧱 • " .. _("bricks_matdung"),
        "🪵 • " .. _("slab_matdung"),
        "🔨 • " .. _("jackhammer_matdung"),
        "⚙️ • " .. _("electric_saw_matdung"),
        "🪛 • " .. _("drill_matdung"), "❌ • " .. _("back_matdung")
    }, nil, indev)

    if not menu then return end

    local actions = {gekom1, gekom2, gekom3, gekom4, gekom5, gekom6}

    if menu >= 1 and menu <= 6 then
        actions[menu](caller)
    elseif menu == 7 then
        if caller == "free" then
            menue3()
        else
            gp10()
        end
        return
    else
        return
    end

    -- ✅ Tampilkan ulang hanya jika bukan "Back"
    if menu ~= 7 then
        while true do
            if gg.isVisible(true) then
                gg.setVisible(false)
                tools1(caller)
                break
            end
        end
    end
end

-- ✅ Fungsi modular hadiah konstruksi
function applyConstructReward(label, emoji, hexList, caller)
    local base = getAddr()
    if not base then return end

    local max = (caller == "free") and 100 or 5000
    local min = 1

    -- prompt text dengan template
    local promptText = _("input_construct_matdung"):gsub("{label}", label):gsub(
                           "{max}", max)

    local prompt = gg.prompt({emoji .. " " .. promptText}, nil, {"number"})
    local amount = tonumber(prompt and prompt[1])

    -- ❌ Tidak ada input
    if not amount then return end

    -- ❌ Input di luar range
    if amount < min or amount > max then
        gg.alert(
            _("invalid_input_matdung"):gsub("{max}", max) .. "\n✅ Min: " ..
                min .. "\n✅ Max: " .. max)
        return
    end

    local edits = {}
    for _, hex in ipairs(hexList) do
        local addr = base + hex[1]
        local val = (hex[2] == "amount") and amount or hex[2]
        table.insert(edits, {address = addr, flags = gg.TYPE_DWORD, value = val})
    end

    gg.setValues(edits)

    local msg = _("reward_set_matdung"):gsub("{emoji}", emoji):gsub("{label}",
                                                                    label):gsub(
                    "{amount}", amount)
    gg.toast(msg)
end

-- ✅ Fungsi hadiah spesifik
function gekom1(caller)
    applyConstructReward(_("glass_matdung"), "🪟", {
        {0x10, 0x616C470A}, {0x14, 0x00007373}, {0x18, 0xA4A23A90},
        {0x1C, 0x8EFCC1BB}, {0x20, 0x23330000}, {0x24, 0x6F}, {0x28, 0},
        {0x2C, "amount"}
    }, caller)
end

function gekom2(caller)
    applyConstructReward(_("bricks_matdung"), "🧱", {
        {0x10, 0x6972420A}, {0x14, 0x00006B63}, {0x18, 0}, {0x1C, 0}, {0x20, 0},
        {0x24, 0}, {0x28, 0}, {0x2C, "amount"}
    }, caller)
end

function gekom3(caller)
    applyConstructReward(_("slabs_matdung"), "🪵", {
        {0x10, 0x696C500A}, {0x14, 0x00006174}, {0x18, 0}, {0x1C, 0}, {0x20, 0},
        {0x24, 0}, {0x28, 0}, {0x2C, "amount"}
    }, caller)
end

function gekom4(caller)
    applyConstructReward(_("jackhammer_matdung"), "🔨", {
        {0x10, 1667328532}, {0x14, 1835100267}, {0x18, 7497069}, {0x1C, 0},
        {0x20, 0}, {0x24, 0}, {0x28, 0}, {0x2C, "amount"}
    }, caller)
end

function gekom5(caller)
    applyConstructReward(_("saw_matdung"), "⚙️", {
        {0x10, 2003791888}, {0x14, 1634955877}, {0x18, 119}, {0x1C, 0},
        {0x20, 0}, {0x24, 0}, {0x28, 0}, {0x2C, "amount"}
    }, caller)
end

function gekom6(caller)
    applyConstructReward(_("drill_matdung"), "🪛", {
        {0x10, 1769104394}, {0x14, 1627417708}, {0x18, 119}, {0x1C, 0},
        {0x20, 0}, {0x24, 0}, {0x28, 0}, {0x2C, "amount"}
    }, caller)
end

function tools2()
    local indev = dev
    local menu = gg.choice({
        "🔨 • " .. _("hammer_gudangdang"),
        "📍 • " .. _("nail_gudangdang"),
        "🪣 • " .. _("red_paint_gudangdang"),
        "❌ • " .. _("go_back_gudangdang")
    }, nil, indev)

    if menu == nil then return end

    local actions = {
        lumbung1, -- Hammer
        lumbung2, -- Nail
        lumbung3, -- Red Paint
        gp10 -- Back
    }

    if actions[menu] then
        actions[menu]()
        if menu >= 1 and menu <= 3 then end
    else
        return
    end

    if menu ~= 4 then
        while true do
            if gg.isVisible(true) then
                gg.setVisible(false)
                tools2()
                break
            end
        end
    end
end

-- 🛠 Fungsi apply barn reward
function applyBarnReward(labelKey, emoji, hex1, hex2, hex3)
    local base = getAddr()
    if not base then return end

    local min = 1
    local max = 5000

    local p = gg.prompt({
        emoji .. " " .. _("enter_amount_gudangdang") .. "" .. _(labelKey) ..
            " [1-5000]:"
    }, nil, {"number"})

    local amount = tonumber(p and p[1])

    -- ❌ Tidak ada input
    if not amount then return end

    -- ❌ Input tidak valid
    if amount < min or amount > max then
        gg.alert(_("invalid_input_gudangdang") .. "\n✅ Min: " .. min ..
                     "\n✅ Max: " .. max)
        return
    end

    -- Patch utama
    local patch = {
        {address = base + 0x10, flags = gg.TYPE_DWORD, value = hex1},
        {address = base + 0x14, flags = gg.TYPE_DWORD, value = hex2},
        {address = base + 0x18, flags = gg.TYPE_DWORD, value = hex3},
        {address = base + 0x2C, flags = gg.TYPE_DWORD, value = amount}
    }

    -- Set 0 pada offset 0x1C, 0x20, 0x24, 0x28
    for o = 0x1C, 0x28, 4 do
        table.insert(patch,
                     {address = base + o, flags = gg.TYPE_DWORD, value = 0})
    end

    gg.setValues(patch)
    gg.toast(emoji .. " " .. _(labelKey) .. " " ..
                 _("barn_reward_set_gudangdang") .. " " .. amount .. " ✅")
end

-- 📦 Item lumbung
function lumbung1()
    applyBarnReward("hammers_gudangdang", "🔨", 0x6D616812, 0x4D72656D,
                    0x00007461)
end

function lumbung2()
    applyBarnReward("nails_gudangdang", "📍", 0x69616E0E, 0x74614D6C,
                    0x00000000)
end

function lumbung3()
    applyBarnReward("red_paint_gudangdang", "🪣", 0x69617016, 0x6552746E,
                    0x74614D64)
end

function tools3()
    local indev = dev
    local menu = gg.choice({
        "🪚 • " .. _("saw_waswas"), "🪓 • " .. _("axe_waswas"),
        "⛏️ • " .. _("shovel_waswas"), "❌ • " .. _("go_back_waswas")
    }, nil, indev)

    if menu == nil then return end

    local actions = {
        luas1, -- Saw
        luas2, -- Axe
        luas3, -- Shovel
        gp10 -- Back
    }

    if actions[menu] then
        actions[menu]()
        if menu >= 1 and menu <= 3 then
            -- bisa tambahkan aksi lain di sini kalau perlu
        end
    else
        return
    end

    -- Tampilkan ulang menu jika bukan Back
    if menu ~= 4 then
        while true do
            if gg.isVisible(true) then
                gg.setVisible(false)
                tools3()
                break
            end
        end
    end
end

function applyExpansionReward(labelKey, emoji, toolId, metaVal)
    local base = getAddr()
    if not base then return end

    local label = _(labelKey)
    local min = 1
    local max = 5000

    local p = gg.prompt({
        emoji .. " " .. _("enter_amount_waswas") .. "" .. label .. " [1-5000]:"
    }, nil, {"number"})

    local amount = tonumber(p and p[1])

    -- ❌ Tidak ada input
    if not amount then return end

    -- ❌ Di luar range
    if amount < min or amount > max then
        gg.alert(_("invalid_input_waswas") .. "\n✅ Min: " .. min ..
                     "\n✅ Max: " .. max)
        return
    end

    local patch = {
        {address = base + 0x10, flags = gg.TYPE_DWORD, value = toolId},
        {address = base + 0x2C, flags = gg.TYPE_DWORD, value = amount}
    }

    if metaVal then
        table.insert(patch, {
            address = base + 0x14,
            flags = gg.TYPE_DWORD,
            value = metaVal
        })
        for o = 0x18, 0x28, -4 do
            table.insert(patch,
                         {address = base + o, flags = gg.TYPE_DWORD, value = 0})
        end
    else
        for o = 0x14, 0x30, -4 do
            table.insert(patch,
                         {address = base - o, flags = gg.TYPE_DWORD, value = 0})
        end
    end

    gg.setValues(patch)
    gg.toast(emoji .. " " .. label .. "" .. _("reward_set_waswas") .. " " ..
                 amount .. " ✅")
end

-- 🔧 Tool Reward Functions
function luas1() applyExpansionReward("saw_waswas", "🪚", 1414419462) end
function luas2() applyExpansionReward("axe_waswas", "🪓", 1702387974) end
function luas3() applyExpansionReward("shovel_waswas", "⛏️", 1667854344, 107) end

function cardbadgecol(label, emoji, values)
    local base = getAddr()
    if not base then return end

    local addrList = {}
    for _, item in ipairs(values) do
        table.insert(addrList, {
            address = base + item.offset,
            flags = gg.TYPE_DWORD,
            value = item.value
        })
    end

    gg.setValues(addrList)
    gg.toast(emoji .. " " .. label .. " applied")
end

function gp11()
    local input = gg.prompt(
        {"Input Card Pack : example 15"},
        {15},
        {"number"}
    )

    if not input then
        gg.toast("Dibatalkan")
        return
    end

    local nilai = input[1]

    cardbadgecol("Card Pack Reward", "🎴", {
        {offset = 0x10, value = 1918976},
        {offset = 0x14, value = 1348420452},
        {offset = 0x18, value = 879453025},
        {offset = 0x1C, value = 0},
        {offset = 0x20, value = 0},
        {offset = 0x24, value = 0},
        {offset = 0x28, value = 0},
        {offset = 0x2C, value = nilai}
    })
end

function gp3()
    local title = banner
    local menu = gg.choice({
        "🍁 • All Decoration", "🎨 • Set All Skins",
        "🪧 • City Sign", "🐻 • Chat Stikers",
        "🏜️ • Frame Style", "🧛 • Avatar List",
        "🔔 • Bagde Style", "❌ • Go Back"
    }, nil, title)

    if menu == nil then
        return
    elseif menu == 1 then
        minidekor()
    elseif menu == 2 then
        kums1()
    elseif menu == 3 then
        kums2()
    elseif menu == 4 then
        kums3()
    elseif menu == 5 then
        kums4()
    elseif menu == 6 then
        kums5()
    elseif menu == 7 then
        kums6()
    elseif menu == 8 then
        menu1()
    end
end

function minidekor()
    local title = banner
    local menu = gg.choice({
        "🌟 • Upgradable Decorations", "🎄 • Christmas Decoration",
        "🏮 • Lantern Decoration", "🐰 • Easter Decoration",
        "💘 • Valentine Decoration", "🎃 • Halloween Decoration",
        "🏺 • Egypt Decoration", "🌟 • Exclusive Decoration",
        "❌ • Go Back"
    }, nil, title)

    if menu == nil then
        return
    elseif menu == 1 then
        coldekor1()
    elseif menu == 2 then
        coldekor2()
    elseif menu == 3 then
        coldekor3()
    elseif menu == 4 then
        coldekor4()
    elseif menu == 5 then
        coldekor5()
    elseif menu == 6 then
        coldekor6()
    elseif menu == 7 then
        coldekor7()
    elseif menu == 8 then
        coldekor8()
    elseif menu == 9 then
        gp3()
    end
end

function coldekor1()
    local title = banner
    local menu = gg.choice({
        "🧭 • Expedition Upgradable", "🧭 • Expedition Non-Upgradable",
        "🧩 • Merge Upgradable", "🌟 • Old Event Upgradable",
        "❌ • Go Back"
    }, nil, title)

    if menu == nil then
        return
    elseif menu == 1 then
        expedekor()
    elseif menu == 2 then
        expenondekor()
    elseif menu == 3 then
        mergedekor()
    elseif menu == 4 then
        oldupgrededekor()
    elseif menu == 5 then
        minidekor()
    end
end

function expedekor()
    while true do
        gg.setVisible(false)
        gg.clearResults()
        local indev = dev
        local skins = {
            "🏞️ • Heroes of the Old Park (1/3)",
            "🏞️ • Heroes of the Old Park (2/3)",
            "🏞️ • Heroes of the Old Park (3/3)",
            "🐢 • Queen of Turtle Island",
            "❄️ • Guardian of the North",
            "🏴‍☠️ • Pirate Odyssey", "🧊 • Yeti Megalith",
            "👑 • Cleopatra's Secret Spa Hotel",
            "🌿 • Botanical Amusement Park",
            "🌊 • Poseidon's Kingdom Museum",
            "🧪 • Natural Anomalies Research Center",
            "🏠 • Smart Mansion", "🦌 • Golden Deer Country House",
            "🪷 • Frozen Lotus Fountain",
            "🎭 • Ancient Theater of Pandora",
            "🐝 • The Wasp Queen's Greenhouse",
            "🛸 • Intergalactic Research Facility", "🌳 • Tree Library",
            "🏕️ • Nature's Embrace Glamping Base",
            "🐒 • Monkeyland Water Park", "☕️ • Cosmic Café",
            "⛰️ • Mountain Haven", "🍭 • Sweet Amusement Park",
            "❌ • Go Back"
        }

        local choice = gg.multiChoice(skins, nil, indev)
        if not choice then return end

        -- 🔙 Back
        if choice[24] then
            if type(coldekor1) == "function" then coldekor1() end
            return
        end

        -- 🔁 Apply per pilihan
        for i = 1, 23 do
            if choice[i] then
                expedecor(i)
                gg.toast(skins[i] .. " applied\n👉 Claim in freeze reward!")

                repeat gg.sleep(500) until gg.isVisible(true)
                gg.setVisible(false)
            end
        end
    end
end

-- 🔐 Cache (reset jika game restart)
local cache = {
    copied = {}, -- hasil copy per index
    target = nil, -- target expedition decor
    sourceBase = nil -- base source decor (sekali search)
}

local expeditionDecor = {
    [1] = {
        offset8 = 27,
        values8 = {
            1701869637, 1769236836, 1698983535, 1634889571, 1852795252,
            1935761955, 101, 0
        }
    },
    [2] = {
        offset8 = 27,
        values8 = {
            1701869637, 1769236836, 1698983535, 1634889571, 1852795252,
            1918988323, 12660, 0
        }
    },
    [3] = {
        offset8 = 27,
        values8 = {
            1701869637, 1769236836, 1698983535, 1634889571, 1852795252,
            1918988323, 12916, 0
        }
    },
    [4] = {
        offset8 = 27,
        values8 = {
            1701869637, 1769236836, 1698983535, 1634889571, 1852795252,
            1634738994, 3372146, 0
        }
    },
    [5] = {
        offset8 = 27,
        values8 = {
            1701869637, 1769236836, 1698983535, 1634889571, 1852795252,
            1634738995, 3241074, 0
        }
    },
    [6] = {
        offset8 = 27,
        values8 = {
            1701869637, 1769236836, 1698983535, 1634889571, 1852795252,
            1634738996, 3241074, 0
        }
    },
    [7] = {
        offset8 = 27,
        values8 = {
            1701869637, 1769236836, 1698983535, 1634889571, 1852795252,
            1634738997, 3241074, 0
        }
    },
    [8] = {
        offset8 = 27,
        values8 = {
            1701869637, 1769236836, 1698983535, 1634889571, 1852795252,
            1634738998, 3241074, 0
        }
    },
    [9] = {
        offset8 = 27,
        values8 = {
            1701869637, 1769236836, 1698983535, 1634889571, 1852795252,
            1634738999, 3241074, 0
        }
    },
    [10] = {
        offset8 = 27,
        values8 = {
            1701869637, 1769236836, 1698983535, 1634889571, 1852795252,
            1634739000, 3241074, 0
        }
    },
    [11] = {
        offset8 = 27,
        values8 = {
            1701869637, 1769236836, 1698983535, 1634889571, 1852795252,
            1634739001, 3241074, 0
        }
    },
    [12] = {
        offset8 = 28,
        values8 = {
            1701869637, 1769236836, 1698983535, 1634889571, 1852795252,
            1881354289, 829715041, 0
        }
    },
    [13] = {
        offset8 = 28,
        values8 = {
            1701869637, 1769236836, 1698983535, 1634889571, 1852795252,
            1881354545, 829715041, 0
        }
    },
    [14] = {
        offset8 = 28,
        values8 = {
            1701869637, 1769236836, 1698983535, 1634889571, 1852795252,
            1881354801, 829715041, 0
        }
    },
    [15] = {
        offset8 = 28,
        values8 = {
            1701869637, 1769236836, 1698983535, 1634889571, 1852795252,
            1881355057, 829715041, 0
        }
    },
    [16] = {
        offset8 = 28,
        values8 = {
            1701869637, 1769236836, 1698983535, 1634889571, 1852795252,
            1881355313, 829715041, 0
        }
    },
    [17] = {
        offset8 = 28,
        values8 = {
            1701869637, 1769236836, 1698983535, 1634889571, 1852795252,
            1881355569, 829715041, 0
        }
    },
    [18] = {
        offset8 = 28,
        values8 = {
            1701869637, 1769236836, 1698983535, 1634889571, 1852795252,
            1881355825, 829715041, 0
        }
    },
    [19] = {
        offset8 = 28,
        values8 = {
            1701869637, 1769236836, 1698983535, 1634889571, 1852795252,
            1881356081, 829715041, 0
        }
    },
    [20] = {
        offset8 = 28,
        values8 = {
            1701869637, 1769236836, 1698983535, 1634889571, 1852795252,
            1881356593, 829715041, 0
        }
    },
    [21] = {
        offset8 = 28,
        values8 = {
            1701869637, 1769236836, 1698983535, 1634889571, 1852795252,
            1881356337, 829715041, 0
        }
    },
    [22] = {
        offset8 = 28,
        values8 = {
            1701869637, 1769236836, 1698983535, 1634889571, 1852795252,
            1881354290, 829715041, 0
        }
    },
    [23] = {
        offset8 = 28,
        values8 = {
            1701869637, 1769236836, 1698983535, 1634889571, 1852795252,
            1881354546, 829715041, 0
        }
    }
}

-------------------------------------------------

function expedecor(index)
    gg.setVisible(false)
    gg.clearResults()

    -- ===============================
    -- VALIDASI DATA
    -- ===============================
    if not expeditionDecor or not expeditionDecor[index] then
        gg.alert("⛔ Expedition Decoration " .. index .. " not found!\n\n" ..
                     "📢 Please restart the game and try again.")
        return
    end

    -- ===============================
    -- 🔍 SEARCH SOURCE DECOR (SEKALI)
    -- ===============================
    if not cache.sourceBase then
        gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)
        local r = gg.getResults(1)
        if #r == 0 then
            gg.alert(
                "⛔ Expedition Decoration source not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.sourceBase = r[1].address + 0x1C
    end

    -- ===============================
    -- 📥 COPY DECOR (cache per index)
    -- ===============================
    if not cache.copied[index] then
        local temp = {}
        for i = 0, 5 do
            temp[#temp + 1] = {
                address = cache.sourceBase + i * 4,
                flags = gg.TYPE_DWORD
            }
        end
        cache.copied[index] = gg.getValues(temp)
    end

    -- ===============================
    -- 📍 TARGET (search sekali)
    -- ===============================
    if not cache.target then
        gg.clearResults()
        gg.searchNumber("2581275344925", gg.TYPE_QWORD)
        local t = gg.getResults(1)
        if #t == 0 then
            gg.alert(
                "❌ Expedition Decoration target not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.target = t[1].address - 0x270
    end

    -- ===============================
    -- 📋 Paste 6 DWORD awal
    -- ===============================
    local edits = {}
    for i, v in ipairs(cache.copied[index]) do
        edits[#edits + 1] = {
            address = cache.target + (i - 1) * 4,
            value = v.value,
            flags = gg.TYPE_DWORD
        }
    end

    -- Extra DWORD
    edits[#edits + 1] = {
        address = cache.target + 6 * 4,
        value = 0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 7 * 4,
        value = 1,
        flags = gg.TYPE_DWORD
    }

    -- FIX offset8
    edits[#edits + 1] = {
        address = cache.target + 0x8,
        value = expeditionDecor[index].offset8,
        flags = gg.TYPE_DWORD
    }

    gg.setValues(edits)

    -- ===============================
    -- 🔗 POINTER VALIDATION
    -- ===============================
    local ptrVal = gg.getValues({
        {address = cache.target + 0x10, flags = gg.TYPE_QWORD}
    })[1].value

    local ptr = tonumber(ptrVal)
    if not ptr or ptr == 0 then return end

    -- ===============================
    -- 🧩 Paste 8 DWORD akhir
    -- ===============================
    local final = {}
    for i = 0, 7 do
        final[#final + 1] = {
            address = ptr + i * 4,
            value = expeditionDecor[index].values8[i + 1],
            flags = gg.TYPE_DWORD
        }
    end

    gg.setValues(final)

    gg.toast("✅ Expedition Decoration " .. index .. " applied!")
end

-------------------------------------------------

function expenondekor()
    while true do
        gg.setVisible(false)
        gg.clearResults()
        local indev = dev
        local skins = {
            "🎃 • Halloween Windmill", "🎅 • Santa's Village",
            "🌐 • Gate to Cyber City", "⭐ • Sheriff's Office",
            "🎷 • Jazz Club", "🕯️ • Sinister Carriage",
            "🛡️ • Viking Gate", "🦃 • Turkey of Plenty",
            "🏔️ • Mountain Chalet", "🐈‍⬛ • Altar of Bastet",
            "✒️ • Golden Quill", "❌ • Go Back"
        }

        local choice = gg.multiChoice(skins, nil, indev)
        if not choice then return end

        -- 🔙 Back
        if choice[12] then
            if type(coldekor1) == "function" then coldekor1() end
            return
        end

        -- 🔁 Apply per pilihan
        for i = 1, 11 do
            if choice[i] then
                expesitionnondecor(i)
                gg.toast(skins[i] .. " applied\n👉 Claim in freeze reward!")

                repeat gg.sleep(500) until gg.isVisible(true)
                gg.setVisible(false)
            end
        end
    end
end

-- 🔐 Cache (reset jika game restart)
local cache = {copied = {}, sourceBase = nil, target = nil}

local expeditionnonDecor = {
    [1] = {
        patch = {
            1886930220, 1953064037, 1148088169, 1919902565, 1869182049, 3289710,
            0, 1
        }
    },
    [2] = {
        patch = {
            1886930220, 1953064037, 1148088169, 1919902565, 1869182049, 3486318,
            0, 1
        }
    },
    [3] = {
        patch = {
            1886930220, 1953064037, 1148088169, 1919902565, 1869182049, 3421038,
            0, 1
        }
    },
    [4] = {
        patch = {
            1886930220, 1953064037, 1148088169, 1919902565, 1869182049, 3617646,
            0, 1
        }
    },
    [5] = {
        patch = {
            1886930220, 1953064037, 1148088169, 1919902565, 1869182049, 3683182,
            0, 1
        }
    },
    [6] = {
        patch = {
            1886930220, 1953064037, 1148088169, 1919902565, 1869182049, 3748718,
            0, 1
        }
    },
    [7] = {
        patch = {
            1886930220, 1953064037, 1148088169, 1919902565, 1869182049, 3159150,
            0, 1
        }
    },
    [8] = {
        patch = {
            1886930220, 1953064037, 1148088169, 1919902565, 1869182049, 3224686,
            0, 1
        }
    },
    [9] = {
        patch = {
            1886930220, 1953064037, 1148088169, 1919902565, 1869182049, 3355758,
            0, 1
        }
    },
    [10] = {
        patch = {
            1886930220, 1953064037, 1148088169, 1919902565, 1869182049, 3421294,
            0, 1
        }
    },
    [11] = {
        patch = {
            1886930220, 1953064037, 1148088169, 1919902565, 1869182049, 3486830,
            0, 1
        }
    }
}

function expesitionnondecor(index)
    gg.setVisible(false)
    gg.clearResults()

    local data = expeditionnonDecor[index]
    if not data then
        gg.alert("⛔ Expedition Decoration " .. index .. " not found!\n\n" ..
                     "📢 Please restart the game and try again.")
        return
    end

    -- ===============================
    -- 📍 TARGET (sekali)
    -- ===============================
    if not cache.target then
        gg.searchNumber("2581275344925", gg.TYPE_QWORD)
        local t = gg.getResults(1)
        if #t == 0 then
            gg.alert(
                "⛔ Expedition Decoration source not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.target = t[1].address - 0x270
    end

    -- ===============================
    -- 🚀 MODE PATCH LANGSUNG
    -- ===============================
    if data.patch then
        local edits = {}
        for i = 0, 7 do
            edits[#edits + 1] = {
                address = cache.target + i * 4,
                flags = gg.TYPE_DWORD,
                value = data.patch[i + 1]
            }
        end
        gg.setValues(edits)
        gg.toast("✅ Expedition Decoration " .. index .. " applied!")
        return
    end

    -- ===============================
    -- 🔍 SOURCE (sekali)
    -- ===============================
    if not cache.sourceBase then
        gg.clearResults()
        gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)
        local r = gg.getResults(1)
        if #r == 0 then
            gg.alert(
                "❌ Expedition Decoration target not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.sourceBase = r[1].address + 0x1C
    end

    -- ===============================
    -- 📥 COPY HEADER (per index)
    -- ===============================
    if not cache.copied[index] then
        local temp = {}
        for i = 0, 5 do
            temp[#temp + 1] = {
                address = cache.sourceBase + i * 4,
                flags = gg.TYPE_DWORD
            }
        end
        cache.copied[index] = gg.getValues(temp)
    end

    -- ===============================
    -- 🧩 PASTE HEADER
    -- ===============================
    local edits = {}

    for i, v in ipairs(cache.copied[index]) do
        edits[#edits + 1] = {
            address = cache.target + (i - 1) * 4,
            value = v.value,
            flags = gg.TYPE_DWORD
        }
    end

    edits[#edits + 1] = {
        address = cache.target,
        value = data.offset0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 0x8,
        value = data.offset8,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 6 * 4,
        value = 0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 7 * 4,
        value = 1,
        flags = gg.TYPE_DWORD
    }

    gg.setValues(edits)

    -- ===============================
    -- 🔗 POINTER
    -- ===============================
    local ptr = tonumber(gg.getValues({
        {address = cache.target + 0x10, flags = gg.TYPE_QWORD}
    })[1].value)

    if not ptr or ptr == 0 then return end

    -- ===============================
    -- 🧩 VALUES12
    -- ===============================
    local final = {}
    for i = 0, 7 do
        final[#final + 1] = {
            address = ptr + i * 4,
            value = data.values8[i + 1],
            flags = gg.TYPE_DWORD
        }
    end

    gg.setValues(final)
    gg.toast("✅ Expedition Decoration " .. index .. " applied!")
end

-------------------------------------------------

function mergedekor()
    while true do
        gg.setVisible(false)
        gg.clearResults()
        local indev = dev
        local skins = {
            "🌳 • Central Park", "🏮 • Chinese Community Center",
            "🌈 • Rainbow Eco Park", "🍽️ • Gourmet Tour",
            "🌾 • Agricultural Show", "🏟️ • Sports Complex",
            "🐧 • Penguin World", "🕺 • Retro Disco Hall",
            "🎨 • Arts & Crafts Fair", "🏕️ • Cozy Campsite",
            "🏖️ • Beach Party", "🇮🇹 • The Heart of Italy",
            "❌ • Go Back"
        }

        local choice = gg.multiChoice(skins, nil, indev)
        if not choice then return end

        -- 🔙 Back
        if choice[13] then
            if type(coldekor1) == "function" then coldekor1() end
            return
        end

        -- 🔁 Apply per pilihan
        for i = 1, 12 do
            if choice[i] then
                mergedecor(i)
                gg.toast(skins[i] .. " applied\n👉 Claim in freeze reward!")

                repeat gg.sleep(500) until gg.isVisible(true)
                gg.setVisible(false)
            end
        end
    end
end

-- 🔐 Cache (reset jika game restart)
local cache = {
    copied = {}, -- hasil copy per index
    target = nil, -- target decor
    sourceBase = nil -- base source decor (sekali search)
}

local mergeDecor = {
    [1] = {
        offset8 = 24,
        values8 = {
            1735550285, 1698968165, 1634889571, 1852795252, 1881350961,
            863269473, 0, 0
        }
    },
    [2] = {
        offset8 = 24,
        values8 = {
            1735550285, 1698968165, 1634889571, 1852795252, 1881350962,
            863269473, 0, 0
        }
    },
    [3] = {
        offset8 = 24,
        values8 = {
            1735550285, 1698968165, 1634889571, 1852795252, 1881350963,
            863269473, 0, 0
        }
    },
    [4] = {
        offset8 = 24,
        values8 = {
            1735550285, 1698968165, 1634889571, 1852795252, 1881350964,
            863269473, 0, 0
        }
    },
    [5] = {
        offset8 = 24,
        values8 = {
            1735550285, 1698968165, 1634889571, 1852795252, 1881350965,
            846492257, 0, 0
        }
    },
    [6] = {
        offset8 = 24,
        values8 = {
            1735550285, 1698968165, 1634889571, 1852795252, 1881350966,
            846492257, 0, 0
        }
    },
    [7] = {
        offset8 = 24,
        values8 = {
            1735550285, 1698968165, 1634889571, 1852795252, 1881350967,
            846492257, 0, 0
        }
    },
    [8] = {
        offset8 = 24,
        values8 = {
            1735550285, 1698968165, 1634889571, 1852795252, 1881350968,
            829715041, 0, 0
        }
    },
    [9] = {
        offset8 = 24,
        values8 = {
            1735550285, 1698968165, 1634889571, 1852795252, 1881350969,
            829715041, 0, 0
        }
    },
    [10] = {
        offset8 = 24,
        values8 = {
            1735550285, 1698968165, 1634889571, 1852795252, 1881354289,
            829715041, 0, 0
        }
    },
    [11] = {
        offset8 = 24,
        values8 = {
            1735550285, 1698968165, 1634889571, 1852795252, 1881354545,
            829715041, 0, 0
        }
    },
    [12] = {
        offset8 = 24,
        values8 = {
            1735550285, 1698968165, 1634889571, 1852795252, 1881354801,
            829715041, 0, 0
        }
    }
}

function mergedecor(index)
    gg.setVisible(false)
    gg.clearResults()

    -- ===============================
    -- VALIDASI DATA
    -- ===============================
    if not mergeDecor or not mergeDecor[index] then
        gg.alert("⛔ Merge Decoration " .. index .. " not found!\n\n" ..
                     "📢 Please restart the game and try again.")
        return
    end

    -- ===============================
    -- 🔍 SEARCH SOURCE DECOR (SEKALI)
    -- ===============================
    if not cache.sourceBase then
        gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)
        local r = gg.getResults(1)
        if #r == 0 then
            gg.alert(
                "⛔ Merge Decoration source not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.sourceBase = r[1].address + 0x1C
    end

    -- ===============================
    -- 📥 COPY DECOR (cache per index)
    -- ===============================
    if not cache.copied[index] then
        local temp = {}
        for i = 0, 5 do
            temp[#temp + 1] = {
                address = cache.sourceBase + i * 4,
                flags = gg.TYPE_DWORD
            }
        end
        cache.copied[index] = gg.getValues(temp)
    end

    -- ===============================
    -- 📍 TARGET (search sekali)
    -- ===============================
    if not cache.target then
        gg.clearResults()
        gg.searchNumber("2581275344925", gg.TYPE_QWORD)
        local t = gg.getResults(1)
        if #t == 0 then
            gg.alert(
                "❌ Merge Decoration target not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.target = t[1].address - 0x270
    end

    -- ===============================
    -- 📋 Paste 6 DWORD awal
    -- ===============================
    local edits = {}
    for i, v in ipairs(cache.copied[index]) do
        edits[#edits + 1] = {
            address = cache.target + (i - 1) * 4,
            value = v.value,
            flags = gg.TYPE_DWORD
        }
    end

    edits[#edits + 1] = {
        address = cache.target + 6 * 4,
        value = 0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 7 * 4,
        value = 1,
        flags = gg.TYPE_DWORD
    }

    -- FIX offset8
    edits[#edits + 1] = {
        address = cache.target + 0x8,
        value = mergeDecor[index].offset8,
        flags = gg.TYPE_DWORD
    }

    gg.setValues(edits)

    -- ===============================
    -- 🔗 POINTER VALIDATION
    -- ===============================
    local ptrVal = gg.getValues({
        {address = cache.target + 0x10, flags = gg.TYPE_QWORD}
    })[1].value

    local ptr = tonumber(ptrVal)
    if not ptr or ptr == 0 then return end

    -- ===============================
    -- 🧩 Paste 8 DWORD akhir
    -- ===============================
    local final = {}
    for i = 0, 7 do
        final[#final + 1] = {
            address = ptr + i * 4,
            value = mergeDecor[index].values8[i + 1],
            flags = gg.TYPE_DWORD
        }
    end

    gg.setValues(final)

    gg.toast("✅ Merge Decoration " .. index .. " applied!")
end

-------------------------------------------------

function oldupgrededekor()
    while true do
        gg.setVisible(false)
        gg.clearResults()
        local indev = dev
        local skins = {
            "🚗 • Classic Car Collection", "🎂 • Biggest Cake",
            "🦖 • Land of the Dinosaurs", "🚀 • Spaceport",
            "⛄ • Snowman", "🪄 • School of Magic",
            "⛲ • BFF Fountain", "🕺 • Disco Block", "❌ • Go Back"
        }

        local choice = gg.multiChoice(skins, nil, indev)
        if not choice then return end

        -- 🔙 Back
        if choice[9] then
            if type(coldekor1) == "function" then coldekor1() end
            return
        end

        -- 🔁 Apply per pilihan
        for i = 1, 8 do
            if choice[i] then
                oldnondecor(i)
                gg.toast(skins[i] .. " applied\n👉 Claim in freeze reward!")

                repeat gg.sleep(500) until gg.isVisible(true)
                gg.setVisible(false)
            end
        end
    end
end

-- 🔐 Cache (reset jika game restart)
local cache = {copied = {}, sourceBase = nil, target = nil}

local oldnonDecor = {
    [1] = {
        patch = {
            1952805396, 1633644402, 7304310, 838873462, 2097152000, 112, 0, 1
        }
    },
    [2] = {
        patch = {
            1734692112, 1801536353, 7274597, 838873462, 2097152000, 112, 0, 1
        }
    },
    [3] = {
        patch = {
            1920289304, 1769173857, 1918980195, 838860907, 2097152000, 112, 0, 1
        }
    },
    [4] = {
        patch = {
            1634751254, 1867670883, 1952803683, 838860800, 2097152000, 112, 0, 1
        }
    },
    [5] = {
        patch = {
            1869501198, 1851878775, 1952803584, 838860800, 2097152000, 112, 0, 1
        }
    },
    [6] = {
        patch = {
            1818314788, 1702326124, 808611429, 1698969393, 7499619, 3486830, 0,
            1
        }
    },
    [7] = {
        offset0 = 33,
        offset8 = 26,
        values8 = {
            1667592275, 1114399081, 1953849701, 1851875193, 1818324329,
            2003792991, 29285, 0
        }
    },
    [8] = {
        patch = {
            1936278564, 1698983779, 1634889571, 1852795252, 3690579, 7566444, 0,
            1
        }
    }
}

function oldnondecor(index)
    gg.setVisible(false)
    gg.clearResults()

    local data = oldnonDecor[index]
    if not data then
        gg.alert("⛔ Old Event Decoration " .. index .. " not found!\n\n" ..
                     "📢 Please restart the game and try again.")
        return
    end

    -- ===============================
    -- 📍 TARGET (sekali)
    -- ===============================
    if not cache.target then
        gg.searchNumber("2581275344925", gg.TYPE_QWORD)
        local t = gg.getResults(1)
        if #t == 0 then
            gg.alert(
                "⛔ Old Event Decoration source not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.target = t[1].address - 0x270
    end

    -- ===============================
    -- 🚀 MODE PATCH LANGSUNG
    -- ===============================
    if data.patch then
        local edits = {}
        for i = 0, 7 do
            edits[#edits + 1] = {
                address = cache.target + i * 4,
                flags = gg.TYPE_DWORD,
                value = data.patch[i + 1]
            }
        end
        gg.setValues(edits)
        gg.toast("✅ Old Event Decoration " .. index .. " applied!")
        return
    end

    -- ===============================
    -- 🔍 SOURCE (sekali)
    -- ===============================
    if not cache.sourceBase then
        gg.clearResults()
        gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)
        local r = gg.getResults(1)
        if #r == 0 then
            gg.alert(
                "❌ Old Event Decoration target not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.sourceBase = r[1].address + 0x1C
    end

    -- ===============================
    -- 📥 COPY HEADER (per index)
    -- ===============================
    if not cache.copied[index] then
        local temp = {}
        for i = 0, 5 do
            temp[#temp + 1] = {
                address = cache.sourceBase + i * 4,
                flags = gg.TYPE_DWORD
            }
        end
        cache.copied[index] = gg.getValues(temp)
    end

    -- ===============================
    -- 🧩 PASTE HEADER
    -- ===============================
    local edits = {}

    for i, v in ipairs(cache.copied[index]) do
        edits[#edits + 1] = {
            address = cache.target + (i - 1) * 4,
            value = v.value,
            flags = gg.TYPE_DWORD
        }
    end

    edits[#edits + 1] = {
        address = cache.target,
        value = data.offset0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 0x8,
        value = data.offset8,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 6 * 4,
        value = 0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 7 * 4,
        value = 1,
        flags = gg.TYPE_DWORD
    }

    gg.setValues(edits)

    -- ===============================
    -- 🔗 POINTER
    -- ===============================
    local ptr = tonumber(gg.getValues({
        {address = cache.target + 0x10, flags = gg.TYPE_QWORD}
    })[1].value)

    if not ptr or ptr == 0 then return end

    -- ===============================
    -- 🧩 VALUES8
    -- ===============================
    local final = {}
    for i = 0, 7 do
        final[#final + 1] = {
            address = ptr + i * 4,
            value = data.values8[i + 1],
            flags = gg.TYPE_DWORD
        }
    end

    gg.setValues(final)
    gg.toast("✅ Old Event Decoration " .. index .. " applied!")
end

-------------------------------------------------

-- ✨ Placeholder for unavailable decorations
local function dekorNotAvailable()
    gg.alert(
        "⚠️ This decoration is not available yet.\nPlease wait for the next update.\n\nThank you!")
    minidekor()
end

function coldekor2() dekorNotAvailable() end

function coldekor6() dekorNotAvailable() end

function coldekor7() dekorNotAvailable() end

function coldekor3()
    while true do
        gg.setVisible(false)
        gg.clearResults()
        local indev = dev
        local skins = {
            "🏮 • Paper Lanterns", "🏯 • Chinese House",
            "🌳 • Lantern Tree", "🐠 • Goldfish",
            "🐒 • Monkey Statue", "🐉 • Red Dragon",
            "🐕 • Yellow Dog", "🦁 • Chinese Lion",
            "🐱 • Maneki-neko", "🌉 • Red Bridge",
            "🐸 • Money Toad", "🥣 • Bowl of Wealth",
            "🎉 • New Year Symbol", "🐲 • Dragon Dance",
            "❌ • Go Back"
        }

        local choice = gg.multiChoice(skins, nil, indev)
        if not choice then return end

        -- 🔙 Back
        if choice[15] then
            if type(minidekor) == "function" then minidekor() end
            return
        end

        -- 🔁 Apply per pilihan
        for i = 1, 14 do
            if choice[i] then
                lunardecor(i)
                gg.toast(skins[i] .. " applied\n👉 Claim in freeze reward!")

                repeat gg.sleep(500) until gg.isVisible(true)
                gg.setVisible(false)
            end
        end
    end
end

-- 🔐 Cache (reset jika game restart)
local cache = {copied = {}, sourceBase = nil, target = nil}

local lunarDecor = {
    [1] = {
        offset0 = 33,
        offset8 = 27,
        values8 = {
            1667592275, 1114399081, 1953849701, 1749245817, 1600220777,
            1953390956, 7238245, 0
        }
    },
    [2] = {
        offset0 = 33,
        offset8 = 25,
        values8 = {
            1667592275, 1114399081, 1953849701, 1749245817, 1600220777,
            1937076072, 101, 0
        }
    },
    [3] = {
        offset0 = 33,
        offset8 = 29,
        values8 = {
            1667592275, 1114399081, 1953849701, 1749245817, 1600220777,
            1751607660, 1701991540, 101
        }
    },
    [4] = {
        offset0 = 33,
        offset8 = 24,
        values8 = {
            1667592275, 1114399081, 1953849701, 1749245817, 1600220777,
            1752394086, 0, 0
        }
    },
    [5] = {
        offset0 = 33,
        offset8 = 26,
        values8 = {
            1667592275, 1114399081, 1953849701, 1749245817, 1600220777,
            1802399597, 31077, 0
        }
    },
    [6] = {
        offset0 = 33,
        offset8 = 30,
        values8 = {
            1667592275, 1114399081, 1953849701, 1751342969, 1600220777,
            1734439524, 808611439, 14129
        }
    },
    [7] = {patch = {1768440596, 1702061422, 6778692, 0, -17638944, 109, 0, 1}},
    [8] = {
        offset0 = 33,
        offset8 = 26,
        values8 = {
            1667592275, 1114399081, 1953849701, 1749245817, 1600220777,
            1734439524, 28271, 0
        }
    },
    [9] = {
        offset0 = 33,
        offset8 = 26,
        values8 = {
            1667592275, 1114399081, 1953849701, 1749245817, 1600220777,
            1701732717, 26987, 0
        }
    },
    [10] = {
        offset0 = 25,
        offset8 = 23,
        values8 = {
            1667592275, 1114399081, 1953849701, 1701994361, 1769095780, 6645604,
            0, 0
        }
    },
    [11] = {
        offset0 = 33,
        offset8 = 24,
        values8 = {
            1667592275, 1114399081, 1953849701, 1917214585, 1951623023,
            1702196321, 0, 0
        }
    },
    [12] = {
        offset0 = 33,
        offset8 = 25,
        values8 = {
            1667592275, 1114399081, 1953849701, 1702322041, 1752460385,
            2003788383, 108, 0
        }
    },
    [13] = {
        patch = {
            1768440614, 1702061422, 1885296974, 1951623017, 1702196321, 0, 0, 1
        }
    },
    [14] = {
        patch = {
            1634034214, 1601795189, 1734439524, 1683975791, 1701015137, 0, 0, 1
        }
    }
}

function lunardecor(index)
    gg.setVisible(false)
    gg.clearResults()

    local data = lunarDecor[index]
    if not data then
        gg.alert("⛔ Lunar Decoration " .. index .. " not found!\n\n" ..
                     "📢 Please restart the game and try again.")
        return
    end

    -- ===============================
    -- 📍 TARGET (sekali)
    -- ===============================
    if not cache.target then
        gg.searchNumber("2581275344925", gg.TYPE_QWORD)
        local t = gg.getResults(1)
        if #t == 0 then
            gg.alert(
                "⛔ Lunar Decoration source not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.target = t[1].address - 0x270
    end

    -- ===============================
    -- 🚀 MODE PATCH LANGSUNG
    -- ===============================
    if data.patch then
        local edits = {}
        for i = 0, 7 do
            edits[#edits + 1] = {
                address = cache.target + i * 4,
                flags = gg.TYPE_DWORD,
                value = data.patch[i + 1]
            }
        end
        gg.setValues(edits)
        gg.toast("✅ Lunar Decoration " .. index .. " applied!")
        return
    end

    -- ===============================
    -- 🔍 SOURCE (sekali)
    -- ===============================
    if not cache.sourceBase then
        gg.clearResults()
        gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)
        local r = gg.getResults(1)
        if #r == 0 then
            gg.alert(
                "❌ Lunar Decoration target not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.sourceBase = r[1].address + 0x1C
    end

    -- ===============================
    -- 📥 COPY HEADER (per index)
    -- ===============================
    if not cache.copied[index] then
        local temp = {}
        for i = 0, 5 do
            temp[#temp + 1] = {
                address = cache.sourceBase + i * 4,
                flags = gg.TYPE_DWORD
            }
        end
        cache.copied[index] = gg.getValues(temp)
    end

    -- ===============================
    -- 🧩 PASTE HEADER
    -- ===============================
    local edits = {}

    for i, v in ipairs(cache.copied[index]) do
        edits[#edits + 1] = {
            address = cache.target + (i - 1) * 4,
            value = v.value,
            flags = gg.TYPE_DWORD
        }
    end

    edits[#edits + 1] = {
        address = cache.target,
        value = data.offset0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 0x8,
        value = data.offset8,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 6 * 4,
        value = 0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 7 * 4,
        value = 1,
        flags = gg.TYPE_DWORD
    }

    gg.setValues(edits)

    -- ===============================
    -- 🔗 POINTER
    -- ===============================
    local ptr = tonumber(gg.getValues({
        {address = cache.target + 0x10, flags = gg.TYPE_QWORD}
    })[1].value)

    if not ptr or ptr == 0 then return end

    -- ===============================
    -- 🧩 VALUES8
    -- ===============================
    local final = {}
    for i = 0, 7 do
        final[#final + 1] = {
            address = ptr + i * 4,
            value = data.values8[i + 1],
            flags = gg.TYPE_DWORD
        }
    end

    gg.setValues(final)
    gg.toast("✅ Lunar Decoration " .. index .. " applied!")
end

function coldekor4()
    while true do
        gg.setVisible(false)
        gg.clearResults()
        local indev = dev
        local skins = {
            "🥚 • Faberge Egg (Red)", "🍫 • Chocolate Fountain",
            "🐇 • Easter Bunny's House", "🎨 • Throes of Art",
            "🌸 • Spring", "⛲ • Easter Fountain",
            "🚧 • Easter Fence", "🧸 • Stuffed Bunny",
            "🌳 • Easter Topiary", "🎁 • Cart Full of Gifts",
            "🌲 • Easter Tree", "🥚 • Egg Topiary",
            "🥚 • Faberge Egg (Blue)", "🐇 • Talented Bunny Statue",
            "🏭 • Easter Workshop", "⛵ • Boat Ride Attraction",
            "🚂 • Easter Railway", "🛏️ • Easter Hammock",
            "🍇 • Vineyard", "🏠 • Rabbit's House",
            "🍄 • Mushroom Stump", "💡 • Flower Lamppost",
            "💎 • Rabbit Treasure", "❌ • Go Back"
        }

        local choice = gg.multiChoice(skins, nil, indev)
        if not choice then return end

        -- 🔙 Back
        if choice[24] then
            if type(minidekor) == "function" then minidekor() end
            return
        end

        -- 🔁 Apply per pilihan
        for i = 1, 23 do
            if choice[i] then
                easterdecor(i)
                gg.toast(skins[i] .. " applied\n👉 Claim in freeze reward!")

                repeat gg.sleep(500) until gg.isVisible(true)
                gg.setVisible(false)
            end
        end
    end
end

-- 🔐 Cache (reset jika game restart)
local cache = {copied = {}, sourceBase = nil, target = nil}

local easterDecor = {
    [1] = {
        offset0 = 33,
        offset8 = 31,
        values8 = {
            1667592275, 1114399081, 1953849701, 1631936377, 1919251571,
            1650542175, 1701278309, 6776645, 1852402515, 1919895135, 1936028276,
            1749245811
        }
    },
    [2] = {
        offset0 = 41,
        offset8 = 34,
        values8 = {
            1667592275, 1114399081, 1953849701, 1631936377, 1919251571,
            1869103967, 1634496355, 1866884468, -2147455371, 112, 0, 0
        }
    },
    [3] = {
        offset0 = 41,
        offset8 = 32,
        values8 = {
            1667592275, 1114399081, 1953849701, 1631936377, 1919251571,
            1650545247, 1215588706, 1702065519, 1852402515, 1919895135,
            1936028276, 1749245811
        }
    },
    [4] = {
        offset0 = 41,
        offset8 = 34,
        values8 = {
            1667592275, 1114399081, 1953849701, 1631936377, 1919251571,
            1935754591, 1131570548, 1801677160, -2130678171, 112, 0, 0
        }
    },
    [5] = {
        offset0 = 33,
        offset8 = 31,
        values8 = {
            1667592275, 1114399081, 1953849701, 1631936377, 1919251571,
            1919963999, 1197960809, 7107177, 1852402515, 1919895135, 1936028276,
            1749245811
        }
    },
    [6] = {
        patch = {
            1935754526, 1601332596, 1853189990, 1852399988, -1592262144, 112, 0,
            1
        }
    },
    [7] = {
        patch = {
            1935754520, 1601332596, 1668179302, 1852375141, -1592262144, 112, 0,
            1
        }
    },
    [8] = {
        offset0 = 41,
        offset8 = 32,
        values8 = {
            1667592275, 1114399081, 1953849701, 1631936377, 1919251571,
            1935754591, 1114793332, 2037280373, 1852402515, 1919895135,
            1936028276, 1749245811
        }
    },
    [9] = {
        offset0 = 33,
        offset8 = 27,
        values8 = {
            1667592275, 1114399081, 1953849701, 1631936377, 1919251571,
            1768976212, 7959137, 112, 1852402515, 1919895135, 1936028276,
            1749245811
        }
    },
    [10] = {
        offset0 = 25,
        offset8 = 26,
        values8 = {
            1667592275, 1114399081, 1953849701, 1631936377, 1919251571,
            1651341651, -1593807761, 112, 1852402515, 1919895135, 1936028276,
            1749245811
        }
    },
    [11] = {
        offset0 = 33,
        offset8 = 31,
        values8 = {
            1667592275, 1114399081, 1953849701, 1631936377, 1919251571,
            1935754591, 1416783220, 6645106, 1852402515, 1919895135, 1936028276,
            1749245811
        }
    },
    [12] = {
        offset0 = 33,
        offset8 = 25,
        values8 = {
            1667592275, 1114399081, 1953849701, 1869897593, 1918986608,
            1734696825, 103, 0, 1852402515, 1919895135, 1936028276, 1749245811
        }
    },
    [13] = {
        offset0 = 41,
        offset8 = 36,
        values8 = {
            1667592275, 1114399081, 1953849701, 1631936377, 1919251571,
            1650542175, 1701278309, 1600612165, 1852402515, 1919895135,
            1936028276, 1749245811
        }
    },
    [14] = {
        offset0 = 33,
        offset8 = 26,
        values8 = {
            1667592275, 1114399081, 1953849701, 1631936377, 1919251571,
            1650614610, -1593805719, 112, 1852402515, 1919895135, 1936028276,
            1749245811
        }
    },
    [15] = {
        patch = {
            1935762716, 1601332596, 1952670054, 7959151, -1592262016, 112, 0, 1
        }
    },
    [16] = {
        patch = {
            1935762710, 1601332596, 1684959088, 7959040, -1592262016, 112, 0, 1
        }
    },
    [17] = {
        patch = {
            1935762716, 1383228788, 1919707489, 6578543, -1592262016, 112, 0, 1
        }
    },
    [18] = {
        patch = {
            1935762714, 1215456628, 1869442401, 27491, -1592262016, 112, 0, 1
        }
    },
    [19] = {
        patch = {
            1935754524, 1450337652, 2036690537, 6582881, -1592262016, 112, 0, 1
        }
    },
    [20] = {
        patch = {
            1935754518, 1400006004, 1886221684, 6582784, -1592262016, 112, 0, 1
        }
    },
    [21] = {
        patch = {
            1634034214, 1601795189, 1953718629, 1935635045, 1886221684, 0, 0, 1
        }
    },
    [22] = {
        patch = {
            1634034218, 1601795189, 1953718629, 1818194533, 1702129249, 28274,
            0, 1
        }
    },
    [23] = {
        patch = {
            1935754524, 1601332596, 1852732770, 7562601, 1702129249, 28274, 0, 1
        }
    }
}

function easterdecor(index)
    gg.setVisible(false)
    gg.clearResults()

    local data = easterDecor[index]
    if not data then
        gg.alert("⛔ Easter Decoration " .. index .. " not found!\n\n" ..
                     "📢 Please restart the game and try again.")
        return
    end

    -- ===============================
    -- 📍 TARGET (sekali)
    -- ===============================
    if not cache.target then
        gg.searchNumber("2581275344925", gg.TYPE_QWORD)
        local t = gg.getResults(1)
        if #t == 0 then
            gg.alert(
                "⛔ Easter Decoration source not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.target = t[1].address - 0x270
    end

    -- ===============================
    -- 🚀 MODE PATCH LANGSUNG
    -- ===============================
    if data.patch then
        local edits = {}
        for i = 0, 7 do
            edits[#edits + 1] = {
                address = cache.target + i * 4,
                flags = gg.TYPE_DWORD,
                value = data.patch[i + 1]
            }
        end
        gg.setValues(edits)
        gg.toast("✅ Easter Decoration " .. index .. " applied!")
        return
    end

    -- ===============================
    -- 🔍 SOURCE (sekali)
    -- ===============================
    if not cache.sourceBase then
        gg.clearResults()
        gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)
        local r = gg.getResults(1)
        if #r == 0 then
            gg.alert(
                "❌ Easter Decoration target not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.sourceBase = r[1].address + 0x1C
    end

    -- ===============================
    -- 📥 COPY HEADER (per index)
    -- ===============================
    if not cache.copied[index] then
        local temp = {}
        for i = 0, 5 do
            temp[#temp + 1] = {
                address = cache.sourceBase + i * 4,
                flags = gg.TYPE_DWORD
            }
        end
        cache.copied[index] = gg.getValues(temp)
    end

    -- ===============================
    -- 🧩 PASTE HEADER
    -- ===============================
    local edits = {}

    for i, v in ipairs(cache.copied[index]) do
        edits[#edits + 1] = {
            address = cache.target + (i - 1) * 4,
            value = v.value,
            flags = gg.TYPE_DWORD
        }
    end

    edits[#edits + 1] = {
        address = cache.target,
        value = data.offset0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 0x8,
        value = data.offset8,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 6 * 4,
        value = 0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 7 * 4,
        value = 1,
        flags = gg.TYPE_DWORD
    }

    gg.setValues(edits)

    -- ===============================
    -- 🔗 POINTER
    -- ===============================
    local ptr = tonumber(gg.getValues({
        {address = cache.target + 0x10, flags = gg.TYPE_QWORD}
    })[1].value)

    if not ptr or ptr == 0 then return end

    -- ===============================
    -- 🧩 VALUES12
    -- ===============================
    local final = {}
    for i = 0, 11 do
        final[#final + 1] = {
            address = ptr + i * 4,
            value = data.values8[i + 1],
            flags = gg.TYPE_DWORD
        }
    end

    gg.setValues(final)
    gg.toast("✅ Easter Decoration " .. index .. " applied!")
end

function coldekor5()
    while true do
        gg.setVisible(false)
        gg.clearResults()

        local skins = {
            "🌸 • Heart Flowerbed", "🏞️ • Small Romantic Park",
            "🕊️ • Doves in Love", "❤️ • Ruby Heart",
            "🚃 • Carriage", "📦 • Love Delivery Statue",
            "🍷 • Romantic Date", "🌳 • Heartfelt Topiary",
            "🏹 • Cupid", "🐻 • Bear in Love",
            "🦄 • Stuffed Unicorn", "🗿 • Affection Statue",
            "⛲ • Heart to Heart Fountain", "🗿 • Statue of Lovers",
            "🦚 • Peacocks in Love", "🎁 • Unexpected Gift",
            "📸 • Perfect Pair Photo Zone", "🌳 • Topiary",
            "🏡 • Romantic Gazebo", "🦢 • Pond with Swans",
            "🛒 • Flower Cart", "🧸 • Teddy Bear",
            "👼 • Flowerbed with Angels", "🎠 • Carousel",
            "🤴 • Prince on a White Horse", "🪑 • Lovers Bench",
            "🔒 • Love Padlocks", "🌉 • Love Tunnel",
            "💘 • Flying Hearts", "🏹 • Cupid Arrow",
            "🐰 • Stuffed Bunny", "🐱 • Cuddly Kitty",
            "👁️ • Eagle Eye Cupid", "🌹 • Love Arch",
            "💞 • Eternal Love Sculpture", "🗝️ • Key to the Heart",
            "❌ • Go Back"
        }

        local choice = gg.multiChoice(skins, nil, "💘 Valentine Decoration")

        if not choice then return end

        -- 🔙 Back option
        if choice[37] then
            if type(minidekor) == "function" then
                minidekor()
            else
            end
            return
        end

        -- 🔁 Process selected avatars one by one
        for i = 1, 36 do
            if choice[i] then
                local func = _G["valdek" .. i]
                if type(func) == "function" then
                    func()
                    gg.toast("✅ Valentine " .. i ..
                                 " Decoration applied.\n👉 Claim it in-freeze reward!")

                    -- ⏸️ Wait for user to press GG icon before continuing
                    repeat gg.sleep(500) until gg.isVisible(true)

                    gg.setVisible(false)
                else
                    gg.alert("❌ Function Valentine Decoration " .. i ..
                                 "() not found!")
                end
            end
        end

        gg.toast(
            "🎉 All selected Valentine decorations have been successfully claimed!")
        -- 🔄 Setelah selesai → otomatis balik ke menu lagi
    end
end

-- 📁 Cache & File Setup
local folder = "/sdcard/.syscfg.lib/"
local fileAddr = folder .. ".addresscache"
local function deleteFile(p) pcall(function() os.remove(p) end) end
gg.setVisible(false)

-- 📍 Get Valentine Decoration Address
function getAddr()
    local f = io.open(fileAddr, "r")
    local addr = f and tonumber(f:read("*l")) or nil
    if f then f:close() end

    if addr then
        local chk = gg.getValues({{address = addr, flags = gg.TYPE_DWORD}})
        if chk and chk[1] and chk[1].value == 29 then return addr end
        deleteFile(fileAddr)
        gg.toast("👑 rish searching address.")
    end

    gg.clearResults()
    gg.searchNumber("1634035750;1918137458;1769300498::121", gg.TYPE_DWORD)
    gg.refineNumber("1769300498", gg.TYPE_DWORD)
    local r = gg.getResults(1)
    if #r == 0 then
        gg.alert(
            "❌ Address not found.\nPlease restart the game and try again.")
        return nil
    end

    local newAddr = r[1].address
    local save = io.open(fileAddr, "w")
    if save then
        save:write(newAddr)
        save:close()
    end
    return newAddr
end

-- 📦 Valentine Decoration Source Base
local baseValentineAddr = nil
function initValentineDecorationSearch()
    if baseValentineAddr then return true end
    gg.clearResults()
    gg.searchNumber("1634035750;1918137458;1769300498::121", gg.TYPE_DWORD)
    gg.refineNumber("1769300498", gg.TYPE_DWORD)
    local r = gg.getResults(1)
    if #r == 0 then
        gg.alert("❌ Valentine decoration structure not found.")
        return false
    end
    baseValentineAddr = r[1].address
    return true
end

-- ?? Apply Valentine Decoration
function valentinedecor(offset, label, emoji)
    if not initValentineDecorationSearch() then return end
    local src = baseValentineAddr + offset
    local vals = {}
    for i = 0, 5 do
        table.insert(vals, {address = src + i * 4, flags = gg.TYPE_DWORD})
    end
    vals = gg.getValues(vals)

    local target = getAddr()
    if not target then return end
    target = target + 0x10

    local newVals = {}
    for i, v in ipairs(vals) do
        table.insert(newVals, {
            address = target + (i - 1) * 4,
            value = v.value,
            flags = gg.TYPE_DWORD
        })
    end

    table.insert(newVals,
                 {address = target + 0x18, value = 0, flags = gg.TYPE_DWORD})
    table.insert(newVals,
                 {address = target + 0x1C, value = 1, flags = gg.TYPE_DWORD})

    gg.setValues(newVals)
    gg.toast(emoji .. " " .. label .. " valentine decoration applied!")
end

function valdek1() valentinedecor(-0x378, "Heart Flowerbed", "🌸") end
function valdek2() valentinedecor(-0x78, "Small Romantic Park", "🏞️") end
function valdek3() valentinedecor(0x288, "Doves in Love", "🕊️") end
function valdek4() valentinedecor(0x588, "Ruby Heart", "❤️") end
function valdek5() valentinedecor(0x888, "Carriage", "🚃") end
function valdek6() valentinedecor(0xB88, "Love Delivery Statue", "📦") end
function valdek7() valentinedecor(0xE88, "Romantic Date", "🍷") end
function valdek8() valentinedecor(0x1188, "Heartfelt Topiary", "🌳") end
function valdek9() valentinedecor(0x1488, "Cupid", "🏹") end
function valdek10() valentinedecor(0x1788, "Bear in Love", "🐻") end
function valdek11() valentinedecor(0x1A88, "Stuffed Unicorn", "🦄") end
function valdek12() valentinedecor(0x1D88, "Affection Statue", "🗿") end
function valdek13() valentinedecor(0x2088, "Heart to Heart Fountain", "⛲") end
function valdek14() valentinedecor(0x2388, "Statue of Lovers", "🗿") end
function valdek15() valentinedecor(0x2688, "Peacocks in Love", "🦚") end
function valdek16() valentinedecor(0x2988, "Unexpected Gift", "🎁") end
function valdek17() valentinedecor(0x2C88, "Perfect Pair Photo Zone", "📸") end
function valdek18() valentinedecor(0x2F88, "Topiary", "🌳") end
function valdek19() valentinedecor(0x3288, "Romantic Gazebo", "🏡") end
function valdek20() valentinedecor(0x3588, "Pond with Swans", "🦢") end
function valdek21() valentinedecor(0x3888, "Flower Cart", "🛒") end
function valdek22() valentinedecor(0x3B88, "Teddy Bear", "🧸") end
function valdek23() valentinedecor(0x3E88, "Flowerbed with Angels", "👼") end
function valdek24() valentinedecor(0x4188, "Carousel", "🎠") end
function valdek25() valentinedecor(0x4488, "Prince on a White Horse", "🤴") end
function valdek26() valentinedecor(0x4788, "Lovers Bench", "🪑") end
function valdek27() valentinedecor(0x4A88, "Love Padlocks", "🔒") end
function valdek28() valentinedecor(0x4D88, "Love Tunnel", "🌉") end
function valdek29() valentinedecor(0x5088, "Flying Hearts", "💘") end
function valdek30() valentinedecor(0x5388, "Cupid Arrow", "🏹") end
function valdek31() valentinedecor(0x5688, "Stuffed Bunny", "🐰") end
function valdek32() valentinedecor(0x5988, "Cuddly Kitty", "🐱") end
function valdek33() valentinedecor(0x5C88, "Eagle Eye Cupid", "👁️") end
function valdek34() valentinedecor(0x5F88, "Love Arch", "🌹") end
function valdek35() valentinedecor(0x6288, "Eternal Love Sculpture", "💞") end
function valdek36() valentinedecor(0x6588, "Key to the Heart", "🗝️") end

function coldekor8()
    local indev = dev
    local menu = gg.choice({
        "✨ • Special Decoration", "💎 • Rare Decoration",
        "🌸 • Unique Decoration", "🏵️ • Limited Decoration",
        "🎀 • Premium Decoration", "🏰 • Classic Decoration",
        "❌ • Go Back"
    }, nil, indev)

    if menu == nil then
        return
    elseif menu == 1 then
        randecor1()
    elseif menu == 2 then
        randecor2()
    elseif menu == 3 then
        randecor3()
    elseif menu == 4 then
        randecor4()
    elseif menu == 5 then
        randecor5()
    elseif menu == 6 then
        randecor6()
    elseif menu == 7 then
        minidekor()
    end
end

function randecor1()
    while true do
        gg.setVisible(false)
        gg.clearResults()

        local skins = {
            "👨‍🍳 • Chef", "🍽️ • Romantic Dinner",
            "🫖 • Tea Party Fountain", "🍹 • Pear Tiki Bar",
            "🌉 • Fruit Bridge", "☕ • Coffee Bike",
            "🌳 • Broccoli Tree", "🚚 • Hot Pizza Truck",
            "🍦 • Ice Cream Cafe", "🎈 • Hot Air Balloon",
            "🎨 • Cooking Masterpiece Banner",
            "🎉 • 5 Year Together Banner", "🏪 • Hot Cup Coffee Shop",
            "🍫 • Chocolate Mill", "🌭 • Hot Dog Swings",
            "🏬 • Bargain District", "🚡 • Ski Lift",
            "🔥 • Eternal Torch", "✈️ • Biomass-powered Airplane",
            "🕷️ • Mechanical Spider", "🤖 • Humanoid Robot",
            "🌸 • Flower Arch", "⛵ • Boat with Flowers",
            "🚗 • Car Flower Bed", "🦚 • Peacock Flower Bed",
            "🎈 • Balloon Arch", "🌲 • Inflatable Tree",
            "🐶 • Inflatable Dog", "🏠 • Flying House",
            "🕺 • Air Dancer", "3️⃣ • Inflatable Number 3",
            "🏰 • Moving Castle", "⛺ • Camping",
            "🎂 • Township Turned 2!", "🕍 • Chamber of Horrors",
            "👻 • Ghost Huntress", "⚰️ • Spooky Crypt",
            "🎻 • Supernatural Orchestra", "🐷 • Inflatable Pig",
            "🐔 • Inflatable Chicken", "🐑 • Inflatable Sheep",
            "🐄 • Inflatable Cow", "🌾 • Goddess of Harvest",
            "🍉 • Giant Watermelon", "🥕 • Carrot Tree",
            "🌽 • Harvest a Giant", "🌶️ • Spicy House",
            "🏛️ • Grand Harvest Square", "🌊 • Poseidon Statue",
            "💰 • Treasure Chest", "❌ • Go Back"
        }

        local choice = gg.multiChoice(skins, nil, "✨ Special Decoration")

        if not choice then return end

        -- 🔙 Back option
        if choice[51] then
            if type(coldekor7) == "function" then
                coldekor7()
            else
            end
            return
        end

        -- 🔁 Process selected avatars one by one
        for i = 1, 50 do
            if choice[i] then
                local func = _G["spesialdekor" .. i]
                if type(func) == "function" then
                    func()
                    gg.toast("✅ Special " .. i ..
                                 " Decoration applied.\n👉 Claim it in-freeze reward!")

                    -- ⏸️ Wait for user to press GG icon before continuing
                    repeat gg.sleep(500) until gg.isVisible(true)

                    gg.setVisible(false)
                else
                    gg.alert("❌ Function Special Decoration " .. i ..
                                 "() not found!")
                end
            end
        end

        gg.toast(
            "🎉 All selected Special decorations have been successfully claimed!")
        -- 🔄 Setelah selesai → otomatis balik ke menu lagi
    end
end

-- 📁 Cache & File Setup
local folder = "/sdcard/.syscfg.lib/"
local fileAddr = folder .. ".addresscache"
local function deleteFile(p) pcall(function() os.remove(p) end) end
gg.setVisible(false)

-- 📍 Get Special Decoration Address
function getAddr()
    local f = io.open(fileAddr, "r")
    local addr = f and tonumber(f:read("*l")) or nil
    if f then f:close() end

    if addr then
        local chk = gg.getValues({{address = addr, flags = gg.TYPE_DWORD}})
        if chk and chk[1] and chk[1].value == 29 then return addr end
        deleteFile(fileAddr)
        gg.toast("👑 rish searching address.")
    end

    gg.clearResults()
    gg.searchNumber("1935754524;1852732770;1769300575::37", gg.TYPE_DWORD)
    gg.refineNumber("1769300575", gg.TYPE_DWORD)
    local r = gg.getResults(1)
    if #r == 0 then
        gg.alert(
            "❌ Address not found.\nPlease restart the game and try again.")
        return nil
    end

    local newAddr = r[1].address
    local save = io.open(fileAddr, "w")
    if save then
        save:write(newAddr)
        save:close()
    end
    return newAddr
end

-- 📦 Special Decoration Source Base
local baseSpecialAddr = nil
function initSpecialDecorationSearch()
    if baseSpecialAddr then return true end
    gg.clearResults()
    gg.searchNumber("1935754524;1852732770;1769300575::37", gg.TYPE_DWORD)
    gg.refineNumber("1769300575", gg.TYPE_DWORD)
    local r = gg.getResults(1)
    if #r == 0 then
        gg.alert("❌ Special decoration structure not found.")
        return false
    end
    baseSpecialAddr = r[1].address
    return true
end

-- 💎 Apply Special Decoration
function specialdecor(offset, label, emoji)
    if not initSpecialDecorationSearch() then return end
    local src = baseSpecialAddr + offset
    local vals = {}
    for i = 0, 5 do
        table.insert(vals, {address = src + i * 4, flags = gg.TYPE_DWORD})
    end
    vals = gg.getValues(vals)

    local target = getAddr()
    if not target then return end
    target = target + 0x10

    local newVals = {}
    for i, v in ipairs(vals) do
        table.insert(newVals, {
            address = target + (i - 1) * 4,
            value = v.value,
            flags = gg.TYPE_DWORD
        })
    end

    table.insert(newVals,
                 {address = target + 0x18, value = 0, flags = gg.TYPE_DWORD})
    table.insert(newVals,
                 {address = target + 0x1C, value = 1, flags = gg.TYPE_DWORD})

    gg.setValues(newVals)
    gg.toast(emoji .. " " .. label .. " special decoration applied!")
end

function spesialdekor1() specialdecor(0x2C, "Chef", "👨‍🍳") end
function spesialdekor2() specialdecor(0x7C, "Romantic Dinner", "🍽️") end
function spesialdekor3() specialdecor(0xCC, "Tea Party Fountain", "🫖") end
function spesialdekor4() specialdecor(0x11C, "Pear Tiki Bar", "🍹") end
function spesialdekor5() specialdecor(0x16C, "Fruit Bridge", "🌉") end
function spesialdekor6() specialdecor(0x1BC, "Coffee Bike", "☕") end
function spesialdekor7() specialdecor(0x20C, "Broccoli Tree", "🌳") end
function spesialdekor8() specialdecor(0x25C, "Hot Pizza Truck", "🚚") end
function spesialdekor9() specialdecor(0x2AC, "Ice Cream Cafe", "🍦") end
function spesialdekor10() specialdecor(0x2FC, "Hot Air Balloon", "🎈") end
function spesialdekor11()
    specialdecor(0x34C, "Cooking Masterpiece Banner", "🎨")
end
function spesialdekor12() specialdecor(0x39C, "5 Year Together Banner", "🎉") end
function spesialdekor13() specialdecor(0x3EC, "Hot Cup Coffee Shop", "🏪") end
function spesialdekor14() specialdecor(0x43C, "Chocolate Mill", "🍫") end
function spesialdekor15() specialdecor(0x48C, "Hot Dog Swings", "🌭") end
function spesialdekor16() specialdecor(0x4DC, "Bargain District", "🏬") end
function spesialdekor17() specialdecor(0x52C, "Ski Lift", "🚡") end
function spesialdekor18() specialdecor(0x57C, "Eternal Torch", "🔥") end
function spesialdekor19()
    specialdecor(0x5CC, "Biomass-powered Airplane", "✈️")
end
function spesialdekor20() specialdecor(0x61C, "Mechanical Spider", "🕷️") end
function spesialdekor21() specialdecor(0x66C, "Humanoid Robot", "🤖") end
function spesialdekor22() specialdecor(0x6BC, "Flower Arch", "🌸") end
function spesialdekor23() specialdecor(0x70C, "Boat with Flowers", "⛵") end
function spesialdekor24() specialdecor(0x75C, "Car Flower Bed", "🚗") end
function spesialdekor25() specialdecor(0x7AC, "Peacock Flower Bed", "🦚") end
function spesialdekor26() specialdecor(0x7FC, "Balloon Arch", "🎈") end
function spesialdekor27() specialdecor(0x84C, "Inflatable Tree", "🌲") end
function spesialdekor28() specialdecor(0x89C, "Inflatable Dog", "🐶") end
function spesialdekor29() specialdecor(0x8EC, "Flying House", "🏠") end
function spesialdekor30() specialdecor(0x93C, "Air Dancer", "🕺") end
function spesialdekor31() specialdecor(0x98C, "Inflatable Number 3", "3️⃣") end
function spesialdekor32() specialdecor(0x9DC, "Moving Castle", "🏰") end
function spesialdekor33() specialdecor(0xA2C, "Camping", "⛺") end
function spesialdekor34() specialdecor(0xA7C, "Township Turned 2!", "🎂") end
function spesialdekor35() specialdecor(0xACC, "Chamber of Horrors", "🕍") end
function spesialdekor36() specialdecor(0xB1C, "Ghost Huntress", "👻") end
function spesialdekor37() specialdecor(0xB6C, "Spooky Crypt", "⚰️") end
function spesialdekor38() specialdecor(0xBBC, "Supernatural Orchestra", "🎻") end
function spesialdekor39() specialdecor(0xC0C, "Inflatable Pig", "🐷") end
function spesialdekor40() specialdecor(0xC5C, "Inflatable Chicken", "🐔") end
function spesialdekor41() specialdecor(0xCAC, "Inflatable Sheep", "🐑") end
function spesialdekor42() specialdecor(0xCFC, "Inflatable Cow", "🐄") end
function spesialdekor43() specialdecor(0xD4C, "Goddess of Harvest", "🌾") end
function spesialdekor44() specialdecor(0xD9C, "Giant Watermelon", "🍉") end
function spesialdekor45() specialdecor(0xDEC, "Carrot Tree", "🥕") end
function spesialdekor46() specialdecor(0xE3C, "Harvest a Giant", "🌽") end
function spesialdekor47() specialdecor(0xE8C, "Spicy House", "🌶️") end
function spesialdekor48() specialdecor(0xEDC, "Grand Harvest Square", "🏛️") end
function spesialdekor49() specialdecor(0xF2C, "Poseidon Statue", "🌊") end
function spesialdekor50() specialdecor(0xF7C, "Treasure Chest", "💰") end

function randecor2()
    while true do
        gg.setVisible(false)
        gg.clearResults()

        local skins = {
            "🏛️ • Ruins of Atlantis", "🚢 • Pirate Ship Bow",
            "🚤 • Submarine", "🍭 • Mountain of Candy",
            "🌉 • Candy Bridge", "🌳 • Candy Tree",
            "🏠 • Candy House", "🐄 • Confectioner Cow",
            "🎠 • Candy Carousel", "🍬 • Sweet Tooth Street",
            "🏪 • Souvenir Shop", "🏋️ • Training Ground",
            "🤿 • Diving Board", "⛲ • New Record Fountain",
            "🏆 • Champions Plaza", "🔥 • Torchbearer Statue",
            "🌊 • Snow Wave Statue", "🎖️ • Triumphal Victory Statue",
            "🏒 • Hockey Rink", "🛷 • Bobsled Track",
            "⛷️ • Never-ending Slope", "🏊 • Triathlon",
            "🛹 • Skateboarders", "🥅 • Seasoned Goalkeeper",
            "🌍 • World Champion", "⛸️ • Forest Skating Rink",
            "❌ • Go Back"
        }

        local choice = gg.multiChoice(skins, nil, "💎 Rare Decoration")

        if not choice then return end

        -- 🔙 Back option
        if choice[27] then
            if type(coldekor7) == "function" then
                coldekor7()
            else
            end
            return
        end

        -- 🔁 Process selected avatars one by one
        for i = 1, 26 do
            if choice[i] then
                local func = _G["raredekor" .. i]
                if type(func) == "function" then
                    func()
                    gg.toast("✅ Rare " .. i ..
                                 " Decoration applied.\n👉 Claim it in-freeze reward!")

                    -- ⏸️ Wait for user to press GG icon before continuing
                    repeat gg.sleep(500) until gg.isVisible(true)

                    gg.setVisible(false)
                else
                    gg.alert("❌ Function Rare Decoration " .. i ..
                                 "() not found!")
                end
            end
        end

        gg.toast(
            "🎉 All selected Rare decorations have been successfully claimed!")
        -- 🔄 Setelah selesai → otomatis balik ke menu lagi
    end
end

-- 📁 Cache & File Setup
local folder = "/sdcard/.syscfg.lib/"
local fileAddr = folder .. ".addresscache"
local function deleteFile(p) pcall(function() os.remove(p) end) end
gg.setVisible(false)

-- 📍 Get Rare Decoration Address
function getAddr()
    local f = io.open(fileAddr, "r")
    local addr = f and tonumber(f:read("*l")) or nil
    if f then f:close() end

    if addr then
        local chk = gg.getValues({{address = addr, flags = gg.TYPE_DWORD}})
        if chk and chk[1] and chk[1].value == 29 then return addr end
        deleteFile(fileAddr)
        gg.toast("👑 rish searching address.")
    end

    gg.clearResults()
    gg.searchNumber("1634034218;1634038388;1769300575::37", gg.TYPE_DWORD)
    gg.refineNumber("1769300575", gg.TYPE_DWORD)
    local r = gg.getResults(1)
    if #r == 0 then
        gg.alert(
            "❌ Address not found.\nPlease restart the game and try again.")
        return nil
    end

    local newAddr = r[1].address
    local save = io.open(fileAddr, "w")
    if save then
        save:write(newAddr)
        save:close()
    end
    return newAddr
end

-- 📦 Rare Decoration Source Base
local baseRareAddr = nil
function initRareDecorationSearch()
    if baseRareAddr then return true end
    gg.clearResults()
    gg.searchNumber("1634034218;1634038388;1769300575::37", gg.TYPE_DWORD)
    gg.refineNumber("1769300575", gg.TYPE_DWORD)
    local r = gg.getResults(1)
    if #r == 0 then
        gg.alert("❌ Rare decoration structure not found.")
        return false
    end
    baseRareAddr = r[1].address
    return true
end

-- 💎 Apply Rare Decoration
function raredecor(offset, label, emoji)
    if not initRareDecorationSearch() then return end
    local src = baseRareAddr + offset
    local vals = {}
    for i = 0, 5 do
        table.insert(vals, {address = src + i * 4, flags = gg.TYPE_DWORD})
    end
    vals = gg.getValues(vals)

    local target = getAddr()
    if not target then return end
    target = target + 0x10

    local newVals = {}
    for i, v in ipairs(vals) do
        table.insert(newVals, {
            address = target + (i - 1) * 4,
            value = v.value,
            flags = gg.TYPE_DWORD
        })
    end

    table.insert(newVals,
                 {address = target + 0x18, value = 0, flags = gg.TYPE_DWORD})
    table.insert(newVals,
                 {address = target + 0x1C, value = 1, flags = gg.TYPE_DWORD})

    gg.setValues(newVals)
    gg.toast(emoji .. " " .. label .. " rare decoration applied!")
end

function raredekor1() raredecor(0x2C, "Ruins of Atlantis", "🏛️") end
function raredekor2() raredecor(0x7C, "Pirate Ship Bow", "🚢") end
function raredekor3() raredecor(0xCC, "Submarine", "🚤") end
function raredekor4() raredecor(0x11C, "Mountain of Candy", "🍭") end
function raredekor5() raredecor(0x16C, "Candy Bridge", "🌉") end
function raredekor6() raredecor(0x1BC, "Candy Tree", "🌳") end
function raredekor7() raredecor(0x20C, "Candy House", "🏠") end
function raredekor8() raredecor(0x25C, "Confectioner Cow", "🐄") end
function raredekor9() raredecor(0x2AC, "Candy Carousel", "🎠") end
function raredekor10() raredecor(0x2FC, "Sweet Tooth Street", "🍬") end
function raredekor11() raredecor(0x34C, "Souvenir Shop", "🏪") end
function raredekor12() raredecor(0x39C, "Training Ground", "🏋️") end
function raredekor13() raredecor(0x3EC, "Diving Board", "🤿") end
function raredekor14() raredecor(0x43C, "New Record Fountain", "⛲") end
function raredekor15() raredecor(0x48C, "Champions Plaza", "🏆") end
function raredekor16() raredecor(0x4DC, "Torchbearer Statue", "🔥") end
function raredekor17() raredecor(0x52C, "Snow Wave Statue", "🌊") end
function raredekor18() raredecor(0x57C, "Triumphal Victory Statue", "🎖️") end
function raredekor19() raredecor(0x5CC, "Hockey Rink", "🏒") end
function raredekor20() raredecor(0x61C, "Bobsled Track", "🛷") end
function raredekor21() raredecor(0x66C, "Never-ending Slope", "⛷️") end
function raredekor22() raredecor(0x6BC, "Triathlon", "🏊") end
function raredekor23() raredecor(0x70C, "Skateboarders", "🛹") end
function raredekor24() raredecor(0x75C, "Seasoned Goalkeeper", "🥅") end
function raredekor25() raredecor(0x7AC, "World Champion", "🌍") end
function raredekor26() raredecor(0x7FC, "Forest Skating Rink", "⛸️") end

function randecor3()
    while true do
        gg.setVisible(false)
        gg.clearResults()

        local skins = {
            "🌊 • Sea Fence", "⚓ • Admiralty Anchor",
            "🐚 • Pearl Shell", "🐴 • Sea Horse",
            "🎣 • Lucky Fisherman", "🐟 • Dancing Koi",
            "🧜‍♀️ • The Mermaid", "🏰 • Water Tower",
            "🐙 • Fishing Octopus", "🛥️ • Stranded Yacht",
            "🏯 • Flooded Tower", "🏡 • Fisherman's House",
            "⚙️ • Watermill", "🐠 • Carp Pond",
            "🎠 • Underwater World Carousel", "🐝 • Bee Pilot",
            "🛩️ • Amphibious Aircraft", "🎈 • Inflatable Plane",
            "🚁 • Helicopter Trampoline", "🕊️ • Dovecote",
            "🪁 • Fly-seasoned Friends", "🎏 • Kite Master",
            "🎢 • Takeoff Ride", "🎒 • Jet Pack Attraction",
            "🏆 • Winged Winner", "🗽 • Happy Town Day Statue",
            "📸 • Festival Selfie Banner", "🏰 • Inflatable Castle",
            "🚂 • Kids Train Ride", "🚗 • Bumper Car Ride",
            "🗿 • Titans", "🌳 • Tree of Life Fountain",
            "🎨 • Jolly Painters", "🏙️ • Art District",
            "🧊 • Thingamacube", "🤹 • Juggler",
            "🖌️ • Graffiti Championship", "⛄ • Winter Fun",
            "🏚️ • Lake House", "🌀 • Endless Stairs",
            "🦣 • Frozen Mammoth", "🦀 • Hermit Crab",
            "🤿 • Divers", "💦 • Happy Splashes",
            "🏪 • Fishing-wharf Market", "🎣 • Lure Makers Hut",
            "🏊 • Polar Water Park", "⛩️ • Underwater Temple",
            "👨‍🚀 • Diver", "🔭 • Bathyscaphe Model",
            "❌ • Go Back"
        }

        local choice = gg.multiChoice(skins, nil, "🌸 Unique Decoration")

        if not choice then return end

        -- 🔙 Back option
        if choice[51] then
            if type(coldekor7) == "function" then
                coldekor7()
            else
            end
            return
        end

        -- 🔁 Process selected avatars one by one
        for i = 1, 50 do
            if choice[i] then
                local func = _G["uniquedekor" .. i]
                if type(func) == "function" then
                    func()
                    gg.toast("✅ Unique " .. i ..
                                 " Decoration applied.\n👉 Claim it in-freeze reward!")

                    -- ⏸️ Wait for user to press GG icon before continuing
                    repeat gg.sleep(500) until gg.isVisible(true)

                    gg.setVisible(false)
                else
                    gg.alert("❌ Function Unique Decoration " .. i ..
                                 "() not found!")
                end
            end
        end

        gg.toast(
            "🎉 All selected Unique decorations have been successfully claimed!")
        -- 🔄 Setelah selesai → otomatis balik ke menu lagi
    end
end

-- 📁 Cache & File Setup
local folder = "/sdcard/.syscfg.lib/"
local fileAddr = folder .. ".addresscache"
local function deleteFile(p) pcall(function() os.remove(p) end) end
gg.setVisible(false)

-- 📍 Get Unique Decoration Address
function getAddr()
    local f = io.open(fileAddr, "r")
    local addr = f and tonumber(f:read("*l")) or nil
    if f then f:close() end

    if addr then
        local chk = gg.getValues({{address = addr, flags = gg.TYPE_DWORD}})
        if chk and chk[1] and chk[1].value == 29 then return addr end
        deleteFile(fileAddr)
        gg.toast("👑 rish searching address.")
    end

    gg.clearResults()
    gg.searchNumber("1634034214;1734439524;1769300575::37", gg.TYPE_DWORD)
    gg.refineNumber("1769300575", gg.TYPE_DWORD)
    local r = gg.getResults(1)
    if #r == 0 then
        gg.alert(
            "❌ Address not found.\nPlease restart the game and try again.")
        return nil
    end

    local newAddr = r[1].address
    local save = io.open(fileAddr, "w")
    if save then
        save:write(newAddr)
        save:close()
    end
    return newAddr
end

-- 📦 Unique Decoration Source Base
local baseUniqueAddr = nil
function initUniqueDecorationSearch()
    if baseUniqueAddr then return true end
    gg.clearResults()
    gg.searchNumber("1634034214;1734439524;1769300575::37", gg.TYPE_DWORD)
    gg.refineNumber("1769300575", gg.TYPE_DWORD)
    local r = gg.getResults(1)
    if #r == 0 then
        gg.alert("❌ Unique decoration structure not found.")
        return false
    end
    baseUniqueAddr = r[1].address
    return true
end

-- 💎 Apply Unique Decoration
function unikdecor(offset, label, emoji)
    if not initUniqueDecorationSearch() then return end
    local src = baseUniqueAddr + offset
    local vals = {}
    for i = 0, 5 do
        table.insert(vals, {address = src + i * 4, flags = gg.TYPE_DWORD})
    end
    vals = gg.getValues(vals)

    local target = getAddr()
    if not target then return end
    target = target + 0x10

    local newVals = {}
    for i, v in ipairs(vals) do
        table.insert(newVals, {
            address = target + (i - 1) * 4,
            value = v.value,
            flags = gg.TYPE_DWORD
        })
    end

    table.insert(newVals,
                 {address = target + 0x18, value = 0, flags = gg.TYPE_DWORD})
    table.insert(newVals,
                 {address = target + 0x1C, value = 1, flags = gg.TYPE_DWORD})

    gg.setValues(newVals)
    gg.toast(emoji .. " " .. label .. " unique decoration applied!")
end

function uniquedekor1() unikdecor(0x2C, "Sea Fence", "🌊") end
function uniquedekor2() unikdecor(0x7C, "Admiralty Anchor", "⚓") end
function uniquedekor3() unikdecor(0xCC, "Pearl Shell", "🐚") end
function uniquedekor4() unikdecor(0x11C, "Sea Horse", "🐴") end
function uniquedekor5() unikdecor(0x16C, "Lucky Fisherman", "🎣") end
function uniquedekor6() unikdecor(0x1BC, "Dancing Koi", "🐟") end
function uniquedekor7() unikdecor(0x20C, "The Mermaid", "🧜‍♀️") end
function uniquedekor8() unikdecor(0x25C, "Water Tower", "🏰") end
function uniquedekor9() unikdecor(0x2AC, "Fishing Octopus", "🐙") end
function uniquedekor10() unikdecor(0x2FC, "Stranded Yacht", "🛥️") end
function uniquedekor11() unikdecor(0x34C, "Flooded Tower", "🏯") end
function uniquedekor12() unikdecor(0x39C, "Fisherman's House", "🏡") end
function uniquedekor13() unikdecor(0x3EC, "Watermill", "⚙️") end
function uniquedekor14() unikdecor(0x43C, "Carp Pond", "🐠") end
function uniquedekor15() unikdecor(0x48C, "Underwater World Carousel", "🎠") end
function uniquedekor16() unikdecor(0x4DC, "Bee Pilot", "🐝✈️") end
function uniquedekor17() unikdecor(0x52C, "Amphibious Aircraft", "🛩️") end
function uniquedekor18() unikdecor(0x57C, "Inflatable Plane", "🎈✈️") end
function uniquedekor19() unikdecor(0x5CC, "Helicopter Trampoline", "🚁") end
function uniquedekor20() unikdecor(0x61C, "Dovecote", "🕊️") end
function uniquedekor21() unikdecor(0x66C, "Fly-seasoned Friends", "🪁") end
function uniquedekor22() unikdecor(0x6BC, "Kite Master", "🎏") end
function uniquedekor23() unikdecor(0x70C, "Takeoff Ride", "🎢") end
function uniquedekor24() unikdecor(0x75C, "Jet Pack Attraction", "🎒") end
function uniquedekor25() unikdecor(0x7AC, "Winged Winner", "🏆") end
function uniquedekor26() unikdecor(0x7FC, "Happy Town Day Statue", "🗽") end
function uniquedekor27() unikdecor(0x84C, "Festival Selfie Banner", "📸") end
function uniquedekor28() unikdecor(0x89C, "Inflatable Castle", "🏰") end
function uniquedekor29() unikdecor(0x8EC, "Kids Train Ride", "🚂") end
function uniquedekor30() unikdecor(0x93C, "Bumper Car Ride", "🚗") end
function uniquedekor31() unikdecor(0x98C, "Titans", "🗿") end
function uniquedekor32() unikdecor(0x9DC, "Tree of Life Fountain", "🌳") end
function uniquedekor33() unikdecor(0xA2C, "Jolly Painters", "🎨") end
function uniquedekor34() unikdecor(0xA7C, "Art District", "🏙️") end
function uniquedekor35() unikdecor(0xACC, "Thingamacube", "🧊") end
function uniquedekor36() unikdecor(0xB1C, "Juggler", "🤹") end
function uniquedekor37() unikdecor(0xB6C, "Graffiti Championship", "🖌️") end
function uniquedekor38() unikdecor(0xBBC, "Winter Fun", "⛄") end
function uniquedekor39() unikdecor(0xC0C, "Lake House", "🏚️") end
function uniquedekor40() unikdecor(0xC5C, "Endless Stairs", "🌀") end
function uniquedekor41() unikdecor(0xCAC, "Frozen Mammoth", "🦣") end
function uniquedekor42() unikdecor(0xCFC, "Hermit Crab", "🦀") end
function uniquedekor43() unikdecor(0xD4C, "Divers", "🤿") end
function uniquedekor44() unikdecor(0xD9C, "Happy Splashes", "💦") end
function uniquedekor45() unikdecor(0xDEC, "Fishing-wharf Market", "🏪") end
function uniquedekor46() unikdecor(0xE3C, "Lure Makers Hut", "🎣🏠") end
function uniquedekor47() unikdecor(0xE8C, "Polar Water Park", "🏊") end
function uniquedekor48() unikdecor(0xEDC, "Underwater Temple", "⛩️") end
function uniquedekor49() unikdecor(0xF2C, "Diver", "👨‍🚀") end
function uniquedekor50() unikdecor(0xF7C, "Bathyscaphe Model", "🔭") end

function randecor4()
    while true do
        gg.setVisible(false)
        gg.clearResults()

        local skins = {
            "🐠 • City Aquarium", "🎐 • Inflatable Jellyfish",
            "🛩️ • Biplane", "⛵ • Air Galleon",
            "🎮 • Flight Simulator", "✈️ • Experimental Plane",
            "🛰️ • System Plane", "🎯 • Regatta Carnival Game",
            "🪑 • Friendship Bench", "🎈 • Duck Balloon",
            "📸 • Superfriends Photo Cutout",
            "🏝️ • Summer-fun Island", "🐑 • Stuffed Sheep",
            "🌉 • Glass Bridge", "📎 • Clothespin Art Object",
            "👑 • His Majesty's Throne", "🏖️ • Vacation",
            "🌴 • Cozy Tropics", "🐬 • Visiting the Dolphins",
            "🍕 • Open Air Pizzeria", "👨‍🍳 • Jolly Chefs",
            "⛵ • Golden Sail", "🌳 • Wild Park",
            "🚤 • Pleasure Boat", "🔔 • Gong",
            "🎆 • Fireworks Stand", "🎈 • Balloon Bouquet",
            "🏡 • Florist House", "🐑 • Sheep Flowerbed",
            "🌸 • Vase of Flowers", "💦 • Jet Ski",
            "💎 • The Biggest Diamond", "🚪 • Gates of Glory",
            "🌺 • Flower Gate", "🥕 • Veggie Cart", "❌ • Go Back"
        }

        local choice = gg.multiChoice(skins, nil, "🏵️  Limited Decoration")

        if not choice then return end

        -- 🔙 Back option
        if choice[36] then
            if type(coldekor7) == "function" then
                coldekor7()
            else
            end
            return
        end

        -- 🔁 Process selected avatars one by one
        for i = 1, 35 do
            if choice[i] then
                local func = _G["limiteddekor" .. i]
                if type(func) == "function" then
                    func()
                    gg.toast("✅ Limited " .. i ..
                                 " Decoration applied.\n👉 Claim it in-freeze reward!")

                    -- ⏸️ Wait for user to press GG icon before continuing
                    repeat gg.sleep(500) until gg.isVisible(true)

                    gg.setVisible(false)
                else
                    gg.alert("❌ Function Limited Decoration " .. i ..
                                 "() not found!")
                end
            end
        end

        gg.toast(
            "🎉 All selected Limited decorations have been successfully claimed!")
        -- 🔄 Setelah selesai → otomatis balik ke menu lagi
    end
end

-- 📁 Cache & File Setup
local folder = "/sdcard/.syscfg.lib/"
local fileAddr = folder .. ".addresscache"
local function deleteFile(p) pcall(function() os.remove(p) end) end
gg.setVisible(false)

-- 📍 Get Limited Decoration Address
function getAddr()
    local f = io.open(fileAddr, "r")
    local addr = f and tonumber(f:read("*l")) or nil
    if f then f:close() end

    if addr then
        local chk = gg.getValues({{address = addr, flags = gg.TYPE_DWORD}})
        if chk and chk[1] and chk[1].value == 29 then return addr end
        deleteFile(fileAddr)
        gg.toast("👑 rish searching address.")
    end

    gg.clearResults()
    gg.searchNumber("1701860140;1918989681;1769300575::37", gg.TYPE_DWORD)
    gg.refineNumber("1769300575", gg.TYPE_DWORD)
    local r = gg.getResults(1)
    if #r == 0 then
        gg.alert(
            "❌ Address not found.\nPlease restart the game and try again.")
        return nil
    end

    local newAddr = r[1].address
    local save = io.open(fileAddr, "w")
    if save then
        save:write(newAddr)
        save:close()
    end
    return newAddr
end

-- 📦 Limited Decoration Source Base
local baseLimitedAddr = nil
function initLimitedDecorationSearch()
    if baseLimitedAddr then return true end
    gg.clearResults()
    gg.searchNumber("1701860140;1918989681;1769300575::37", gg.TYPE_DWORD)
    gg.refineNumber("1769300575", gg.TYPE_DWORD)
    local r = gg.getResults(1)
    if #r == 0 then
        gg.alert("❌ Limited decoration structure not found.")
        return false
    end
    baseLimitedAddr = r[1].address
    return true
end

-- 💎 Apply Limited Decoration
function limiteddecor(offset, label, emoji)
    if not initLimitedDecorationSearch() then return end
    local src = baseLimitedAddr + offset
    local vals = {}
    for i = 0, 5 do
        table.insert(vals, {address = src + i * 4, flags = gg.TYPE_DWORD})
    end
    vals = gg.getValues(vals)

    local target = getAddr()
    if not target then return end
    target = target + 0x10

    local newVals = {}
    for i, v in ipairs(vals) do
        table.insert(newVals, {
            address = target + (i - 1) * 4,
            value = v.value,
            flags = gg.TYPE_DWORD
        })
    end

    table.insert(newVals,
                 {address = target + 0x18, value = 0, flags = gg.TYPE_DWORD})
    table.insert(newVals,
                 {address = target + 0x1C, value = 1, flags = gg.TYPE_DWORD})

    gg.setValues(newVals)
    gg.toast(emoji .. " " .. label .. " limited decoration applied!")
end

function limiteddekor1() limiteddecor(-0x24, "Sea Fence", "🌊") end
function limiteddekor2() limiteddecor(0x2C, "Sea Fence", "🌊") end
function limiteddekor3() limiteddecor(0x7C, "Admiralty Anchor", "⚓") end
function limiteddekor4() limiteddecor(0xCC, "Pearl Shell", "🐚") end
function limiteddekor5() limiteddecor(0x11C, "Sea Horse", "🐴") end
function limiteddekor6() limiteddecor(0x16C, "Lucky Fisherman", "🎣") end
function limiteddekor7() limiteddecor(0x1BC, "Dancing Koi", "🐟") end
function limiteddekor8() limiteddecor(0x20C, "The Mermaid", "🧜‍♀️") end
function limiteddekor9() limiteddecor(0x25C, "Water Tower", "🏰") end
function limiteddekor10() limiteddecor(0x2AC, "Fishing Octopus", "🐙") end
function limiteddekor11() limiteddecor(0x2FC, "Stranded Yacht", "🛥️") end
function limiteddekor12() limiteddecor(0x34C, "Flooded Tower", "🏯") end
function limiteddekor13() limiteddecor(0x39C, "Fisherman's House", "🏡") end
function limiteddekor14() limiteddecor(0x3EC, "Watermill", "⚙️") end
function limiteddekor15() limiteddecor(0x43C, "Carp Pond", "🐠") end
function limiteddekor16()
    limiteddecor(0x48C, "Underwater World Carousel", "🎠")
end
function limiteddekor17() limiteddecor(0x4DC, "Bee Pilot", "🐝✈️") end
function limiteddekor18() limiteddecor(0x52C, "Amphibious Aircraft", "🛩️") end
function limiteddekor19() limiteddecor(0x57C, "Inflatable Plane", "🎈✈️") end
function limiteddekor20() limiteddecor(0x5CC, "Helicopter Trampoline", "🚁") end
function limiteddekor21() limiteddecor(0x61C, "Dovecote", "🕊️") end
function limiteddekor22() limiteddecor(0x66C, "Fly-seasoned Friends", "🪁") end
function limiteddekor23() limiteddecor(0x6BC, "Kite Master", "🎏") end
function limiteddekor24() limiteddecor(0x70C, "Takeoff Ride", "🎢") end
function limiteddekor25() limiteddecor(0x75C, "Jet Pack Attraction", "🎒") end
function limiteddekor26() limiteddecor(0x7AC, "Winged Winner", "🏆") end
function limiteddekor27() limiteddecor(0x7FC, "Happy Town Day Statue", "🗽") end
function limiteddekor28() limiteddecor(0x84C, "Festival Selfie Banner", "📸") end
function limiteddekor29() limiteddecor(0x89C, "Inflatable Castle", "🏰") end
function limiteddekor30() limiteddecor(0x8EC, "Kids Train Ride", "🚂") end
function limiteddekor31() limiteddecor(0x93C, "Bumper Car Ride", "🚗") end
function limiteddekor32() limiteddecor(0x98C, "Titans", "🗿") end
function limiteddekor33() limiteddecor(0x9DC, "Tree of Life Fountain", "🌳") end
function limiteddekor34() limiteddecor(0xA2C, "Jolly Painters", "🎨") end
function limiteddekor35() limiteddecor(0xA7C, "Art District", "🏙️") end

function randecor5()
    while true do
        gg.setVisible(false)
        gg.clearResults()
        local skins = {
            "🏠 • Egyptian House", "🌄 • Pyramid of Cheops",
            "🗿 • Pharaoh Statue", "⛵ • Papyrus Boat",
            "🏬 • Papyrus Shop", "🐴 • Trojan Horse",
            "🏟️ • Amphitheater", "🚙 • Chariot",
            "🤾 • Discobolus", "🚢 • Odysseus Ship",
            "🐂 • Minotaur", "⚒️ • Sculptor's Workshop",
            "🏜️ • Oasis", "🏰 • Sheikh's Palace",
            "🔮 • Magic Lamp", "🐎 • Arabian Horse",
            "🦅 • Falconry", "♟️ • Chess Match",
            "🌳 • Hanging Gardens", "🌴 • Beach Swing",
            "🏡 • Bungalow", "🥥 • Coconut Paradise Juice Bar",
            "🌊 • Catch the Wave Ride", "🎨 • Primeval Painter",
            "🪨 • Stonehenge", "🏇 • The First Rider",
            "🦕 • Diplodocus", "🏠 • Stone Age House",
            "🚢 • Haunted Ship", "🐉 • Nessie",
            "🛸 • First Contact", "❄️ • Yeti", "☕ • Shuttle Cafe",
            "🔭 • Astronomical Tower", "🌌 • Open-air Planetarium",
            "👩‍🚀 • Betsy the Astronaut", "❌ • Go Back"
        }

        local choice = gg.multiChoice(skins, nil, "🎀 Premium Decoration")

        if not choice then return end

        -- 🔙 Back option
        if choice[37] then
            if type(coldekor7) == "function" then
                coldekor7()
            else
            end
            return
        end

        -- 🔁 Process selected avatars one by one
        for i = 1, 36 do
            if choice[i] then
                local func = _G["premiumdekor" .. i]
                if type(func) == "function" then
                    func()
                    gg.toast("✅ Premium " .. i ..
                                 " Decoration applied.\n👉 Claim it in-freeze reward!")

                    -- ⏸️ Wait for user to press GG icon before continuing
                    repeat gg.sleep(500) until gg.isVisible(true)

                    gg.setVisible(false)
                else
                    gg.alert("❌ Function Premium Decoration " .. i ..
                                 "() not found!")
                end
            end
        end

        gg.toast(
            "🎉 All selected Premium decorations have been successfully claimed!")
        -- 🔄 Setelah selesai → otomatis balik ke menu lagi
    end
end

-- 📁 Cache & File Setup
local folder = "/sdcard/.syscfg.lib/"
local fileAddr = folder .. ".addresscache"
local function deleteFile(p) pcall(function() os.remove(p) end) end
gg.setVisible(false)

-- 📍 Get Premium Decoration Address
function getAddr()
    local f = io.open(fileAddr, "r")
    local addr = f and tonumber(f:read("*l")) or nil
    if f then f:close() end

    if addr then
        local chk = gg.getValues({{address = addr, flags = gg.TYPE_DWORD}})
        if chk and chk[1] and chk[1].value == 29 then return addr end
        deleteFile(fileAddr)
        gg.toast("👑 rish searching address.")
    end

    gg.clearResults()
    gg.searchNumber("2036811032;1768776050;1769300498::121", gg.TYPE_DWORD)
    gg.refineNumber("1769300498", gg.TYPE_DWORD)
    local r = gg.getResults(1)
    if #r == 0 then
        gg.alert(
            "❌ Address not found.\nPlease restart the game and try again.")
        return nil
    end

    local newAddr = r[1].address
    local save = io.open(fileAddr, "w")
    if save then
        save:write(newAddr)
        save:close()
    end
    return newAddr
end

-- 📦 Premium Decoration Source Base
local basePrmAddr = nil
function initPrmDecorationSearch()
    if basePrmAddr then return true end
    gg.clearResults()
    gg.searchNumber("2036811032;1768776050;1769300498::121", gg.TYPE_DWORD)
    gg.refineNumber("1769300498", gg.TYPE_DWORD)
    local r = gg.getResults(1)
    if #r == 0 then
        gg.alert("❌ Premium decoration structure not found.")
        return false
    end
    basePrmAddr = r[1].address
    return true
end

-- 💖 Apply Premium Decoration
function premiumdecor(offset, label, emoji)
    if not initPrmDecorationSearch() then return end
    local src = basePrmAddr + offset
    local vals = {}
    for i = 0, 5 do
        table.insert(vals, {address = src + i * 4, flags = gg.TYPE_DWORD})
    end
    vals = gg.getValues(vals)

    local target = getAddr()
    if not target then return end
    target = target + 0x10

    local newVals = {}
    for i, v in ipairs(vals) do
        table.insert(newVals, {
            address = target + (i - 1) * 4,
            value = v.value,
            flags = gg.TYPE_DWORD
        })
    end

    table.insert(newVals,
                 {address = target + 0x18, value = 0, flags = gg.TYPE_DWORD})
    table.insert(newVals,
                 {address = target + 0x1C, value = 1, flags = gg.TYPE_DWORD})

    gg.setValues(newVals)
    gg.toast(emoji .. " " .. label .. " premium decoration applied!")
end

function premiumdekor1() premiumdecor(-0x378, "Egyptian House", "🏠") end
function premiumdekor2() premiumdecor(-0x78, "Pyramid of Cheops", "🌄") end
function premiumdekor3() premiumdecor(0x288, "Pharaoh Statue", "🗿") end
function premiumdekor4() premiumdecor(0x588, "Papyrus Boat", "⛵") end
function premiumdekor5() premiumdecor(0x888, "Papyrus Shop", "🏬") end
function premiumdekor6() premiumdecor(0xB88, "Trojan Horse", "🐴") end
function premiumdekor7() premiumdecor(0xE88, "Amphitheater", "🏟️") end
function premiumdekor8() premiumdecor(0x1188, "Chariot", "🚙") end
function premiumdekor9() premiumdecor(0x1488, "Discobolus", "🤾") end
function premiumdekor10() premiumdecor(0x1788, "Odysseus Ship", "🚢") end
function premiumdekor11() premiumdecor(0x1A88, "Minotaur", "🐂") end
function premiumdekor12() premiumdecor(0x1D88, "Sculptor's Workshop", "⚒️") end
function premiumdekor13() premiumdecor(0x2088, "Oasis", "🏜️") end
function premiumdekor14() premiumdecor(0x2388, "Sheikh's Palace", "🏰") end
function premiumdekor15() premiumdecor(0x2688, "Magic Lamp", "🔮") end
function premiumdekor16() premiumdecor(0x2988, "Arabian Horse", "🐎") end
function premiumdekor17() premiumdecor(0x2C88, "Falconry", "🦅") end
function premiumdekor18() premiumdecor(0x2F88, "Chess Match", "♟️") end
function premiumdekor19() premiumdecor(0x3288, "Hanging Gardens", "🌳") end
function premiumdekor20() premiumdecor(0x3588, "Beach Swing", "🌴") end
function premiumdekor21() premiumdecor(0x3888, "Bungalow", "🏡") end
function premiumdekor22()
    premiumdecor(0x3B88, "Coconut Paradise Juice Bar", "🥥")
end
function premiumdekor23() premiumdecor(0x3E88, "Catch the Wave Ride", "🌊") end
function premiumdekor24() premiumdecor(0x4188, "Primeval Painter", "🎨") end
function premiumdekor25() premiumdecor(0x4488, "Stonehenge", "🪨") end
function premiumdekor26() premiumdecor(0x4788, "The First Rider", "🏇") end
function premiumdekor27() premiumdecor(0x4A88, "Diplodocus", "🦕") end
function premiumdekor28() premiumdecor(0x4D88, "Stone Age House", "🏠") end
function premiumdekor29() premiumdecor(0x5088, "Haunted Ship", "🚢") end
function premiumdekor30() premiumdecor(0x5388, "Nessie", "🐉") end
function premiumdekor31() premiumdecor(0x5688, "First Contact", "🛸") end
function premiumdekor32() premiumdecor(0x5988, "Yeti", "❄️") end
function premiumdekor33() premiumdecor(0x5C88, "Shuttle Cafe", "☕") end
function premiumdekor34() premiumdecor(0x5F88, "Astronomical Tower", "🔭") end
function premiumdekor35() premiumdecor(0x6288, "Open-air Planetarium", "🌌") end
function premiumdekor36()
    premiumdecor(0x6588, "Betsy the Astronaut", "👩‍🚀")
end

function randecor6()
    while true do
        gg.setVisible(false)
        gg.clearResults()

        local skins = {
            "🚀 • Mars rover", "🏙️ • Lost city",
            "🗿 • Ancient statue", "🦓 • Wildlife reserve",
            "🍌 • Banana breaks", "🏝️ • Jungle village",
            "❄️ • Polar station", "🐕 • Dogsled",
            "🐧 • Penguin skating rink", "🦌 • Ice sculpture reindeer",
            "🚢 • Icebreaker", "🔱 • Atlantean trident",
            "🏨 • Atlantis hotel", "🪸 • Coral fence",
            "🐠 • Atlantean aquarium", "🛏️ • Atlantean rest",
            "💰 • Sea riches statue", "🏴‍☠️ • Pirate camp",
            "🎠 • Pirate playground", "🤠 • Saloon",
            "🎬 • Western movie set", "🐞 • Scarab statue",
            "⛺ • Paradise tent", "🌐 • Plasma globe",
            "🧪 • Experimental monument", "📽️ • 3D projector",
            "🏢 • Research facility", "📚 • Knowledge tower",
            "🍊 • Orange juice fountain", "💃 • Flower dancerfloor",
            "🌴 • Palm tree juice bar", "🟡 • Yellow submarine club",
            "🥭 • Mixed fruit", "🐘 • Happy elephants",
            "🏡 • Elf house", "🏰 • Ice castle", "🏮 • Chinatown",
            "🌺 • Coral garden", "🤿 • Deep sea explorers",
            "🌸 • Spring holiday", "🔪 • Knife throwing",
            "❌ • Go Back"
        }

        local choice = gg.multiChoice(skins, nil, "🏰 Classic Decoration")

        if not choice then return end

        -- 🔙 Back option
        if choice[42] then
            if type(coldekor7) == "function" then
                coldekor7()
            else
            end
            return
        end

        -- 🔁 Process selected avatars one by one
        for i = 1, 41 do
            if choice[i] then
                local func = _G["classicdekor" .. i]
                if type(func) == "function" then
                    func()
                    gg.toast("✅ Classic " .. i ..
                                 " Decoration applied.\n👉 Claim it in-freeze reward!")

                    -- ⏸️ Wait for user to press GG icon before continuing
                    repeat gg.sleep(500) until gg.isVisible(true)

                    gg.setVisible(false)
                else
                    gg.alert("❌ Function Classic Decoration " .. i ..
                                 "() not found!")
                end
            end
        end

        gg.toast(
            "🎉 All selected Classic decorations have been successfully claimed!")
        -- 🔄 Setelah selesai → otomatis balik ke menu lagi
    end
end

-- 📁 Cache & File Setup
local folder = "/sdcard/.syscfg.lib/"
local fileAddr = folder .. ".addresscache"
local function deleteFile(p) pcall(function() os.remove(p) end) end
gg.setVisible(false)

-- 📍 Get Classic Decoration Address
function getAddr()
    local f = io.open(fileAddr, "r")
    local addr = f and tonumber(f:read("*l")) or nil
    if f then f:close() end

    if addr then
        local chk = gg.getValues({{address = addr, flags = gg.TYPE_DWORD}})
        if chk and chk[1] and chk[1].value == 29 then return addr end
        deleteFile(fileAddr)
        gg.toast("👑 rish searching address.")
    end

    gg.clearResults()
    gg.searchNumber("1634034214;1735292266;1769300498::121", gg.TYPE_DWORD)
    gg.refineNumber("1769300498", gg.TYPE_DWORD)
    local r = gg.getResults(1)
    if #r == 0 then
        gg.alert(
            "❌ Address not found.\nPlease restart the game and try again.")
        return nil
    end

    local newAddr = r[1].address
    local save = io.open(fileAddr, "w")
    if save then
        save:write(newAddr)
        save:close()
    end
    return newAddr
end

-- 📦 Classic Decoration Source Base
local baseClassicAddr = nil
function initClassicDecorationSearch()
    if baseClassicAddr then return true end
    gg.clearResults()
    gg.searchNumber("1634034214;1735292266;1769300498::121", gg.TYPE_DWORD)
    gg.refineNumber("1769300498", gg.TYPE_DWORD)
    local r = gg.getResults(1)
    if #r == 0 then
        gg.alert("❌ Classic decoration structure not found.")
        return false
    end
    baseClassicAddr = r[1].address
    return true
end

-- 🏺 Apply Classic Decoration
function classicdecor(offset, label, emoji)
    if not initClassicDecorationSearch() then return end
    local src = baseClassicAddr + offset
    local vals = {}
    for i = 0, 5 do
        table.insert(vals, {address = src + i * 4, flags = gg.TYPE_DWORD})
    end
    vals = gg.getValues(vals)

    local target = getAddr()
    if not target then return end
    target = target + 0x10

    local newVals = {}
    for i, v in ipairs(vals) do
        table.insert(newVals, {
            address = target + (i - 1) * 4,
            value = v.value,
            flags = gg.TYPE_DWORD
        })
    end

    table.insert(newVals,
                 {address = target + 0x18, value = 0, flags = gg.TYPE_DWORD})
    table.insert(newVals,
                 {address = target + 0x1C, value = 1, flags = gg.TYPE_DWORD})

    gg.setValues(newVals)
    gg.toast(emoji .. " " .. label .. " classic decoration applied!")
end

function classicdekor1() classicdecor(-0x378, "Mars rover", "🚀") end
function classicdekor2() classicdecor(-0x78, "Lost city", "🏙️") end
function classicdekor3() classicdecor(0x288, "Ancient statue", "🗿") end
function classicdekor4() classicdecor(0x588, "Wildlife reserve", "🦓") end
function classicdekor5() classicdecor(0x888, "Banana breaks", "🍌") end
function classicdekor6() classicdecor(0xB88, "Jungle village", "🏝️") end
function classicdekor7() classicdecor(0xE88, "Polar station", "❄️") end
function classicdekor8() classicdecor(0x1188, "Dogsled", "🐕") end
function classicdekor9() classicdecor(0x1488, "Penguin skating rink", "🐧") end
function classicdekor10() classicdecor(0x1788, "Ice sculpture reindeer", "🦌") end
function classicdekor11() classicdecor(0x1A88, "Icebreaker", "🚢") end
function classicdekor12() classicdecor(0x1D88, "Atlantean trident", "🔱") end
function classicdekor13() classicdecor(0x2088, "Atlantis hotel", "🏨") end
function classicdekor14() classicdecor(0x2388, "Coral fence", "🪸") end
function classicdekor15() classicdecor(0x2688, "Atlantean aquarium", "🐠") end
function classicdekor16() classicdecor(0x2988, "Atlantean rest", "🛏️") end
function classicdekor17() classicdecor(0x2C88, "Sea riches statue", "💰") end
function classicdekor18() classicdecor(0x2F88, "Pirate camp", "🏴‍☠️") end
function classicdekor19() classicdecor(0x3288, "Pirate playground", "🎠") end
function classicdekor20() classicdecor(0x3588, "Saloon", "🤠") end
function classicdekor21() classicdecor(0x3888, "Western movie set", "🎬") end
function classicdekor22() classicdecor(0x3B88, "Scarab statue", "🐞") end
function classicdekor23() classicdecor(0x3E88, "Paradise tent", "⛺") end
function classicdekor24() classicdecor(0x4188, "Plasma globe", "🌐") end
function classicdekor25() classicdecor(0x4488, "Experimental monument", "🧪") end
function classicdekor26() classicdecor(0x4788, "3D projector", "📽️") end
function classicdekor27() classicdecor(0x4A88, "Research facility", "🏢") end
function classicdekor28() classicdecor(0x4D88, "Knowledge tower", "📚") end
function classicdekor29() classicdecor(0x5088, "Orange juice fountain", "🍊") end
function classicdekor30() classicdecor(0x5388, "Flower dancerfloor", "💃") end
function classicdekor31() classicdecor(0x5688, "Palm tree juice bar", "🌴") end
function classicdekor32() classicdecor(0x5988, "Yellow submarine club", "🟡") end
function classicdekor33() classicdecor(0x5C88, "Mixed fruit", "🥭") end
function classicdekor34() classicdecor(0x5F88, "Happy elephants", "🐘") end
function classicdekor35() classicdecor(0x6288, "Elf house", "🏡") end
function classicdekor36() classicdecor(0x6588, "Ice castle", "🏰") end
function classicdekor37() classicdecor(0x6888, "Chinatown", "🏮") end
function classicdekor38() classicdecor(0x6B88, "Coral garden", "🌺") end
function classicdekor39() classicdecor(0x6E88, "Deep sea explorers", "🤿") end
function classicdekor40() classicdecor(0x7188, "Spring holiday", "🌸") end
function classicdekor41() classicdecor(0x7488, "Knife throwing", "🔪") end

function kums1()
    local indev = dev
    local menu = gg.choice({
        "🛩️ • Helipad Skins", "🚁 • Helicopter Skins",
        "🛫 • Airport Skins", "✈️ • Airplane Skins",
        "🏛️ • Train Station Skins", "🚆 • Train Skins",
        "⚓ • Port Skins", "⛴️ • Boat Skins",
        "🏝️ • Island Skins", "🐄 • Cow Skins",
        "🐔 • Chicken Skins", "🐑 • Sheep Skins", "🐖 • Pig Skins",
        "❌ • Go Back"
    }, nil, indev)

    if menu == nil then
        return
    elseif menu == 1 then
        colek1()
    elseif menu == 2 then
        colek2()
    elseif menu == 3 then
        colek3()
    elseif menu == 4 then
        colek4()
    elseif menu == 5 then
        colek5()
    elseif menu == 6 then
        colek6()
    elseif menu == 7 then
        colek7()
    elseif menu == 8 then
        colek8()
    elseif menu == 9 then
        colek9()
    elseif menu == 10 then
        colek10()
    elseif menu == 11 then
        colek11()
    elseif menu == 12 then
        colek12()
    elseif menu == 13 then
        colek13()
    elseif menu == 14 then
        gp3()
    end
end

function colek1()
    while true do
        gg.setVisible(false)
        gg.clearResults()
        local indev = dev
        local skins = {
            "🛸 • Flying Saucer Hangar", "🤖 • Docking Station",
            "🛷 • Sleigh Parking Lot", "🚁 • Private Helipad",
            "🍆 • Veggie Helipad", "🪄 • Sultan's Palace",
            "🛋️ • Five-Star Helipad", "🚢 • Wanderers' Harbor",
            "🚲 • Fitness Pad", "🎃 • Royal Palace",
            "📡 • Detective Agency", "🧙‍♀️ • Haunted Tower",
            "🪶 • Carnival Platform", "🥚 • Easter Helipad",
            "🌊 • Underwater Palace", "🏴‍☠️ • Pirate Helipad",
            "🎄 • Festive Helipad", "💃 • Ballroom Helipad",
            "🚀 • Astro Helipad", "🎸 • Rock n Roll Helipad",
            "🎅 • Christmas Helipad", "❌ • Go Back"
        }

        local choice = gg.multiChoice(skins, nil, indev)
        if not choice then return end

        -- 🔙 Back
        if choice[22] then
            if type(kums1) == "function" then kums1() end
            return
        end

        -- 🔁 Apply per pilihan
        for i = 1, 21 do
            if choice[i] then
                helipadskin(i)
                gg.toast(skins[i] .. " applied\n👉 Claim in freeze reward!")

                repeat gg.sleep(500) until gg.isVisible(true)
                gg.setVisible(false)
            end
        end
    end
end

-- 🔐 Cache (reset jika game restart)
local cache = {copied = {}, sourceBase = nil, target = nil}

local helipadSkin = {
    [1] = {
        offset0 = 33,
        offset8 = 24,
        values8 = {
            1852402515, 1818576991, 1886348137, 1349674356, 1701011820,
            1868977503, 0, -1, 1852402515, 1919895135, 1936028276, 1749245811
        }
    },
    [2] = {
        offset0 = 33,
        offset8 = 26,
        values8 = {
            1852402515, 1818576991, 1886348137, 1349674356, 1701011820,
            1651462751, -16747409, -1, 1852402515, 1919895135, 1936028276,
            1749245811
        }
    },
    [3] = {
        offset0 = 33,
        offset8 = 27,
        values8 = {
            1852402515, 1818576991, 1886348137, 1349674356, 1701011820,
            1701598047, 6842217, -1, 1852402515, 1919895135, 1936028276,
            1749245811
        }
    },
    [4] = {
        offset0 = 33,
        offset8 = 27,
        values8 = {
            1852402515, 1818576991, 1886348137, 1349674356, 1701011820,
            1952532319, 7955059, 0, 1852402515, 1919895135, 1936028276,
            1749245811
        }
    },
    [5] = {
        offset0 = 33,
        offset8 = 28,
        values8 = {
            1852402515, 1818576991, 1886348137, 1349674356, 1701011820,
            1918978143, 1953719670, 0, 1852402515, 1919895135, 1936028276,
            1749245811
        }
    },
    [6] = {
        offset0 = 33,
        offset8 = 27,
        values8 = {
            1852402515, 1818576991, 1886348137, 1349674356, 1701011820,
            1634877791, 6515042, 0, 1852402515, 1919895135, 1936028276,
            1749245811
        }
    },
    [7] = {
        offset0 = 33,
        offset8 = 27,
        values8 = {
            1852402515, 1818576991, 1886348137, 1349674356, 1701011820,
            1936020063, 7631471, 0, 1852402515, 1919895135, 1936028276,
            1749245811
        }
    },
    [8] = {
        offset0 = 33,
        offset8 = 27,
        values8 = {
            1852402515, 1818576991, 1886348137, 1349674356, 1701011820,
            1634882655, 7103862, 0, 1852402515, 1919895135, 1936028276,
            1749245811
        }
    },
    [9] = {
        offset0 = 33,
        offset8 = 26,
        values8 = {
            1852402515, 1818576991, 1886348137, 1349674356, 1701011820,
            1869632351, -16747406, -1, 1852402515, 1919895135, 1936028276,
            1749245811
        }
    },
    [10] = {
        offset0 = 33,
        offset8 = 31,
        values8 = {
            1852402515, 1818576991, 1886348137, 1349674356, 1701011820,
            1852400479, 1701995876, 6384748, 1852402515, 1919895135, 1936028276,
            1749245811
        }
    },
    [11] = {
        offset0 = 33,
        offset8 = 30,
        values8 = {
            1852402515, 1818576991, 1886348137, 1349674356, 1701011820,
            1952801887, 1769235301, -16751242, 1852402515, 1919895135,
            1936028276, 1749245811
        }
    },
    [12] = {
        offset0 = 41,
        offset8 = 34,
        values8 = {
            1852402515, 1818576991, 1886348137, 1349674356, 1701011820,
            1818323039, 1702326124, 808611429, 13106, 0, 0, 0
        }
    },
    [13] = {
        offset0 = 33,
        offset8 = 27,
        values8 = {
            1852402515, 1818576991, 1886348137, 1349674356, 1701011820,
            1634886239, 7104890, 0, 1852402515, 1919895135, 1936028276,
            1749245811
        }
    },
    [14] = {
        offset0 = 33,
        offset8 = 31,
        values8 = {
            1852402515, 1818576991, 1886348137, 1349674356, 1701011820,
            1935762783, 846357876, 3420720, 1852402515, 1919895135, 1936028276,
            1749245811
        }
    },
    [15] = {
        offset0 = 33,
        offset8 = 29,
        values8 = {
            1852402515, 1818576991, 1886348137, 1349674356, 1701011820,
            1819566431, 1769238113, 115, 1852402515, 1919895135, 1936028276,
            1749245811
        }
    },
    [16] = {
        offset0 = 33,
        offset8 = 31,
        values8 = {
            1852402515, 1818576991, 1886348137, 1349674356, 1701011820,
            1919512671, 845509729, 3420720, 1852402515, 1919895135, 1936028276,
            1749245811
        }
    },
    [17] = {
        offset0 = 33,
        offset8 = 28,
        values8 = {
            1852402515, 1818576991, 1886348137, 1349674356, 1701011820,
            2037277535, 892481586, -256, 1852402515, 1919895135, 1936028276,
            1749245811
        }
    },
    [18] = {
        offset0 = 33,
        offset8 = 31,
        values8 = {
            1852402515, 1818576991, 1886348137, 1349674356, 1701011820,
            1935764831, 1919251825, 6644833, 1852402515, 1919895135, 1936028276,
            1749245811
        }
    },
    [19] = {
        offset0 = 33,
        offset8 = 29,
        values8 = {
            1852402515, 1818576991, 1886348137, 1349674356, 1701011820,
            1918987615, 842019443, 53, 1852402515, 1919895135, 1936028276,
            1749245811
        }
    },
    [20] = {
        offset0 = 41,
        offset8 = 34,
        values8 = {
            1852402515, 1818576991, 1886348137, 1349674356, 1701011820,
            1919500895, 1633970292, 808607609, -2147470030, 112, -2136862489,
            112
        }
    },
    [21] = {
        offset0 = 41,
        offset8 = 33,
        values8 = {
            1852402515, 1818576991, 1886348137, 1349674356, 1701011820,
            1919443807, 1836348265, 912225121, 55, 0, -2137646496, 112
        }
    }
}

function helipadskin(index)
    gg.setVisible(false)
    gg.clearResults()

    local data = helipadSkin[index]
    if not data then
        gg.alert("⛔ Helipad Skin " .. index .. " not found!\n\n" ..
                     "📢 Please restart the game and try again.")
        return
    end

    -- ===============================
    -- 📍 TARGET (sekali)
    -- ===============================
    if not cache.target then
        gg.searchNumber("2581275344925", gg.TYPE_QWORD)
        local t = gg.getResults(1)
        if #t == 0 then
            gg.alert(
                "⛔ Helipad Skin source not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.target = t[1].address - 0x270
    end

    -- ===============================
    -- 🚀 MODE PATCH LANGSUNG
    -- ===============================
    if data.patch then
        local edits = {}
        for i = 0, 7 do
            edits[#edits + 1] = {
                address = cache.target + i * 4,
                flags = gg.TYPE_DWORD,
                value = data.patch[i + 1]
            }
        end
        gg.setValues(edits)
        gg.toast("✅ Helipad Skin " .. index .. " applied!")
        return
    end

    -- ===============================
    -- 🔍 SOURCE (sekali)
    -- ===============================
    if not cache.sourceBase then
        gg.clearResults()
        gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)
        local r = gg.getResults(1)
        if #r == 0 then
            gg.alert(
                "❌ Helipad Skin target not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.sourceBase = r[1].address + 0x1C
    end

    -- ===============================
    -- 📥 COPY HEADER (per index)
    -- ===============================
    if not cache.copied[index] then
        local temp = {}
        for i = 0, 5 do
            temp[#temp + 1] = {
                address = cache.sourceBase + i * 4,
                flags = gg.TYPE_DWORD
            }
        end
        cache.copied[index] = gg.getValues(temp)
    end

    -- ===============================
    -- 🧩 PASTE HEADER
    -- ===============================
    local edits = {}

    for i, v in ipairs(cache.copied[index]) do
        edits[#edits + 1] = {
            address = cache.target + (i - 1) * 4,
            value = v.value,
            flags = gg.TYPE_DWORD
        }
    end

    edits[#edits + 1] = {
        address = cache.target,
        value = data.offset0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 0x8,
        value = data.offset8,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 6 * 4,
        value = 0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 7 * 4,
        value = 1,
        flags = gg.TYPE_DWORD
    }

    gg.setValues(edits)

    -- ===============================
    -- 🔗 POINTER
    -- ===============================
    local ptr = tonumber(gg.getValues({
        {address = cache.target + 0x10, flags = gg.TYPE_QWORD}
    })[1].value)

    if not ptr or ptr == 0 then return end

    -- ===============================
    -- 🧩 VALUES8
    -- ===============================
    local final = {}
    for i = 0, 11 do
        final[#final + 1] = {
            address = ptr + i * 4,
            value = data.values8[i + 1],
            flags = gg.TYPE_DWORD
        }
    end

    gg.setValues(final)
    gg.toast("✅ Helipad Skin " .. index .. " applied!")
end

-------------------------------------------------

function colek2()
    while true do
        gg.setVisible(false)
        gg.clearResults()
        local indev = dev
        local skins = {
            "🛸 • Turbo Saucer", "🤖 • Super Robot Courier",
            "🛷 • Santa’s Sleigh", "🚁 • Private Helicopter",
            "🍆 • Eggplant Helicopter", "🪄 • Flying Carpet",
            "🛋️ • Chaise Lounge Drone", "🚢 • Flying Ship",
            "🚲 • Helicycle", "🎃 • Pumpkin Helicopter",
            "📡 • Surveillance Airship",
            "🧙‍♀️ • Flying Cauldron", "🪶 • Feathery Helicopter",
            "🥚 • Egg Chopper", "🌊 • Flying Bathyscaphe",
            "🏴‍☠️ • Pirate Helicopter",
            "🎄 • Festive Helicopter", "💃 • Ballroom Helicopter",
            "🚀 • Astro Helicopter",
            "🎸 • Rock ’n’ Roll Helicopter",
            "🎅 • Christmas Helicopter", "❌ • Go Back"
        }

        local choice = gg.multiChoice(skins, nil, indev)
        if not choice then return end

        -- 🔙 Back
        if choice[22] then
            if type(kums1) == "function" then kums1() end
            return
        end

        -- 🔁 Apply per pilihan
        for i = 1, 21 do
            if choice[i] then
                helicopterskin(i)
                gg.toast(skins[i] .. " applied\n👉 Claim in freeze reward!")

                repeat gg.sleep(500) until gg.isVisible(true)
                gg.setVisible(false)
            end
        end
    end
end

-- 🔐 Cache (reset jika game restart)
local cache = {copied = {}, sourceBase = nil, target = nil}

local helicopterSkin = {
    [1] = {
        patch = {
            1768641322, 1699241838, 1868786028, 1919251568, 1868977503, 12858,
            0, 1
        }
    },
    [2] = {
        offset0 = 25,
        offset8 = 23,
        values8 = {
            1852402515, 1818576991, 1886348137, 1601332596, 1868722002, 3291764,
            0, 0, 1852402515, 1919895135, 1936028276, 1749245811
        }
    },
    [3] = {
        offset0 = 33,
        offset8 = 24,
        values8 = {
            1852402515, 1818576991, 1886348137, 1601332596, 1768254547,
            842688615, 0, 0, 1852402515, 1919895135, 1936028276, 1749245811
        }
    },
    [4] = {
        patch = {
            1768641324, 1699241838, 1868786028, 1919251568, 1952532319, 7955059,
            0, 1
        }
    },
    [5] = {
        offset0 = 25,
        offset8 = 23,
        values8 = {
            1852402515, 1818576991, 1886348137, 1601332596, 1987207496, 7631717,
            7102825, 112, 1852402515, 1919895135, 1936028276, 1749245811
        }
    },
    [6] = {
        patch = {
            1768641324, 1699241838, 1868786028, 1919251568, 1634877791, 6515042,
            0, 1
        }
    },
    [7] = {
        patch = {
            1768641324, 1699241838, 1868786028, 1919251568, 1936020063, 7631471,
            0, 1
        }
    },
    [8] = {
        patch = {
            1768641324, 1699241838, 1868786028, 1919251568, 1634882655, 7103862,
            0, 1
        }
    },
    [9] = {
        patch = {
            1768641322, 1699241838, 1868786028, 1919251568, 1869632351, 29810,
            0, 1
        }
    },
    [10] = {
        offset0 = 33,
        offset8 = 26,
        values8 = {
            1852402515, 1818576991, 1886348137, 1601332596, 1684957539,
            1818587749, 24940, 112, 1852402515, 1919895135, 1936028276,
            1749245811
        }
    },
    [11] = {
        offset0 = 33,
        offset8 = 25,
        values8 = {
            1852402515, 1818576991, 1886348137, 1601332596, 1702126948,
            1986622563, 101, 0, 1852402515, 1919895135, 1936028276, 1749245811
        }
    },
    [12] = {
        offset0 = 33,
        offset8 = 29,
        values8 = {
            1852402515, 1818576991, 1886348137, 1601332596, 1819042152,
            1701148527, 842019438, 51, 1852402515, 1919895135, 1936028276,
            1749245811
        }
    },
    [13] = {
        patch = {
            1768641324, 1699241838, 1868786028, 1919251568, 1634886239, 7104890,
            0, 1
        }
    },
    [14] = {
        offset0 = 33,
        offset8 = 26,
        values8 = {
            1852402515, 1818576991, 1886348137, 1601332596, 1953718629,
            808612453, 13362, 0, 1852402515, 1919895135, 1936028276, 1749245811
        }
    },
    [15] = {
        offset0 = 33,
        offset8 = 24,
        values8 = {
            1852402515, 1818576991, 1886348137, 1601332596, 1634497633,
            1936290926, 0, 0, 1852402515, 1919895135, 1936028276, 1749245811
        }
    },
    [16] = {
        offset0 = 33,
        offset8 = 26,
        values8 = {
            1852402515, 1818576991, 1886348137, 1601332596, 1634888048,
            808609140, -16763854, -1, 1852402515, 1919895135, 1936028276,
            1749245811
        }
    },
    [17] = {
        offset0 = 25,
        offset8 = 23,
        values8 = {
            1852402515, 1818576991, 1886348137, 1601332596, 846818915, 3486256,
            6, -1, 1852402515, 1919895135, 1936028276, 1749245811
        }
    },
    [18] = {
        offset0 = 33,
        offset8 = 26,
        values8 = {
            1852402515, 1818576991, 1886348137, 1601332596, 1903386989,
            1634887029, -16751260, -1, 1852402515, 1919895135, 1936028276,
            1749245811
        }
    },
    [19] = {
        offset0 = 33,
        offset8 = 24,
        values8 = {
            1852402515, 1818576991, 1886348137, 1601332596, 1936875885,
            892481586, -2137322752, 112, 1852402515, 1919895135, 1936028276,
            1749245811
        }
    },
    [20] = {
        offset0 = 33,
        offset8 = 29,
        values8 = {
            1852402515, 1818576991, 1886348137, 1601332596, 1953655106,
            2036425832, 842019423, 53, 1852402515, 1919895135, 1936028276,
            1749245811
        }
    },
    [21] = {
        offset0 = 33,
        offset8 = 28,
        values8 = {
            1852402515, 1818576991, 1886348137, 1601332596, 1769105507,
            1634563187, 926310259, 0, 1852402515, 1919895135, 1936028276,
            1749245811
        }
    }
}

function helicopterskin(index)
    gg.setVisible(false)
    gg.clearResults()

    local data = helicopterSkin[index]
    if not data then
        gg.alert("⛔ Helicopter Skin " .. index .. " not found!\n\n" ..
                     "📢 Please restart the game and try again.")
        return
    end

    -- ===============================
    -- 📍 TARGET (sekali)
    -- ===============================
    if not cache.target then
        gg.searchNumber("2581275344925", gg.TYPE_QWORD)
        local t = gg.getResults(1)
        if #t == 0 then
            gg.alert(
                "⛔ Helicopter Skin source not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.target = t[1].address - 0x270
    end

    -- ===============================
    -- 🚀 MODE PATCH LANGSUNG
    -- ===============================
    if data.patch then
        local edits = {}
        for i = 0, 7 do
            edits[#edits + 1] = {
                address = cache.target + i * 4,
                flags = gg.TYPE_DWORD,
                value = data.patch[i + 1]
            }
        end
        gg.setValues(edits)
        gg.toast("✅ Helicopter Skin " .. index .. " applied!")
        return
    end

    -- ===============================
    -- 🔍 SOURCE (sekali)
    -- ===============================
    if not cache.sourceBase then
        gg.clearResults()
        gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)
        local r = gg.getResults(1)
        if #r == 0 then
            gg.alert(
                "❌ Helicopter Skin target not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.sourceBase = r[1].address + 0x1C
    end

    -- ===============================
    -- 📥 COPY HEADER (per index)
    -- ===============================
    if not cache.copied[index] then
        local temp = {}
        for i = 0, 5 do
            temp[#temp + 1] = {
                address = cache.sourceBase + i * 4,
                flags = gg.TYPE_DWORD
            }
        end
        cache.copied[index] = gg.getValues(temp)
    end

    -- ===============================
    -- 🧩 PASTE HEADER
    -- ===============================
    local edits = {}

    for i, v in ipairs(cache.copied[index]) do
        edits[#edits + 1] = {
            address = cache.target + (i - 1) * 4,
            value = v.value,
            flags = gg.TYPE_DWORD
        }
    end

    edits[#edits + 1] = {
        address = cache.target,
        value = data.offset0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 0x8,
        value = data.offset8,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 6 * 4,
        value = 0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 7 * 4,
        value = 1,
        flags = gg.TYPE_DWORD
    }

    gg.setValues(edits)

    -- ===============================
    -- 🔗 POINTER
    -- ===============================
    local ptr = tonumber(gg.getValues({
        {address = cache.target + 0x10, flags = gg.TYPE_QWORD}
    })[1].value)

    if not ptr or ptr == 0 then return end

    -- ===============================
    -- 🧩 VALUES8
    -- ===============================
    local final = {}
    for i = 0, 11 do
        final[#final + 1] = {
            address = ptr + i * 4,
            value = data.values8[i + 1],
            flags = gg.TYPE_DWORD
        }
    end

    gg.setValues(final)
    gg.toast("✅ Helicopter Skin " .. index .. " applied!")
end

-------------------------------------------------

function colek3()
    while true do
        gg.setVisible(false)
        gg.clearResults()
        local indev = dev
        local skins = {
            "🛩️ • Aerial Portal", "🎉 • Festival Airport",
            "🌴 • Tropical Airport", "👻 • Ghost Airport",
            "🚀 • Spaceport", "🎸 • Rock Airport",
            "🎬 • Cinema Airport", "🎅 • Santa’s Residence",
            "🐣 • Easter Airport", "🍭 • Sugary Airport",
            "⛷️ • Ski Station", "🌈 • Rainbow’s End Airport",
            "🕶️ • Secret Base", "⭐ • Five-Star Airport",
            "🎼 • Symphony Airport", "👗 • Fashion Airport",
            "🕌 • Arabian Airport", "🧛 • Vampire Airport",
            "🌮 • Mexican Airport", "❌ • Go Back"
        }

        local choice = gg.multiChoice(skins, nil, indev)
        if not choice then return end

        -- 🔙 Back
        if choice[20] then
            if type(kums1) == "function" then kums1() end
            return
        end

        -- 🔁 Apply per pilihan
        for i = 1, 19 do
            if choice[i] then
                airportskin(i)
                gg.toast(skins[i] .. " applied\n👉 Claim in freeze reward!")

                repeat gg.sleep(500) until gg.isVisible(true)
                gg.setVisible(false)
            end
        end
    end
end

-- 🔐 Cache (reset jika game restart)
local cache = {copied = {}, sourceBase = nil, target = nil}

local airportSkin = {
    [1] = {
        patch = {1768641312, 1765891950, 1919905906, 1347641204, 51, 0, 0, 1}
    },
    [2] = {
        patch = {1768641312, 1765891950, 1919905906, 1347641204, 55, 0, 0, 1}
    },
    [3] = {
        patch = {1768641312, 1765891950, 1919905906, 1347641204, 57, 0, 0, 1}
    },
    [4] = {
        offset0 = 33,
        offset8 = 26,
        values8 = {
            1852402515, 1919500639, 1953656688, 1818323039, 1702326124,
            808611429, 12594, 0
        }
    },
    [5] = {
        patch = {
            1768641316, 1765891950, 1919905906, 1886609268, 6644577, 0, 0, 1
        }
    },
    [6] = {
        patch = {1768641314, 1765891950, 1919905906, 1869766516, 27491, 0, 0, 1}
    },
    [7] = {
        patch = {
            1768641316, 1765891950, 1919905906, 1869438836, 6646134, 0, 0, 1
        }
    },
    [8] = {
        offset0 = 33,
        offset8 = 26,
        values8 = {
            1852402515, 1919500639, 1953656688, 1919443807, 1836348265,
            808612705, 12850, 0
        }
    },
    [9] = {
        offset0 = 25,
        offset8 = 23,
        values8 = {
            1852402515, 1919500639, 1953656688, 1935762783, 846357876, 3355184,
            0, 0
        }
    },
    [10] = {
        patch = {
            1768641316, 1765891950, 1919905906, 2004049780, 7628133, 0, 0, 1
        }
    },
    [11] = {
        offset0 = 33,
        offset8 = 24,
        values8 = {
            1852402515, 1919500639, 1953656688, 1852405599, 1400006004,
            1953656688, 0, 0
        }
    },
    [12] = {
        patch = {
            1768641320, 1765891950, 1919905906, 1919508340, 1851878501, 100, 0,
            1
        }
    },
    [13] = {
        patch = {1768641312, 1765891950, 1919905906, 1886609268, 121, 0, 0, 1}
    },
    [14] = {
        offset0 = 33,
        offset8 = 25,
        values8 = {
            1852402515, 1919500639, 1953656688, 1819042143, 1818455657,
            1986622325, 101, 0
        }
    },
    [15] = {
        offset0 = 33,
        offset8 = 25,
        values8 = {
            1852402515, 1919500639, 1953656688, 1634493279, 1667855219,
            1769174381, 99, 0
        }
    },
    [16] = {
        patch = {
            1768641320, 1765891950, 1919905906, 1634099060, 1869178995, 110, 0,
            1
        }
    },
    [17] = {
        patch = {1768641314, 1765891950, 1919905906, 1918984052, 25185, 0, 0, 1}
    },
    [18] = {
        offset0 = 49,
        offset8 = 26,
        values8 = {
            1852402515, 1919500639, 1953656688, 1818314847, 1702326124,
            808611429, -1828702926, 112, 1919510026, 1426093171, 282859208, 113
        }
    },
    [19] = {
        offset0 = 49,
        offset8 = 24,
        values8 = {
            1852402515, 1919500639, 1953656688, 1918985055, 1635150190,
            808935276, 0, 0, 0, 0, 0, 0
        }
    }
}

function airportskin(index)
    gg.setVisible(false)
    gg.clearResults()

    local data = airportSkin[index]
    if not data then
        gg.alert("⛔ Airport Skin " .. index .. " not found!\n\n" ..
                     "📢 Please restart the game and try again.")
        return
    end

    -- ===============================
    -- 📍 TARGET (sekali)
    -- ===============================
    if not cache.target then
        gg.searchNumber("2581275344925", gg.TYPE_QWORD)
        local t = gg.getResults(1)
        if #t == 0 then
            gg.alert(
                "⛔ Airport Skin source not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.target = t[1].address - 0x270
    end

    -- ===============================
    -- 🚀 MODE PATCH LANGSUNG
    -- ===============================
    if data.patch then
        local edits = {}
        for i = 0, 7 do
            edits[#edits + 1] = {
                address = cache.target + i * 4,
                flags = gg.TYPE_DWORD,
                value = data.patch[i + 1]
            }
        end
        gg.setValues(edits)
        gg.toast("✅ Airport Skin " .. index .. " applied!")
        return
    end

    -- ===============================
    -- 🔍 SOURCE (sekali)
    -- ===============================
    if not cache.sourceBase then
        gg.clearResults()
        gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)
        local r = gg.getResults(1)
        if #r == 0 then
            gg.alert(
                "❌ Airport Skin target not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.sourceBase = r[1].address + 0x1C
    end

    -- ===============================
    -- 📥 COPY HEADER (per index)
    -- ===============================
    if not cache.copied[index] then
        local temp = {}
        for i = 0, 5 do
            temp[#temp + 1] = {
                address = cache.sourceBase + i * 4,
                flags = gg.TYPE_DWORD
            }
        end
        cache.copied[index] = gg.getValues(temp)
    end

    -- ===============================
    -- 🧩 PASTE HEADER
    -- ===============================
    local edits = {}

    for i, v in ipairs(cache.copied[index]) do
        edits[#edits + 1] = {
            address = cache.target + (i - 1) * 4,
            value = v.value,
            flags = gg.TYPE_DWORD
        }
    end

    edits[#edits + 1] = {
        address = cache.target,
        value = data.offset0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 0x8,
        value = data.offset8,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 6 * 4,
        value = 0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 7 * 4,
        value = 1,
        flags = gg.TYPE_DWORD
    }

    gg.setValues(edits)

    -- ===============================
    -- 🔗 POINTER
    -- ===============================
    local ptr = tonumber(gg.getValues({
        {address = cache.target + 0x10, flags = gg.TYPE_QWORD}
    })[1].value)

    if not ptr or ptr == 0 then return end

    -- ===============================
    -- 🧩 VALUES8
    -- ===============================
    local final = {}
    for i = 0, 7 do
        final[#final + 1] = {
            address = ptr + i * 4,
            value = data.values8[i + 1],
            flags = gg.TYPE_DWORD
        }
    end

    gg.setValues(final)
    gg.toast("✅ Airport Skin " .. index .. " applied!")
end

-------------------------------------------------

function colek4()
    while true do
        gg.setVisible(false)
        gg.clearResults()
        local indev = dev
        local skins = {
            "🛩️ • Ultra Plane", "🎉 • Sky Dragon",
            "🌴 • Tropical Biplane", "👻 • Ghost Plane",
            "🚀 • Launch Vehicle", "🎸 • Rock Plane",
            "🎬 • A-Lister Jet", "🎅 • Holiday Plane",
            "🐣 • Bird Plane", "🍭 • Eclair Plane",
            "⛷️ • Aero Sleigh", "🌈 • Lucky Jet",
            "🕶️ • Stealth Aircraft", "⭐ • Seaplane",
            "🎼 • Symphony Plane", "👗 • Arabian Plane",
            "🕌 • Fashion Plane", "🧛 • Vampire Plane",
            "🌮 • Mexican Plane", "❌ • Go Back"
        }

        local choice = gg.multiChoice(skins, nil, indev)
        if not choice then return end

        -- 🔙 Back
        if choice[20] then
            if type(kums1) == "function" then kums1() end
            return
        end

        -- 🔁 Apply per pilihan
        for i = 1, 19 do
            if choice[i] then
                planeskin(i)
                gg.toast(skins[i] .. " applied\n👉 Claim in freeze reward!")

                repeat gg.sleep(500) until gg.isVisible(true)
                gg.setVisible(false)
            end
        end
    end
end

-- 🔐 Cache (reset jika game restart)
local cache = {copied = {}, sourceBase = nil, target = nil}

local planeSkin = {
    [1] = {
        patch = {1768641314, 1765891950, 1634496626, 1398760814, 13136, 0, 0, 1}
    },
    [2] = {
        patch = {1768641314, 1765891950, 1634496626, 1398760814, 14160, 0, 0, 1}
    },
    [3] = {
        patch = {1768641314, 1765891950, 1634496626, 1398760814, 14672, 0, 0, 1}
    },
    [4] = {
        offset0 = 49,
        offset8 = 27,
        values8 = {
            1852402515, 1919500639, 1851878512, 1634230117, 2003956,
            846095717, 3224112, 536883254, 1869767700, 1952661872, 6649449, 0
        }
    },
    [5] = {
        patch = {
            1768641318, 1765891950, 1634496626, 1935631726, 1701011824, 0, 0, 1
        }
    },
    [6] = {
        patch = {
            1768641316, 1765891950, 1634496626, 1918854510, 7037807, 0, 0, 1
        }
    },
    [7] = {
        patch = {
            1768641318, 1765891950, 1634496626, 1834968430, 1701410415, 0, 0, 1
        }
    },
    [8] = {
        offset0 = 49,
        offset8 = 27,
        values8 = {
            1852402515, 1919500639, 1851878512, 1751342949, 1953720690,
            846422381, 3289648, 1701998624, 1818321779, 7954277, 892219426,
            1868767232
        }
    },
    [9] = {
        offset0 = 49,
        offset8 = 24,
        values8 = {
            1852402515, 1919500639, 1851878512, 1634033509, 1919251571,
            858927154, 536883200, 1835102822, 1919510026, 29811, 436390912, 113
        }
    },
    [10] = {
        patch = {
            1768641318, 1765891950, 1634496626, 1935631726, 1952802167, 0, 0, 1
        }
    },
    [11] = {
        offset0 = 49,
        offset8 = 25,
        values8 = {
            1852402515, 1919500639, 1851878512, 1769430885, 1919251566,
            1919905875, 1935933556, 7628115, -1566776928, 112, 1668571469,
            1917858664
        }
    },
    [12] = {
        patch = {
            1768641322, 1765891950, 1634496626, 1767859566, 1634493810, 25710,
            0, 1
        }
    },
    [13] = {
        patch = {1768641314, 1765891950, 1634496626, 1935631726, 31088, 0, 0, 1}
    },
    [14] = {
        offset0 = 49,
        offset8 = 26,
        values8 = {
            1852402515, 1919500639, 1851878512, 1818320741, 1668180332,
            1769174380, 1912628598, 1735287145, 1667592972, 6581871, 0, 0
        }
    },
    [15] = {
        offset0 = 49,
        offset8 = 26,
        values8 = {
            1852402515, 1919500639, 1851878512, 1818451813, 1769173857,
            1937075555, 1879073641, 536897390, 1667592972, 6581871, 0, 0
        }
    },
    [16] = {
        patch = {
            1768641316, 1765891950, 1634496626, 1633641838, 6447474, 0, 0, 1
        }
    },
    [17] = {
        patch = {
            1768641322, 1765891950, 1634496626, 1717527918, 1768452961, 28271,
            0, 1
        }
    },
    [18] = {
        offset0 = 49,
        offset8 = 27,
        values8 = {
            1852402515, 1919500639, 1851878512, 1632132965, 2003790956,
            846095717, 3486256, 1852797542, 1667592972, 6581871, 0, 0
        }
    },
    [19] = {
        offset0 = 49,
        offset8 = 25,
        values8 = {
            1852402515, 1919500639, 1851878512, 1633902437, 1986621042,
            929000545, 1701576752, 151587390, 1667592972, 6581871, 0, 0
        }
    }
}

function planeskin(index)
    gg.setVisible(false)
    gg.clearResults()

    local data = planeSkin[index]
    if not data then
        gg.alert("⛔ Plane Skin " .. index .. " not found!\n\n" ..
                     "📢 Please restart the game and try again.")
        return
    end

    -- ===============================
    -- 📍 TARGET (sekali)
    -- ===============================
    if not cache.target then
        gg.searchNumber("2581275344925", gg.TYPE_QWORD)
        local t = gg.getResults(1)
        if #t == 0 then
            gg.alert(
                "⛔ Plane Skin source not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.target = t[1].address - 0x270
    end

    -- ===============================
    -- 🚀 MODE PATCH LANGSUNG
    -- ===============================
    if data.patch then
        local edits = {}
        for i = 0, 7 do
            edits[#edits + 1] = {
                address = cache.target + i * 4,
                flags = gg.TYPE_DWORD,
                value = data.patch[i + 1]
            }
        end
        gg.setValues(edits)
        gg.toast("✅ Plane Skin " .. index .. " applied!")
        return
    end

    -- ===============================
    -- 🔍 SOURCE (sekali)
    -- ===============================
    if not cache.sourceBase then
        gg.clearResults()
        gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)
        local r = gg.getResults(1)
        if #r == 0 then
            gg.alert(
                "❌ Plane Skin target not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.sourceBase = r[1].address + 0x1C
    end

    -- ===============================
    -- 📥 COPY HEADER (per index)
    -- ===============================
    if not cache.copied[index] then
        local temp = {}
        for i = 0, 5 do
            temp[#temp + 1] = {
                address = cache.sourceBase + i * 4,
                flags = gg.TYPE_DWORD
            }
        end
        cache.copied[index] = gg.getValues(temp)
    end

    -- ===============================
    -- 🧩 PASTE HEADER
    -- ===============================
    local edits = {}

    for i, v in ipairs(cache.copied[index]) do
        edits[#edits + 1] = {
            address = cache.target + (i - 1) * 4,
            value = v.value,
            flags = gg.TYPE_DWORD
        }
    end

    edits[#edits + 1] = {
        address = cache.target,
        value = data.offset0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 0x8,
        value = data.offset8,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 6 * 4,
        value = 0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 7 * 4,
        value = 1,
        flags = gg.TYPE_DWORD
    }

    gg.setValues(edits)

    -- ===============================
    -- 🔗 POINTER
    -- ===============================
    local ptr = tonumber(gg.getValues({
        {address = cache.target + 0x10, flags = gg.TYPE_QWORD}
    })[1].value)

    if not ptr or ptr == 0 then return end

    -- ===============================
    -- 🧩 VALUES8
    -- ===============================
    local final = {}
    for i = 0, 11 do
        final[#final + 1] = {
            address = ptr + i * 4,
            value = data.values8[i + 1],
            flags = gg.TYPE_DWORD
        }
    end

    gg.setValues(final)
    gg.toast("✅ Plane Skin " .. index .. " applied!")
end

-------------------------------------------------

function colek5()
    while true do
        gg.setVisible(false)
        gg.clearResults()
        local indev = dev
        local skins = {
            "🚄 • Express Portal", "👻 • Ghost Station",
            "🕺 • Disco Station", "🤠 • Cowboy Station",
            "🎄 • Christmas Station I", "🐣 • Easter Station",
            "🏺 • Ancient Settlement", "🎭 • Theater Set Station",
            "🏮 • Chinese Station", "🚀 • Space Station",
            "🏋️ • Training Camp", "🎵 • Record Station",
            "🏰 • Castle Station", "🏛️ • Roman Station",
            "🎃 • Halloween Station", "🎄 • Christmas Station II",
            "🌸 • Flower Station", "🥐 • French Station",
            "🕴️ • Gatsby Station", "🐉 • Mythic Station",
            "❌ • Go Back"
        }

        local choice = gg.multiChoice(skins, nil, indev)
        if not choice then return end

        -- 🔙 Back
        if choice[21] then
            if type(kums1) == "function" then kums1() end
            return
        end

        -- 🔁 Apply per pilihan
        for i = 1, 20 do
            if choice[i] then
                stationtrainskin(i)
                gg.toast(skins[i] .. " applied\n👉 Claim in freeze reward!")

                repeat gg.sleep(500) until gg.isVisible(true)
                gg.setVisible(false)
            end
        end
    end
end

-- 🔐 Cache (reset jika game restart)
local cache = {copied = {}, sourceBase = nil, target = nil}

local stationtrainSkin = {
    [1] = {
        patch = {
            1768641322, 1918132078, 1399744865, 1769234804, 1398763119, 12880,
            0, 1
        }
    },
    [2] = {
        patch = {
            1768641322, 1918132078, 1399744865, 1769234804, 1398763119, 13648,
            0, 1
        }
    },
    [3] = {
        patch = {
            1768641322, 1918132078, 1399744865, 1769234804, 1398763119, 14416,
            0, 1
        }
    },
    [4] = {
        offset0 = 49,
        offset8 = 25,
        values8 = {
            1852402515, 1634882655, 1951624809, 1869182049, 1702322030,
            1919251571, 110, 0, -1557774848, 112, 0, 0
        }
    },
    [5] = {
        offset0 = 49,
        offset8 = 27,
        values8 = {
            1852402515, 1634882655, 1951624809, 1869182049, 1751342958,
            1953720690, 7561581, 0, -1557774784, 112, 0, 0
        }
    },
    [6] = {
        offset0 = 49,
        offset8 = 24,
        values8 = {
            1852402515, 1634882655, 1951624809, 1869182049, 1634033518,
            1919251571, 0, 0, 1667592972, 6581871, 0, 0
        }
    },
    [7] = {
        offset0 = 49,
        offset8 = 29,
        values8 = {
            1852402515, 1634882655, 1951624809, 1869182049, 1919967086,
            1936287845, 1769107316, 99, 1919510026, 29811, 447663744, 113
        }
    },
    [8] = {
        offset0 = 49,
        offset8 = 28,
        values8 = {
            1852402515, 1634882655, 1951624809, 1869182049, 1752457070,
            1920229733, 1818321769, 0, 1667592972, 6581871, 0, 0
        }
    },
    [9] = {
        offset0 = 49,
        offset8 = 29,
        values8 = {
            1852402515, 1634882655, 1951624809, 1869182049, 1970036590,
            1316118894, 842019417, 50, 0, 0, 0, 0
        }
    },
    [10] = {
        patch = {
            1768641324, 1918132078, 1399744865, 1769234804, 1834970735, 7565921,
            0, 1
        }
    },
    [11] = {
        offset0 = 49,
        offset8 = 27,
        values8 = {
            1852402515, 1634882655, 1951624809, 1869182049, 1869766510,
            1215195490, 6582127, 0, 0, 0, 0, 0
        }
    },
    [12] = {
        offset0 = 49,
        offset8 = 27,
        values8 = {
            1852402515, 1634882655, 1951624809, 1869182049, 1869766510,
            1919839075, 7105647, 0, 0, 0, 0, 0
        }
    },
    [13] = {
        offset0 = 49,
        offset8 = 24,
        values8 = {
            1852402515, 1634882655, 1951624809, 1869182049, 1852530542,
            1952999273, 0, 0, 0, 0, 0, 0
        }
    },
    [14] = {
        offset0 = 49,
        offset8 = 27,
        values8 = {
            1852402515, 1634882655, 1951624809, 1869182049, 1953062766,
            846818401, 3420720, 0, 0, 0, 0, 0
        }
    },
    [15] = {
        offset0 = 49,
        offset8 = 31,
        values8 = {
            1852402515, 1634882655, 1951624809, 1869182049, 1634230126,
            2003790956, 846095717, 3420720, 0, 0, 0, 0
        }
    },
    [16] = {
        offset0 = 49,
        offset8 = 31,
        values8 = {
            1852402515, 1634882655, 1951624809, 1869182049, 1751342958,
            1953720690, 846422381, 3420720, 0, 0, 0, 0
        }
    },
    [17] = {
        offset0 = 49,
        offset8 = 26,
        values8 = {
            1852402515, 1634882655, 1951624809, 1869182049, 1701207918,
            1986622579, 27745, 0, 0, 0, 0, 0
        }
    },
    [18] = {
        offset0 = 49,
        offset8 = 27,
        values8 = {
            1852402515, 1634882655, 1951624809, 1869182049, 1919311726,
            1701015137, 3683935, 0, 0, 0, 0, 0
        }
    },
    [19] = {
        offset0 = 49,
        offset8 = 24,
        values8 = {
            1852402515, 1634882655, 1951624809, 1869182049, 1632067438,
            2036495220, 0, 0, 0, 0, 0, 0
        }
    },
    [20] = {
        offset0 = 49,
        offset8 = 28,
        values8 = {
            1852402515, 1634882655, 1951624809, 1869182049, 1701338990,
            1935764588, 892481586, 0, 0, 0, 0, 0
        }
    }
}

function stationtrainskin(index)
    gg.setVisible(false)
    gg.clearResults()

    local data = stationtrainSkin[index]
    if not data then
        gg.alert("⛔ Station Train Skin " .. index .. " not found!\n\n" ..
                     "📢 Please restart the game and try again.")
        return
    end

    -- ===============================
    -- 📍 TARGET (sekali)
    -- ===============================
    if not cache.target then
        gg.searchNumber("2581275344925", gg.TYPE_QWORD)
        local t = gg.getResults(1)
        if #t == 0 then
            gg.alert(
                "⛔ Station Train Skin source not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.target = t[1].address - 0x270
    end

    -- ===============================
    -- 🚀 MODE PATCH LANGSUNG
    -- ===============================
    if data.patch then
        local edits = {}
        for i = 0, 7 do
            edits[#edits + 1] = {
                address = cache.target + i * 4,
                flags = gg.TYPE_DWORD,
                value = data.patch[i + 1]
            }
        end
        gg.setValues(edits)
        gg.toast("✅ Station Train Skin " .. index .. " applied!")
        return
    end

    -- ===============================
    -- 🔍 SOURCE (sekali)
    -- ===============================
    if not cache.sourceBase then
        gg.clearResults()
        gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)
        local r = gg.getResults(1)
        if #r == 0 then
            gg.alert(
                "❌ Station Train Skin target not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.sourceBase = r[1].address + 0x1C
    end

    -- ===============================
    -- 📥 COPY HEADER (per index)
    -- ===============================
    if not cache.copied[index] then
        local temp = {}
        for i = 0, 5 do
            temp[#temp + 1] = {
                address = cache.sourceBase + i * 4,
                flags = gg.TYPE_DWORD
            }
        end
        cache.copied[index] = gg.getValues(temp)
    end

    -- ===============================
    -- 🧩 PASTE HEADER
    -- ===============================
    local edits = {}

    for i, v in ipairs(cache.copied[index]) do
        edits[#edits + 1] = {
            address = cache.target + (i - 1) * 4,
            value = v.value,
            flags = gg.TYPE_DWORD
        }
    end

    edits[#edits + 1] = {
        address = cache.target,
        value = data.offset0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 0x8,
        value = data.offset8,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 6 * 4,
        value = 0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 7 * 4,
        value = 1,
        flags = gg.TYPE_DWORD
    }

    gg.setValues(edits)

    -- ===============================
    -- 🔗 POINTER
    -- ===============================
    local ptr = tonumber(gg.getValues({
        {address = cache.target + 0x10, flags = gg.TYPE_QWORD}
    })[1].value)

    if not ptr or ptr == 0 then return end

    -- ===============================
    -- 🧩 VALUES8
    -- ===============================
    local final = {}
    for i = 0, 11 do
        final[#final + 1] = {
            address = ptr + i * 4,
            value = data.values8[i + 1],
            flags = gg.TYPE_DWORD
        }
    end

    gg.setValues(final)
    gg.toast("✅ Station Train Skin " .. index .. " applied!")
end

-------------------------------------------------

function colek6()
    while true do
        gg.setVisible(false)
        gg.clearResults()
        local indev = dev
        local skins = {
            "🚄 • Future Express", "👻 • Ghost Train",
            "🕺 • Disco Train", "🤠 • Cowboy Train",
            "🎄 • Christmas Train I", "🐣 • Easter Train",
            "🦴 • Primeval Express", "🎭 • Theater Express",
            "🐉 • Dragon Train", "🚀 • Mars Rover",
            "🪵 • Wooden Wagon", "🎵 • Music Express",
            "⚔️ • Knight Train", "🚋 • Express Tram",
            "🎃 • Halloween Train", "🎄 • Christmas Train II",
            "🌸 • Flower Train", "🥐 • French Train",
            "🕴️ • Gatsby Train", "🐲 • Mythic Train",
            "❌ • Go Back"
        }

        local choice = gg.multiChoice(skins, nil, indev)
        if not choice then return end

        -- 🔙 Back
        if choice[21] then
            if type(kums1) == "function" then kums1() end
            return
        end

        -- 🔁 Apply per pilihan
        for i = 1, 20 do
            if choice[i] then
                trainskin(i)
                gg.toast(skins[i] .. " applied\n👉 Claim in freeze reward!")

                repeat gg.sleep(500) until gg.isVisible(true)
                gg.setVisible(false)
            end
        end
    end
end

-- 🔐 Cache (reset jika game restart)
local cache = {copied = {}, sourceBase = nil, target = nil}

local trainSkin = {
    [1] = {patch = {1768641308, 1918132078, 1601071457, 3297363, 0, 0, 0, 1}},
    [2] = {patch = {1768641308, 1918132078, 1601071457, 3493971, 0, 0, 0, 1}},
    [3] = {patch = {1768641308, 1918132078, 1601071457, 3690579, 0, 0, 0, 1}},
    [4] = {
        patch = {
            1768641316, 1918132078, 1601071457, 1953719671, 7238245, 0, 0, 1
        }
    },
    [5] = {
        patch = {
            1768641320, 1918132078, 1601071457, 1769105507, 1634563187, 115, 0,
            1
        }
    },
    [6] = {
        patch = {1768641314, 1918132078, 1601071457, 1953718629, 29285, 0, 0, 1}
    },
    [7] = {
        patch = {
            1768641324, 1918132078, 1601071457, 1751478896, 1869902697, 6515058,
            0, 1
        }
    },
    [8] = {
        patch = {
            1768641322, 1918132078, 1601071457, 1634035828, 1667854964, 27745,
            0, 1
        }
    },
    [9] = {
        patch = {
            1768641324, 1918132078, 1601071457, 1634628972, 844713586, 3289648,
            0, 1
        }
    },
    [10] = {
        patch = {1768641310, 1918132078, 1601071457, 1936875885, 0, 0, 0, 1}
    },
    [11] = {
        patch = {
            1768641320, 1918132078, 1601071457, 1768058738, 1869564014, 100, 0,
            1
        }
    },
    [12] = {
        patch = {
            1768641320, 1918132078, 1601071457, 1801678706, 1819243118, 108, 0,
            1
        }
    },
    [13] = {
        patch = {1768641314, 1918132078, 1601071457, 1734962795, 29800, 0, 0, 1}
    },
    [14] = {
        patch = {
            1768641320, 1918132078, 1601071457, 1818326121, 842019449, 52, 0, 1
        }
    },
    [15] = {
        offset0 = 49,
        offset8 = 24,
        values8 = {
            1852402515, 1634882655, 1751084649, 1869376609, 1852138871,
            875704370, 0, 0, 0, 0, 0, 0
        }
    },
    [16] = {
        offset0 = 49,
        offset8 = 24,
        values8 = {
            1852402515, 1634882655, 1667198569, 1936290408, 1935764852,
            875704370, 0, 0, 0, 0, 0, 0
        }
    },
    [17] = {
        patch = {
            1768641318, 1918132078, 1601071457, 1953719654, 1818326633, 0, 0, 1
        }
    },
    [18] = {
        patch = {
            1768641320, 1918132078, 1601071457, 1851880038, 912221539, 56, 0, 1
        }
    },
    [19] = {
        patch = {1768641314, 1918132078, 1601071457, 1937006919, 31074, 0, 0, 1}
    },
    [20] = {
        patch = {
            1768641322, 1918132078, 1601071457, 1819043176, 808612705, 13618, 0,
            1
        }
    }
}

function trainskin(index)
    gg.setVisible(false)
    gg.clearResults()

    local data = trainSkin[index]
    if not data then
        gg.alert("⛔ Train Skin " .. index .. " not found!\n\n" ..
                     "📢 Please restart the game and try again.")
        return
    end

    -- ===============================
    -- 📍 TARGET (sekali)
    -- ===============================
    if not cache.target then
        gg.searchNumber("2581275344925", gg.TYPE_QWORD)
        local t = gg.getResults(1)
        if #t == 0 then
            gg.alert(
                "⛔ Train Skin source not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.target = t[1].address - 0x270
    end

    -- ===============================
    -- 🚀 MODE PATCH LANGSUNG
    -- ===============================
    if data.patch then
        local edits = {}
        for i = 0, 7 do
            edits[#edits + 1] = {
                address = cache.target + i * 4,
                flags = gg.TYPE_DWORD,
                value = data.patch[i + 1]
            }
        end
        gg.setValues(edits)
        gg.toast("✅ Train Skin " .. index .. " applied!")
        return
    end

    -- ===============================
    -- 🔍 SOURCE (sekali)
    -- ===============================
    if not cache.sourceBase then
        gg.clearResults()
        gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)
        local r = gg.getResults(1)
        if #r == 0 then
            gg.alert(
                "❌ Train Skin target not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.sourceBase = r[1].address + 0x1C
    end

    -- ===============================
    -- 📥 COPY HEADER (per index)
    -- ===============================
    if not cache.copied[index] then
        local temp = {}
        for i = 0, 5 do
            temp[#temp + 1] = {
                address = cache.sourceBase + i * 4,
                flags = gg.TYPE_DWORD
            }
        end
        cache.copied[index] = gg.getValues(temp)
    end

    -- ===============================
    -- 🧩 PASTE HEADER
    -- ===============================
    local edits = {}

    for i, v in ipairs(cache.copied[index]) do
        edits[#edits + 1] = {
            address = cache.target + (i - 1) * 4,
            value = v.value,
            flags = gg.TYPE_DWORD
        }
    end

    edits[#edits + 1] = {
        address = cache.target,
        value = data.offset0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 0x8,
        value = data.offset8,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 6 * 4,
        value = 0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 7 * 4,
        value = 1,
        flags = gg.TYPE_DWORD
    }

    gg.setValues(edits)

    -- ===============================
    -- 🔗 POINTER
    -- ===============================
    local ptr = tonumber(gg.getValues({
        {address = cache.target + 0x10, flags = gg.TYPE_QWORD}
    })[1].value)

    if not ptr or ptr == 0 then return end

    -- ===============================
    -- 🧩 VALUES8
    -- ===============================
    local final = {}
    for i = 0, 11 do
        final[#final + 1] = {
            address = ptr + i * 4,
            value = data.values8[i + 1],
            flags = gg.TYPE_DWORD
        }
    end

    gg.setValues(final)
    gg.toast("✅ Train Skin " .. index .. " applied!")
end

-------------------------------------------------

function colek7()
    while true do
        gg.setVisible(false)
        gg.clearResults()
        local indev = dev
        local skins = {
            "🏴‍☠️ • Pirate Harbor", "🌴 • Equatorial Port",
            "🍭 • Sweet Port", "🦁 • Doge's Pier",
            "💀 • Port of Horrors", "💘 • Romantic Harbor",
            "🛡️ • Viking Harbor", "🌳 • Jungle Port",
            "🎄 • Christmas Port", "🏮 • Lantern Harbor",
            "🏺 • Ancient Port", "🤠 • Saloon on the Water",
            "🍬 • Candy Port", "🕌 • Egyptian-Themed Port",
            "❄️ • Arctic Port", "🧳 • Vacation Port",
            "🍣 • Japanese Port", "⚔️ • Knight Port",
            "🎭 • Broadway Port", "❌ • Go Back"
        }

        local choice = gg.multiChoice(skins, nil, indev)
        if not choice then return end

        -- 🔙 Back
        if choice[20] then
            if type(kums1) == "function" then kums1() end
            return
        end

        -- 🔁 Apply per pilihan
        for i = 1, 19 do
            if choice[i] then
                portskin(i)
                gg.toast(skins[i] .. " applied\n👉 Claim in freeze reward!")

                repeat gg.sleep(500) until gg.isVisible(true)
                gg.setVisible(false)
            end
        end
    end
end

-- 🔐 Cache (reset jika game restart)
local cache = {copied = {}, sourceBase = nil, target = nil}

local portSkin = {
    [1] = {patch = {1768641310, 1632132974, 1919902322, 827609951, 0, 0, 0, 1}},
    [2] = {patch = {1768641310, 1632132974, 1919902322, 961565535, 0, 0, 0, 1}},
    [3] = {
        patch = {1768641314, 1632132974, 1919902322, 1918988383, 29545, 0, 0, 1}
    },
    [4] = {
        patch = {
            1768641316, 1632132974, 1919902322, 1852143199, 6644585, 0, 0, 1
        }
    },
    [5] = {
        offset0 = 33,
        offset8 = 25,
        values8 = {
            1852402515, 1918978143, 1601335138, 1819042152, 1701148527,
            842019438, 1953366066, 0, 1852402515, 1919895135, 1936028276,
            1749245811
        }
    },
    [6] = {
        offset0 = 33,
        offset8 = 25,
        values8 = {
            1852402515, 1918978143, 1601335138, 1701601654, 1852404846,
            1631875941, 121, 0, 1852402515, 1919895135, 1936028276, 1749245811
        }
    },
    [7] = {
        patch = {
            1768641322, 1632132974, 1919902322, 1919905375, 1197697380, 25711,
            0, 1
        }
    },
    [8] = {
        patch = {
            1768641316, 1632132974, 1919902322, 1853188703, 6646887, 0, 0, 1
        }
    },
    [9] = {
        offset0 = 33,
        offset8 = 25,
        values8 = {
            1852402515, 1918978143, 1601335138, 1769105507, 1634563187,
            842019443, 51, 0, 1852402515, 1919895135, 1936028276, 1749245811
        }
    },
    [10] = {
        patch = {1768641310, 1632132974, 1919902322, 1498301279, 0, 0, 0, 1}
    },
    [11] = {
        patch = {
            1768641316, 1632132974, 1919902322, 1818585183, 7561580, 0, 0, 1
        }
    },
    [12] = {
        offset0 = 33,
        offset8 = 24,
        values8 = {
            1852402515, 1918978143, 1601335138, 1684826487, 1953719671,
            875704370, 0, 0, 1852402515, 1919895135, 1936028276, 1749245811
        }
    },
    [13] = {
        offset0 = 33,
        offset8 = 24,
        values8 = {
            1852402515, 1918978143, 1601335138, 1953655138, 2036425832,
            875704370, 0, 0, 1852402515, 1919895135, 1936028276, 1749245811
        }
    },
    [14] = {
        patch = {1768641314, 1632132974, 1919902322, 2036819295, 29808, 0, 0, 1}
    },
    [15] = {
        patch = {
            1768641316, 1632132974, 1919902322, 1668440415, 6515060, 0, 0, 1
        }
    },
    [16] = {
        offset0 = 49,
        offset8 = 28,
        values8 = {
            1852402515, 1918978143, 1601335138, 1768713313, 1970037614,
            1702259059, 892481586, 1767863296, 1852401262, 6648937, 2672640, 0
        }
    },
    [17] = {
        patch = {1768641314, 1632132974, 1919902322, 1885432415, 28257, 0, 0, 1}
    },
    [18] = {
        patch = {
            1768641316, 1632132974, 1919902322, 1768835935, 7628903, 0, 0, 1
        }
    },
    [19] = {
        offset0 = 49,
        offset8 = 23,
        values8 = {
            1852402515, 1918978143, 1601335138, 1634693730, 2036430692, 3749471,
            0, 0, 1852402515, 1919895135, 1936028276, 1749245811
        }
    }
}

function portskin(index)
    gg.setVisible(false)
    gg.clearResults()

    local data = portSkin[index]
    if not data then
        gg.alert("⛔ Port Skin " .. index .. " not found!\n\n" ..
                     "📢 Please restart the game and try again.")
        return
    end

    -- ===============================
    -- 📍 TARGET (sekali)
    -- ===============================
    if not cache.target then
        gg.searchNumber("2581275344925", gg.TYPE_QWORD)
        local t = gg.getResults(1)
        if #t == 0 then
            gg.alert(
                "⛔ Port Skin source not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.target = t[1].address - 0x270
    end

    -- ===============================
    -- 🚀 MODE PATCH LANGSUNG
    -- ===============================
    if data.patch then
        local edits = {}
        for i = 0, 7 do
            edits[#edits + 1] = {
                address = cache.target + i * 4,
                flags = gg.TYPE_DWORD,
                value = data.patch[i + 1]
            }
        end
        gg.setValues(edits)
        gg.toast("✅ Port Skin " .. index .. " applied!")
        return
    end

    -- ===============================
    -- 🔍 SOURCE (sekali)
    -- ===============================
    if not cache.sourceBase then
        gg.clearResults()
        gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)
        local r = gg.getResults(1)
        if #r == 0 then
            gg.alert(
                "❌ Port Skin target not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.sourceBase = r[1].address + 0x1C
    end

    -- ===============================
    -- 📥 COPY HEADER (per index)
    -- ===============================
    if not cache.copied[index] then
        local temp = {}
        for i = 0, 5 do
            temp[#temp + 1] = {
                address = cache.sourceBase + i * 4,
                flags = gg.TYPE_DWORD
            }
        end
        cache.copied[index] = gg.getValues(temp)
    end

    -- ===============================
    -- 🧩 PASTE HEADER
    -- ===============================
    local edits = {}

    for i, v in ipairs(cache.copied[index]) do
        edits[#edits + 1] = {
            address = cache.target + (i - 1) * 4,
            value = v.value,
            flags = gg.TYPE_DWORD
        }
    end

    edits[#edits + 1] = {
        address = cache.target,
        value = data.offset0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 0x8,
        value = data.offset8,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 6 * 4,
        value = 0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 7 * 4,
        value = 1,
        flags = gg.TYPE_DWORD
    }

    gg.setValues(edits)

    -- ===============================
    -- 🔗 POINTER
    -- ===============================
    local ptr = tonumber(gg.getValues({
        {address = cache.target + 0x10, flags = gg.TYPE_QWORD}
    })[1].value)

    if not ptr or ptr == 0 then return end

    -- ===============================
    -- 🧩 VALUES8
    -- ===============================
    local final = {}
    for i = 0, 11 do
        final[#final + 1] = {
            address = ptr + i * 4,
            value = data.values8[i + 1],
            flags = gg.TYPE_DWORD
        }
    end

    gg.setValues(final)
    gg.toast("✅ Port Skin " .. index .. " applied!")
end

-------------------------------------------------

function colek8()
    while true do
        gg.setVisible(false)
        gg.clearResults()
        local indev = dev
        local skins = {
            "🏴‍☠️ • Pirate Galleon", "🌴 • Cruise Liner",
            "🥐 • Croissant Ferry", "🦁 • Gondola",
            "💀 • Ghost Ship", "💘 • Love Boat",
            "🛡️ • Sturdy Drakkar", "🌳 • Cruise Ship",
            "🎁 • Gift Boat", "🏮 • Dragon Boat",
            "🏺 • Greek Bireme", "🤠 • River Steamboat",
            "🍬 • Sweet Boat", "🕌 • Egyptian-Themed Ship",
            "❄️ • Arctic Ship", "🧳 • Vacation Ship",
            "🍣 • Japanese Ship", "⚔️ • Knight Ship",
            "🎭 • Broadway Ship", "❌ • Go Back"
        }

        local choice = gg.multiChoice(skins, nil, indev)
        if not choice then return end

        -- 🔙 Back
        if choice[20] then
            if type(kums1) == "function" then kums1() end
            return
        end

        -- 🔁 Apply per pilihan
        for i = 1, 19 do
            if choice[i] then
                boatskin(i)
                gg.toast(skins[i] .. " applied\n👉 Claim in freeze reward!")

                repeat gg.sleep(500) until gg.isVisible(true)
                gg.setVisible(false)
            end
        end
    end
end

-- 🔐 Cache (reset jika game restart)
local cache = {copied = {}, sourceBase = nil, target = nil}

local boatSkin = {
    [1] = {patch = {1768641306, 1750294382, 1398763625, 14672, 0, 0, 0, 1}},
    [2] = {patch = {1768641306, 1750294382, 1398763625, 12628, 0, 0, 0, 1}},
    [3] = {patch = {1768641310, 1750294382, 1885302889, 1936290401, 0, 0, 0, 1}},
    [4] = {
        patch = {1768641312, 1750294382, 1985966185, 1667853925, 101, 0, 0, 1}
    },
    [5] = {
        offset0 = 25,
        offset8 = 23,
        values8 = {
            1852402515, 1768444767, 1634230128, 2003790956, 846095717, 3289648,
            0, 0, 1852402515, 1919895135, 1936028276, 1749245811
        }
    },
    [6] = {
        offset0 = 25,
        offset8 = 23,
        values8 = {
            1852402515, 1768444767, 1635147632, 1953391980, 1936027241, 7954756,
            0, 0, 1852402515, 1919895135, 1936028276, 1749245811
        }
    },
    [7] = {
        patch = {
            1768641318, 1750294382, 1851748457, 1768190575, 1685014371, 0, 0, 1
        }
    },
    [8] = {
        patch = {1768641312, 1750294382, 1784639593, 1818717813, 101, 0, 0, 1}
    },
    [9] = {
        offset0 = 25,
        offset8 = 23,
        values8 = {
            1852402515, 1768444767, 1751342960, 1953720690, 846422381, 3355184,
            0, 0, 1852402515, 1919895135, 1936028276, 1749245811
        }
    },
    [10] = {patch = {1768641306, 1750294382, 1130328169, 22862, 0, 0, 0, 1}},
    [11] = {
        patch = {1768641312, 1750294382, 1751085161, 1634495589, 115, 0, 0, 1}
    },
    [12] = {
        patch = {
            1768641324, 1750294382, 2002743401, 2003070057, 846492517, 3420720,
            0, 1
        }
    },
    [13] = {
        patch = {
            1768641324, 1750294382, 1650421865, 1752461929, 846815588, 3420720,
            0, 1
        }
    },
    [14] = {
        patch = {1768641310, 1750294382, 1700753513, 1953528167, 0, 0, 0, 1}
    },
    [15] = {
        patch = {1768641312, 1750294382, 1633644649, 1769235314, 99, 0, 0, 1}
    },
    [16] = {
        offset0 = 49,
        offset8 = 26,
        values8 = {
            1852402515, 1768444767, 1818320752, 1668180332, 1769174380,
            808609142, 13618, 0, 1714689832, 0, 0, 0
        }
    },
    [17] = {
        patch = {1768641310, 1750294382, 1784639593, 1851879521, 0, 0, 0, 1}
    },
    [18] = {
        patch = {1768641312, 1750294382, 1264545897, 1751607662, 116, 0, 0, 1}
    },
    [19] = {
        patch = {
            1768641322, 1750294382, 1650421865, 1684107122, 1601790327, 14646,
            0, 1
        }
    }
}

function boatskin(index)
    gg.setVisible(false)
    gg.clearResults()

    local data = boatSkin[index]
    if not data then
        gg.alert("⛔ Boat Skin " .. index .. " not found!\n\n" ..
                     "📢 Please restart the game and try again.")
        return
    end

    -- ===============================
    -- 📍 TARGET (sekali)
    -- ===============================
    if not cache.target then
        gg.searchNumber("2581275344925", gg.TYPE_QWORD)
        local t = gg.getResults(1)
        if #t == 0 then
            gg.alert(
                "⛔ Boat Skin source not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.target = t[1].address - 0x270
    end

    -- ===============================
    -- 🚀 MODE PATCH LANGSUNG
    -- ===============================
    if data.patch then
        local edits = {}
        for i = 0, 7 do
            edits[#edits + 1] = {
                address = cache.target + i * 4,
                flags = gg.TYPE_DWORD,
                value = data.patch[i + 1]
            }
        end
        gg.setValues(edits)
        gg.toast("✅ Boat Skin " .. index .. " applied!")
        return
    end

    -- ===============================
    -- 🔍 SOURCE (sekali)
    -- ===============================
    if not cache.sourceBase then
        gg.clearResults()
        gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)
        local r = gg.getResults(1)
        if #r == 0 then
            gg.alert(
                "❌ Boat Skin target not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.sourceBase = r[1].address + 0x1C
    end

    -- ===============================
    -- 📥 COPY HEADER (per index)
    -- ===============================
    if not cache.copied[index] then
        local temp = {}
        for i = 0, 5 do
            temp[#temp + 1] = {
                address = cache.sourceBase + i * 4,
                flags = gg.TYPE_DWORD
            }
        end
        cache.copied[index] = gg.getValues(temp)
    end

    -- ===============================
    -- 🧩 PASTE HEADER
    -- ===============================
    local edits = {}

    for i, v in ipairs(cache.copied[index]) do
        edits[#edits + 1] = {
            address = cache.target + (i - 1) * 4,
            value = v.value,
            flags = gg.TYPE_DWORD
        }
    end

    edits[#edits + 1] = {
        address = cache.target,
        value = data.offset0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 0x8,
        value = data.offset8,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 6 * 4,
        value = 0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 7 * 4,
        value = 1,
        flags = gg.TYPE_DWORD
    }

    gg.setValues(edits)

    -- ===============================
    -- 🔗 POINTER
    -- ===============================
    local ptr = tonumber(gg.getValues({
        {address = cache.target + 0x10, flags = gg.TYPE_QWORD}
    })[1].value)

    if not ptr or ptr == 0 then return end

    -- ===============================
    -- 🧩 VALUES8
    -- ===============================
    local final = {}
    for i = 0, 11 do
        final[#final + 1] = {
            address = ptr + i * 4,
            value = data.values8[i + 1],
            flags = gg.TYPE_DWORD
        }
    end

    gg.setValues(final)
    gg.toast("✅ Boat Skin " .. index .. " applied!")
end

-------------------------------------------------

function colek9()
    while true do
        gg.setVisible(false)
        gg.clearResults()
        local indev = dev
        local skins = {
            "🏴‍☠️ • Pirate Shack", "⚓️ • Pirate Hub",
            "🏰 • Pirate Fort", "🏝️ • Island House",
            "🏯 • Island Manor", "🏡 • Island Residance",
            "🧙‍♀️ • Witct's House", "🏚️ • Witct's Manor",
            "🏰 • Witct's Castle", "❄️ • Ice Castle",
            "🗼 • Little Paris", "🐣 • Easter Village",
            "🦕 • Neanderthal Island", "🪵 • Aztec Island",
            "🎅 • Holiday Island", "❌ • Go Back"
        }

        local choice = gg.multiChoice(skins, nil, indev)
        if not choice then return end

        -- 🔙 Back
        if choice[16] then
            if type(kums1) == "function" then kums1() end
            return
        end

        -- 🔁 Apply per pilihan
        for i = 1, 15 do
            if choice[i] then
                islandskin(i)
                gg.toast(skins[i] .. " applied\n👉 Claim in freeze reward!")

                repeat gg.sleep(500) until gg.isVisible(true)
                gg.setVisible(false)
            end
        end
    end
end

-- 🔐 Cache (reset jika game restart)
local cache = {copied = {}, sourceBase = nil, target = nil}

local islandSkin = {
    [1] = {
        patch = {
            1768641322, 1866882926, 1701999730, 1348432755, 1952543337, 12645,
            0, 1
        }
    },
    [2] = {
        patch = {
            1768641322, 1866882926, 1701999730, 1348432755, 1952543337, 12901,
            0, 1
        }
    },
    [3] = {
        patch = {
            1768641322, 1866882926, 1701999730, 1348432755, 1952543337, 13157,
            0, 1
        }
    },
    [4] = {
        patch = {
            1768641322, 1866882926, 1701999730, 1197437811, 1651733601, 12665,
            0, 1
        }
    },
    [5] = {
        patch = {
            1768641322, 1866882926, 1701999730, 1197437811, 1651733601, 12921,
            0, 1
        }
    },
    [6] = {
        patch = {
            1768641322, 1866882926, 1701999730, 1197437811, 1651733601, 13177,
            0, 1
        }
    },
    [7] = {
        offset0 = 33,
        offset8 = 29,
        values8 = {
            1852402515, 1919895135, 1936028276, 1632132979, 2003790956,
            846095717, 1597059632, 1949237297
        }
    },
    [8] = {
        offset0 = 33,
        offset8 = 29,
        values8 = {
            1852402515, 1919895135, 1936028276, 1632132979, 2003790956,
            846095717, 1597059632, 50
        }
    },
    [9] = {
        offset0 = 33,
        offset8 = 29,
        values8 = {
            1852402515, 1919895135, 1936028276, 1632132979, 2003790956,
            846095717, 1597059632, 51
        }
    },
    [10] = {
        offset0 = 25,
        offset8 = 23,
        values8 = {
            1852402515, 1919895135, 1936028276, 1749245811, 1953720690, 7561581,
            -1729126816, 112
        }
    },
    [11] = {
        patch = {
            1768641318, 1866882926, 1701999730, 1885303667, 1936290401, 0, 0, 1
        }
    },
    [12] = {
        patch = {
            1768641320, 1866882926, 1701999730, 1700754291, 1702130529, 114, 0,
            0, 1
        }
    },
    [13] = {
        offset0 = 33,
        offset8 = 25,
        values8 = {
            1852402515, 1919895135, 1936028276, 1919967091, 1936287845,
            1769107316, 3342435, 171847456
        }
    },
    [14] = {
        patch = {
            1768641320, 1866882926, 1701999730, 1633645427, 1667593338, 115, 0,
            1
        }
    },
    [15] = {
        offset0 = 33,
        offset8 = 28,
        values8 = {
            1852402515, 1919895135, 1936028276, 1751342963, 1953720690,
            1601397101, 808464947, 0
        }
    }
}

function islandskin(index)
    gg.setVisible(false)
    gg.clearResults()

    local data = islandSkin[index]
    if not data then
        gg.alert("⛔ Island Skin " .. index .. " not found!\n\n" ..
                     "📢 Please restart the game and try again.")
        return
    end

    -- ===============================
    -- 📍 TARGET (sekali)
    -- ===============================
    if not cache.target then
        gg.searchNumber("2581275344925", gg.TYPE_QWORD)
        local t = gg.getResults(1)
        if #t == 0 then
            gg.alert(
                "⛔ Island Skin source not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.target = t[1].address - 0x270
    end

    -- ===============================
    -- 🚀 MODE PATCH LANGSUNG
    -- ===============================
    if data.patch then
        local edits = {}
        for i = 0, 7 do
            edits[#edits + 1] = {
                address = cache.target + i * 4,
                flags = gg.TYPE_DWORD,
                value = data.patch[i + 1]
            }
        end
        gg.setValues(edits)
        gg.toast("✅ Island Skin " .. index .. " applied!")
        return
    end

    -- ===============================
    -- 🔍 SOURCE (sekali)
    -- ===============================
    if not cache.sourceBase then
        gg.clearResults()
        gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)
        local r = gg.getResults(1)
        if #r == 0 then
            gg.alert(
                "❌ Island Skin target not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.sourceBase = r[1].address + 0x1C
    end

    -- ===============================
    -- 📥 COPY HEADER (per index)
    -- ===============================
    if not cache.copied[index] then
        local temp = {}
        for i = 0, 5 do
            temp[#temp + 1] = {
                address = cache.sourceBase + i * 4,
                flags = gg.TYPE_DWORD
            }
        end
        cache.copied[index] = gg.getValues(temp)
    end

    -- ===============================
    -- 🧩 PASTE HEADER
    -- ===============================
    local edits = {}

    for i, v in ipairs(cache.copied[index]) do
        edits[#edits + 1] = {
            address = cache.target + (i - 1) * 4,
            value = v.value,
            flags = gg.TYPE_DWORD
        }
    end

    edits[#edits + 1] = {
        address = cache.target,
        value = data.offset0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 0x8,
        value = data.offset8,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 6 * 4,
        value = 0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 7 * 4,
        value = 1,
        flags = gg.TYPE_DWORD
    }

    gg.setValues(edits)

    -- ===============================
    -- 🔗 POINTER
    -- ===============================
    local ptr = tonumber(gg.getValues({
        {address = cache.target + 0x10, flags = gg.TYPE_QWORD}
    })[1].value)

    if not ptr or ptr == 0 then return end

    -- ===============================
    -- 🧩 VALUES8
    -- ===============================
    local final = {}
    for i = 0, 7 do
        final[#final + 1] = {
            address = ptr + i * 4,
            value = data.values8[i + 1],
            flags = gg.TYPE_DWORD
        }
    end

    gg.setValues(final)
    gg.toast("✅ Island Skin " .. index .. " applied!")
end

-------------------------------------------------

function colek10()
    while true do
        gg.setVisible(false)
        gg.clearResults()
        local indev = dev
        local skins = {
            "🎬 • Cinema Cow", "🧝 • Elf Cow", "💘 • Flirty Cow",
            "🚀 • Astronaut Cow", "🎉 • Party Cow",
            "🎂 • Birthday Cow", "🍰 • Confectioner Cow",
            "🧛 • Moo-sferatu", "🏔️ • Alpine Cow",
            "🎎 • Ceremonial Cow", "🐣 • Easter Cow",
            "🕵️ • Spy Cow", "👑 • Queen of Atlantis",
            "👗 • Stylish Cow", "🎄 • Festive Cow",
            "🏴‍☠️ • Corsair Cow", "❄️ • Arctic Cow",
            "🎼 • Symphony Cow", "🎸 • Rock ’n’ Roll Shades Cow",
            "🍣 • Japanese Cow", "🕌 • Arabian Cow",
            "🌸 • Flower Cow", "🌮 • Carnival Cow", "❌ • Go Back"
        }

        local choice = gg.multiChoice(skins, nil, indev)
        if not choice then return end

        -- 🔙 Back
        if choice[24] then
            if type(kums1) == "function" then kums1() end
            return
        end

        -- 🔁 Apply per pilihan
        for i = 1, 23 do
            if choice[i] then
                cowskin(i)
                gg.toast(skins[i] .. " applied\n👉 Claim in freeze reward!")

                repeat gg.sleep(500) until gg.isVisible(true)
                gg.setVisible(false)
            end
        end
    end
end

-- 🔐 Cache (reset jika game restart)
local cache = {copied = {}, sourceBase = nil, target = nil}

local cowSkin = {
    [1] = {patch = {1768641308, 1866686318, 1869438839, 6646134, 0, 0, 0, 1}},
    [2] = {
        patch = {
            1768641324, 1866686318, 1751342967, 1953720690, 846422381, 3289648,
            0, 1
        }
    },
    [3] = {
        patch = {
            1768641316, 1866686318, 1635147639, 1953391980, 6647401, 0, 0, 1
        }
    },
    [4] = {patch = {1768641306, 1866686318, 1634557815, 29554, 0, 0, 0, 1}},
    [5] = {
        patch = {1768641314, 1866686318, 1768054647, 1684567154, 31073, 0, 0, 1}
    },
    [6] = {patch = {1768641308, 1866686318, 2004049783, 7628133, 0, 0, 0, 1}},
    [7] = {patch = {1768641310, 1866686318, 2004049783, 846488933, 0, 0, 0, 1}},
    [8] = {
        patch = {
            1768641324, 1866686318, 1634230135, 2003790956, 846095717, 3355184,
            0, 1
        }
    },
    [9] = {
        patch = {
            1768641320, 1866686318, 1769430903, 1919251566, 1919905875, 116, 0,
            1
        }
    },
    [10] = {patch = {1768641304, 1866686318, 1313038199, 89, 0, 0, 0, 1}},
    [11] = {
        patch = {
            1768641318, 1866686318, 1634033527, 1919251571, 875704370, 0, 0, 1
        }
    },
    [12] = {patch = {1768641304, 1866686318, 1886609271, 121, 0, 0, 0, 1}},
    [13] = {
        patch = {1768641314, 1866686318, 1952538487, 1953390956, 29545, 0, 0, 1}
    },
    [14] = {
        patch = {
            1768641316, 1866686318, 1953062775, 846818401, 3420720, 0, 0, 1
        }
    },
    [15] = {
        patch = {
            1768641322, 1866686318, 1768054647, 1684567154, 808614241, 13362, 0,
            1
        }
    },
    [16] = {
        patch = {
            1768641318, 1866686318, 1768972151, 1702125938, 875704370, 0, 0, 1
        }
    },
    [17] = {
        patch = {1768641310, 1866686318, 1918984055, 1667855459, 0, 0, 0, 1}
    },
    [18] = {
        patch = {
            1768641322, 1866686318, 1818451831, 1769173857, 1937075555, 25449,
            0, 1
        }
    },
    [19] = {
        patch = {
            1768641324, 1866686318, 1765957495, 1684567154, 845117793, 3486256,
            0, 1
        }
    },
    [20] = {patch = {1768641308, 1866686318, 1634361207, 7233904, 0, 0, 0, 1}},
    [21] = {patch = {1768641306, 1866686318, 1918984055, 25185, 0, 0, 0, 1}},
    [22] = {
        patch = {1768641314, 1866686318, 1701207927, 1986622579, 27745, 0, 0, 1}
    },
    [23] = {
        patch = {
            1768641320, 1866686318, 1633902455, 1986621042, 929000545, 48, 0, 1
        }
    }
}

function cowskin(index)
    gg.setVisible(false)
    gg.clearResults()

    local data = cowSkin[index]
    if not data then
        gg.alert("⛔ Cow Skin " .. index .. " not found!\n\n" ..
                     "📢 Please restart the game and try again.")
        return
    end

    -- ===============================
    -- 📍 TARGET (sekali)
    -- ===============================
    if not cache.target then
        gg.searchNumber("2581275344925", gg.TYPE_QWORD)
        local t = gg.getResults(1)
        if #t == 0 then
            gg.alert(
                "⛔ Cow Skin source not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.target = t[1].address - 0x270
    end

    -- ===============================
    -- 🚀 MODE PATCH LANGSUNG
    -- ===============================
    if data.patch then
        local edits = {}
        for i = 0, 7 do
            edits[#edits + 1] = {
                address = cache.target + i * 4,
                flags = gg.TYPE_DWORD,
                value = data.patch[i + 1]
            }
        end
        gg.setValues(edits)
        gg.toast("✅ Cow Skin " .. index .. " applied!")
        return
    end

    -- ===============================
    -- 🔍 SOURCE (sekali)
    -- ===============================
    if not cache.sourceBase then
        gg.clearResults()
        gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)
        local r = gg.getResults(1)
        if #r == 0 then
            gg.alert(
                "❌ Cow Skin target not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.sourceBase = r[1].address + 0x1C
    end

    -- ===============================
    -- 📥 COPY HEADER (per index)
    -- ===============================
    if not cache.copied[index] then
        local temp = {}
        for i = 0, 5 do
            temp[#temp + 1] = {
                address = cache.sourceBase + i * 4,
                flags = gg.TYPE_DWORD
            }
        end
        cache.copied[index] = gg.getValues(temp)
    end

    -- ===============================
    -- 🧩 PASTE HEADER
    -- ===============================
    local edits = {}

    for i, v in ipairs(cache.copied[index]) do
        edits[#edits + 1] = {
            address = cache.target + (i - 1) * 4,
            value = v.value,
            flags = gg.TYPE_DWORD
        }
    end

    edits[#edits + 1] = {
        address = cache.target,
        value = data.offset0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 0x8,
        value = data.offset8,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 6 * 4,
        value = 0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 7 * 4,
        value = 1,
        flags = gg.TYPE_DWORD
    }

    gg.setValues(edits)

    -- ===============================
    -- 🔗 POINTER
    -- ===============================
    local ptr = tonumber(gg.getValues({
        {address = cache.target + 0x10, flags = gg.TYPE_QWORD}
    })[1].value)

    if not ptr or ptr == 0 then return end

    -- ===============================
    -- 🧩 VALUES8
    -- ===============================
    local final = {}
    for i = 0, 7 do
        final[#final + 1] = {
            address = ptr + i * 4,
            value = data.values8[i + 1],
            flags = gg.TYPE_DWORD
        }
    end

    gg.setValues(final)
    gg.toast("✅ Cow Skin " .. index .. " applied!")
end

-------------------------------------------------

function colek11()
    while true do
        gg.setVisible(false)
        gg.clearResults()
        local indev = dev
        local skins = {
            "🧑‍✈️ • Pilot Chicken", "🎭 • Harlequin Chicken",
            "📣 • Cheerleader Chicken", "📖 • Fairytale Chicken",
            "🧭 • Explorer Chicken", "🎂 • Birthday Chicken",
            "🎅 • Santa’s Little Helper", "🍀 • Leprechaun Chicken",
            "🏺 • Chicken in a Chiton", "🧳 • Vacation Chicken",
            "🎄 • Festive Chicken", "🎉 • Party Chicken",
            "🎃 • Halloween Chicken", "🧧 • Festive Lunar Chicken",
            "🎸 • Rock ’n’ Roll Shades Chicken",
            "🎸 • Rock ’n’ Roll Chicken", "🚀 • Astro Chicken",
            "🎭 • Broadway Chicken", "❌ • Go Back"
        }

        local choice = gg.multiChoice(skins, nil, indev)
        if not choice then return end

        -- 🔙 Back
        if choice[19] then
            if type(kums1) == "function" then kums1() end
            return
        end

        -- 🔁 Apply per pilihan
        for i = 1, 18 do
            if choice[i] then
                chickenskin(i)
                gg.toast(skins[i] .. " applied\n👉 Claim in freeze reward!")

                repeat gg.sleep(500) until gg.isVisible(true)
                gg.setVisible(false)
            end
        end
    end
end

-- 🔐 Cache (reset jika game restart)
local cache = {copied = {}, sourceBase = nil, target = nil}

local chickenSkin = {
    [1] = {
        patch = {
            1768641318, 1749245806, 1701536617, 1920229230, 1818588769, 0, 0, 1
        }
    },
    [2] = {
        offset0 = 25,
        offset8 = 23,
        values8 = {
            1852402515, 1768440671, 1852140387, 1701344351, 1769108577, 7102819,
            0, 0, 1852402515, 1919895135, 1936028276, 1749245811
        }
    },
    [3] = {
        patch = {
            1768641316, 1749245806, 1701536617, 1886609262, 7631471, 0, 0, 1
        }
    },
    [4] = {
        offset0 = 25,
        offset8 = 23,
        values8 = {
            1852402515, 1768440671, 1852140387, 1852400479, 1701995876, 6384748,
            0, 0, 1852402515, 1919895135, 1936028276, 1749245811
        }
    },
    [5] = {
        patch = {
            1768641318, 1749245806, 1701536617, 1969905518, 1701603182, 0, 0, 1
        }
    },
    [6] = {
        patch = {
            1768641316, 1749245806, 1701536617, 2004049774, 7628133, 0, 0, 1
        }
    },
    [7] = {
        offset0 = 33,
        offset8 = 26,
        values8 = {
            1852402515, 1768440671, 1852140387, 1919443807, 1836348265,
            808612705, -117427406, 112, 1852402515, 1919895135, 1936028276,
            1749245811
        }
    },
    [8] = {
        patch = {
            1768641320, 1749245806, 1701536617, 1919508334, 1851878501, 100, 0,
            1
        }
    },
    [9] = {
        patch = {
            1768641318, 1749245806, 1701536617, 1701338990, 1935764588, 0, 0, 1
        }
    },
    [10] = {
        offset0 = 33,
        offset8 = 25,
        values8 = {
            1852402515, 1768440671, 1852140387, 1819042143, 1818455657,
            1986622325, 101, 0, 1852402515, 1919895135, 1936028276, 1749245811
        }
    },
    [11] = {
        offset0 = 33,
        offset8 = 25,
        values8 = {
            1852402515, 1768440671, 1852140387, 1919509087, 1633970292,
            842019449, 52, 0, 1852402515, 1919895135, 1936028276, 1749245811
        }
    },
    [12] = {
        offset0 = 33,
        offset8 = 26,
        values8 = {
            1852402515, 1768440671, 1852140387, 1919509087, 1633970292,
            842019449, 25396, 0, 1852402515, 1919895135, 1936028276, 1749245811
        }
    },
    [13] = {
        offset0 = 33,
        offset8 = 26,
        values8 = {
            1852402515, 1768440671, 1852140387, 1818323039, 1702326124,
            808611429, 13362, 0, 1852402515, 1919895135, 1936028276, 1749245811
        }
    },
    [14] = {
        patch = {
            1768641320, 1749245806, 1701536617, 1852006254, 842019449, 53, 0, 1
        }
    },
    [15] = {
        offset0 = 49,
        offset8 = 27,
        values8 = {
            1852402515, 1768440671, 1852140387, 1919500895, 1633970292,
            808607609, 7550258, 1718511967, 1701669204, 0, 0, 0
        }
    },
    [16] = {
        offset0 = 49,
        offset8 = 26,
        values8 = {
            1852402515, 1768440671, 1852140387, 1919500895, 1633970292,
            808607609, 13618, 0, 1684632838, 0, 88, 0
        }
    },
    [17] = {
        patch = {
            1768641322, 1749245806, 1701536617, 1634557806, 808612722, 13618, 0,
            1
        }
    },
    [18] = {
        offset0 = 49,
        offset8 = 24,
        values8 = {
            1852402515, 1768440671, 1852140387, 1869767263, 1635214433,
            959864697, -1705097216, 112, 1869116186, 1382959479, 1918990181,
            29540
        }
    }
}

function chickenskin(index)
    gg.setVisible(false)
    gg.clearResults()

    local data = chickenSkin[index]
    if not data then
        gg.alert("⛔ Chicken Skin " .. index .. " not found!\n\n" ..
                     "📢 Please restart the game and try again.")
        return
    end

    -- ===============================
    -- 📍 TARGET (sekali)
    -- ===============================
    if not cache.target then
        gg.searchNumber("2581275344925", gg.TYPE_QWORD)
        local t = gg.getResults(1)
        if #t == 0 then
            gg.alert(
                "⛔ Chicken Skin source not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.target = t[1].address - 0x270
    end

    -- ===============================
    -- 🚀 MODE PATCH LANGSUNG
    -- ===============================
    if data.patch then
        local edits = {}
        for i = 0, 7 do
            edits[#edits + 1] = {
                address = cache.target + i * 4,
                flags = gg.TYPE_DWORD,
                value = data.patch[i + 1]
            }
        end
        gg.setValues(edits)
        gg.toast("✅ Chicken Skin " .. index .. " applied!")
        return
    end

    -- ===============================
    -- 🔍 SOURCE (sekali)
    -- ===============================
    if not cache.sourceBase then
        gg.clearResults()
        gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)
        local r = gg.getResults(1)
        if #r == 0 then
            gg.alert(
                "❌ Chicken Skin target not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.sourceBase = r[1].address + 0x1C
    end

    -- ===============================
    -- 📥 COPY HEADER (per index)
    -- ===============================
    if not cache.copied[index] then
        local temp = {}
        for i = 0, 5 do
            temp[#temp + 1] = {
                address = cache.sourceBase + i * 4,
                flags = gg.TYPE_DWORD
            }
        end
        cache.copied[index] = gg.getValues(temp)
    end

    -- ===============================
    -- 🧩 PASTE HEADER
    -- ===============================
    local edits = {}

    for i, v in ipairs(cache.copied[index]) do
        edits[#edits + 1] = {
            address = cache.target + (i - 1) * 4,
            value = v.value,
            flags = gg.TYPE_DWORD
        }
    end

    edits[#edits + 1] = {
        address = cache.target,
        value = data.offset0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 0x8,
        value = data.offset8,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 6 * 4,
        value = 0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 7 * 4,
        value = 1,
        flags = gg.TYPE_DWORD
    }

    gg.setValues(edits)

    -- ===============================
    -- 🔗 POINTER
    -- ===============================
    local ptr = tonumber(gg.getValues({
        {address = cache.target + 0x10, flags = gg.TYPE_QWORD}
    })[1].value)

    if not ptr or ptr == 0 then return end

    -- ===============================
    -- 🧩 VALUES8
    -- ===============================
    local final = {}
    for i = 0, 11 do
        final[#final + 1] = {
            address = ptr + i * 4,
            value = data.values8[i + 1],
            flags = gg.TYPE_DWORD
        }
    end

    gg.setValues(final)
    gg.toast("✅ Chicken Skin " .. index .. " applied!")
end

-------------------------------------------------

function colek12()
    while true do
        gg.setVisible(false)
        gg.clearResults()
        local indev = dev
        local skins = {
            "🧙‍♀️ • Witch Sheep", "🌸 • Spring Festival Sheep",
            "🐣 • Easter Sheep", "🛡️ • Nordic Sheep",
            "🕵️ • Sleuth Sheep", "🎂 • Birthday Sheep",
            "🎩 • Noble Bandit", "💃 • Samba Sheep",
            "🎸 • Rock ’n’ Roll Sheep", "⚔️ • Baa-ttle Sheep",
            "👥 • Baa Baa Bandits", "🍫 • Billy Bonka",
            "🎄 • Festive Sheep", "🐫 • Egyptian Sheep",
            "🎅 • Christmas Sheep", "🕺 • Ballroom Sheep",
            "🎸 • Rock ’n’ Roll Shader Sheep", "🎸 • Rocker Sheep",
            "🐉 • Mythic Sheep", "🧳 • Vacation Sheep",
            "❌ • Go Back"
        }

        local choice = gg.multiChoice(skins, nil, indev)
        if not choice then return end

        -- 🔙 Back
        if choice[21] then
            if type(kums1) == "function" then kums1() end
            return
        end

        -- 🔁 Apply per pilihan
        for i = 1, 20 do
            if choice[i] then
                sheepskin(i)
                gg.toast(skins[i] .. " applied\n👉 Claim in freeze reward!")

                repeat gg.sleep(500) until gg.isVisible(true)
                gg.setVisible(false)
            end
        end
    end
end

-- 🔐 Cache (reset jika game restart)
local cache = {copied = {}, sourceBase = nil, target = nil}

local sheepSkin = {
    [1] = {
        offset0 = 33,
        offset8 = 24,
        values8 = {
            1852402515, 1701335903, 1751085157, 1869376609, 1852138871,
            842149938, 0, 0, 1852402515, 1919895135, 1936028276, 1749245811
        }
    },
    [2] = {
        patch = {
            1768641324, 1750294382, 1601201509, 1634628972, 844713586, 3289648,
            0, 1
        }
    },
    [3] = {
        patch = {
            1768641322, 1750294382, 1601201509, 1953718629, 808612453, 13106, 0,
            1
        }
    },
    [4] = {
        patch = {
            1768641320, 1750294382, 1601201509, 1685221230, 1866949481, 100, 0,
            1
        }
    },
    [5] = {
        patch = {
            1768641320, 1750294382, 1601201509, 1702126948, 1986622563, 101, 0,
            1
        }
    },
    [6] = {
        patch = {1768641312, 1750294382, 1601201509, 1701148531, 116, 0, 0, 1}
    },
    [7] = {
        patch = {
            1768641320, 1750294382, 1601201509, 1768058738, 1869564014, 100, 0,
            1
        }
    },
    [8] = {
        patch = {1768641314, 1750294382, 1601201509, 2053206626, 27753, 0, 0, 1}
    },
    [9] = {
        patch = {
            1768641320, 1750294382, 1601201509, 1801678706, 1819243118, 108, 0,
            1
        }
    },
    [10] = {
        patch = {1768641314, 1750294382, 1601201509, 1734962795, 29800, 0, 0, 1}
    },
    [11] = {
        offset0 = 25,
        offset8 = 23,
        values8 = {
            1852402515, 1701335903, 2002743397, 2003070057, 846492517, 3420720,
            1852795252, 0, 1852402515, 1919895135, 1936028276, 1749245811
        }
    },
    [12] = {
        offset0 = 25,
        offset8 = 23,
        values8 = {
            1852402515, 1701335903, 1650421861, 1752461929, 846815588, 3420720,
            1869181952, 110, 1852402515, 1919895135, 1936028276, 1749245811
        }
    },
    [13] = {
        offset0 = 33,
        offset8 = 24,
        values8 = {
            1852402515, 1701335903, 1650421861, 1752461929, 846815588,
            1932800560, 1953391872, 0, 1852402515, 1919895135, 1936028276,
            1749245811
        }
    },
    [14] = {
        patch = {1768641312, 1750294382, 1601201509, 1887004517, 116, 0, 0, 1}
    },
    [15] = {
        offset0 = 33,
        offset8 = 24,
        values8 = {
            1852402515, 1701335903, 1667199077, 1936290408, 1935764852,
            875704370, 0, 0, 1852402515, 1919895135, 1936028276, 1749245811
        }
    },
    [16] = {
        patch = {
            1768641322, 1750294382, 1601201509, 1903386989, 1634887029, 25956,
            0, 1
        }
    },
    [17] = {
        offset0 = 49,
        offset8 = 23,
        values8 = {
            1852402515, 1701335903, 1650421861, 1752461929, 846815588, 3486256,
            0, 0, 0, 0, -1704931413, 112
        }
    },
    [18] = {
        offset0 = 49,
        offset8 = 24,
        values8 = {
            1852402515, 1701335903, 1113550949, 1752461929, 1601790308,
            892481586, -1705094400, 112, 1835101704, 101, 88, 0
        }
    },
    [19] = {
        patch = {
            1768641322, 1750294382, 1601201509, 1819043176, 808612705, 13618, 0,
            1
        }
    },
    [20] = {
        offset0 = 49,
        offset8 = 27,
        values8 = {
            1852402515, 1701335903, 1633644645, 1852402796, 1937075299,
            845510249, 3486256, 112, 5779456, 0, -1704931362, 112
        }
    }
}

function sheepskin(index)
    gg.setVisible(false)
    gg.clearResults()

    local data = sheepSkin[index]
    if not data then
        gg.alert("⛔ Sheep Skin " .. index .. " not found!\n\n" ..
                     "📢 Please restart the game and try again.")
        return
    end

    -- ===============================
    -- 📍 TARGET (sekali)
    -- ===============================
    if not cache.target then
        gg.searchNumber("2581275344925", gg.TYPE_QWORD)
        local t = gg.getResults(1)
        if #t == 0 then
            gg.alert(
                "⛔ Sheep Skin source not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.target = t[1].address - 0x270
    end

    -- ===============================
    -- 🚀 MODE PATCH LANGSUNG
    -- ===============================
    if data.patch then
        local edits = {}
        for i = 0, 7 do
            edits[#edits + 1] = {
                address = cache.target + i * 4,
                flags = gg.TYPE_DWORD,
                value = data.patch[i + 1]
            }
        end
        gg.setValues(edits)
        gg.toast("✅ Sheep Skin " .. index .. " applied!")
        return
    end

    -- ===============================
    -- 🔍 SOURCE (sekali)
    -- ===============================
    if not cache.sourceBase then
        gg.clearResults()
        gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)
        local r = gg.getResults(1)
        if #r == 0 then
            gg.alert(
                "❌ Sheep Skin target not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.sourceBase = r[1].address + 0x1C
    end

    -- ===============================
    -- 📥 COPY HEADER (per index)
    -- ===============================
    if not cache.copied[index] then
        local temp = {}
        for i = 0, 5 do
            temp[#temp + 1] = {
                address = cache.sourceBase + i * 4,
                flags = gg.TYPE_DWORD
            }
        end
        cache.copied[index] = gg.getValues(temp)
    end

    -- ===============================
    -- 🧩 PASTE HEADER
    -- ===============================
    local edits = {}

    for i, v in ipairs(cache.copied[index]) do
        edits[#edits + 1] = {
            address = cache.target + (i - 1) * 4,
            value = v.value,
            flags = gg.TYPE_DWORD
        }
    end

    edits[#edits + 1] = {
        address = cache.target,
        value = data.offset0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 0x8,
        value = data.offset8,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 6 * 4,
        value = 0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 7 * 4,
        value = 1,
        flags = gg.TYPE_DWORD
    }

    gg.setValues(edits)

    -- ===============================
    -- 🔗 POINTER
    -- ===============================
    local ptr = tonumber(gg.getValues({
        {address = cache.target + 0x10, flags = gg.TYPE_QWORD}
    })[1].value)

    if not ptr or ptr == 0 then return end

    -- ===============================
    -- 🧩 VALUES8
    -- ===============================
    local final = {}
    for i = 0, 11 do
        final[#final + 1] = {
            address = ptr + i * 4,
            value = data.values8[i + 1],
            flags = gg.TYPE_DWORD
        }
    end

    gg.setValues(final)
    gg.toast("✅ Sheep Skin " .. index .. " applied!")
end

-------------------------------------------------

function colek13()
    while true do
        gg.setVisible(false)
        gg.clearResults()
        local indev = dev
        local skins = {
            "💘 • Cupid Pig", "🎎 • Ceremonial Pig", "❌ • Go Back"
        }

        local choice = gg.multiChoice(skins, nil, indev)
        if not choice then return end

        -- 🔙 Back
        if choice[3] then
            if type(kums1) == "function" then kums1() end
            return
        end

        -- 🔁 Apply per pilihan
        for i = 1, 2 do
            if choice[i] then
                pigskin(i)
                gg.toast(skins[i] .. " applied\n👉 Claim in freeze reward!")

                repeat gg.sleep(500) until gg.isVisible(true)
                gg.setVisible(false)
            end
        end
    end
end

-- 🔐 Cache (reset jika game restart)
local cache = {copied = {}, sourceBase = nil, target = nil}

local pigSkin = {
    [1] = {
        patch = {
            1768641324, 1766874990, 1635147623, 1953391980, 1936027241, 7954756,
            0, 1
        }
    },
    [2] = {patch = {1768641304, 1766874990, 1313038183, 89, 0, 0, 0, 1}}
}

function pigskin(index)
    gg.setVisible(false)
    gg.clearResults()

    local data = pigSkin[index]
    if not data then
        gg.alert("⛔ Pig Skin " .. index .. " not found!\n\n" ..
                     "📢 Please restart the game and try again.")
        return
    end

    -- ===============================
    -- 📍 TARGET (sekali)
    -- ===============================
    if not cache.target then
        gg.searchNumber("2581275344925", gg.TYPE_QWORD)
        local t = gg.getResults(1)
        if #t == 0 then
            gg.alert(
                "⛔ Pig Skin source not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.target = t[1].address - 0x270
    end

    -- ===============================
    -- 🚀 MODE PATCH LANGSUNG
    -- ===============================
    if data.patch then
        local edits = {}
        for i = 0, 7 do
            edits[#edits + 1] = {
                address = cache.target + i * 4,
                flags = gg.TYPE_DWORD,
                value = data.patch[i + 1]
            }
        end
        gg.setValues(edits)
        gg.toast("✅ Pig Skin " .. index .. " applied!")
        return
    end

    -- ===============================
    -- 🔍 SOURCE (sekali)
    -- ===============================
    if not cache.sourceBase then
        gg.clearResults()
        gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)
        local r = gg.getResults(1)
        if #r == 0 then
            gg.alert(
                "❌ Pig Skin target not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.sourceBase = r[1].address + 0x1C
    end

    -- ===============================
    -- 📥 COPY HEADER (per index)
    -- ===============================
    if not cache.copied[index] then
        local temp = {}
        for i = 0, 5 do
            temp[#temp + 1] = {
                address = cache.sourceBase + i * 4,
                flags = gg.TYPE_DWORD
            }
        end
        cache.copied[index] = gg.getValues(temp)
    end

    -- ===============================
    -- 🧩 PASTE HEADER
    -- ===============================
    local edits = {}

    for i, v in ipairs(cache.copied[index]) do
        edits[#edits + 1] = {
            address = cache.target + (i - 1) * 4,
            value = v.value,
            flags = gg.TYPE_DWORD
        }
    end

    edits[#edits + 1] = {
        address = cache.target,
        value = data.offset0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 0x8,
        value = data.offset8,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 6 * 4,
        value = 0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 7 * 4,
        value = 1,
        flags = gg.TYPE_DWORD
    }

    gg.setValues(edits)

    -- ===============================
    -- 🔗 POINTER
    -- ===============================
    local ptr = tonumber(gg.getValues({
        {address = cache.target + 0x10, flags = gg.TYPE_QWORD}
    })[1].value)

    if not ptr or ptr == 0 then return end

    -- ===============================
    -- 🧩 VALUES8
    -- ===============================
    local final = {}
    for i = 0, 7 do
        final[#final + 1] = {
            address = ptr + i * 4,
            value = data.values8[i + 1],
            flags = gg.TYPE_DWORD
        }
    end

    gg.setValues(final)
    gg.toast("✅ Pig Skin " .. index .. " applied!")
end

-------------------------------------------------

function kums2()
    local title = banner
    local menu = gg.choice({
        "🪧 • Old Event Town Sign", "🪧 • Regatta Town Sign",
        "🪧 • Expedition Town Sign", "❌ • Go Back"
    }, nil, title)

    if menu == nil then
        return
    elseif menu == 1 then
        townsign1()
    elseif menu == 2 then
        townsign2()
    elseif menu == 3 then
        townsign3()
    elseif menu == 4 then
        gp3()
    end
end

function townsign1()
    while true do
        gg.setVisible(false)
        gg.clearResults()
        local indev = dev
        local skins = {
            "🐣 • Easter Town Sign", "🎈 • Town Day Town Sign",
            "🎃 • Big Halloween Sign", "🎄 • Christmas Town Sign I",
            "🌾 • Good Old Rancho Sign", "📺 • Big Screen Town Sign",
            "✈️ • Aviator Town Sign", "🌺 • Aloha Town Sign",
            "👻 • Paranormal Town Sign", "👾 • Inflatable Monster Sign",
            "🏂 • Snowboarding Town Sign",
            "🍬 • Bubble Gum for All Sign", "🥤 • Smoothie Stand Sign",
            "🏠 • Cozy Home Sign", "🎄 • Christmas Town Sign II",
            "🎤 • Coming to You Live Sign",
            "🌃 • The Town Never Sleeps Sign",
            "🍎 • Big Apple Town Sign", "🧚 • Fairytale Town Sign",
            "🎸 • Rock Town Sign", "🎉 • Anniversary Town Sign",
            "❌ • Go Back"
        }

        local choice = gg.multiChoice(skins, nil, indev)
        if not choice then return end

        -- 🔙 Back
        if choice[22] then
            if type(kums2) == "function" then kums2() end
            return
        end

        -- 🔁 Apply per pilihan
        for i = 1, 21 do
            if choice[i] then
                oldsign(i)
                gg.toast(skins[i] .. " applied\n👉 Claim in freeze reward!")

                repeat gg.sleep(500) until gg.isVisible(true)
                gg.setVisible(false)
            end
        end
    end
end

-- 🔐 Cache (reset jika game restart)
local cache = {copied = {}, sourceBase = nil, target = nil}

local oldSign = {
    [1] = {
        offset0 = 33,
        offset8 = 26,
        values8 = {
            1852402547, 1953063775, 1769168761, 1700752999, 1702130529,
            1769168754, -1946128793, 112
        }
    },
    [2] = {
        offset0 = 33,
        offset8 = 28,
        values8 = {
            1852402547, 1953063775, 1769168761, 1650421351, 1752461929,
            1601790308, 1852270963, 0
        }
    },
    [3] = {
        offset0 = 33,
        offset8 = 29,
        values8 = {
            1852402547, 1953063775, 1769168761, 1751084647, 1869376609,
            1852138871, 1734964063, 110
        }
    },
    [4] = {
        offset0 = 33,
        offset8 = 29,
        values8 = {
            1852402547, 1953063775, 1769168761, 1667198567, 1936290408,
            1935764852, 1734964063, 110
        }
    },
    [5] = {
        offset0 = 25,
        offset8 = 23,
        values8 = {
            1852402547, 1953063775, 1769168761, 1667198567, 1935636335, 7235433,
            4, 0
        }
    },
    [6] = {
        offset0 = 33,
        offset8 = 26,
        values8 = {
            1852402547, 1953063775, 1769168761, 1667198567, 1835363945,
            1769168737, 28263, 0
        }
    },
    [7] = {
        offset0 = 33,
        offset8 = 26,
        values8 = {
            1852402547, 1953063775, 1769168761, 2002742887, 1701277289,
            1769168740, -1946128793, 112
        }
    },
    [8] = {
        offset0 = 33,
        offset8 = 25,
        values8 = {
            1852402547, 1953063775, 1769168761, 1885302375, 1601006689,
            1701147252, -1945239437, 112
        }
    },
    [9] = {
        offset0 = 33,
        offset8 = 30,
        values8 = {
            1852402547, 1953063775, 1769168761, 1834970727, 1769239417,
            1600938339, 1852143205, 29556
        }
    },
    [10] = {
        offset0 = 33,
        offset8 = 30,
        values8 = {
            1852402547, 1953063775, 1769168761, 1717530215, 1802396018,
            1818323039, 1702326124, 28261
        }
    },
    [11] = {
        offset0 = 33,
        offset8 = 29,
        values8 = {
            1852402547, 1953063775, 1769168761, 1935634023, 1651994478,
            1685217647, 1734964063, 110
        }
    },
    [12] = {
        offset0 = 33,
        offset8 = 31,
        values8 = {
            1852402547, 1953063775, 1769168761, 1918856807, 1852403061,
            1601465953, 1751343469, 6647401
        }
    },
    [13] = {
        offset0 = 33,
        offset8 = 31,
        values8 = {
            1852402547, 1953063775, 1769168761, 1935634023, 1953460077,
            1650813288, 1935635041, 7235433
        }
    },
    [14] = {
        offset0 = 33,
        offset8 = 29,
        values8 = {
            1852402547, 1953063775, 1769168761, 1717530215, 1768845941,
            1701999988, 1734964063, 110
        }
    },
    [15] = {
        offset0 = 33,
        offset8 = 26,
        values8 = {
            1852402547, 1953063775, 1769168761, 1398763111, 959930192,
            1769168688, -1946128793, 112
        }
    },
    [16] = {
        offset0 = 33,
        offset8 = 27,
        values8 = {
            1852402547, 1953063775, 1769168761, 1415540327, 1768120150,
            1935636852, 7235433, 112
        }
    },
    [17] = {
        offset0 = 33,
        offset8 = 30,
        values8 = {
            1852402547, 1953063775, 1769168761, 1683975783, 1868788585,
            1953063775, 1769168761, 28263
        }
    },
    [18] = {
        offset0 = 33,
        offset8 = 27,
        values8 = {
            1852402547, 1953063775, 1769168761, 1751084647, 1702261345,
            1935635571, 7235433, 0
        }
    },
    [19] = {
        offset0 = 33,
        offset8 = 26,
        values8 = {
            1852402547, 1953063775, 1769168761, 1633644135, 1768055154,
            1769168739, -1946128793, 112
        }
    },
    [20] = {
        offset0 = 33,
        offset8 = 24,
        values8 = {
            1852402547, 1953063775, 1769168761, 1918856807, 1600873327,
            1852270963, 0, 0
        }
    },
    [21] = {
        offset0 = 33,
        offset8 = 31,
        values8 = {
            1852402547, 1953063775, 1769168761, 1650421351, 1752461929,
            1601790308, 1702441009, 7565921
        }
    }
}

function oldsign(index)
    gg.setVisible(false)
    gg.clearResults()

    local data = oldSign[index]
    if not data then
        gg.alert("⛔ Old Event Town Sign " .. index .. " not found!\n\n" ..
                     "📢 Please restart the game and try again.")
        return
    end

    -- ===============================
    -- 📍 TARGET (sekali)
    -- ===============================
    if not cache.target then
        gg.searchNumber("2581275344925", gg.TYPE_QWORD)
        local t = gg.getResults(1)
        if #t == 0 then
            gg.alert(
                "⛔ Old Event Town Sign source not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.target = t[1].address - 0x270
    end

    -- ===============================
    -- 🚀 MODE PATCH LANGSUNG
    -- ===============================
    if data.patch then
        local edits = {}
        for i = 0, 7 do
            edits[#edits + 1] = {
                address = cache.target + i * 4,
                flags = gg.TYPE_DWORD,
                value = data.patch[i + 1]
            }
        end
        gg.setValues(edits)
        gg.toast("✅ Old Event Town Sign " .. index .. " applied!")
        return
    end

    -- ===============================
    -- 🔍 SOURCE (sekali)
    -- ===============================
    if not cache.sourceBase then
        gg.clearResults()
        gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)
        local r = gg.getResults(1)
        if #r == 0 then
            gg.alert(
                "❌ Old Event Town Sign target not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.sourceBase = r[1].address + 0x1C
    end

    -- ===============================
    -- 📥 COPY HEADER (per index)
    -- ===============================
    if not cache.copied[index] then
        local temp = {}
        for i = 0, 5 do
            temp[#temp + 1] = {
                address = cache.sourceBase + i * 4,
                flags = gg.TYPE_DWORD
            }
        end
        cache.copied[index] = gg.getValues(temp)
    end

    -- ===============================
    -- 🧩 PASTE HEADER
    -- ===============================
    local edits = {}

    for i, v in ipairs(cache.copied[index]) do
        edits[#edits + 1] = {
            address = cache.target + (i - 1) * 4,
            value = v.value,
            flags = gg.TYPE_DWORD
        }
    end

    edits[#edits + 1] = {
        address = cache.target,
        value = data.offset0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 0x8,
        value = data.offset8,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 6 * 4,
        value = 0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 7 * 4,
        value = 1,
        flags = gg.TYPE_DWORD
    }

    gg.setValues(edits)

    -- ===============================
    -- 🔗 POINTER
    -- ===============================
    local ptr = tonumber(gg.getValues({
        {address = cache.target + 0x10, flags = gg.TYPE_QWORD}
    })[1].value)

    if not ptr or ptr == 0 then return end

    -- ===============================
    -- 🧩 VALUES8
    -- ===============================
    local final = {}
    for i = 0, 7 do
        final[#final + 1] = {
            address = ptr + i * 4,
            value = data.values8[i + 1],
            flags = gg.TYPE_DWORD
        }
    end

    gg.setValues(final)
    gg.toast("✅ Old Event Town Sign " .. index .. " applied!")
end

-------------------------------------------------

function townsign2()
    while true do
        gg.setVisible(false)
        gg.clearResults()
        local indev = dev
        local skins = {
            "🏴‍☠️ • Pirate Town Sign", "❄️ • Winter Town Sign",
            "🎉 • Festive Town Sign", "🎃 • Big Halloween Sign",
            "☃️ • Winter Wonder Town Sign", "❌ • Go Back"
        }

        local choice = gg.multiChoice(skins, nil, indev)
        if not choice then return end

        -- 🔙 Back
        if choice[6] then
            if type(kums2) == "function" then kums2() end
            return
        end

        -- 🔁 Apply per pilihan
        for i = 1, 5 do
            if choice[i] then
                regattasign(i)
                gg.toast(skins[i] .. " applied\n👉 Claim in freeze reward!")

                repeat gg.sleep(500) until gg.isVisible(true)
                gg.setVisible(false)
            end
        end
    end
end

-- 🔐 Cache (reset jika game restart)
local cache = {copied = {}, sourceBase = nil, target = nil}

local regattaSign = {
    [1] = {
        offset0 = 41,
        offset8 = 32,
        values8 = {
            1852402547, 1953063775, 1769168761, 1918856807, 1952540517,
            845111668, 1596993585, 1852270963
        }
    },
    [2] = {
        offset0 = 41,
        offset8 = 32,
        values8 = {
            1852402547, 1953063775, 1769168761, 1918856807, 1952540517,
            845111668, 1596993587, 1852270963
        }
    },
    [3] = {
        offset0 = 41,
        offset8 = 32,
        values8 = {
            1852402547, 1953063775, 1769168761, 1918856807, 1952540517,
            845111668, 1596993588, 1852270963
        }
    },
    [4] = {
        offset0 = 41,
        offset8 = 32,
        values8 = {
            1852402547, 1953063775, 1769168761, 1918856807, 1952540517,
            861888884, 1596993584, 1852270963
        }
    },
    [5] = {
        offset0 = 41,
        offset8 = 32,
        values8 = {
            1852402547, 1953063775, 1769168761, 1918856807, 1952540517,
            861888884, 1596993585, 1852270963
        }
    }
}

function regattasign(index)
    gg.setVisible(false)
    gg.clearResults()

    local data = regattaSign[index]
    if not data then
        gg.alert("⛔ Regatta Town Sign " .. index .. " not found!\n\n" ..
                     "📢 Please restart the game and try again.")
        return
    end

    -- ===============================
    -- 📍 TARGET (sekali)
    -- ===============================
    if not cache.target then
        gg.searchNumber("2581275344925", gg.TYPE_QWORD)
        local t = gg.getResults(1)
        if #t == 0 then
            gg.alert(
                "⛔ Regatta Town Sign source not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.target = t[1].address - 0x270
    end

    -- ===============================
    -- 🚀 MODE PATCH LANGSUNG
    -- ===============================
    if data.patch then
        local edits = {}
        for i = 0, 7 do
            edits[#edits + 1] = {
                address = cache.target + i * 4,
                flags = gg.TYPE_DWORD,
                value = data.patch[i + 1]
            }
        end
        gg.setValues(edits)
        gg.toast("✅ Regatta Town Sign " .. index .. " applied!")
        return
    end

    -- ===============================
    -- 🔍 SOURCE (sekali)
    -- ===============================
    if not cache.sourceBase then
        gg.clearResults()
        gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)
        local r = gg.getResults(1)
        if #r == 0 then
            gg.alert(
                "❌ Regatta Town Sign target not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.sourceBase = r[1].address + 0x1C
    end

    -- ===============================
    -- 📥 COPY HEADER (per index)
    -- ===============================
    if not cache.copied[index] then
        local temp = {}
        for i = 0, 5 do
            temp[#temp + 1] = {
                address = cache.sourceBase + i * 4,
                flags = gg.TYPE_DWORD
            }
        end
        cache.copied[index] = gg.getValues(temp)
    end

    -- ===============================
    -- 🧩 PASTE HEADER
    -- ===============================
    local edits = {}

    for i, v in ipairs(cache.copied[index]) do
        edits[#edits + 1] = {
            address = cache.target + (i - 1) * 4,
            value = v.value,
            flags = gg.TYPE_DWORD
        }
    end

    edits[#edits + 1] = {
        address = cache.target,
        value = data.offset0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 0x8,
        value = data.offset8,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 6 * 4,
        value = 0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 7 * 4,
        value = 1,
        flags = gg.TYPE_DWORD
    }

    gg.setValues(edits)

    -- ===============================
    -- 🔗 POINTER
    -- ===============================
    local ptr = tonumber(gg.getValues({
        {address = cache.target + 0x10, flags = gg.TYPE_QWORD}
    })[1].value)

    if not ptr or ptr == 0 then return end

    -- ===============================
    -- 🧩 VALUES8
    -- ===============================
    local final = {}
    for i = 0, 7 do
        final[#final + 1] = {
            address = ptr + i * 4,
            value = data.values8[i + 1],
            flags = gg.TYPE_DWORD
        }
    end

    gg.setValues(final)
    gg.toast("✅ Regatta Town Sign " .. index .. " applied!")
end

-------------------------------------------------

function townsign3()
    while true do
        gg.setVisible(false)
        gg.clearResults()
        local indev = dev
        local skins = {
            "🔮 • Supernatural Town Sign", "🐙 • Cthuthun Town Sign",
            "🎉 • Holiday Town Sign", "🛸 • Extraterrestrial Town Sign",
            "👻 • Ghostly Town Sign", "🏜️ • Dessert Town Sign",
            "🤠 • Cowboy Town Sign",
            "🗿 • Power of Ancestors Town Sign",
            "🌊 • Atlantis Town Sign", "🌱 • Smart Garden Town Sign",
            "🍬 • Sweet Treat Town Sign",
            "🐧 • Penguin Resort Town Sign", "❌ • Go Back"
        }

        local choice = gg.multiChoice(skins, nil, indev)
        if not choice then return end

        -- 🔙 Back
        if choice[13] then
            if type(kums2) == "function" then kums2() end
            return
        end

        -- 🔁 Apply per pilihan
        for i = 1, 12 do
            if choice[i] then
                expesign(i)
                gg.toast(skins[i] .. " applied\n👉 Claim in freeze reward!")

                repeat gg.sleep(500) until gg.isVisible(true)
                gg.setVisible(false)
            end
        end
    end
end

-- 🔐 Cache (reset jika game restart)
local cache = {copied = {}, sourceBase = nil, target = nil}

local expeSign = {
    [1] = {
        offset0 = 41,
        offset8 = 37,
        values8 = {
            1852402547, 1953063775, 1769168761, 1700752999, 1684369528,
            1869182057, 1597190766, 808464946, 1734964063, 110, 2086167891, 112
        }
    },
    [2] = {
        offset0 = 41,
        offset8 = 37,
        values8 = {
            1852402547, 1953063775, 1769168761, 1700752999, 1684369528,
            1869182057, 1597256302, 808465202, 1734964063, 110, 2086167891, 112
        }
    },
    [3] = {
        offset0 = 41,
        offset8 = 37,
        values8 = {
            1852402547, 1953063775, 1769168761, 1700752999, 1684369528,
            1869182057, 1597321838, 808465202, 1734964063, 110, 2086167891, 112
        }
    },
    [4] = {
        offset0 = 41,
        offset8 = 37,
        values8 = {
            1852402547, 1953063775, 1769168761, 1700752999, 1684369528,
            1869182057, 1597387374, 808465458, 1734964063, 110, 2086167891, 112
        }
    },
    [5] = {
        offset0 = 41,
        offset8 = 37,
        values8 = {
            1852402547, 1953063775, 1769168761, 1700752999, 1684369528,
            1869182057, 1597452910, 808465458, 1734964063, 110, 2086167891, 112
        }
    },
    [6] = {
        offset0 = 41,
        offset8 = 37,
        values8 = {
            1852402547, 1953063775, 1769168761, 1700752999, 1684369528,
            1869182057, 1597518446, 808465714, 1734964063, 110, 2086167891, 112
        }
    },
    [7] = {
        offset0 = 41,
        offset8 = 37,
        values8 = {
            1852402547, 1953063775, 1769168761, 1700752999, 1684369528,
            1869182057, 1597583982, 808465714, 1734964063, 110, 2086167891, 112
        }
    },
    [8] = {
        offset0 = 41,
        offset8 = 37,
        values8 = {
            1852402547, 1953063775, 1769168761, 1700752999, 1684369528,
            1869182057, 1596994414, 808465970, 1734964063, 110, 2086167891, 112
        }
    },
    [9] = {
        offset0 = 41,
        offset8 = 37,
        values8 = {
            1852402547, 1953063775, 1769168761, 1700752999, 1684369528,
            1869182057, 1597059950, 808465970, 1734964063, 110, 2086167891, 112
        }
    },
    [10] = {
        offset0 = 41,
        offset8 = 37,
        values8 = {
            1852402547, 1953063775, 1769168761, 1700752999, 1684369528,
            1869182057, 1597125486, 808466226, 1734964063, 110, 2086167891, 112
        }
    },
    [11] = {
        offset0 = 41,
        offset8 = 37,
        values8 = {
            1852402547, 1953063775, 1769168761, 1700752999, 1684369528,
            1869182057, 1597191022, 808466226, 1734964063, 110, 2086167891, 112
        }
    },
    [12] = {
        offset0 = 41,
        offset8 = 37,
        values8 = {
            1852402547, 1953063775, 1769168761, 1700752999, 1684369528,
            1869182057, 1597387630, 808466738, 1734964063, 110, 2086167891, 112
        }
    }
}

function expesign(index)
    gg.setVisible(false)
    gg.clearResults()

    local data = expeSign[index]
    if not data then
        gg.alert("⛔ Expedition Town Sign " .. index .. " not found!\n\n" ..
                     "📢 Please restart the game and try again.")
        return
    end

    -- ===============================
    -- 📍 TARGET (sekali)
    -- ===============================
    if not cache.target then
        gg.searchNumber("2581275344925", gg.TYPE_QWORD)
        local t = gg.getResults(1)
        if #t == 0 then
            gg.alert(
                "⛔ Expedition Town Sign source not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.target = t[1].address - 0x270
    end

    -- ===============================
    -- 🚀 MODE PATCH LANGSUNG
    -- ===============================
    if data.patch then
        local edits = {}
        for i = 0, 7 do
            edits[#edits + 1] = {
                address = cache.target + i * 4,
                flags = gg.TYPE_DWORD,
                value = data.patch[i + 1]
            }
        end
        gg.setValues(edits)
        gg.toast("✅ Expedition Town Sign " .. index .. " applied!")
        return
    end

    -- ===============================
    -- 🔍 SOURCE (sekali)
    -- ===============================
    if not cache.sourceBase then
        gg.clearResults()
        gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)
        local r = gg.getResults(1)
        if #r == 0 then
            gg.alert(
                "❌ Expedition Town Sign target not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.sourceBase = r[1].address + 0x1C
    end

    -- ===============================
    -- 📥 COPY HEADER (per index)
    -- ===============================
    if not cache.copied[index] then
        local temp = {}
        for i = 0, 5 do
            temp[#temp + 1] = {
                address = cache.sourceBase + i * 4,
                flags = gg.TYPE_DWORD
            }
        end
        cache.copied[index] = gg.getValues(temp)
    end

    -- ===============================
    -- 🧩 PASTE HEADER
    -- ===============================
    local edits = {}

    for i, v in ipairs(cache.copied[index]) do
        edits[#edits + 1] = {
            address = cache.target + (i - 1) * 4,
            value = v.value,
            flags = gg.TYPE_DWORD
        }
    end

    edits[#edits + 1] = {
        address = cache.target,
        value = data.offset0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 0x8,
        value = data.offset8,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 6 * 4,
        value = 0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 7 * 4,
        value = 1,
        flags = gg.TYPE_DWORD
    }

    gg.setValues(edits)

    -- ===============================
    -- 🔗 POINTER
    -- ===============================
    local ptr = tonumber(gg.getValues({
        {address = cache.target + 0x10, flags = gg.TYPE_QWORD}
    })[1].value)

    if not ptr or ptr == 0 then return end

    -- ===============================
    -- 🧩 VALUES8
    -- ===============================
    local final = {}
    for i = 0, 11 do
        final[#final + 1] = {
            address = ptr + i * 4,
            value = data.values8[i + 1],
            flags = gg.TYPE_DWORD
        }
    end

    gg.setValues(final)
    gg.toast("✅ Expedition Town Sign " .. index .. " applied!")
end

-------------------------------------------------

function kums3()
    while true do
        local indev = dev
        local options = {}
        for i = 1, 63 do
            table.insert(options, "🐻 • Chat Sticker (" .. i .. ")")
        end
        table.insert(options, "❌ • Go Back")

        -- 📋 Multi select
        local choice = gg.multiChoice(options, nil, indev)

        if not choice then return end

        -- 🔙 If Back selected
        if choice[64] then
            if type(gp3) == "function" then
                gp3()
            else
            end
            return
        end

        -- 🔁 Process selected stickers one by one
        for i = 1, 63 do
            if choice[i] then
                local func = _G["tikel" .. i]
                if type(func) == "function" then
                    func()
                    gg.toast("✅ " .. options[i] ..
                                 " applied.\n👉 Claim it in-freeze reward!")

                    -- ⏸️ Wait until user taps GG icon to continue
                    repeat gg.sleep(500) until gg.isVisible(true)

                    gg.setVisible(false) -- hide again after continue
                else
                    gg.alert("❌ Sticker " .. i .. " function not found!")
                end
            end
        end
        gg.toast("🎉 All selected stickers have been successfully claimed!")
    end
end

-- 🧩 Apply Sticker by Address
function applySticker(hex1, hex2, hex3, label)
    local addr = getAddr()
    if not addr then return end

    local patch = {
        {address = addr + 0x10, flags = gg.TYPE_DWORD, value = hex1},
        {address = addr + 0x14, flags = gg.TYPE_DWORD, value = hex2},
        {address = addr + 0x18, flags = gg.TYPE_DWORD, value = hex3},
        {address = addr + 0x1C, flags = gg.TYPE_DWORD, value = 0},
        {address = addr + 0x20, flags = gg.TYPE_DWORD, value = 0},
        {address = addr + 0x24, flags = gg.TYPE_DWORD, value = 0},
        {address = addr + 0x28, flags = gg.TYPE_DWORD, value = 0},
        {address = addr + 0x2C, flags = gg.TYPE_DWORD, value = 1}
    }

    gg.setValues(patch)
    gg.toast("✅ Sticker " .. label .. " applied successfully!")
end

-- 📦 Sticker Data
local stickers = {
    {0x6F6D6514, 0x735F696A, 0x00333170}, {0x6F6D6512, 0x735F696A, 0x00003274},
    {0x6F6D6512, 0x735F696A, 0x00343470}, {0x6F6D6512, 0x735F696A, 0x00003874},
    {0x6F6D6512, 0x735F696A, 0x00343770}, {0x6F6D6514, 0x735F696A, 0x00373170},
    {0x6F6D6512, 0x735F696A, 0x00003970}, {0x6F6D6512, 0x735F696A, 0x00003674},
    {1869440276, 1935632746, 3683188}, {1869440276, 1935632746, 355160},
    {1869440276, 1935632746, 3551860}, {1869440276, 1935632746, 3682932},
    {1869440276, 1935632746, 3748468}, {1869440276, 1935632746, 3158900},
    {1869440276, 1935632746, 3224436}, {1869440276, 1935632746, 3289972},
    {0x6F6D6514, 0x735F696A, 0x00343170}, {0x6F6D6514, 0x735F696A, 0x00323270},
    {0x6F6D6512, 0x735F696A, 0x00003370}, {0x6F6D6510, 0x765F696A, 0x00000033},
    {0x6F6D6514, 0x735F696A, 0x00313270}, {0x6F6D6512, 0x735F696A, 0x00003670},
    {0x6F6D6510, 0x765F696A, 0x00000032}, {0x6F6D6514, 0x735F696A, 0x00393170},
    {0x6F6D6514, 0x735F696A, 0x00303170}, {0x6F6D6514, 0x735F696A, 0x00353270},
    {0x6F6D6514, 0x735F696A, 0x00313170}, {0x6F6D6512, 0x735F696A, 0x00003574},
    {0x6F6D6512, 0x735F696A, 0x00003774}, {0x6F6D6514, 0x735F696A, 0x00373270},
    {0x6F6D6512, 0x735F696A, 0x00003374}, {1869440276, 1935632746, 3617908},
    {1869440276, 1935632746, 3683444}, {0x6F6D6514, 0x735F696A, 0x00363170},
    {1869440276, 1935632746, 361816}, {1869440276, 1935632746, 3682676},
    {1869440276, 1935632746, 3420788}, {1869440276, 1935632746, 3486580},
    {0x6F6D6514, 0x735F696A, 0x00333574}, {1869440276, 1935632746, 3421044},
    {1869440276, 1935632746, 3421556}, {1869440276, 1935632746, 3158388},
    {1869440276, 1935632746, 3617140}, {1869440276, 1935632746, 3552628},
    {1869440276, 1935632746, 3355252}, {1869440276, 1935632746, 3290228},
    {1869440276, 1935632746, 3487092}, {1869440276, 1935632746, 3355764},
    {1869440276, 1935632746, 3289716}, {1869440276, 1935632746, 3289460},
    {1869440276, 1935632746, 3683700}, {1869440276, 1935632746, 3486324},
    {1869440276, 1935632746, 3552116}, {1869440276, 1935632746, 3223924},
    {1869440276, 1935632746, 3617652}, {1869440276, 1935632746, 3159668},
    {1869440276, 1935632746, 3225204}, {1869440276, 1935632746, 3420532},
    {1869440276, 1935632746, 3159412}, {1869440276, 1935632746, 3486068},
    {1869440276, 1935632746, 3224948}, {1869440276, 1935632746, 3748980},
    {1869440276, 1935632746, 3749236}
}

-- 🔁 Generate tikelX() Automatically
for i, s in ipairs(stickers) do
    _G["tikel" .. i] = function() applySticker(s[1], s[2], s[3], i) end
end

-------------------------------------------------

function kums4()
  while true do
    gg.setVisible(false)
    gg.clearResults()
    local indev = dev
    local skins = {
      "🌸 • Festival Frame",
      "🌸 • Festival Name",
      "✨ • Sparkling Purple Frame",
      "❄️ • Ice Frame",
      "🐉 • CNY Frame",
      "❌ • Go Back"
    }

    local choice = gg.multiChoice(skins, nil, indev)
    if not choice then return end

    -- 🔙 Back
    if choice[6] then
      if type(gp3) == "function" then gp3() end
      return
    end

    -- 🔁 Apply per pilihan
    for i = 1, 5 do
      if choice[i] then
        framestyle(i)
        gg.toast(skins[i] .. " applied\n👉 Claim in freeze reward!")

        repeat
          gg.sleep(500)
        until gg.isVisible(true)
        gg.setVisible(false)
      end
    end
  end
end

-- 🔐 Cache (reset jika game restart)
local cache = {
  copied = {},
  sourceBase = nil,
  target = nil
}

local frameStyle = {
  [1]  = {offset0 = 49, offset8 = 24, values8 = {1348423763,1768320882,1917216108,1600482657,1953719654,1818326633,808534528,1110454853,2051542784,112,9,0}},
  [2] = {offset0 = 49, offset8 = 24, values8 = {1348423763,1768320882,1951622508,1600482425,1953719654,1818326633,980641024,56,0,0,436207655,113}},
  [3]  = {offset0 = 49, offset8 = 24, values8 = {1348423763,1768320882,1917216108;1600482657,1835102822,825253733,0,0,1852402515;1919895135;1936028276;1749245811}},
  [4] = {offset0 = 49, offset8 = 24, values8 = {1348423763,1768320882,1917216108;1600482657,1835102822,842030949,0,0,1852402515;1919895135;1936028276;1749245811}},
  [5]  = {offset0 = 49, offset8 = 24, values8 = {1348423763,1768320882,1917216108;1600482657,1835102822,858808165,0,0,1852402515;1919895135;1936028276;1749245811}}}

function framestyle(index)
  gg.setVisible(false)
  gg.clearResults()

  local data = frameStyle[index]
  if not data then
    gg.alert("⛔ Frame Style "..index.." not found!\n\n" ..
      "📢 Please restart the game and try again.")
    return
  end

  -- ===============================
  -- 📍 TARGET (sekali)
  -- ===============================
  if not cache.target then
    gg.searchNumber("2581275344925", gg.TYPE_QWORD)
    local t = gg.getResults(1)
    if #t == 0 then
      gg.alert("⛔ Frame Style source not found!\n\n📢 Please restart the game and try again.")
      return
    end
    cache.target = t[1].address - 0x270
  end
    -- ===============================
    -- 🚀 MODE PATCH LANGSUNG
    -- ===============================
    if data.patch then
        local edits = {}
        for i = 0, 7 do
            edits[#edits + 1] = {
                address = cache.target + i * 4,
                flags = gg.TYPE_DWORD,
                value = data.patch[i + 1]
            }
        end
        gg.setValues(edits)
        gg.toast("✅ Frame Style " .. index .. " applied!")
        return
    end

    -- ===============================
    -- 🔍 SOURCE (sekali)
    -- ===============================
    if not cache.sourceBase then
        gg.clearResults()
        gg.searchNumber("7021767231079972979", gg.TYPE_QWORD)
        local r = gg.getResults(1)
        if #r == 0 then
            gg.alert(
                "❌ Frame Style target not found!\n\n📢 Please restart the game and try again.")
            return
        end
        cache.sourceBase = r[1].address + 0x1C
    end

    -- ===============================
    -- 📥 COPY HEADER (per index)
    -- ===============================
    if not cache.copied[index] then
        local temp = {}
        for i = 0, 5 do
            temp[#temp + 1] = {
                address = cache.sourceBase + i * 4,
                flags = gg.TYPE_DWORD
            }
        end
        cache.copied[index] = gg.getValues(temp)
    end

    -- ===============================
    -- 🧩 PASTE HEADER
    -- ===============================
    local edits = {}

    for i, v in ipairs(cache.copied[index]) do
        edits[#edits + 1] = {
            address = cache.target + (i - 1) * 4,
            value = v.value,
            flags = gg.TYPE_DWORD
        }
    end

    edits[#edits + 1] = {
        address = cache.target,
        value = data.offset0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 0x8,
        value = data.offset8,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 6 * 4,
        value = 0,
        flags = gg.TYPE_DWORD
    }
    edits[#edits + 1] = {
        address = cache.target + 7 * 4,
        value = 1,
        flags = gg.TYPE_DWORD
    }

    gg.setValues(edits)

    -- ===============================
    -- 🔗 POINTER
    -- ===============================
    local ptr = tonumber(gg.getValues({
        {address = cache.target + 0x10, flags = gg.TYPE_QWORD}
    })[1].value)

    if not ptr or ptr == 0 then return end

    -- ===============================
    -- 🧩 VALUES8
    -- ===============================
    local final = {}
    for i = 0, 7 do
        final[#final + 1] = {
            address = ptr + i * 4,
            value = data.values8[i + 1],
            flags = gg.TYPE_DWORD
        }
    end

    gg.setValues(final)
    gg.toast("✅ Frame Style " .. index .. " applied!")
end

-------------------------------------------------

function kums5()
    local title = banner
    local menu = gg.choice({
        "🌟 • Exclusive Avatars List", "✨ • Complete Avatar List",
        "❌ • Go Back"
    }, nil, title)

    if menu == nil then
        return
    elseif menu == 1 then
        avatar1()
    elseif menu == 2 then
        avatar2()
    elseif menu == 3 then
        gp3()
    end
end

function avatar1()
    while true do
        gg.setVisible(false)
        gg.clearResults()

        local skins = {
            "🌟 • Year 1 Avatar", "🌟 • Year 2 Avatar",
            "🌟 • Year 3 Avatar", "🌟 • Year 4 Avatar",
            "🌟 • Year 5 Avatar", "🌟 • Year 6 Avatar",
            "🌟 • Year 7 Avatar", "🌟 • Year 8 Avatar",
            "🌟 • Year 9 Avatar", "🌟 • Year 10 Avatar",
            "🌟 • Year 11 Avatar (1)", "🌟 • Year 11 Avatar (2)",
            "❌ • Go Back"
        }

        local choice = gg.multiChoice(skins, nil, "🎉 Exclusive Avatars")
        if not choice then return end

        -- 🔙 Back option
        if choice[#skins] then
            if type(kums5) == "function" then
                return kums5()
            else
                return
            end
        end

        -- 🔁 Process selected avatars
        for i, _ in ipairs(skins) do
            if choice[i] and i < #skins then
                local func = _G["avatarYear" .. i]
                if type(func) == "function" then
                    func()
                    gg.toast("✅ " .. skins[i] ..
                                 " applied.\n👉 Claim it in-freeze reward!")
                else
                    gg.alert("❌ Function avatarYear" .. i .. "() not found!")
                end
            end
        end

        gg.toast("🎉 All selected avatars have been successfully claimed!")
    end
end

function applyAvatarAnniversary(hex, emoji, name)
    local addr = getAddr()
    if not addr then
        gg.alert("❌ No matching value found.\n" .. name ..
                     " could not be applied.\nPlease try again or restart the game!")
        return
    end

    local patch = {
        {address = addr + 0x10, flags = gg.TYPE_DWORD, value = hex[1]},
        {address = addr + 0x14, flags = gg.TYPE_DWORD, value = hex[2]},
        {address = addr + 0x18, flags = gg.TYPE_DWORD, value = hex[3] or 0},
        {address = addr + 0x1C, flags = gg.TYPE_DWORD, value = 0},
        {address = addr + 0x20, flags = gg.TYPE_DWORD, value = 0},
        {address = addr + 0x24, flags = gg.TYPE_DWORD, value = 0},
        {address = addr + 0x28, flags = gg.TYPE_DWORD, value = 0},
        {address = addr + 0x2C, flags = gg.TYPE_DWORD, value = 1}
    }

    gg.setValues(patch)
    gg.toast("✅ " .. name .. " applied!")
end

-- 🎉 Avatar Anniversary Functions
function avatarYear1()
    applyAvatarAnniversary({1635148044, 3748145}, "🌟", "Year 1 Avatar")
end
function avatarYear2()
    applyAvatarAnniversary({1635148044, 3158577}, "🌟", "Year 2 Avatar")
end
function avatarYear3()
    applyAvatarAnniversary({1635148044, 3224113}, "🌟", "Year 3 Avatar")
end
function avatarYear4()
    applyAvatarAnniversary({1635148044, 3289649}, "🌟", "Year 4 Avatar")
end
function avatarYear5()
    applyAvatarAnniversary({1635148044, 3355185}, "🌟", "Year 5 Avatar")
end
function avatarYear6()
    applyAvatarAnniversary({1635148044, 3421489}, "🌟", "Year 6 Avatar")
end
function avatarYear7()
    applyAvatarAnniversary({1635148044, 3225905}, "🌟", "Year 7 Avatar")
end
function avatarYear8()
    applyAvatarAnniversary({1635148044, 3748658}, "🌟", "Year 8 Avatar")
end
function avatarYear9()
    applyAvatarAnniversary({1635148044, 3225650}, "🌟", "Year 9 Avatar")
end
function avatarYear10()
    applyAvatarAnniversary({1635148044, 3354931}, "🌟", "Year 10 Avatar")
end
function avatarYear11()
    applyAvatarAnniversary({1635148044, 3290675}, "🌟", "Year 11 Avatar (1)")
end
function avatarYear12()
    applyAvatarAnniversary({1635148044, 3225139}, "🌟", "Year 11 Avatar (2)")
end

function avatar2()
    while true do
        gg.setVisible(false)
        local options = {}

        -- ✨ Generate avatar list
        for i = 1, 323 do
            table.insert(options, "✨ • Complete Avatar (" .. i .. ")")
        end
        table.insert(options, "❌ • Go Back")

        -- 📋 Multi select menu
        local choice = gg.multiChoice(options, nil, "🎊 Complete Avatar List")

        if not choice then return end

        -- 🔙 If Back selected
        if choice[#options] then
            if type(kums5) == "function" then
                kums5()
            else
            end
            return -- keluar total dari avatar2()
        end

        -- 🔁 Process selected avatars
        for i = 1, 323 do
            if choice[i] then
                local func = _G["comAvatar" .. i]
                if type(func) == "function" then
                    func()
                    gg.toast("✅ " .. options[i] ..
                                 " applied.\n👉 Claim it in-freeze reward!")

                    -- ⏸️ Wait until user taps GG icon
                    repeat gg.sleep(500) until gg.isVisible(true)

                    gg.setVisible(false) -- hide again
                else
                    gg.alert("❌ " .. options[i] .. " function not found!")
                end
            end
        end

        gg.toast(
            "🎉 All selected Complete Avatars have been successfully claimed!")
    end
end

function applyCompleteAvatar(hex, emoji, name)
    local addr = getAddr()
    if not addr then
        gg.alert("❌ No matching value found.\n" .. name ..
                     " could not be applied.\nPlease try again or restart the game!")
        return
    end

    local patch = {
        {address = addr + 0x10, flags = gg.TYPE_DWORD, value = hex[1]},
        {address = addr + 0x14, flags = gg.TYPE_DWORD, value = hex[2]},
        {address = addr + 0x18, flags = gg.TYPE_DWORD, value = hex[3] or 0},
        {address = addr + 0x1C, flags = gg.TYPE_DWORD, value = 0},
        {address = addr + 0x20, flags = gg.TYPE_DWORD, value = 0},
        {address = addr + 0x24, flags = gg.TYPE_DWORD, value = 0},
        {address = addr + 0x28, flags = gg.TYPE_DWORD, value = 0},
        {address = addr + 0x2C, flags = gg.TYPE_DWORD, value = 1}
    }

    gg.setValues(patch)
    gg.toast("✅ " .. name .. " applied!")
end

function comAvatar1()
    applyCompleteAvatar({0x6176610C, 0x00323031}, "🎊", "Complete Avatar 1")
end
function comAvatar2()
    applyCompleteAvatar({0x6176610C, 0x00333731}, "🎂", "Complete Avatar 2")
end
function comAvatar3()
    applyCompleteAvatar({0x6176610C, 0x00393631}, "🏆", "Complete Avatar 3")
end
function comAvatar4()
    applyCompleteAvatar({0x6176610C, 0x00343431}, "🌈", "Complete Avatar 4")
end
function comAvatar5()
    applyCompleteAvatar({0x6176610C, 0x00363232}, "🔥", "Complete Avatar 5")
end
function comAvatar6()
    applyCompleteAvatar({0x6176610C, 0x00343331}, "💎", "Complete Avatar 6")
end
function comAvatar7()
    applyCompleteAvatar({0x6176610C, 0x00303432}, "🌟", "Complete Avatar 7")
end
function comAvatar8()
    applyCompleteAvatar({0x6176610C, 0x00303031}, "🎯", "Complete Avatar 8")
end
function comAvatar9()
    applyCompleteAvatar({0x6176610C, 0x00353332}, "🛡️", "Complete Avatar 9")
end
function comAvatar10()
    applyCompleteAvatar({0x6176610C, 0x00383032}, "👑", "Complete Avatar 10")
end

function comAvatar11()
    applyCompleteAvatar({0x6176610C, 0x00333132}, "🐉", "Complete Avatar 11")
end
function comAvatar12()
    applyCompleteAvatar({0x6176610C, 0x00383331}, "⚡", "Complete Avatar 12")
end
function comAvatar13()
    applyCompleteAvatar({0x6176610C, 0x00303631}, "🧲", "Complete Avatar 13")
end
function comAvatar14()
    applyCompleteAvatar({0x6176610C, 0x00353831}, "📦", "Complete Avatar 14")
end
function comAvatar15()
    applyCompleteAvatar({0x6176610A, 0x00003732}, "🍭", "Complete Avatar 15")
end
function comAvatar16()
    applyCompleteAvatar({0x6176610A, 0x00003934}, "🚀", "Complete Avatar 16")
end
function comAvatar17()
    applyCompleteAvatar({0x6176610A, 0x00003634}, "🧁", "Complete Avatar 17")
end
function comAvatar18()
    applyCompleteAvatar({0x6176610C, 0x00313132}, "🐾", "Complete Avatar 18")
end
function comAvatar19()
    applyCompleteAvatar({0x6176610C, 0x00393032}, "🌍", "Complete Avatar 19")
end
function comAvatar20()
    applyCompleteAvatar({0x6176610A, 0x00003134}, "🎮", "Complete Avatar 20")
end

function comAvatar21()
    applyCompleteAvatar({0x6176610C, 0x00373131}, "🎨", "Complete Avatar 21")
end
function comAvatar22()
    applyCompleteAvatar({0x6176610C, 0x00373931}, "📚", "Complete Avatar 22")
end
function comAvatar23()
    applyCompleteAvatar({0x6176610C, 0x00333332}, "🎻", "Complete Avatar 23")
end
function comAvatar24()
    applyCompleteAvatar({0x6176610C, 0x00363332}, "💡", "Complete Avatar 24")
end
function comAvatar25()
    applyCompleteAvatar({0x6176610C, 0x00373831}, "🎬", "Complete Avatar 25")
end
function comAvatar26()
    applyCompleteAvatar({0x6176610C, 0x00323731}, "🧠", "Complete Avatar 26")
end
function comAvatar27()
    applyCompleteAvatar({0x6176610A, 0x00003239}, "🦄", "Complete Avatar 27")
end
function comAvatar28()
    applyCompleteAvatar({0x6176610A, 0x00003938}, "🍀", "Complete Avatar 28")
end
function comAvatar29()
    applyCompleteAvatar({0x6176610C, 0x00373631}, "🪐", "Complete Avatar 29")
end
function comAvatar30()
    applyCompleteAvatar({0x6176610A, 0x00003033}, "🎭", "Complete Avatar 30")
end

function comAvatar31()
    applyCompleteAvatar({0x6176610A, 0x00003632}, "🎆", "Complete Avatar 31")
end
function comAvatar32()
    applyCompleteAvatar({0x6176610C, 0x00323531}, "🥁", "Complete Avatar 32")
end
function comAvatar33()
    applyCompleteAvatar({0x6176610C, 0x00333131}, "🍓", "Complete Avatar 33")
end
function comAvatar34()
    applyCompleteAvatar({0x6176610A, 0x00003039}, "🍕", "Complete Avatar 34")
end
function comAvatar35()
    applyCompleteAvatar({0x6176610C, 0x00333831}, "🎈", "Complete Avatar 35")
end
function comAvatar36()
    applyCompleteAvatar({0x6176610C, 0x00303731}, "🐠", "Complete Avatar 36")
end
function comAvatar37()
    applyCompleteAvatar({0x6176610C, 0x00393931}, "🪄", "Complete Avatar 37")
end
function comAvatar38()
    applyCompleteAvatar({0x6176610C, 0x00353431}, "🔔", "Complete Avatar 38")
end
function comAvatar39()
    applyCompleteAvatar({0x6176610A, 0x00003338}, "🛠️",
                        "Complete Avatar 39")
end
function comAvatar40()
    applyCompleteAvatar({0x6176610C, 0x00353132}, "🐺", "Complete Avatar 40")
end

function comAvatar41()
    applyCompleteAvatar({0x6176610C, 0x00393132}, "🌻", "Complete Avatar 41")
end
function comAvatar42()
    applyCompleteAvatar({0x6176610C, 0x00383631}, "🏰", "Complete Avatar 42")
end
function comAvatar43()
    applyCompleteAvatar({0x6176610C, 0x00353731}, "🎰", "Complete Avatar 43")
end
function comAvatar44()
    applyCompleteAvatar({0x6176610A, 0x00003138}, "🎯", "Complete Avatar 44")
end
function comAvatar45()
    applyCompleteAvatar({0x6176610A, 0x00003637}, "🦊", "Complete Avatar 45")
end
function comAvatar46()
    applyCompleteAvatar({0x6176610A, 0x00003837}, "📸", "Complete Avatar 46")
end
function comAvatar47()
    applyCompleteAvatar({0x6176610A, 0x00003737}, "🧬", "Complete Avatar 47")
end
function comAvatar48()
    applyCompleteAvatar({0x6176610C, 0x00363631}, "📦", "Complete Avatar 48")
end
function comAvatar49()
    applyCompleteAvatar({0x6176610C, 0x00313332}, "🎁", "Complete Avatar 49")
end
function comAvatar50()
    applyCompleteAvatar({0x6176610C, 0x00363132}, "📀", "Complete Avatar 50")
end

function comAvatar51()
    applyCompleteAvatar({0x6176610A, 0x00003136}, "🥳", "Complete Avatar 51")
end
function comAvatar52()
    applyCompleteAvatar({0x6176610C, 0x00383431}, "🎇", "Complete Avatar 52")
end
function comAvatar53()
    applyCompleteAvatar({0x6176610C, 0x00363531}, "🏹", "Complete Avatar 53")
end
function comAvatar54()
    applyCompleteAvatar({0x6176610C, 0x00303831}, "🧃", "Complete Avatar 54")
end
function comAvatar55()
    applyCompleteAvatar({0x6176610C, 0x00383332}, "🚴", "Complete Avatar 55")
end
function comAvatar56()
    applyCompleteAvatar({0x6176610C, 0x00333032}, "🌌", "Complete Avatar 56")
end
function comAvatar57()
    applyCompleteAvatar({0x6176610A, 0x00003533}, "🍩", "Complete Avatar 57")
end
function comAvatar58()
    applyCompleteAvatar({0x6176610C, 0x00343831}, "🧸", "Complete Avatar 58")
end
function comAvatar59()
    applyCompleteAvatar({0x6176610C, 0x00373731}, "🚓", "Complete Avatar 59")
end
function comAvatar60()
    applyCompleteAvatar({0x6176610A, 0x00003839}, "🐼", "Complete Avatar 60")
end

function comAvatar61()
    applyCompleteAvatar({0x6176610C, 0x00383132}, "🍁", "Complete Avatar 61")
end
function comAvatar62()
    applyCompleteAvatar({0x6176610C, 0x00303232}, "🛸", "Complete Avatar 62")
end
function comAvatar63()
    applyCompleteAvatar({0x6176610C, 0x00383031}, "🌠", "Complete Avatar 63")
end
function comAvatar64()
    applyCompleteAvatar({0x6176610C, 0x00363031}, "🐝", "Complete Avatar 64")
end
function comAvatar65()
    applyCompleteAvatar({0x6176610C, 0x00363931}, "🌊", "Complete Avatar 65")
end
function comAvatar66()
    applyCompleteAvatar({0x6176610C, 0x00303331}, "🌋", "Complete Avatar 66")
end
function comAvatar67()
    applyCompleteAvatar({0x6176610C, 0x00383931}, "🦋", "Complete Avatar 67")
end
function comAvatar68()
    applyCompleteAvatar({0x6176610C, 0x00303132}, "🍔", "Complete Avatar 68")
end
function comAvatar69()
    applyCompleteAvatar({0x6176610C, 0x00353232}, "🛵", "Complete Avatar 69")
end
function comAvatar70()
    applyCompleteAvatar({0x6176610A, 0x00003939}, "🐬", "Complete Avatar 70")
end

function comAvatar71()
    applyCompleteAvatar({0x6176610C, 0x00343731}, "📣", "Complete Avatar 71")
end
function comAvatar72()
    applyCompleteAvatar({0x6176610C, 0x00363231}, "🪁", "Complete Avatar 72")
end
function comAvatar73()
    applyCompleteAvatar({0x6176610A, 0x00003135}, "📌", "Complete Avatar 73")
end
function comAvatar74()
    applyCompleteAvatar({0x6176610C, 0x00323032}, "🪴", "Complete Avatar 74")
end
function comAvatar75()
    applyCompleteAvatar({0x6176610C, 0x00383131}, "🖼️",
                        "Complete Avatar 75")
end
function comAvatar76()
    applyCompleteAvatar({0x6176610C, 0x00393731}, "🧃", "Complete Avatar 76")
end
function comAvatar77()
    applyCompleteAvatar({0x6176610C, 0x00363831}, "📲", "Complete Avatar 77")
end
function comAvatar78()
    applyCompleteAvatar({0x6176610A, 0x00003538}, "🍇", "Complete Avatar 78")
end
function comAvatar79()
    applyCompleteAvatar({0x6176610A, 0x00003337}, "🔮", "Complete Avatar 79")
end
function comAvatar80()
    applyCompleteAvatar({0x6176610C, 0x00323131}, "🐳", "Complete Avatar 80")
end

function comAvatar81()
    applyCompleteAvatar({0x6176610C, 0x00303531}, "🍒", "Complete Avatar 81")
end
function comAvatar82()
    applyCompleteAvatar({0x6176610C, 0x00313731}, "🪵", "Complete Avatar 82")
end
function comAvatar83()
    applyCompleteAvatar({0x6176610C, 0x00343631}, "🍬", "Complete Avatar 83")
end
function comAvatar84()
    applyCompleteAvatar({0x6176610C, 0x00363431}, "🌽", "Complete Avatar 84")
end
function comAvatar85()
    applyCompleteAvatar({0x6176610C, 0x00373232}, "🍗", "Complete Avatar 85")
end
function comAvatar86()
    applyCompleteAvatar({0x6176610C, 0x00313831}, "🧀", "Complete Avatar 86")
end
function comAvatar87()
    applyCompleteAvatar({0x6176610C, 0x00343031}, "🥦", "Complete Avatar 87")
end
function comAvatar88()
    applyCompleteAvatar({0x6176610C, 0x00343032}, "🫐", "Complete Avatar 88")
end
function comAvatar89()
    applyCompleteAvatar({0x6176610C, 0x00353631}, "🍖", "Complete Avatar 89")
end
function comAvatar90()
    applyCompleteAvatar({0x6176610C, 0x00353531}, "🥓", "Complete Avatar 90")
end

function comAvatar91()
    applyCompleteAvatar({0x6176610C, 0x00383731}, "🧂", "Complete Avatar 91")
end
function comAvatar92()
    applyCompleteAvatar({0x6176610C, 0x00333931}, "🍳", "Complete Avatar 92")
end
function comAvatar93()
    applyCompleteAvatar({0x6176610C, 0x00333531}, "🥚", "Complete Avatar 93")
end
function comAvatar94()
    applyCompleteAvatar({0x6176610C, 0x00303332}, "🥨", "Complete Avatar 94")
end
function comAvatar95()
    applyCompleteAvatar({0x6176610A, 0x00003233}, "🫔", "Complete Avatar 95")
end
function comAvatar96()
    applyCompleteAvatar({0x6176610A, 0x00003133}, "🍞", "Complete Avatar 96")
end
function comAvatar97()
    applyCompleteAvatar({0x6176610A, 0x00003433}, "🧈", "Complete Avatar 97")
end
function comAvatar98()
    applyCompleteAvatar({0x6176610C, 0x00313631}, "🥗", "Complete Avatar 98")
end
function comAvatar99()
    applyCompleteAvatar({0x6176610C, 0x00313431}, "🍱", "Complete Avatar 99")
end
function comAvatar100()
    applyCompleteAvatar({0x6176610C, 0x00313031}, "🍙", "Complete Avatar 100")
end

function comAvatar101()
    applyCompleteAvatar({0x6176610C, 0x00313431}, "🎉", "Complete Avatar 101")
end
function comAvatar102()
    applyCompleteAvatar({0x6176610C, 0x00313031}, "🎂", "Complete Avatar 102")
end
function comAvatar103()
    applyCompleteAvatar({0x6176610A, 0x00003335}, "🏆", "Complete Avatar 103")
end
function comAvatar104()
    applyCompleteAvatar({0x6176610A, 0x00003437}, "🌈", "Complete Avatar 104")
end
function comAvatar105()
    applyCompleteAvatar({0x6176610C, 0x00373531}, "🔥", "Complete Avatar 105")
end
function comAvatar106()
    applyCompleteAvatar({0x6176610A, 0x00003235}, "💎", "Complete Avatar 106")
end
function comAvatar107()
    applyCompleteAvatar({0x6176610C, 0x00323831}, "🌟", "Complete Avatar 107")
end
function comAvatar108()
    applyCompleteAvatar({0x6176610C, 0x00383531}, "🎯", "Complete Avatar 108")
end
function comAvatar109()
    applyCompleteAvatar({0x6176610C, 0x00373031}, "🛡️",
                        "Complete Avatar 109")
end
function comAvatar110()
    applyCompleteAvatar({0x6176610A, 0x00003838}, "👑", "Complete Avatar 110")
end

function comAvatar111()
    applyCompleteAvatar({0x6176610C, 0x00363131}, "🐉", "Complete Avatar 111")
end
function comAvatar112()
    applyCompleteAvatar({0x6176610C, 0x00383432}, "⚡", "Complete Avatar 112")
end
function comAvatar113()
    applyCompleteAvatar({0x6176610C, 0x00353231}, "🧲", "Complete Avatar 113")
end
function comAvatar114()
    applyCompleteAvatar({0x6176610C, 0x00373132}, "📦", "Complete Avatar 114")
end
function comAvatar115()
    applyCompleteAvatar({0x6176610C, 0x00333232}, "🍭", "Complete Avatar 115")
end
function comAvatar116()
    applyCompleteAvatar({0x6176610C, 0x00353931}, "🚀", "Complete Avatar 116")
end
function comAvatar117()
    applyCompleteAvatar({0x6176610C, 0x00313232}, "🧁", "Complete Avatar 117")
end
function comAvatar118()
    applyCompleteAvatar({0x6176610C, 0x00383231}, "🐾", "Complete Avatar 118")
end
function comAvatar119()
    applyCompleteAvatar({0x6176610C, 0x00353031}, "🌍", "Complete Avatar 119")
end
function comAvatar120()
    applyCompleteAvatar({0x6176610C, 0x00393231}, "🎮", "Complete Avatar 120")
end

function comAvatar121()
    applyCompleteAvatar({0x6176610C, 0x00343132}, "🎨", "Complete Avatar 121")
end
function comAvatar122()
    applyCompleteAvatar({0x6176610C, 0x00333431}, "📚", "Complete Avatar 122")
end
function comAvatar123()
    applyCompleteAvatar({0x6176610A, 0x00003738}, "🎻", "Complete Avatar 123")
end
function comAvatar124()
    applyCompleteAvatar({0x6176610A, 0x00003237}, "💡", "Complete Avatar 124")
end
function comAvatar125()
    applyCompleteAvatar({0x6176610C, 0x00353331}, "🎬", "Complete Avatar 125")
end
function comAvatar126()
    applyCompleteAvatar({0x6176610C, 0x00373231}, "🧠", "Complete Avatar 126")
end
function comAvatar127()
    applyCompleteAvatar({0x6176610C, 0x00373431}, "🦄", "Complete Avatar 127")
end
function comAvatar128()
    applyCompleteAvatar({0x6176610C, 0x00363731}, "🍀", "Complete Avatar 128")
end
function comAvatar129()
    applyCompleteAvatar({0x6176610C, 0x00303131}, "🪐", "Complete Avatar 129")
end
function comAvatar130()
    applyCompleteAvatar({0x6176610C, 0x00373331}, "🎭", "Complete Avatar 130")
end

function comAvatar131()
    applyCompleteAvatar({0x6176610C, 0x00393531}, "🎆", "Complete Avatar 131")
end
function comAvatar132()
    applyCompleteAvatar({0x6176610C, 0x00373032}, "🥁", "Complete Avatar 132")
end
function comAvatar133()
    applyCompleteAvatar({0x6176610C, 0x00343931}, "🍓", "Complete Avatar 133")
end
function comAvatar134()
    applyCompleteAvatar({0x6176610C, 0x00303931}, "🍕", "Complete Avatar 134")
end
function comAvatar135()
    applyCompleteAvatar({0x6176610C, 0x00393831}, "🎈", "Complete Avatar 135")
end
function comAvatar136()
    applyCompleteAvatar({0x6176610A, 0x00003933}, "🐠", "Complete Avatar 136")
end
function comAvatar137()
    applyCompleteAvatar({0x6176610C, 0x00313032}, "🪄", "Complete Avatar 137")
end
function comAvatar138()
    applyCompleteAvatar({0x6176610C, 0x00323532}, "🔔", "Complete Avatar 138")
end
function comAvatar139()
    applyCompleteAvatar({0x6176610A, 0x00003635}, "🛠️",
                        "Complete Avatar 139")
end
function comAvatar140()
    applyCompleteAvatar({0x6176610A, 0x00003139}, "🐺", "Complete Avatar 140")
end

function comAvatar141()
    applyCompleteAvatar({0x6176610A, 0x00003234}, "🌻", "Complete Avatar 141")
end
function comAvatar142()
    applyCompleteAvatar({0x6176610C, 0x00323631}, "🏰", "Complete Avatar 142")
end
function comAvatar143()
    applyCompleteAvatar({0x6176610A, 0x00003532}, "🎰", "Complete Avatar 143")
end
function comAvatar144()
    applyCompleteAvatar({0x6176610C, 0x00323332}, "🎯", "Complete Avatar 144")
end
function comAvatar145()
    applyCompleteAvatar({0x6176610A, 0x00003936}, "🦊", "Complete Avatar 145")
end
function comAvatar146()
    applyCompleteAvatar({0x6176610A, 0x00003735}, "📸", "Complete Avatar 146")
end
function comAvatar147()
    applyCompleteAvatar({0x6176610A, 0x00003535}, "🧬", "Complete Avatar 147")
end
function comAvatar148()
    applyCompleteAvatar({0x6176610A, 0x00003435}, "🍿", "Complete Avatar 148")
end
function comAvatar149()
    applyCompleteAvatar({0x6176610A, 0x00003236}, "🎁", "Complete Avatar 149")
end
function comAvatar150()
    applyCompleteAvatar({0x6176610A, 0x00003137}, "📀", "Complete Avatar 150")
end

function comAvatar151()
    applyCompleteAvatar({1635148044, 3552562}, "🎉", "Complete Avatar 151")
end
function comAvatar152()
    applyCompleteAvatar({1635148044, 3749170}, "🎂", "Complete Avatar 152")
end
function comAvatar153()
    applyCompleteAvatar({1635148044, 3290674}, "🏆", "Complete Avatar 153")
end
function comAvatar154()
    applyCompleteAvatar({1635148044, 3356210}, "🌈", "Complete Avatar 154")
end
function comAvatar155()
    applyCompleteAvatar({1635148044, 3487282}, "🔥", "Complete Avatar 155")
end
function comAvatar156()
    applyCompleteAvatar({1635148044, 3618354}, "💎", "Complete Avatar 156")
end
function comAvatar157()
    applyCompleteAvatar({1635148044, 3158323}, "🌟", "Complete Avatar 157")
end
function comAvatar158()
    applyCompleteAvatar({1635148044, 3289395}, "🎯", "Complete Avatar 158")
end
function comAvatar159()
    applyCompleteAvatar({1635148044, 3420467}, "🛡️", "Complete Avatar 159")
end
function comAvatar160()
    applyCompleteAvatar({1635148044, 3486003}, "👑", "Complete Avatar 160")
end

function comAvatar161()
    applyCompleteAvatar({1635148044, 3683890}, "🐉", "Complete Avatar 161")
end
function comAvatar162()
    applyCompleteAvatar({1635148044, 3159602}, "⚡", "Complete Avatar 162")
end
function comAvatar163()
    applyCompleteAvatar({1635148044, 3749426}, "🧲", "Complete Avatar 163")
end
function comAvatar164()
    applyCompleteAvatar({1635148044, 3159858}, "📦", "Complete Avatar 164")
end
function comAvatar165()
    applyCompleteAvatar({1635148044, 3225394}, "🍭", "Complete Avatar 165")
end
function comAvatar166()
    applyCompleteAvatar({1635148044, 3290930}, "🚀", "Complete Avatar 166")
end
function comAvatar167()
    applyCompleteAvatar({1635148044, 3356466}, "🧁", "Complete Avatar 167")
end
function comAvatar168()
    applyCompleteAvatar({1635148044, 3487538}, "🐾", "Complete Avatar 168")
end
function comAvatar169()
    applyCompleteAvatar({1635148044, 3553074}, "🌍", "Complete Avatar 169")
end
function comAvatar170()
    applyCompleteAvatar({1635148044, 3618610}, "🎮", "Complete Avatar 170")
end

function comAvatar171()
    applyCompleteAvatar({1635148044, 3749682}, "🎨", "Complete Avatar 171")
end
function comAvatar172()
    applyCompleteAvatar({1635148044, 3684146}, "📚", "Complete Avatar 172")
end
function comAvatar173()
    applyCompleteAvatar({1635148044, 3160114}, "🎻", "Complete Avatar 173")
end
function comAvatar174()
    applyCompleteAvatar({1635148044, 3291186}, "💡", "Complete Avatar 174")
end
function comAvatar175()
    applyCompleteAvatar({1635148044, 3356722}, "🎬", "Complete Avatar 175")
end
function comAvatar176()
    applyCompleteAvatar({1635148044, 3422258}, "🧠", "Complete Avatar 176")
end
function comAvatar177()
    applyCompleteAvatar({1635148044, 3487794}, "🦄", "Complete Avatar 177")
end
function comAvatar178()
    applyCompleteAvatar({1635148044, 3553330}, "🍀", "Complete Avatar 178")
end
function comAvatar179()
    applyCompleteAvatar({1635148044, 3618866}, "🪐", "Complete Avatar 179")
end
function comAvatar180()
    applyCompleteAvatar({1635148044, 3684402}, "🎭", "Complete Avatar 180")
end

function comAvatar181()
    applyCompleteAvatar({1635148044, 3749938}, "🎆", "Complete Avatar 181")
end
function comAvatar182()
    applyCompleteAvatar({1635148044, 3225906}, "🥁", "Complete Avatar 182")
end
function comAvatar183()
    applyCompleteAvatar({1635148044, 3291442}, "🍓", "Complete Avatar 183")
end
function comAvatar184()
    applyCompleteAvatar({1635148044, 3356978}, "🍕", "Complete Avatar 184")
end
function comAvatar185()
    applyCompleteAvatar({1635148044, 3422514}, "🎈", "Complete Avatar 185")
end
function comAvatar186()
    applyCompleteAvatar({1635148044, 3488050}, "🐠", "Complete Avatar 186")
end
function comAvatar187()
    applyCompleteAvatar({1635148044, 3553586}, "🪄", "Complete Avatar 187")
end
function comAvatar188()
    applyCompleteAvatar({1635148044, 3619122}, "🔔", "Complete Avatar 188")
end
function comAvatar189()
    applyCompleteAvatar({1635148044, 3750194}, "🛠️", "Complete Avatar 189")
end
function comAvatar190()
    applyCompleteAvatar({1635148044, 3158067}, "🎮", "Complete Avatar 190")
end

function comAvatar191()
    applyCompleteAvatar({1635148044, 3684658}, "🎯", "Complete Avatar 191")
end
function comAvatar192()
    applyCompleteAvatar({1635148044, 3289139}, "🎨", "Complete Avatar 192")
end
function comAvatar193()
    applyCompleteAvatar({1635148044, 3354675}, "🎶", "Complete Avatar 193")
end
function comAvatar194()
    applyCompleteAvatar({1635148044, 3420211}, "🍬", "Complete Avatar 194")
end
function comAvatar195()
    applyCompleteAvatar({1635148044, 3485747}, "🍣", "Complete Avatar 195")
end
function comAvatar196()
    applyCompleteAvatar({1635148044, 3551283}, "🧃", "Complete Avatar 196")
end
function comAvatar197()
    applyCompleteAvatar({1635148044, 3616819}, "🐱", "Complete Avatar 197")
end
function comAvatar198()
    applyCompleteAvatar({1635148044, 3682355}, "🐶", "Complete Avatar 198")
end
function comAvatar199()
    applyCompleteAvatar({1635148044, 3747891}, "🦊", "Complete Avatar 199")
end
function comAvatar200()
    applyCompleteAvatar({1635148044, 3552562}, "🐼", "Complete Avatar 200")
end

function comAvatar201()
    applyCompleteAvatar({1635148044, 3619378}, "🐸", "Complete Avatar 201")
end
function comAvatar202()
    applyCompleteAvatar({1635148044, 3684914}, "🦁", "Complete Avatar 202")
end
function comAvatar203()
    applyCompleteAvatar({1635148044, 3750450}, "🐵", "Complete Avatar 203")
end
function comAvatar204()
    applyCompleteAvatar({1635148044, 3158310}, "🐧", "Complete Avatar 204")
end
function comAvatar205()
    applyCompleteAvatar({1635148044, 3225882}, "🦋", "Complete Avatar 205")
end
function comAvatar206()
    applyCompleteAvatar({1635148044, 3291954}, "🌸", "Complete Avatar 206")
end
function comAvatar207()
    applyCompleteAvatar({1635148044, 3357490}, "🌼", "Complete Avatar 207")
end
function comAvatar208()
    applyCompleteAvatar({1635148044, 3423026}, "🌹", "Complete Avatar 208")
end
function comAvatar209()
    applyCompleteAvatar({1635148044, 3488562}, "🌻", "Complete Avatar 209")
end
function comAvatar210()
    applyCompleteAvatar({1635148044, 3554098}, "🍂", "Complete Avatar 210")
end

function comAvatar211()
    applyCompleteAvatar({1635148044, 3619634}, "🍁", "Complete Avatar 211")
end
function comAvatar212()
    applyCompleteAvatar({1635148044, 3685170}, "🌲", "Complete Avatar 212")
end
function comAvatar213()
    applyCompleteAvatar({1635148044, 3750706}, "🌳", "Complete Avatar 213")
end
function comAvatar214()
    applyCompleteAvatar({1635148044, 3158566}, "🌴", "Complete Avatar 214")
end
function comAvatar215()
    applyCompleteAvatar({1635148044, 3226138}, "🌵", "Complete Avatar 215")
end
function comAvatar216()
    applyCompleteAvatar({1635148044, 3292210}, "🍄", "Complete Avatar 216")
end
function comAvatar217()
    applyCompleteAvatar({1635148044, 3357746}, "🌾", "Complete Avatar 217")
end
function comAvatar218()
    applyCompleteAvatar({1635148044, 3423282}, "💐", "Complete Avatar 218")
end
function comAvatar219()
    applyCompleteAvatar({1635148044, 3488818}, "🌺", "Complete Avatar 219")
end
function comAvatar220()
    applyCompleteAvatar({1635148044, 3554354}, "🪷", "Complete Avatar 220")
end

function comAvatar221()
    applyCompleteAvatar({1635148044, 3619890}, "🌙", "Complete Avatar 221")
end
function comAvatar222()
    applyCompleteAvatar({1635148044, 3685426}, "☀️", "Complete Avatar 222")
end
function comAvatar223()
    applyCompleteAvatar({1635148044, 3750962}, "🌞", "Complete Avatar 223")
end
function comAvatar224()
    applyCompleteAvatar({1635148044, 3158822}, "🌚", "Complete Avatar 224")
end
function comAvatar225()
    applyCompleteAvatar({1635148044, 3226394}, "⭐", "Complete Avatar 225")
end
function comAvatar226()
    applyCompleteAvatar({1635148044, 3292466}, "✨", "Complete Avatar 226")
end
function comAvatar227()
    applyCompleteAvatar({1635148044, 3358002}, "🌠", "Complete Avatar 227")
end
function comAvatar228()
    applyCompleteAvatar({1635148044, 3423538}, "🌟", "Complete Avatar 228")
end
function comAvatar229()
    applyCompleteAvatar({1635148044, 3489074}, "💫", "Complete Avatar 229")
end
function comAvatar230()
    applyCompleteAvatar({1635148044, 3554610}, "🔥", "Complete Avatar 230")
end

function comAvatar231()
    applyCompleteAvatar({1635148044, 3620146}, "💥", "Complete Avatar 231")
end
function comAvatar232()
    applyCompleteAvatar({1635148044, 3685682}, "⚡", "Complete Avatar 232")
end
function comAvatar233()
    applyCompleteAvatar({1635148044, 3751218}, "❄️", "Complete Avatar 233")
end
function comAvatar234()
    applyCompleteAvatar({1635148044, 3159078}, "🌊", "Complete Avatar 234")
end
function comAvatar235()
    applyCompleteAvatar({1635148044, 3226650}, "💧", "Complete Avatar 235")
end
function comAvatar236()
    applyCompleteAvatar({1635148044, 3292722}, "🌬️", "Complete Avatar 236")
end
function comAvatar237()
    applyCompleteAvatar({1635148044, 3358258}, "🍃", "Complete Avatar 237")
end
function comAvatar238()
    applyCompleteAvatar({1635148044, 3423794}, "🌀", "Complete Avatar 238")
end
function comAvatar239()
    applyCompleteAvatar({1635148044, 3489330}, "☁️", "Complete Avatar 239")
end
function comAvatar240()
    applyCompleteAvatar({1635148044, 3554866}, "🌪️", "Complete Avatar 240")
end

function comAvatar241()
    applyCompleteAvatar({1635148044, 3620402}, "🌫️", "Complete Avatar 241")
end
function comAvatar242()
    applyCompleteAvatar({1635148044, 3685938}, "🌈", "Complete Avatar 242")
end
function comAvatar243()
    applyCompleteAvatar({1635148044, 3751474}, "🌩️", "Complete Avatar 243")
end
function comAvatar244()
    applyCompleteAvatar({1635148044, 3159334}, "🕸️", "Complete Avatar 244")
end
function comAvatar245()
    applyCompleteAvatar({1635148044, 3226906}, "🌋", "Complete Avatar 245")
end
function comAvatar246()
    applyCompleteAvatar({1635148044, 3292978}, "🌌", "Complete Avatar 246")
end
function comAvatar247()
    applyCompleteAvatar({1635148044, 3358514}, "🎇", "Complete Avatar 247")
end
function comAvatar248()
    applyCompleteAvatar({1635148044, 3424050}, "🎆", "Complete Avatar 248")
end
function comAvatar249()
    applyCompleteAvatar({1635148044, 3489586}, "🪐", "Complete Avatar 249")
end
function comAvatar250()
    applyCompleteAvatar({1635148044, 3555122}, "🚀", "Complete Avatar 250")
end

function comAvatar251()
    applyCompleteAvatar({1635148044, 3620658}, "🛰️", "Complete Avatar 251")
end
function comAvatar252()
    applyCompleteAvatar({1635148044, 3686194}, "🛸", "Complete Avatar 252")
end
function comAvatar253()
    applyCompleteAvatar({1635148044, 3751730}, "👾", "Complete Avatar 253")
end
function comAvatar254()
    applyCompleteAvatar({1635148044, 3159590}, "🎮", "Complete Avatar 254")
end
function comAvatar255()
    applyCompleteAvatar({1635148044, 3227162}, "🕹️", "Complete Avatar 255")
end
function comAvatar256()
    applyCompleteAvatar({1635148044, 3293234}, "🎲", "Complete Avatar 256")
end
function comAvatar257()
    applyCompleteAvatar({1635148044, 3358770}, "♟️", "Complete Avatar 257")
end
function comAvatar258()
    applyCompleteAvatar({1635148044, 3424306}, "📦", "Complete Avatar 258")
end
function comAvatar259()
    applyCompleteAvatar({1635148044, 3489842}, "🧩", "Complete Avatar 259")
end
function comAvatar260()
    applyCompleteAvatar({1635148044, 3555378}, "🎁", "Complete Avatar 260")
end

function comAvatar261()
    applyCompleteAvatar({1635148044, 3620914}, "🎈", "Complete Avatar 261")
end
function comAvatar262()
    applyCompleteAvatar({1635148044, 3686450}, "🎊", "Complete Avatar 262")
end
function comAvatar263()
    applyCompleteAvatar({1635148044, 3751986}, "🧨", "Complete Avatar 263")
end
function comAvatar264()
    applyCompleteAvatar({1635148044, 3159846}, "🍮", "Complete Avatar 264")
end
function comAvatar265()
    applyCompleteAvatar({1635148044, 3227418}, "🧁", "Complete Avatar 265")
end
function comAvatar266()
    applyCompleteAvatar({1635148044, 3293490}, "🍭", "Complete Avatar 266")
end
function comAvatar267()
    applyCompleteAvatar({1635148044, 3359026}, "🍬", "Complete Avatar 267")
end
function comAvatar268()
    applyCompleteAvatar({1635148044, 3424562}, "🍰", "Complete Avatar 268")
end
function comAvatar269()
    applyCompleteAvatar({1635148044, 3490098}, "🍪", "Complete Avatar 269")
end
function comAvatar270()
    applyCompleteAvatar({1635148044, 3555634}, "🍩", "Complete Avatar 270")
end

function comAvatar271()
    applyCompleteAvatar({1635148044, 3621170}, "🍨", "Complete Avatar 271")
end
function comAvatar272()
    applyCompleteAvatar({1635148044, 3686706}, "🍧", "Complete Avatar 272")
end
function comAvatar273()
    applyCompleteAvatar({1635148044, 3752242}, "🍦", "Complete Avatar 273")
end
function comAvatar274()
    applyCompleteAvatar({1635148044, 3160102}, "🍼", "Complete Avatar 274")
end
function comAvatar275()
    applyCompleteAvatar({1635148044, 3227674}, "🥤", "Complete Avatar 275")
end
function comAvatar276()
    applyCompleteAvatar({1635148044, 3293746}, "🍹", "Complete Avatar 276")
end
function comAvatar277()
    applyCompleteAvatar({1635148044, 3359282}, "🍸", "Complete Avatar 277")
end
function comAvatar278()
    applyCompleteAvatar({1635148044, 3424818}, "🍷", "Complete Avatar 278")
end
function comAvatar279()
    applyCompleteAvatar({1635148044, 3490354}, "🍺", "Complete Avatar 279")
end
function comAvatar280()
    applyCompleteAvatar({1635148044, 3555890}, "🍻", "Complete Avatar 280")
end

function comAvatar281()
    applyCompleteAvatar({1635148044, 3621426}, "🥂", "Complete Avatar 281")
end
function comAvatar282()
    applyCompleteAvatar({1635148044, 3686962}, "🍾", "Complete Avatar 282")
end
function comAvatar283()
    applyCompleteAvatar({1635148044, 3752498}, "🥃", "Complete Avatar 283")
end
function comAvatar284()
    applyCompleteAvatar({1635148044, 3160358}, "🍽️", "Complete Avatar 284")
end
function comAvatar285()
    applyCompleteAvatar({1635148044, 3227930}, "🥢", "Complete Avatar 285")
end
function comAvatar286()
    applyCompleteAvatar({1635148044, 3294002}, "🥄", "Complete Avatar 286")
end
function comAvatar287()
    applyCompleteAvatar({1635148044, 3359538}, "🍴", "Complete Avatar 287")
end
function comAvatar288()
    applyCompleteAvatar({1635148044, 3425074}, "🔪", "Complete Avatar 288")
end
function comAvatar289()
    applyCompleteAvatar({1635148044, 3490610}, "🏺", "Complete Avatar 289")
end
function comAvatar290()
    applyCompleteAvatar({1635148044, 3556146}, "🧿", "Complete Avatar 290")
end

function comAvatar291()
    applyCompleteAvatar({1635148044, 3621682}, "📿", "Complete Avatar 291")
end
function comAvatar292()
    applyCompleteAvatar({1635148044, 3687218}, "💍", "Complete Avatar 292")
end
function comAvatar293()
    applyCompleteAvatar({1635148044, 3752754}, "💎", "Complete Avatar 293")
end
function comAvatar294()
    applyCompleteAvatar({1635148044, 3160614}, "📸", "Complete Avatar 294")
end
function comAvatar295()
    applyCompleteAvatar({1635148044, 3228186}, "🎥", "Complete Avatar 295")
end
function comAvatar296()
    applyCompleteAvatar({1635148044, 3294258}, "📹", "Complete Avatar 296")
end
function comAvatar297()
    applyCompleteAvatar({1635148044, 3359794}, "🎞️", "Complete Avatar 297")
end
function comAvatar298()
    applyCompleteAvatar({1635148044, 3425330}, "📽️", "Complete Avatar 298")
end
function comAvatar299()
    applyCompleteAvatar({1635148044, 3490866}, "📺", "Complete Avatar 299")
end
function comAvatar300()
    applyCompleteAvatar({1635148044, 3556402}, "📻", "Complete Avatar 300")
end

function comAvatar301()
    applyCompleteAvatar({1635148044, 3225395}, "🎉", "Complete Avatar 301")
end
function comAvatar302()
    applyCompleteAvatar({1635148044, 3290931}, "🎂", "Complete Avatar 302")
end
function comAvatar303()
    applyCompleteAvatar({1635148044, 3356467}, "🏆", "Complete Avatar 303")
end
function comAvatar304()
    applyCompleteAvatar({1635148044, 3422003}, "🌈", "Complete Avatar 304")
end
function comAvatar305()
    applyCompleteAvatar({1635148044, 3487539}, "🔥", "Complete Avatar 305")
end
function comAvatar306()
    applyCompleteAvatar({1635148044, 3553075}, "💎", "Complete Avatar 306")
end
function comAvatar307()
    applyCompleteAvatar({1635148044, 3618611}, "🌟", "Complete Avatar 307")
end
function comAvatar308()
    applyCompleteAvatar({1635148044, 3684147}, "🎯", "Complete Avatar 308")
end
function comAvatar309()
    applyCompleteAvatar({1635148044, 3225651}, "🛡️", "Complete Avatar 309")
end
function comAvatar310()
    applyCompleteAvatar({1635148044, 3356723}, "👑", "Complete Avatar 310")
end
function comAvatar311()
    applyCompleteAvatar({1635148044, 3422259}, "🐉", "Complete Avatar 311")
end
function comAvatar312()
    applyCompleteAvatar({1635148044, 3487795}, "⚡", "Complete Avatar 312")
end
function comAvatar313()
    applyCompleteAvatar({1635148044, 3553331}, "🧲", "Complete Avatar 313")
end
function comAvatar314()
    applyCompleteAvatar({1635148044, 3618867}, "📦", "Complete Avatar 314")
end
function comAvatar315()
    applyCompleteAvatar({1635148044, 3684403}, "🍭", "Complete Avatar 315")
end
function comAvatar316()
    applyCompleteAvatar({1635148044, 3749939}, "🚀", "Complete Avatar 316")
end
function comAvatar317()
    applyCompleteAvatar({1635148044, 3160371}, "🧁", "Complete Avatar 317")
end
function comAvatar318()
    applyCompleteAvatar({1635148044, 3225907}, "🐾", "Complete Avatar 318")
end
function comAvatar319()
    applyCompleteAvatar({1635148044, 3422515}, "🌍", "Complete Avatar 319")
end
function comAvatar320()
    applyCompleteAvatar({1635148044, 3488051}, "🎮", "Complete Avatar 320")
end
function comAvatar321()
    applyCompleteAvatar({1635148044, 3553587}, "🎨", "Complete Avatar 321")
end
function comAvatar322()
    applyCompleteAvatar({1635148044, 3619123}, "📚", "Complete Avatar 322")
end
function comAvatar323()
    applyCompleteAvatar({1635148044, 3684659}, "🎻", "Complete Avatar 323")
end

function kums6()
    while true do
        gg.setVisible(false)
        gg.clearResults()
        local indev = dev
        local skins = {
            "🌃 • City Badge", "👑 • Legendary Town Badge",
            "🏠 • Mayors Yellow House Badge",
            "🏛️ • Purple House Badge", "🔔 • Winter Badge",
            "❄️ • Legendary Winter Badge", "🧭 • Journey Badge",
            "🗺️ • Legendary Journey Badge", "❌ • Go Back"
        }

        local choice = gg.multiChoice(skins, nil, indev)
        if not choice then return end

        -- 🔙 Back option (selalu terakhir)
        if choice[#skins] then
            if type(kums6) == "function" then
                gp3()
            else
            end
            return
        end

        local processed = false
        -- 🔁 Jalankan fungsi badge berdasarkan pilihan
        for i = 1, #skins - 1 do
            if choice[i] then
                local func = _G["badgecollect" .. i]
                if type(func) == "function" then
                    func()
                    gg.toast("✅ " .. skins[i] ..
                                 " applied.\n👉 Claim it in-freeze reward!")

                    -- ⏸️ Tunggu user tekan ikon GG sebelum lanjut
                    repeat gg.sleep(500) until gg.isVisible(true)
                    gg.setVisible(false)

                    processed = true
                else
                    gg.alert("❌ Function badgecollect" .. i .. "() not found!")
                end
            end
        end

        if processed then
            gg.toast("🎉 All selected Badge have been successfully claimed!")
        end
        -- 🔄 Setelah selesai → balik ke menu lagi
    end
end

-- Fungsi utama untuk menerapkan badge
function applybBadge(hex, emoji, name)
    local addr = getAddr()
    if not addr then
        gg.alert("❌ No matching value found.\n" .. name ..
                     " could not be applied.\nPlease try again or restart the game!")
        return
    end

    local patch = {
        {address = addr + 0x10, flags = gg.TYPE_DWORD, value = hex[1]},
        {address = addr + 0x14, flags = gg.TYPE_DWORD, value = hex[2]},
        {address = addr + 0x18, flags = gg.TYPE_DWORD, value = hex[3]},
        {address = addr + 0x1C, flags = gg.TYPE_DWORD, value = hex[4]},
        {address = addr + 0x20, flags = gg.TYPE_DWORD, value = hex[5]},
        {address = addr + 0x24, flags = gg.TYPE_DWORD, value = hex[6]},
        {address = addr + 0x28, flags = gg.TYPE_DWORD, value = 0},
        {address = addr + 0x2C, flags = gg.TYPE_DWORD, value = 1}
    }

    gg.setValues(patch)
    gg.toast("✅ " .. emoji .. " " .. name .. " applied!")
end

-- Kumpulan badge
function badgecollect1()
    applybBadge({
        0x6461621A, 0x305F6567, 0x61625F31, 0x00006573, 0x00000000, 0x00000000
    }, "🌃", "City Badge")
end

function badgecollect2()
    applybBadge({
        0x6461621C, 0x305F6567, 0x72675F31, 0x00646E61, 0x00000000, 0x00000000
    }, "👑", "Legendary Town Badge")
end

function badgecollect3()
    applybBadge({
        0x64616220, 0x305F6567, 0x32765F31, 0x7361625F, 0x00000065, 0x00000000
    }, "🏠", "Mayors Yellow House Badge")
end

function badgecollect4()
    applybBadge({
        0x64616222, 0x305F6567, 0x32765F31, 0x6172675F, 0x1900646E, 0x00000000
    }, "🏛️", "Purple House Badge")
end

function badgecollect5()
    applybBadge({
        0x6461621A, 0x305F6567, 0x61625F32, 0x00006573, 0x00000000, 0x00000000
    }, "🔔", "Winter Badge")
end

function badgecollect6()
    applybBadge({
        0x6461621C, 0x305F6567, 0x72675F32, 0x00646E61, 0x00000000, 0x00000000
    }, "❄️", "Legendary Winter Badge")
end

function badgecollect7()
    applybBadge({
        0x6461621A, 0x305F6567, 0x61625F33, 0x00006573, 0x00000000, 0x00000000
    }, "🧭", "Journey Badge")
end

function badgecollect8()
    applybBadge({
        0x6461621C, 0x305F6567, 0x72675F33, 0x00646E61, 0x00000000, 0x00000000
    }, "🗺️", "Legendary Journey Badge")
end

-------------------------------------------------

function menuSpecial()
    local title = banner
    local menu = gg.choice({
        _("vip_regatta_task"), -- 💎 • VIP Tugas Regata
        _("auto_finish_task"), -- 🌊 • Selesaikan Tugas Otomatis
        _("edit_regatta_points"), -- ⭐ • Edit Poin Regata
        _("back_main_menu_spesial") -- ❌ • Kembali ke Menu Utama
    }, nil, title)

    if menu == nil then
        return
    elseif menu == 1 then
        ms1()
    elseif menu == 2 then
        ms2()
    elseif menu == 3 then
        ms3()
    elseif menu == 4 then
        Main()
        return
    else
        return
    end

    -- 🔁 Ulangi menu setelah fungsi selesai
    while true do
        if gg.isVisible(true) then
            gg.setVisible(false)
            menuSpecial()
            break
        end
    end
end

function ms1()
    gg.setVisible(false)
    gg.clearResults()

    -- 📥 Pilih jumlah poin
    local poinChoice = gg.choice({
        _("vipedit150"), _("vipedit200"), _("vipedit300")
    }, nil, _("title_pilih_poin"))

    if not poinChoice then return end

    local points = ({150, 200, 300})[poinChoice]

    gg.searchNumber("65538", gg.TYPE_QWORD)
    local allResults = gg.getResults(99999)
    if #allResults == 0 then return gg.alert(_("alert_tidak_ditemukan")) end

    local checkList = {}
    for i, r in ipairs(allResults) do
        checkList[i] = {address = r.address + 0x100, flags = gg.TYPE_DWORD}
    end
    local checkVals = gg.getValues(checkList)

    local edits, count = {}, 0
    for i, c in ipairs(checkVals) do
        if c.value == -1 then
            local addr = allResults[i].address
            local baseVal = gg.getValues({
                {address = addr + 0x148, flags = gg.TYPE_QWORD}
            })[1].value
            if baseVal and baseVal > 0x100000 then
                count = count + 1
                edits[#edits + 1] = {
                    address = addr + 0xC0,
                    flags = gg.TYPE_DWORD,
                    value = 0
                }
                edits[#edits + 1] = {
                    address = addr + 0xC4,
                    flags = gg.TYPE_DWORD,
                    value = 0
                }
                edits[#edits + 1] = {
                    address = baseVal,
                    flags = gg.TYPE_DWORD,
                    value = 0
                }
                edits[#edits + 1] = {
                    address = baseVal + 0x4,
                    flags = gg.TYPE_DWORD,
                    value = points
                }
            end
        end
    end

    if #edits > 0 then
        gg.setValues(edits)
        gg.clearResults()
        gg.alert(_("alert_berhasil_prefix") .. " " .. count .. "\n" ..
                     _("alert_berhasil_suffix") .. " " .. points)
        gg.toast(_("toast_berhasil"))
    else
        gg.alert(_("alert_tidak_valid"))
    end
end

function ms2()
    gg.setVisible(false)
    gg.clearResults()

    -- 🔍 Cari QWORD utama
    gg.searchNumber("65540", gg.TYPE_QWORD)
    local hasil = gg.getResults(1000) -- batasi agar lebih ringan

    if #hasil == 0 then return end

    -- 🧩 Ambil semua offset sekaligus (lebih cepat)
    local offsets = {}
    for i, v in ipairs(hasil) do
        table.insert(offsets,
                     {address = v.address + 0x130, flags = gg.TYPE_DWORD})
        table.insert(offsets,
                     {address = v.address + 0x1E8, flags = gg.TYPE_DWORD})
    end

    local nilai = gg.getValues(offsets)
    local kandidat = nil

    -- 🧮 Cek nilai offset
    for i = 1, #hasil do
        local val130 = nilai[(i - 1) * 2 + 1].value
        local val1E8 = nilai[(i - 1) * 2 + 2].value
        if val130 == -1 and val1E8 == 1 then
            kandidat = hasil[i]
            break
        end
    end

    if not kandidat then return gg.alert(_("regata_failed")) end

    -- 🧠 Persiapan data edit
    local targetAddress = kandidat.address
    local edit = {
        {address = targetAddress + 0xC8, flags = gg.TYPE_DWORD, value = 0}, -- status
        {address = targetAddress + 0xCC, flags = gg.TYPE_DWORD, value = 15000} -- nilai tugas
    }

    -- ✏️ Terapkan perubahan
    gg.setValues(edit)
    gg.clearResults()

    -- ✅ Notifikasi sukses
    gg.toast(_("regata_done"))
end

function ms3()
    gg.setVisible(false)
    gg.clearResults()

    -- 💬 Pilihan poin
    local pilihan = gg.choice({_("edit150"), _("edit200"), _("edit300")}, nil,
                              _("pilih_poin"))

    if not pilihan then return end

    local poin = ({150, 200, 300})[pilihan]

    -- 🔍 Cari QWORD utama
    gg.searchNumber("65540", gg.TYPE_QWORD)
    local hasil = gg.getResults(1000)
    if #hasil == 0 then return end

    -- 🧩 Siapkan batch offset
    local checkList = {}
    for i, v in ipairs(hasil) do
        table.insert(checkList,
                     {address = v.address + 0x130, flags = gg.TYPE_DWORD})
        table.insert(checkList,
                     {address = v.address + 0x1E8, flags = gg.TYPE_DWORD})
    end

    local checked = gg.getValues(checkList)
    local kandidat = nil

    for i = 1, #hasil do
        local val130 = checked[(i - 1) * 2 + 1].value
        local val1E8 = checked[(i - 1) * 2 + 2].value
        if val130 == -1 and val1E8 == 1 then
            kandidat = hasil[i]
            break
        end
    end

    if not kandidat then return gg.alert(_ "gagal_regata") end

    local baseData = gg.getValues({
        {address = kandidat.address + 0x208, flags = gg.TYPE_QWORD}
    })[1]
    if not baseData or baseData.value <= 0x100000 then return end

    -- ✏️ Edit poin
    gg.setValues({
        {address = baseData.value + 0x0, flags = gg.TYPE_DWORD, value = 0},
        {address = baseData.value + 0x4, flags = gg.TYPE_DWORD, value = poin}
    })

    gg.clearResults()
    gg.toast(_ "sukses" .. poin)
end

function menu2()
    local title = banner
    local menu = gg.choice({
        _("menu2_levelup_puzzle"), _("menu2_weekly_contest"),
        _("menu2_erni_cup"), _("menu2_ruler_the_mine"),
        _("menu2_treasure_pirate"), _("menu2_send_goldcard"),
        _("menu2_duplicate_card"), _("menu2_frozen_poin"),
        _("menu_back_menuipen")
    }, nil, title)

    if menu == nil then
        return

    elseif menu == 1 then
        ipen1()
    elseif menu == 2 then
        ipen2()
    elseif menu == 3 then
        ipen3()
    elseif menu == 4 then
        ipen4()
    elseif menu == 5 then
        ipen5()
    elseif menu == 6 then
        ipen6()
    elseif menu == 7 then
        ipen7()
    elseif menu == 8 then
        ipen8()
    elseif menu == 9 then
        Main()
        return -- stop loop kalau balik ke menu utama
    else
        return
    end

    -- Setelah user memilih fungsi, tunggu klik GG baru ulangi menu
    while true do
        if gg.isVisible(true) then
            gg.setVisible(false)
            menu2()
            break
        end
    end
end

function ipen1()
    gg.setVisible(false)
    gg.clearResults()

    -- 🏁 Input poin
    local input = gg.prompt({_("input_level_puzzel")}, nil, {"number"})
    local val = tonumber(input and input[1])
    if not val or val < 1 then return end

    -- ===============================
    -- 🔍 SEARCH PERTAMA (131074) - FAST FILTER
    -- ===============================
    gg.searchNumber("131074", gg.TYPE_DWORD)
    local r = gg.getResults(100000)

    if #r == 0 then
        gg.alert(_("level_puzzle_not_found"))
        return
    end

    -- siapkan list cek offset
    local checkList = {}
    for i, v in ipairs(r) do
        checkList[#checkList + 1] = {
            address = v.address - 0xC0,
            flags = gg.TYPE_DWORD
        }
        checkList[#checkList + 1] = {
            address = v.address - 0x8,
            flags = gg.TYPE_DWORD
        }
    end

    -- ambil SEMUA value sekaligus
    local checkValues = gg.getValues(checkList)

    local valid1 = {}
    local idx = 1

    for i, v in ipairs(r) do
        local val1 = checkValues[idx].value -- -0xC0
        local val2 = checkValues[idx + 1].value -- -0x8
        idx = idx + 2

        if val1 == 291 and val2 == 2 then
            valid1[#valid1 + 1] = {
                address = v.address - 0xC,
                flags = gg.TYPE_DWORD,
                value = val
            }
        end
    end

    if #valid1 == 0 then
        gg.alert(_("level_puzzle_invalid"))
        return
    end

    gg.setValues(valid1)
    gg.clearResults()

    -- ===============================
    -- 🔍 SEARCH KEDUA (86400)
    -- ===============================
    gg.searchNumber("86400", gg.TYPE_DWORD)
    local results2 = gg.getResults(1000)

    if #results2 == 0 then
        gg.alert(_("level_puzzle_not_found"))
        return
    end

    local valid2 = {}
    for i, v in ipairs(results2) do
        local checks = gg.getValues({
            {address = v.address - 0x20, flags = gg.TYPE_DWORD},
            {address = v.address - 0x10, flags = gg.TYPE_DWORD}
        })

        if checks[1].value == 290 and checks[2].value == 2 then
            valid2[#valid2 + 1] = {
                address = v.address - 0x14,
                flags = gg.TYPE_DWORD,
                value = val
            }
        end
    end

    if #valid2 == 0 then
        gg.alert(_("level_puzzle_invalid"))
        return
    end

    gg.setValues(valid2)
    gg.clearResults()

    a2()
    gg.toast(_("level_puzzle_success"))
end

function ipen2()
    gg.setVisible(false)
    gg.clearResults()

    -- 🏁 Input poin
    local input = gg.prompt({_("input_weekly_point")}, nil, {"number"})
    local val = tonumber(input and input[1])
    if not val or val < 1 then return end

    -- 🔍 Cari base QWORD
    gg.searchNumber("7304685138115716370", gg.TYPE_QWORD)
    local results = gg.getResults(100)

    if #results == 0 then
        gg.alert(_("ernie_not_found"))
        return
    end

    -- 🔎 Filter offset +0x600
    local validBase = {}
    for i = 1, #results do
        local check = gg.getValues({
            {address = results[i].address + 0x600, flags = gg.TYPE_DWORD}
        })[1]

        if check and check.value == 1936681992 then
            table.insert(validBase, results[i])
        end
    end

    if #validBase == 0 then
        gg.alert(_("ernie_invalid"))
        return
    end

    -- ✏️ Edit poin offset +0x418
    local setval = {}
    for i = 1, #validBase do
        setval[#setval + 1] = {
            address = validBase[i].address + 0x418,
            flags = gg.TYPE_DWORD,
            value = val
        }
    end

    gg.setValues(setval)
    gg.clearResults()
    gg.toast(_("point_success"))
    a2()
end

function ipen3()
    gg.setVisible(false)
    gg.clearResults()

    -- 🏆 Input poin
    local input = gg.prompt({_("ernie_input")}, nil, {"number"})
    local val = tonumber(input and input[1])
    if not val or val < 1 then return end

    -- 🔍 Cari base QWORD
    gg.searchNumber("7304685138115716370", gg.TYPE_QWORD)
    local results = gg.getResults(100)
    if #results == 0 then
        gg.alert(_("ernie_notfound"))
        return
    end

    -- 🔎 Filter offset +0x2D8
    local validBase = {}
    for i = 1, #results do
        local check = gg.getValues({
            {address = results[i].address + 0x2D8, flags = gg.TYPE_DWORD}
        })[1]

        if check and check.value == 49 then
            table.insert(validBase, results[i])
        end
    end

    if #validBase == 0 then
        gg.alert(_("ernie_notvalid"))
        return
    end

    -- ✏️ Edit poin offset +0x318
    local setval = {}
    for i = 1, #validBase do
        setval[#setval + 1] = {
            address = validBase[i].address + 0x318,
            flags = gg.TYPE_DWORD,
            value = val
        }
    end

    gg.setValues(setval)
    gg.toast(_("ernie_success"))
    a2()
end

-- ✅ Fungsi utama ipen3 multi-bahasa
function ipen4()
    gg.setVisible(false)
    gg.clearResults()
    gg.alert(_ "Etamwarn_event_not_claimed")

    -- Search main QWORD
    gg.searchNumber("3304708", gg.TYPE_QWORD)
    local list = gg.getResults(500)

    if #list == 0 then
        gg.alert(_ "Etamno_data_found")
        return
    end

    -- Check offset +0xD4
    local target = nil

    for i, v in ipairs(list) do
        local checkAddr = v.address + 0xD4
        local check = gg.getValues({
            {address = checkAddr, flags = gg.TYPE_DWORD}
        })

        if check[1].value == 3237230 then
            target = v.address
            break
        end
    end

    if not target then
        gg.alert(_ "Etamno_target")
        return
    end

    -- Apply edit
    gg.setValues({
        {address = target - 0x18, flags = gg.TYPE_DWORD, value = 0},
        {address = target - 0x14, flags = gg.TYPE_DWORD, value = 2000}
    })

    a2()
    gg.alert(_ "Etamsuccess_alert")
    gg.toast(_ "Etamsuccess_toast")
end

-- ✅ Fungsi utama ipen4 multi-bahasa
function ipen5()
    gg.setVisible(false)
    gg.clearResults()

    gg.searchNumber("1734429984;85::281", gg.TYPE_DWORD)
    gg.refineNumber("85", gg.TYPE_DWORD)

    local r = gg.getResults(gg.getResultCount())
    if #r == 0 then
        gg.alert(_("dataNotFound_bajak"))
        return
    end

    local freeze = {}
    for i = 1, #r do
        local addr = r[i].address
        table.insert(freeze, {
            address = addr - 0x70,
            flags = gg.TYPE_DWORD,
            value = 0,
            freeze = true
        })
        table.insert(freeze, {
            address = addr - 0x6C,
            flags = gg.TYPE_DWORD,
            value = 1,
            freeze = true
        })
    end

    gg.addListItems(freeze)
    gg.clearResults()
    a2()
    gg.toast(string.format(_("toastFreeze_bajak") .. " (%d)", #r))
end

function ipen6()
    gg.setVisible(false)
    gg.clearResults()

    gg.searchNumber("97059372622158", gg.TYPE_QWORD)
    local hasil1 = gg.getResults(5000)

    if #hasil1 == 0 then
        gg.alert(_("goldcard_notfound"))
        return
    end

    local offsets1 = {}
    for _, v in ipairs(hasil1) do
        offsets1[#offsets1 + 1] = {
            address = v.address + 0x20,
            flags = gg.TYPE_DWORD
        }
    end

    local nilai1 = gg.getValues(offsets1)
    local kandidat1 = nil

    for i = 1, #nilai1 do
        if nilai1[i].value == 1684828007 then
            kandidat1 = hasil1[i]
            break
        end
    end

    if not kandidat1 then
        gg.alert(_("goldcard_notverify"))
        return
    end

    gg.setValues({
        {address = kandidat1.address + 0x20, flags = gg.TYPE_DWORD, value = 0}
    })

    gg.clearResults()

    gg.searchNumber("12884967423", gg.TYPE_QWORD)
    local hasil2 = gg.getResults(500)

    if #hasil2 == 0 then
        gg.alert(_("noDataFound_sendcard"))
        return
    end

    local cekList = {}
    for _, v in ipairs(hasil2) do
        table.insert(cekList,
                     {address = v.address + 0x24, flags = gg.TYPE_DWORD})
    end

    local nilaiOffset = gg.getValues(cekList)
    local kandidat2 = {}

    for i = 1, #nilaiOffset do
        if nilaiOffset[i].value == 86400 then
            table.insert(kandidat2, hasil2[i])
        end
    end

    if #kandidat2 == 0 then
        gg.alert(_("baseNotFound_sendcard"))
        return
    end

    local offsets2 = {0x44, 0x48, 0x4C, 0x50, 0x54, 0x58}
    local edits = {}

    for _, base in ipairs(kandidat2) do
        for _, off in ipairs(offsets2) do
            table.insert(edits, {
                address = base.address + off,
                flags = gg.TYPE_DWORD,
                value = 0,
                freeze = true
            })
        end
    end

    gg.setValues(edits)
    gg.addListItems(edits)
    gg.clearResults()

    a2()
    gg.toast(_("success_sendcard"))
end

function ipen7()
    gg.setVisible(false)
    gg.clearResults()
    gg.setRanges(gg.REGION_C_ALLOC)

    -- ✨ Pilihan jumlah kartu baru
    local ch = gg.choice({
        _("duplikat_opt_50"), _("duplikat_opt_100"), _("duplikat_opt_500")
    }, nil, _("duplikat_title"))

    if not ch then return end

    -- nilai patch (+1 biar aman)
    local newCount = ({51, 101, 501})[ch]
    if not newCount then return end

    local allResults = {}

    -- 🔍 Grup 1
    gg.searchNumber("1918984974", gg.TYPE_DWORD)
    local r1 = gg.getResults(2000)
    gg.clearResults()

    -- 🔍 Grup 2
    gg.searchNumber("1918984976", gg.TYPE_DWORD)
    local r2 = gg.getResults(2000)
    gg.clearResults()

    -- 🔗 Gabungkan hasil
    for i = 1, #r1 do allResults[#allResults + 1] = r1[i] end
    for i = 1, #r2 do allResults[#allResults + 1] = r2[i] end

    if #allResults == 0 then
        gg.alert(_("duplikat_not_found"))
        return
    end

    -- 🎯 Ambil nilai offset +0x28
    local batch = {}
    for i = 1, #allResults do
        batch[i] = {
            address = allResults[i].address + 0x28,
            flags = gg.TYPE_DWORD
        }
    end

    local values = gg.getValues(batch)
    local targets = {}
    local seen = {}

    -- ✅ FILTER GABUNG (OR)
    for i = 1, #values do
        local v = values[i].value
        local addr = allResults[i].address
        if (v == 1918984974 or v == 1918984976) and not seen[addr] then
            seen[addr] = true
            targets[#targets + 1] = addr
        end
    end

    if #targets == 0 then
        gg.alert(_("duplikat_invalid"))
        return
    end

    -- ✍️ Patch jumlah kartu (offset +0x1C)
    local edits = {}
    for i = 1, #targets do
        edits[i] = {
            address = targets[i] + 0x1C,
            flags = gg.TYPE_DWORD,
            value = newCount
        }
    end

    gg.setValues(edits)
    a2()
    gg.toast(_("duplikat_success") .. newCount)
end

function ipen8()
    gg.setVisible(false)
    gg.clearResults()
    gg.setRanges(gg.REGION_C_ALLOC)

    -- 🏁 Input poin
    local input = gg.prompt({_("menu2_input")}, {5}, {"number"})

    local val = tonumber(input and input[1])
    if not val then return end

    if val < 5 or val > 55000 then
        gg.alert(_("menu2_invalid"))
        return
    end

    -- 🔍 Cari base
    gg.searchNumber("1986947350", gg.TYPE_DWORD)
    local results = gg.getResults(200)
    if #results == 0 then
        gg.alert(_("menu2_notfound"))
        return
    end

    -- 🔎 Filter berantai
    local validBase = {}

    for i = 1, #results do
        local addr = results[i].address

        local v1 =
            gg.getValues({{address = addr - 0x64, flags = gg.TYPE_DWORD}})[1]
                .value
        local v2 =
            gg.getValues({{address = addr - 0x60, flags = gg.TYPE_DWORD}})[1]
                .value
        local v3 =
            gg.getValues({{address = addr - 0x5C, flags = gg.TYPE_DWORD}})[1]
                .value

        if v1 == val and v2 == val and v3 == val then
            table.insert(validBase, results[i])
        end
    end

    if #validBase == 0 then
        gg.alert(_("menu2_novalid"))
        return
    end

    -- ✏️ Edit poin
    local setval = {}
    for i = 1, #validBase do
        local addr = validBase[i].address
        setval[#setval + 1] = {
            address = addr - 0x64,
            flags = gg.TYPE_DWORD,
            value = 55000
        }
        setval[#setval + 1] = {
            address = addr - 0x60,
            flags = gg.TYPE_DWORD,
            value = 55000
        }
        setval[#setval + 1] = {
            address = addr - 0x5C,
            flags = gg.TYPE_DWORD,
            value = 55000
        }
    end

    gg.setValues(setval)
    gg.clearResults()
    gg.toast(_("menu2_success"))
    a2()
end

function menu7()
    local title = banner
    local menu = gg.choice({
        _("shipBoost_aripal"), _("cargoAuto1_aripal"), _("heliAuto_aripal"),
        _("trainBoost11_aripal"), _("go_back_skiptime")
    }, nil, title)

    if menu == nil then
        return
    elseif menu == 1 then
        auto1()
    elseif menu == 2 then
        auto2()
    elseif menu == 3 then
        auto3()
    elseif menu == 4 then
        auto4()
    elseif menu == 5 then
        Main()
        return
    else
        return
    end

    -- 🔁 Ulangi menu setelah fungsi selesai
    while true do
        if gg.isVisible(true) then
            gg.setVisible(false)
            menu7()
            break
        end
    end
end

function auto1()
    gg.setVisible(false)
    gg.clearResults()

    -- 🔍 Cari DRAFT Gold Card Identifier
    gg.searchNumber("8315178131471156752", gg.TYPE_QWORD)
    local hasil = gg.getResults(100)

    if #hasil == 0 then
        gg.alert(_ "pulau_no_data")
        return
    end

    -- 🔍 Siapkan list offset untuk dicek (hanya 0x20)
    local offsets = {}
    for _, v in ipairs(hasil) do
        offsets[#offsets + 1] = {
            address = v.address - 0x6D4,
            flags = gg.TYPE_DWORD
        }
    end

    -- 📥 Ambil nilai offset
    local nilai = gg.getValues(offsets)

    local kandidat = nil

    -- 🔎 Validasi offset
    for i = 1, #nilai do
        if nilai[i].value == 120 then
            kandidat = hasil[i]
            break
        end
    end

    if not kandidat then
        gg.alert(_ "pulau_invalid")
        return
    end

    -- ✏️ Siapkan patch
    local edit = {
        {address = kandidat.address - 0x6D8, flags = gg.TYPE_DWORD, value = 1},
        {address = kandidat.address - 0x598, flags = gg.TYPE_DWORD, value = 1},
        {address = kandidat.address - 0x458, flags = gg.TYPE_DWORD, value = 1},
        {address = kandidat.address - 0x318, flags = gg.TYPE_DWORD, value = 1},
        {address = kandidat.address - 0x098, flags = gg.TYPE_DWORD, value = 1}
    }

    gg.setValues(edit)
    gg.clearResults()

    -- 🎉 Sukses
    a2()
    gg.toast(_ "pulau_success")
end

function auto2()
    gg.setVisible(false)
    gg.clearResults()

    -- 🔍 Cari nilai cooldown utama
    gg.searchNumber("54000", gg.TYPE_DWORD)
    local results = gg.getResults(10)

    if #results == 0 then
        gg.alert(_ "no_data")
        return
    end

    local freezeList = {}

    -- 🔎 Validasi dan Freeze
    for _, v in ipairs(results) do
        local checkAddr = v.address - 0x4 -- validasi
        local freezeAddr = v.address - 0x8 -- untuk freeze

        local val = gg.getValues({{address = checkAddr, flags = gg.TYPE_DWORD}})
        if val[1].value == 18000 then
            table.insert(freezeList, {
                address = freezeAddr,
                flags = gg.TYPE_DWORD,
                value = 0,
                freeze = true
            })
        end
    end

    if #freezeList == 0 then
        gg.alert(_ "no_valid")
        return
    end

    gg.addListItems(freezeList)
    gg.clearResults()
    a2()
    gg.toast(_ "activated")
end

function auto3()
    gg.setVisible(false)
    gg.clearResults()

    -- 🔍 Cari DRAFT Gold Card Identifier
    gg.searchNumber("16842752", gg.TYPE_QWORD)
    local hasil = gg.getResults(gg.getResultCount()) -- ambil semua hasil

    if #hasil == 0 then
        gg.alert(_("helikopter_not_found"))
        return
    end

    -- 🔍 Siapkan list offset untuk dicek (0x10)
    local offsets = {}
    for _, v in ipairs(hasil) do
        offsets[#offsets + 1] = {
            address = v.address + 0x10,
            flags = gg.TYPE_DWORD
        }
    end

    -- 📥 Ambil nilai offset
    local nilai = gg.getValues(offsets)

    local editList = {}

    -- 🔎 Validasi dan siapkan semua patch
    for i = 1, #nilai do
        if nilai[i].value == 100 then
            local v = hasil[i]
            table.insert(editList, {
                address = v.address - 0x8,
                flags = gg.TYPE_DWORD,
                value = 0
            })
            table.insert(editList, {
                address = v.address - 0x4,
                flags = gg.TYPE_DWORD,
                value = 0
            })
            table.insert(editList, {
                address = v.address + 0x10,
                flags = gg.TYPE_DWORD,
                value = 0
            })
            table.insert(editList, {
                address = v.address,
                flags = gg.TYPE_DWORD,
                value = 0
            })
        end
    end

    if #editList == 0 then
        gg.alert(_("helikopter_invalid"))
        return
    end

    -- ✏️ Patch semua
    gg.setValues(editList)
    gg.clearResults()

    -- 🎉 Sukses
    a2() -- pastikan fungsi a2() ada di script utama
    gg.toast(_("helikopter_success"))
end

-- Fungsi auto4() multi-bahasa
function auto4()
    gg.setVisible(false)

    local d = gg.prompt(_ "train_prompt_kreta", nil,
                        {"number", "number", "checkbox"})
    if not d then return gg.alert(_ "cancelled_kreta") end

    local h = tonumber(d[1]) or 0
    local m = tonumber(d[2]) or 0
    local freezeCargo = d[3]

    if h < 1 or h > 5 or m < 0 or m > 55 then
        gg.alert(_ "invalid_input_kreta")
        return
    end

    local total = (h * 3600) + (m * 60)
    gg.clearResults()
    gg.searchNumber(total, gg.TYPE_FLOAT)

    local found = gg.getResults(gg.getResultCount())
    if #found == 0 then
        gg.alert(_ "no_timer_kreta")
        return
    end

    local patch = {}
    for _, v in ipairs(found) do
        table.insert(patch, {
            address = v.address,
            flags = gg.TYPE_FLOAT,
            freeze = true,
            value = 1
        })

        if freezeCargo then
            for _, offset in ipairs({0x1a0, 0x2c8, 0x3f0, 0x518, 0x640}) do
                table.insert(patch, {
                    address = v.address - offset,
                    flags = gg.TYPE_DWORD,
                    freeze = true,
                    value = 1
                })
            end
        end
    end

    gg.addListItems(patch)
    gg.clearResults()
    a2()

    local msg = _("train_timer_frozen_kreta") .. h .. "h " .. m .. "m"
    if freezeCargo then msg = msg .. _("carriage_frozen_kreta") end

    gg.alert(_ "success_msg_kreta" .. msg)
    gg.toast(_ "train_updated_kreta")
end

-- ✅ Fungsi menu3 dengan multi bahasa
function menu3()
    local title = banner
    local menu = gg.choice({
        _("no_feed_timer_skiptime"), _("no_farm_timer_skiptime"),
        _("instant_foundry_skiptime"), _("no_request_delay_skiptime"),
        _("more_requests_menupenambah"), _("extra_ship_menupenambah"),
        _("back_menupenambah")
    }, nil, title)

    if menu == nil then
        return
    elseif menu == 1 then
        parming1()
    elseif menu == 2 then
        parming2()
    elseif menu == 3 then
        parming3()
    elseif menu == 4 then
        parming4()
    elseif menu == 5 then
        parming5()
    elseif menu == 6 then
        parming6()
    elseif menu == 7 then
        Main() -- Kembali ke menu utama
        return
    else
        return
    end

    -- 🔁 Buka ulang menu jika user tekan ikon GG
    while true do
        if gg.isVisible(true) then
            gg.setVisible(false)
            menu3()
            break
        end
    end
end

function parming1()
    gg.setVisible(false)

    -- 📦 Pilih jumlah feed
    local choice = gg.choice({_("feed_50"), _("feed_100"), _("feed_500")}, nil,
                             _("feed_select_title"))

    if not choice then return end

    local feedamount = ({50, 100, 500})[choice]

    gg.clearResults()

    -- 🔍 Cari QWORD utama
    gg.searchNumber("8751179571608512014", gg.TYPE_QWORD)
    local results = gg.getResults(1000)

    if #results == 0 then
        gg.alert(_("feed_not_found"))
        return
    end

    -- 🔎 Validasi offset
    local base = nil
    for _, v in ipairs(results) do
        local check = gg.getValues({
            {address = v.address + 0x28, flags = gg.TYPE_DWORD}
        })
        if check[1].value == 2003788558 then
            base = v.address
            break
        end
    end

    if not base then
        gg.alert(_("feed_not_valid"))
        return
    end

    -- 📌 Offset pakan
    local offsets = {
        0x40, 0x44, 0x48, 0x50, 0x54, 0x58, 0x5C, 0x60, 0x64, 0xE0, 0xE4, 0xE8,
        0xF0, 0xF4, 0xF8, 0xFC, 0x100, 0x104, 0x180, 0x184, 0x188, 0x190, 0x194,
        0x198, 0x19C, 0x1A0, 0x1A4, 0x220, 0x224, 0x228, 0x230, 0x234, 0x238,
        0x23C, 0x240, 0x244, 0x2C0, 0x2C4, 0x2C8, 0x2D0, 0x2D4, 0x2D8, 0x2DC,
        0x2E0, 0x2E4, 0x310, 0x314, 0x318, 0x320, 0x324, 0x328, 0x32C, 0x330,
        0x334
    }

    local edits = {}

    -- 🛠 Patch pakan instan
    for i = 1, #offsets, 9 do
        table.insert(edits, {
            address = base + offsets[i],
            flags = gg.TYPE_DWORD,
            value = 1
        })
        table.insert(edits, {
            address = base + offsets[i + 1],
            flags = gg.TYPE_DWORD,
            value = 0
        })
        table.insert(edits, {
            address = base + offsets[i + 2],
            flags = gg.TYPE_DWORD,
            value = feedamount
        })
        table.insert(edits, {
            address = base + offsets[i + 3],
            flags = gg.TYPE_DWORD,
            value = 0
        })
        table.insert(edits, {
            address = base + offsets[i + 4],
            flags = gg.TYPE_DWORD,
            value = 0
        })
        table.insert(edits, {
            address = base + offsets[i + 5],
            flags = gg.TYPE_DWORD,
            value = 0
        })
        table.insert(edits, {
            address = base + offsets[i + 6],
            flags = gg.TYPE_DWORD,
            value = 0
        })
        table.insert(edits, {
            address = base + offsets[i + 7],
            flags = gg.TYPE_DWORD,
            value = 0
        })
        table.insert(edits, {
            address = base + offsets[i + 8],
            flags = gg.TYPE_DWORD,
            value = 0
        })
    end

    gg.setValues(edits)
    gg.clearResults()
    a2()
    gg.toast(_("feed_success"))
end

function oder6() parming2("free") end

function parming2()
    gg.setVisible(false)
    gg.clearResults()

    -- 🔍 Cari pola utama (banyak hasil)
    gg.searchNumber("8386654023812342548", gg.TYPE_QWORD)
    local results = gg.getResults(100)

    if #results == 0 then
        gg.alert(_("animal_instant_not_found"))
        return
    end

    -- 🔎 Filter dengan offset +0x40 == 1818848520
    local valid = {}

    for _, v in ipairs(results) do
        local check = gg.getValues({
            {address = v.address + 0x40, flags = gg.TYPE_DWORD}
        })

        if check[1].value == 1818848520 then table.insert(valid, v) end
    end

    if #valid == 0 then
        gg.alert(_("animal_instant_not_valid"))
        return
    end

    -- ✅ Gunakan base yang sudah tervalidasi
    local base = valid[1].address
    local edits = {}

    -- 🛠 Patch Instant Production
    table.insert(edits,
                 {address = base + 0x58, flags = gg.TYPE_DWORD, value = 0})
    table.insert(edits,
                 {address = base + 0xF8, flags = gg.TYPE_DWORD, value = 0})
    table.insert(edits,
                 {address = base + 0x198, flags = gg.TYPE_DWORD, value = 0})
    table.insert(edits,
                 {address = base + 0x238, flags = gg.TYPE_DWORD, value = 0})
    table.insert(edits,
                 {address = base + 0x2D8, flags = gg.TYPE_DWORD, value = 0})
    table.insert(edits,
                 {address = base + 0x378, flags = gg.TYPE_DWORD, value = 0})

    gg.setValues(edits)
    gg.clearResults()
    a2()

    gg.toast(_("animal_instant_success"))
end

function oder5() parming3("free") end

function parming3(caller)
    gg.setVisible(false)
    gg.clearResults()

    -- 🔍 Cari QWORD utama (hasil banyak)
    gg.searchNumber("8243122701878522640", gg.TYPE_QWORD)
    local results = gg.getResults(100)

    if #results == 0 then
        gg.alert(_("foundry_not_found"))
        return
    end

    -- 🔎 Validasi dengan offset +0x18 = 1701868320
    local base = nil
    for _, v in ipairs(results) do
        local check = gg.getValues({
            {address = v.address + 0x18, flags = gg.TYPE_DWORD}
        })
        if check[1].value == 1701868320 then
            base = v.address
            break
        end
    end

    if not base then
        gg.alert(_("foundry_invalid"))
        return
    end

    -- 📌 Offset peleburan
    local offsets = {
        0x58, 0x68, 0x6C, 0x70, 0x74, 0x78, 0x7C, 0xA8, 0xB8, 0xBC, 0xC0, 0xC4,
        0xC8, 0xCC, 0xF8, 0x10C, 0x108, 0x110, 0x114, 0x118, 0x11C, 0x148,
        0x158, 0x15C, 0x160, 0x164, 0x168, 0x16C
    }

    local edits = {}

    -- 🛠 Patch: aktifkan instan
    for i = 1, #offsets, 7 do
        table.insert(edits, {
            address = base + offsets[i],
            flags = gg.TYPE_DWORD,
            value = 1
        })
        table.insert(edits, {
            address = base + offsets[i + 1],
            flags = gg.TYPE_DWORD,
            value = 0
        })
        table.insert(edits, {
            address = base + offsets[i + 2],
            flags = gg.TYPE_DWORD,
            value = 0
        })
        table.insert(edits, {
            address = base + offsets[i + 3],
            flags = gg.TYPE_DWORD,
            value = 0
        })
        table.insert(edits, {
            address = base + offsets[i + 4],
            flags = gg.TYPE_DWORD,
            value = 0
        })
        table.insert(edits, {
            address = base + offsets[i + 5],
            flags = gg.TYPE_DWORD,
            value = 0
        })
        table.insert(edits, {
            address = base + offsets[i + 6],
            flags = gg.TYPE_DWORD,
            value = 0
        })
    end

    gg.setValues(edits)
    gg.clearResults()
    a2()
    gg.toast(_("foundry_success"))
end

function parming4()
    gg.setVisible(false)
    gg.clearResults()
    gg.setRanges(gg.REGION_CODE_APP)

    -- 🔍 Cari cooldown request (hasil banyak)
    gg.searchNumber("86400", gg.TYPE_DWORD)
    local results = gg.getResults(20)

    if #results == 0 then
        gg.alert(_("request_not_found"))
        return
    end

    local edited = 0

    -- 🔎 Validasi offset -0x4 == 10800 lalu edit ke 1
    for _, v in ipairs(results) do
        local addr = v.address - 0x4
        local val = gg.getValues({{address = addr, flags = gg.TYPE_DWORD}})

        if val[1].value == 10800 then
            gg.setValues({{address = addr, flags = gg.TYPE_DWORD, value = 1}})
            edited = edited + 1
        end
    end

    if edited == 0 then
        gg.alert(_("request_invalid"))
        return
    end

    a2()
    gg.clearResults()
    gg.toast(_("request_success"))
end

function parming5()
    gg.setVisible(false)
    gg.clearResults()

    local cropKeys = {
        _("crop_wheat"), _("crop_corn"), _("crop_carrot"), _("crop_sugar"),
        _("crop_cotton"), _("crop_strawberry"), _("crop_tomato"),
        _("crop_pine"), _("crop_potato"), _("crop_cacao"), _("crop_rubber"),
        _("crop_silk"), _("crop_chili"), _("crop_rice"), _("crop_rose"),
        _("crop_jasmine"), _("crop_coffee"), _("crop_peanut"), _("crop_tea"),
        _("crop_apple"), _("crop_mint"), _("crop_soy"), _("crop_cork"),
        _("crop_lavender")
    }

    local searchPatterns = {
        '65687718h;6F437461h;6568770Ah:25', '726F6316h;756F436Eh;726F6308h:25',
        '7261631Ah;43746F72h;7261630Ch:25', '67757320h;61637261h;67757312h:25',
        '746F631Ah;436E6F74h;746F630Ch:25', '72747322h;65627761h;72747314h:25',
        '6D6F7418h;6F437461h;6D6F740Ah:25', '6E697016h;756F4365h;6E697008h:25',
        '746F701Ah;436F7461h;746F700Ch:25', '63616318h;6F436F61h;6361630Ah:25',
        '62757222h;54726562h;62757214h:25', '6C697316h;756F436Bh;6C697308h:25',
        '7065700Ch;00726570h;65657318h:25', '63697216h;756F4365h;63697208h:25',
        '736F721Eh;65655365h;736F7210h:25', '73616A1Ch;656E696Dh;73616A0Eh:25',
        '666F631Ah;43656566h;666F630Ch:25', '6165701Ah;4374756Eh;6165700Ch:25',
        '6165741Ch;68737562h;6165740Eh:25', '70706118h;6F43656Ch;7070610Ah:25',
        '6E696D16h;756F4374h;6E696D08h:25', '796F731Ch;6E616562h;796F730Eh:25',
        '726F6316h;756F436Bh;726F6308h:25', '76616C1Eh;65646E65h;76616C10h:25'
    }

    local refinePatterns = {
        '6568770Ah', '726F6308h', '7261630Ch', '67757312h', '746F630Ch',
        '72747314h', '6D6F740Ah', '6E697008h', '746F700Ch', '6361630Ah',
        '62757214h', '6C697308h', '65657318h', '63697208h', '736F7210h',
        '73616A0Eh', '666F630Ch', '6165700Ch', '6165740Eh', '7070610Ah',
        '6E696D08h', '796F730Eh', '726F6308h', '76616C10h'
    }

    local cropMenu = {}
    for i, key in ipairs(cropKeys) do cropMenu[i] = _(key) end

    local selected = gg.multiChoice(cropMenu, nil, _("select_crop"))
    if not selected then return end

    local input = gg.prompt({_("enter_crop_amount")}, nil, {"number"})
    if not input then return end

    local value = tonumber(input[1])
    if not value or value < 1 or value > 500 then
        gg.alert(_("invalid_crop_amount")) -- Alert jika input tidak valid
        return
    end

    for i = 1, #cropKeys do
        if selected[i] then
            gg.clearResults()
            gg.searchNumber(searchPatterns[i], gg.TYPE_DWORD)
            gg.refineNumber(refinePatterns[i], gg.TYPE_DWORD)

            local r = gg.getResults(10)
            if #r == 0 then
                gg.toast(_("not_found") .. " " .. _(cropKeys[i]))
            else
                local edits = {}
                for _, v in ipairs(r) do
                    edits[#edits + 1] = {
                        address = v.address + 0xF8,
                        flags = gg.TYPE_DWORD,
                        value = 0
                    }
                    edits[#edits + 1] = {
                        address = v.address + 0xFC,
                        flags = gg.TYPE_DWORD,
                        value = value
                    }
                end
                gg.setValues(edits)
                gg.toast(
                    "✅ " .. _(cropKeys[i]) .. " " .. _("set_to") .. " " ..
                        value)
            end
        end
    end
end

-- 🛳️ Fungsi Ship Product Edit
function parming6()
    gg.setVisible(false)
    gg.clearResults()

    -- ⚠️ Warning
    gg.alert(_("ship_warning"))

    -- 📦 Pilihan jumlah produk
    local choice = gg.choice({"📦 50", "📦 100", "📦 500"}, nil,
                             _("ship_choose_amount"))

    if not choice then return end

    local values = {[1] = 50, [2] = 100, [3] = 500}
    local new = values[choice]

    -- 🔍 Cari signature QWORD
    gg.searchNumber("8678228057538458392", gg.TYPE_QWORD)
    local r = gg.getResults(10)

    if #r == 0 then
        gg.alert(_("ship_not_found"))
        return
    end

    -- 🎯 Ambil offset -0x24 (DWORD)
    local edits = {}
    for _, v in ipairs(r) do
        table.insert(edits, {
            address = v.address - 0x24,
            flags = gg.TYPE_DWORD,
            value = new
        })
    end

    -- 🛠 Terapkan edit
    gg.setValues(edits)
    gg.clearResults()
    a2()

    gg.toast(_("ship_success") .. new .. "!")
end

function menumarketplace()
    local title = banner
    local menu = gg.choice({
        _("market_quantity_marketplace"), _("market_unlim_marketplace"),
        _("no_dealer_rest_marketplace"), _("dealer_rent_marketplace"),
        _("back_main_menu_spesial")
    }, nil, title)

    if menu == nil then
        return
    elseif menu == 1 then
        cmarket1()
    elseif menu == 2 then
        cmarket2()
    elseif menu == 3 then
        cmarket3()
    elseif menu == 4 then
        cmarket4()
    elseif menu == 5 then
        Main()
        return
    else
        return
    end

    -- 🔁 Ulangi menu setelah fungsi selesai
    while true do
        if gg.isVisible(true) then
            gg.setVisible(false)
            menumarketplace()
            break
        end
    end
end

function cmarket1()
    gg.setVisible(false)

    -- ✏️ Input manual jumlah produk
    local input = gg.prompt({_("quantityproduk_input")}, {50}, {"number"})
    if not input then return end

    local quantityamount = tonumber(input[1])
    if not quantityamount or quantityamount < 50 or quantityamount > 1000 then
        gg.alert(_("quantityproduk_invalid"))
        return
    end

    gg.clearResults()

    -- 🔍 Cari data Dealer
    gg.searchNumber("6072", gg.TYPE_DWORD)
    local results = gg.getResults(100)
    if #results == 0 then
        gg.alert(_("quantityproduk_not_found"))
        return
    end

    local valid = {}

    -- 🔎 Validasi signature
    for _, v in ipairs(results) do
        local val = gg.getValues({
            {address = v.address - 0x4, flags = gg.TYPE_DWORD}
        })
        if val[1].value == 1149804544 then table.insert(valid, v) end
    end

    if #valid == 0 then
        gg.alert(_("quantityproduk_not_valid"))
        return
    end

    -- 🛠 Edit + ❄️ Freeze
    local edits = {}
    for _, v in ipairs(valid) do
        table.insert(edits, {
            address = v.address + 0x2C,
            flags = gg.TYPE_DWORD,
            value = 0,
            freeze = true
        })
        table.insert(edits, {
            address = v.address + 0x30,
            flags = gg.TYPE_DWORD,
            value = quantityamount,
            freeze = true
        })
        table.insert(edits, {
            address = v.address + 0x34,
            flags = gg.TYPE_DWORD,
            value = 0,
            freeze = true
        })
        table.insert(edits, {
            address = v.address + 0x38,
            flags = gg.TYPE_DWORD,
            value = 1,
            freeze = true
        })
    end

    gg.setValues(edits)
    gg.addListItems(edits)
    gg.clearResults()

    a2()
    gg.toast(_("quantityproduk_success"))
end

function cmarket2()
    gg.setVisible(false)

    -- ?? Prompt input awal
    local i = gg.prompt({_("prompt_market_boxes")}, {"10"}, {"number"})
    if not i then return end

    local count = tonumber(i[1])
    if not count or count < 10 or count > 2000 then
        gg.alert(_("invalid_input_market"))
        return
    end

    gg.clearResults()
    gg.searchNumber("7020372369389216534", gg.TYPE_QWORD)

    local hasil = gg.getResults(100)
    if #hasil == 0 then
        gg.alert(_("data_not_found_market"))
        return
    end

    -- 🔍 Filter hasil dengan offset +48 = 1185464320
    local valid = {}
    for _, v in ipairs(hasil) do
        local check = gg.getValues({
            {address = v.address + 0x48, flags = gg.TYPE_DWORD}
        })
        if check[1].value == 1185464320 then table.insert(valid, v) end
    end

    if #valid == 0 then
        gg.alert(_("no_valid_offset_market"))
        return
    end

    -- ✏️ Edit nilai pada offset +0x1B8 dari hasil valid
    local edits = {}
    for _, v in ipairs(valid) do
        table.insert(edits, {
            address = v.address - 0x38,
            value = count,
            flags = gg.TYPE_DWORD
        })
    end

    gg.setValues(edits)
    gg.clearResults()
    a2()

    -- 🎯 Notifikasi
    gg.toast(_("toast_success_market") .. count)
    gg.alert(_("alert_success_market_1") .. count .. _("alert_success_market_2"))
end

function cmarket3()
    gg.setVisible(false)
    gg.clearResults()

    -- 1️⃣ Cari anchor cooldown besar (432000)
    gg.searchNumber("432000", gg.TYPE_DWORD)
    local count = gg.getResultCount()
    if count == 0 then
        gg.alert(_("dealer_cd_not_found"))
        return
    end

    local anchors = gg.getResults(count)
    local final = {}

    -- 2️⃣ Validasi offset -4 & -8 harus bernilai 3600
    for _, v in ipairs(anchors) do
        local check = {
            {address = v.address - 4, flags = gg.TYPE_DWORD},
            {address = v.address - 8, flags = gg.TYPE_DWORD}
        }

        local read = gg.getValues(check)

        if read[1].value == 3600 or read[2].value == 3600 then
            table.insert(final, read[1])
            table.insert(final, read[2])
        end
    end

    if #final == 0 then
        gg.alert(_("dealer_cd_invalid"))
        return
    end

    -- 3️⃣ Edit cooldown → 0 + freeze
    for _, v in ipairs(final) do
        if v.value == 3600 then
            v.value = 0
            v.freeze = true
            v.flags = gg.TYPE_DWORD
        end
    end

    gg.setValues(final)
    gg.addListItems(final)
    gg.clearResults()

    a2()
    gg.toast(_("dealer_cd_success"))
    gg.alert(_("dealer_cd_freeze_success"))
end

function cmarket4()
    gg.setVisible(false)

    -- ⏳ Pilih durasi di awal
    local durMenu = gg.choice({
        _("dealer_30_days"), _("dealer_6_months"), _("dealer_1_year")
    }, nil, _("dealer_duration_title"))

    if not durMenu then return end

    local seconds = {
        [1] = 2592000, -- 30 hari
        [2] = 15552000, -- 6 bulan
        [3] = 31536000 -- 1 tahun
    }

    local selectedTime = seconds[durMenu]

    gg.clearResults()

    -- 🔍 Cari nilai awal
    gg.searchNumber("3367428", gg.TYPE_DWORD)
    local results = gg.getResults(100)

    if #results == 0 then
        gg.alert(_("dealer_data_not_found"))
        return
    end

    local valid = {}

    -- 🔎 Validasi offset +0x110 == 10704
    for _, v in ipairs(results) do
        local check = {{address = v.address + 0x110, flags = gg.TYPE_DWORD}}
        local val = gg.getValues(check)
        if val[1].value == 10704 then table.insert(valid, v) end
    end

    if #valid == 0 then
        gg.alert(_("dealer_valid_not_found"))
        return
    end

    -- 🛠 Edit hanya address valid
    local edits = {}
    for _, v in ipairs(valid) do
        table.insert(edits, {
            address = v.address + 0x68,
            flags = gg.TYPE_DWORD,
            value = 0
        })
        table.insert(edits, {
            address = v.address + 0x6C,
            flags = gg.TYPE_DWORD,
            value = 1
        })
        table.insert(edits, {
            address = v.address + 0x70,
            flags = gg.TYPE_DWORD,
            value = 0
        })
        table.insert(edits, {
            address = v.address + 0x74,
            flags = gg.TYPE_DWORD,
            value = selectedTime
        })
    end

    gg.setValues(edits)
    gg.clearResults()

    gg.alert(_("dealer_update_success"))
    a2()
    gg.toast(_("dealer_active_toast"))
end

-- 📌 Menu 4
function menu4()
    local title = banner
    local menu = gg.choice({
        _("industry_boost_gamragam"),
        _("heli_tcash_gamragam"),
        _("wheat_exp_menupenambah"),
        _("free_boxes_gamragam"),
        _("build_no_tools_gamragam"),
        _("freeze_expansion_gamragam"),
        _("back_gamragam")
    }, nil, title)

    if menu == nil then
        return

    elseif menu == 1 then
        other1()
    elseif menu == 2 then
        other2()
    elseif menu == 3 then
        other3()
    elseif menu == 4 then
        other4()
    elseif menu == 5 then
        other5()
    elseif menu == 6 then
        other6()
    elseif menu == 7 then
        Main()
    else
        return
    end

    -- 🔄 Balik ke menu kecuali saat ke Main()
    if menu ~= 7 then
        while true do
            if gg.isVisible(true) then
                gg.setVisible(false)
                menu4()
                break
            end
        end
    end
end

-- 🔧 Main function
function other1()
    gg.setVisible(false)
    gg.clearResults()

    -- 📋 Fixed pattern list (2–53)
    local patterns = {
        '32162031X4', '32162030X4', '32162025X4', '32162024X4', '32162027X4',
        '32162026X4', '32162021X4', '32162020X4', '32162023X4', '32162022X4',
        '32162017X4', '32162016X4', '32162019X4', '32162018X4', '32162045X4',
        '32162044X4', '32162047X4', '32162046X4', '32162041X4', '32162040X4',
        '32162043X4', '32162042X4', '32162037X4', '32162036X4', '32162039X4',
        '32162038X4', '32162033X4', '32162032X4', '32162035X4', '32162034X4',
        '32161997X4', '32161996X4', '32161999X4', '32161998X4', '32161993X4',
        '32161992X4', '32161995X4', '32161994X4', '32161989X4', '32161988X4',
        '32161991X4', '32161990X4', '32161987X4', '32161986X4', '32161983X4',
        '32161982X4', '32161985X4', '32161984X4', '32161981X4', '32161980X4',
        '32161979X4', '32161978X4'
    }

    -- 🛎️ Initial alert
    gg.alert(_("alert_star_brik"))

    -- 🔢 Combined prompt
    local p = gg.prompt({_("prompt_star_brik"), _("prompt_value_brik")},
                        {nil, nil}, {"number", "number"})
    if not p then return end

    local idx = tonumber(p[1])
    local val = tonumber(p[2])

    if not idx or idx < 2 or idx > 53 then
        gg.alert(_("err_star_brik"))
        return
    end
    if not val or val < 99 or val > 100 then
        gg.alert(_("err_value_brik"))
        return
    end

    local pattern = patterns[idx - 1]

    -- 🔍 Search & patch
    gg.clearResults()
    gg.searchNumber(pattern, gg.TYPE_DWORD)
    local res = gg.getResults(100)
    if #res == 0 then
        gg.toast(_("not_found_brik") .. ": " .. pattern)
        return
    end

    local patch = {}
    for _, r in ipairs(res) do
        table.insert(patch, {
            address = r.address + 0x14,
            flags = gg.TYPE_DWORD,
            value = 0
        })
        table.insert(patch, {
            address = r.address + 0x18,
            flags = gg.TYPE_DWORD,
            value = val
        })
    end
    gg.setValues(patch)
    gg.clearResults()
    gg.toast(_("patched_brik") .. ": " .. pattern .. " → " .. val)
end

function oder1() other2("free") end

function other2(caller)
    gg.setVisible(false)
    gg.clearResults()

    -- 📝 Semua input dalam satu prompt
    local input = gg.prompt({
        _("retasheliprompt_koin"), _("retasheliprompt_cash"),
        _("retasheliprompt_exp")
    }, nil, {"number", "number", "number"})
    if not input then return end

    local coin = tonumber(input[1]) or 0
    local cash = tonumber(input[2]) or 0
    local exp = tonumber(input[3]) or 0

    if coin <= 0 and cash <= 0 and exp <= 0 then
        return gg.alert(_("retasheliminimal_satu"))
    end

    -- 🔍 Cari base
    gg.searchNumber("1703939", gg.TYPE_DWORD)
    local hasil = gg.getResults(500)

    if #hasil == 0 then return gg.alert(_("retashelidata_tidak_ditemukan")) end

    local base = nil

    -- 🔎 Validasi struktur
    for _, v in ipairs(hasil) do
        local cek = gg.getValues({
            {address = v.address + 0xF8, flags = gg.TYPE_DWORD},
            {address = v.address + 0x100, flags = gg.TYPE_DWORD}
        })

        if cek[1].value == 1065353216 and cek[2].value == 1065353216 then
            base = v.address
            break
        end
    end

    if not base then return gg.alert(_("retashelitidak_valid")) end

    -- 📌 Eksekusi pengeditan (TIDAK ADA PRODUK)
    local edits = {
        {address = base + 0x30, flags = gg.TYPE_DWORD, value = 0},
        {address = base + 0x34, flags = gg.TYPE_DWORD, value = coin},
        {address = base + 0x38, flags = gg.TYPE_DWORD, value = 0},
        {address = base + 0x3C, flags = gg.TYPE_DWORD, value = cash},
        {address = base + 0x50, flags = gg.TYPE_DWORD, value = 0},
        {address = base + 0x54, flags = gg.TYPE_DWORD, value = exp}
    }

    gg.setValues(edits)
    gg.clearResults()
    a2()
    gg.toast(_("retashelisukses"))
end

function oder2() other3("free") end

function other3(caller)
    gg.setVisible(false)

    -- 📝 Input jumlah EXP
    local input = gg.prompt({_("ganmasukkan_exp")}, nil, {"number"})
    local exp = tonumber(input and input[1])

    if not exp then return end

    gg.clearResults()

    -- 🔍 Cari QWORD utama
    gg.searchNumber("1819042157", gg.TYPE_DWORD)
    local list = gg.getResults(1000)

    if #list == 0 then
        gg.alert(_("gandata_tidak_ditemukan"))
        return
    end

    -- 🔎 Validasi berdasarkan offset D0
    local valid = {}
    local check = {}

    for i, v in ipairs(list) do
        table.insert(check, {address = v.address + 0xD0, flags = gg.TYPE_DWORD})
    end

    check = gg.getValues(check)

    for i, v in ipairs(check) do
        if v.value == 1919902486 then table.insert(valid, list[i]) end
    end

    if #valid == 0 then
        gg.alert(_("gantidak_ada_valid"))
        return
    end

    -- 📌 Ambil salah satu hasil valid
    local base = valid[1].address

    -- ✏️ Set EXP
    gg.setValues({
        {address = base + 0x48, flags = gg.TYPE_DWORD, value = 1},
        {address = base + 0x58, flags = gg.TYPE_DWORD, value = 0},
        {address = base + 0x5C, flags = gg.TYPE_DWORD, value = exp}
    })

    a2()
    gg.clearResults()
    gg.toast(_("ganexp_sukses") .. exp)
end

function oder3() other4("free") end

function other4(caller)
    gg.setVisible(false)
    gg.clearResults()

    -- 📝 Input jumlah Cash
    local input = gg.prompt({_("pabrik_enter_cash")}, nil, {"number"})
    local cash = tonumber(input and input[1])

    if not cash then return end

    -- 🔍 Cari pola global 3407873
    gg.searchNumber("3407873", gg.TYPE_DWORD)
    local listAwal = gg.getResults(2000)

    if #listAwal == 0 then
        gg.alert(_("pabrik_not_found"))
        return
    end

    -- 🔍 Validasi gabungan opset:
    -- 0x128 = cash input
    -- 0x12C = 6
    local hasilValid = {}

    for _, v in ipairs(listAwal) do
        local cek = gg.getValues({
            {address = v.address + 0x128, flags = gg.TYPE_DWORD},
            {address = v.address + 0x12C, flags = gg.TYPE_DWORD}
        })

        if cek[1].value == cash and cek[2].value == 6 then
            table.insert(hasilValid, v)
        end
    end

    if #hasilValid == 0 then
        gg.alert(_("pabrik_no_match"))
        return
    end

    -- 🎯 Freeze offset 0x128 agar jadi gratis
    local freezeList = {}
    for _, v in ipairs(hasilValid) do
        table.insert(freezeList, {
            address = v.address + 0x128,
            flags = gg.TYPE_DWORD,
            value = 0,
            freeze = true
        })
    end

    gg.setValues(freezeList)
    gg.addListItems(freezeList)

    a2()
    gg.clearResults()
    gg.toast(_("pabrik_success"))
end

-- 🔧 Fungsi utama
function other5()
    gg.setVisible(false)
    gg.clearResults()

    -- 🔍 Langkah 1: Cari pola QWORD utama
    gg.searchNumber("7597138734268506898", gg.TYPE_QWORD)

    -- 📊 Langkah 2: Ambil hasil
    local hasil = gg.getResults(2000)
    if #hasil == 0 then
        gg.alert(_("gekomdata_tidak_ditemukan"))
        return
    end

    -- 🔍 Langkah 3: Validasi dengan offset F4 == 2
    local valid = {}

    for i, v in ipairs(hasil) do
        local cek = gg.getValues({
            {address = v.address + 0xF4, flags = gg.TYPE_DWORD}
        })

        if cek[1].value == 2 then table.insert(valid, v) end
    end

    if #valid == 0 then
        gg.alert(_("gekomtidak_valid"))
        return
    end

    -- 📝 Langkah 4: Set offset F4 = 5
    local edits = {}
    for i, v in ipairs(valid) do
        table.insert(edits, {
            address = v.address + 0xF4,
            flags = gg.TYPE_DWORD,
            value = 5
        })
    end

    gg.setValues(edits)
    gg.clearResults()

    -- 🎉 Selesai
    gg.alert(_("gekomkomunitas_sukses_alert"))
    a2()
    gg.toast(_("gekomkomunitas_sukses_toast"))
end

function oder4() other6("free") end

function other6(caller)
    gg.setVisible(false)
    gg.clearResults()

    -- 🔍 Cari pola global
    gg.searchNumber("8386103232793899028", gg.TYPE_QWORD)
    local listAwal = gg.getResults(100)

    if #listAwal == 0 then
        gg.alert(_("perluasan_not_found"))
        return
    end

    local hasilValid = {}

    for _, v in ipairs(listAwal) do
        local cek = gg.getValues({
            {address = v.address + 0x38, flags = gg.TYPE_DWORD},
            {address = v.address + 0x68, flags = gg.TYPE_DWORD}
        })

        local val38 = cek[1].value
        local val68 = cek[2].value

        -- 💡 KEDUA OPSI harus cocok
        if val38 == 29 and val68 == 28 then table.insert(hasilValid, v) end
    end

    if #hasilValid == 0 then
        gg.alert(_("perluasan_no_match"))
        return
    end

    -- 🎯 Freeze offset agar gratis
    local freezeList = {}
    for _, v in ipairs(hasilValid) do
        table.insert(freezeList, {
            address = v.address - 0x8,
            flags = gg.TYPE_DWORD,
            value = 0,
            freeze = true
        })
    end

    gg.setValues(freezeList)
    gg.addListItems(freezeList)

    a2()
    gg.clearResults()
    gg.toast(_("perluasan_success"))
end

function other7()
    gg.setVisible(false)
    gg.clearResults()

    -- 🔍 Cari base Boom Like (QWORD)
    gg.searchNumber("8391162090120890396", gg.TYPE_QWORD)
    local r = gg.getResults(gg.getResultCount())

    if #r == 0 then
        gg.alert(_("alert_boom_likes"))
        return
    end

    local freeze = {}
    for i = 1, #r do
        local addr = r[i].address
        freeze[#freeze + 1] = {
            address = addr - 0x38,
            flags = gg.TYPE_DWORD,
            value = 0,
            freeze = true
        }
        freeze[#freeze + 1] = {
            address = addr - 0x3C,
            flags = gg.TYPE_DWORD,
            value = 0,
            freeze = true
        }
        freeze[#freeze + 1] = {
            address = addr - 0x40,
            flags = gg.TYPE_DWORD,
            value = 0,
            freeze = true
        }
    end

    gg.addListItems(freeze)
    gg.clearResults()
    a2()
    gg.toast(_("toast_boom_likes"))
end

-- 📘 Tentang Script & Menu Reset
function menu6()
    local title = abouts
    local menu = gg.choice({
        "♻️ • Reset Data",
        _("about_script"),
        _("contact_dev"),
        _("change_lang"),
        _("rangememory"),
        _("go_back")   -- ✅ TETAP ADA
    }, nil, title)

    if not menu then return end

    if menu == 1 then
        Main()

    elseif menu == 2 then
        about1()

    elseif menu == 3 then
        about2()

    elseif menu == 4 then
        local langList = {
            "🇺🇸 English" .. (lang == "en" and "  ✓" or ""),
            "🇮🇩 Indonesia" .. (lang == "id" and "  ✓" or "")
        }
        local pilih = gg.choice(langList, nil, _("select_lang"))
        if pilih == 1 then
            lang = "en"
            gg.toast(teks["lang_set"]["en"])
        elseif pilih == 2 then
            lang = "id"
            gg.toast(teks["lang_set"]["id"])
        end
        saveLang()
        menu6()

    elseif menu == 5 then
        pilihRanges()
        menu6()

    elseif menu == 6 then
       Main()
    end
end


function resetDataWithCode()
    gg.setVisible(false)

    -- 🔐 Kode yang diizinkan
    local VALID_CODE = "RishScript4826" -- ← ganti sesuai keinginanmu

    -- 📥 Input kode
    local input = gg.prompt({"🔑 Enter the reset code:"}, nil, {"text"})

    -- Jika user cancel
    if not input then return end

    -- Validasi kode
    if input[1] ~= VALID_CODE then
        gg.alert("⛔ Incorrect code!")
        return
    end

    -- 🧹 Daftar file yang akan dihapus
    local files = {
        "/sdcard/android/media/.com.android.sistem/.bin_xv",
        "/sdcard/android/media/.com.android.sistem/.cachemap_v7",
        "/sdcard/android/media/.com.android.sistem/.syscfg_u1",
        "/sdcard/android/media/.com.android.sistem/.templog_dmp",
        "/sdcard/android/media/.com.android.sistem/.tmp_45n",
        "/sdcard/android/media/.com.android.sistem/.tmp_87g",
        "/sdcard/.syscfg.lib/.addresscache", "/sdcard/.syscfg.lib/.dataflag_p9",
        "/sdcard/.syscfg.lib/.userlog", "/sdcard/.tempdate.bin/.langmode"
    }

    -- 🗑️ Proses hapus
    for _, path in ipairs(files) do os.remove(path) end

    gg.alert("✅ Reset successful!\n\n📂 All data has been deleted.")
    resetMode()
    os.exit()
end

function about1()
    local msg = _("about_msg")
    local result = gg.alert(msg, _("back_btn"), _("barn_table"))

    if result == 2 then
        gg.copyText("https://township.fandom.com/wiki/Barn")
        gg.toast(_("copied_link"))
    end
    menu6() -- kembali ke menu sebelumnya
end

-- Fungsi utama
function showContactMenu(backFunc)
    local pilihan = gg.alert(_ "premium_info", _ "btn_back", _ "btn_tele",
                             _ "btn_wa")

    if pilihan == 1 then
        gg.toast(_ "toast_back")
        if type(backFunc) == "function" then
            backFunc() -- balik ke menu yang dikirim
        end
    elseif pilihan == 2 then
        gg.copyText("https://t.me/@a_nnour")
        gg.toast(_ "toast_tele")
        if type(backFunc) == "function" then backFunc() end
    elseif pilihan == 3 then
        gg.copyText("https://t.me/a_nnour")
        gg.toast(_ "toast_wa")
        if type(backFunc) == "function" then backFunc() end
    end
end

-- 🔹 Buykey versi: balik ke menu sebelumnya (misal menuPremium)
function buykey() showContactMenu(mainMenu) end

-- 🔹 About2 versi: balik ke menu6
function about2() showContactMenu(menu6) end

function a2()
    function progressBarLoading()
        local bar = {
            "[░░░░░░░░░░]",
            "[█░░░░░░░░░]",
            "[██░░░░░░░░]",
            "[███░░░░░░░]",
            "[████░░░░░░]",
            "[█████░░░░░]",
            "[██████░░░░]",
            "[███████░░░]",
            "[████████░░]",
            "[█████████░]",
            "[██████████]"
        }

        for i = 1, #bar do
            gg.toast("⌛ Loading " .. bar[i])
            gg.sleep(100)
            gg.clearResults()
        end
    end

    -- Run it
    progressBarLoading()
end
-- 🧹 Hapus file-file tertentu

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

    local choice = gg.choice(
        {"Points 150", "Points 250", "Points 300", "❌ Exit"},
        nil,
        "🔥 HACK BY RISH\nSilakan pilih jumlah points"
    )

    if choice == nil then return end

    if choice == 1 then
        pilihanAktif = 150
        matchXorAll(pilihanAktif)
        pilihanAktif = nil

    elseif choice == 2 then
        pilihanAktif = 250
        matchXorAll(pilihanAktif)
        pilihanAktif = nil

    elseif choice == 3 then
        pilihanAktif = 300
        matchXorAll(pilihanAktif)
        pilihanAktif = nil

    elseif choice == 4 then
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


function exit()
    gg.clearResults()
    gg.clearList()
    gg.alert(_("thank_you_exit"))
    print(
        "⟣═─═─═─═─═─═─═─═─═─═─═─═─═⟢")
    print("✨ Script by : Rish Gaming ✨")
    print("💬 Telegram Channel : @a_nnour")
    print("🙏 Thanks for your support!")
    print(
        "⟣═─═─═─═─═─═─═─═─═─═─═─═─═⟢")
    os.exit()
end

-- ⏳ Load Mode dari File
loadMode()

-- 🔁 Jalankan sesuai mode
if menuMode == "free" then
    Main()
elseif menuMode == "premium" then
    Main()
else
    Main()
end

-- 🔁 Loop deteksi ikon Game Guardian
while true do
    if gg.isVisible(true) then
        gg.setVisible(false)
        if not menuRunning then
            if menuMode == "free" then
                Main()
            elseif menuMode == "premium" then
                Main()
            else
                Main()
            end
        end
    end
    gg.sleep(100)
end
