# RexshackGaming
- discord : https://discord.gg/s5uSk56B65
- youtube : https://www.youtube.com/channel/UCikEgGfXO-HCPxV5rYHEVbA
- github : https://github.com/RexShack
- website : https://www.rexshack.com

# Built using RedM Game Build 1436 and Framework QBCore RedM Edition
- https://github.com/qbcore-redm-framework
- https://docs.fivem.net/docs/server-manual/server-commands/#sv_enforcegamebuild-build
- add to your server.cfg : sv_enforceGameBuild 1436

# Description
- chop wood from points around the map
- Axe required to chop wood

# Installation
1. extract the contents of the rsg_woodcutter.zip
2. add it to your resources folder
3. Add the following to your resources\[qbr]\qbr-core\shared\items.lua

### items.lua

	["axe"]		= {["name"] = "axe",	["label"] = "Axe",		["weight"] = 100,	["type"] = "item",	["image"] = "rsg_axe.png",	['unique'] = false,	['useable'] = true,	['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	["description"] = "equipment for chopping stuff"},
	["wood"]	= {["name"] = "wood",	["label"] = "Wood",		["weight"] = 100,	["type"] = "item",	["image"] = "rsg_wood.png",	['unique'] = false,	['useable'] = true,	['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	["description"] = "crafting material"},

4. Add the following to your "server.cfg"
5. Add to server.cfg to start

ensure rsg_woodcutter

# consider donating:
- https://www.buymeacoffee.com/rexshack