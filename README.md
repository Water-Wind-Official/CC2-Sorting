For the Minecraft Mod
ComputerCraft 2: Tweaked (CC:Tweaked)
Auto-Sorting Storage Tower

This document provides instructions for setting up and configuring the sort.lua script, which creates a highly efficient, vertical, daisy-chained item sorting system using only computers and chests.

🛠️ System Overview
The sort.lua script runs on individual computers within a stack, performing the following tasks every 5 seconds:

Sorting: Checks the items in the Primary Chest (on top).

Filtering: Keeps only the items that match the locally defined TARGET_PHRASES.

Transfer: Pushes all non-matching items to the next inventory in the chain, which is the Target Chest (on the bottom).

Tracking: Prints the total item count in the Primary Chest to the terminal, logging any changes.

This setup ensures each storage unit holds only its intended materials, with overflow automatically passed down the line to the next sorting computer or, eventually, a designated "dump" chest at the bottom.

🧱 Hardware Setup (Vertical Stack)

The entire system is a vertical stack of alternating Chests and Computers:
It's a stack of three items vertically

Chest - Top - primary head chest that is sorted
Computer - Mid - pushes items
Chest - Bottom - output chest that another computer can sort

the script iterates every 5 seconds, removing items that are not allowed from the top chest into the bottom chest. 

...

Dump Chest: Located at the very bottom, receiving all un-sorted items.

🚀 Installation & Configuration

1. Script Download

Place a Computer where you want the first sorting unit to be.

Right-click the computer to open the terminal.

Use the pastebin program to download the script (You will need the Pastebin ID for the script). Run:

pastebin get f591P2sY sort.lua

use KTL42wJN for the same script but adjusted with ores/ingots sorted, instead of wood. 


2. Configure Item Targets

The most important step is editing the list of items for each computer's unique storage category.

Open the script for editing:

edit sort.lua


Navigate to the TARGET_PHRASES table at the top of the file and modify it for that specific chest:

local TARGET_PHRASES = {
    "iron",       -- Will catch 'Iron Ingot', 'Iron Block', 'Iron Plate'
    "ore",        -- Will catch 'Copper Ore', 'Gold Ore', etc.
    "diamond",    -- Will catch 'Diamond' and 'Diamond Block'
    "redstone"
}


Press CTRL $\to$ Save $\to$ Exit.

3. Run the Program

Start the sorting loop on the computer:

sort


The system will now continuously check and sort items every 5 seconds. Repeat this installation and configuration process for every computer in your sorting tower.
