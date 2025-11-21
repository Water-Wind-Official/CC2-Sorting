## 💾 Auto-Sorter Script: CC:Tweaked (sorter.lua) - Bottom Output

--[[
    This script maintains a list of target items for the chest on 'top',
    and every 5 seconds, it pushes any non-matching items to the chest on the 'bottom',
    allowing for a stackable sorting system.
]]--

-- 📝 Configuration
--------------------------------------------------------------------------------
-- Define the target items/phrases for this specific chest.
-- Matching is case-insensitive.
local TARGET_PHRASES = {
    "stick", "torch", "log", "wood", "lantern", "plank", "twig", "sapling",
    "seed", "stripped", "chest", "fence", "ladder", "gate", "door", "leaves"
}

-- Peripheral slots
local PRIMARY_CHEST_SIDE = "top"    -- The chest we are sorting FROM (Primary Storage)
local TARGET_CHEST_SIDE = "bottom"  -- **CHANGED**: The chest we are sorting INTO (Next Chest/Computer below)

-- Item list tracking
local item_list = {}
local last_count = 0

-- 🛠️ Utility Functions
--------------------------------------------------------------------------------

-- Initialize and wrap a peripheral, halting the script if it fails.
local function setup_peripheral(side, name)
    local p = peripheral.wrap(side)
    if not p then
        print(string.format("Error: No %s found on the %s side.", name, side))
        error("Script cannot continue without required peripherals.")
    end
    return p
end

-- Check if an item matches any target phrase in the list.
local function is_target_item(item_data)
    local name = string.lower(item_data.label or item_data.name)
    for _, phrase in ipairs(TARGET_PHRASES) do
        -- Use string.find to check if the item name contains the phrase
        if string.find(name, string.lower(phrase)) then
            return true
        end
    end
    return false
end

-- 📦 Sorting Logic
--------------------------------------------------------------------------------

local function sort_chest(primary_chest, target_chest)
    local slots_to_transfer = {}
    local transfer_count = 0

    -- 1. Identify items to transfer (non-matching items)
    for slot, item_data in pairs(primary_chest.list()) do
        if item_data and not is_target_item(item_data) then
            -- Item is not a target for this chest, mark its slot for transfer
            table.insert(slots_to_transfer, slot)
        end
    end

    -- 2. Transfer identified items to the adjacent chest on the bottom
    for _, slot in ipairs(slots_to_transfer) do
        local item_data = primary_chest.list()[slot]
        if item_data then
            -- pushItems( destination_name, source_slot, count )
            local transferred = primary_chest.pushItems(
                peripheral.getName(target_chest), -- Destination peripheral name
                slot,                             -- Source slot in the primary chest
                item_data.count                   -- Try to move the whole stack
            )

            if transferred and transferred > 0 then
                transfer_count = transfer_count + transferred
            end
        end
    end

    if transfer_count > 0 then
        print(string.format("⬇️ Items Sorted: Transferred **%d** stacks/items to the bottom chest.", transfer_count))
    end
end


-- 📊 Main Loop and Tracking
--------------------------------------------------------------------------------

local function update_and_sort(primary_chest, target_chest)
    -- Run sorting logic first
    sort_chest(primary_chest, target_chest)

    -- Update tracking list and get total count
    item_list = {}
    local total_count = 0

    for _, item_data in pairs(primary_chest.list()) do
        if item_data then
            table.insert(item_list, {
                name = item_data.name,
                label = item_data.label or item_data.name,
                count = item_data.count
            })
            total_count = total_count + item_data.count
        end
    end

    -- Print count update only if the total count has changed
    if total_count ~= last_count then
        print(string.format("📦 Current Item Count: **%d** (Change: %s%d)",
                            total_count,
                            total_count > last_count and "+" or "",
                            total_count - last_count))
        last_count = total_count
    end
end

-- 🏁 Program Initialization
--------------------------------------------------------------------------------

local primary_chest = setup_peripheral(PRIMARY_CHEST_SIDE, "Primary Chest")
local target_chest = setup_peripheral(TARGET_CHEST_SIDE, "Target Chest (Bottom)")

print("--- Auto Sorter Started ---")
print("Computer ID: " .. os.getComputerID())
print("Target items/phrases: " .. table.concat(TARGET_PHRASES, ", "))
print("Items NOT matching these targets will be sent to the **bottom** chest.")
print("Sorting loop set to **5 seconds**.")

while true do
    update_and_sort(primary_chest, target_chest)
    os.sleep(5) -- 5 second delay
end