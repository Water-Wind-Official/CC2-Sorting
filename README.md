ComputerCraft 2 (CC:Tweaked) Auto-Sorting Storage Tower

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

Component

Position Relative to Computer N

Role

Primary Chest

top

Input inventory for sorting and item storage.

Computer (N)

Center

Runs sort.lua.

Target Chest

bottom

Destination for non-matching items (acts as the input for Computer N-1).

Example Chain (Top to Bottom):

Computer A (sort.lua): Chest on top (Primary A) $\to$ Chest below (Target A, which is also Primary B)

Computer B (sort.lua): Chest on top (Primary B) $\to$ Chest below (Target B, which is also Primary C)

...

Dump Chest: Located at the very bottom, receiving all un-sorted items.

🚀 Installation & Configuration

1. Script Download

Place a Computer where you want the first sorting unit to be.

Right-click the computer to open the terminal.

Use the pastebin program to download the script (You will need the Pastebin ID for the script). Run:

pastebin get <PASTEBIN_ID> sort.lua


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
