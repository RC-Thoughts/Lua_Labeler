--[[
	-------------------------------------------------------------
    RCT-Labeler is a simple label by switch-app for main-screen.
    
    App is a request from a forum-user.
    
    Requires transmitter firmware 4.22 or higher.
    
    Works in DC/DS-14/16/24
	-------------------------------------------------------------
	   Localization-file has to be as /Apps/Lang/RCT-Lblr.jsn
	-------------------------------------------------------------
	       RCT-Labeler is part of RC-Thoughts Jeti Tools.
	-------------------------------------------------------------
	  Released under MIT-license by Tero @ RC-Thoughts.com 2018
	-------------------------------------------------------------
--]]
collectgarbage()
--------------------------------------------------------------------------------
-- Locals for application
local sw1,sw2,sw3,sw4,sw5,lbl1,lbl2,lbl3,lbl4,lbl5
local dispLbl, lblMain = ""
--------------------------------------------------------------------------------
-- Read and set translations
local function setLanguage()
    local lng=system.getLocale()
    local file = io.readall("Apps/Lang/RCT-Lblr.jsn")
    local obj = json.decode(file)
    if(obj) then
        trans21 = obj[lng] or obj[obj.default]
    end
end
--------------------------------------------------------------------------------
local function printLabel()
    lcd.drawText(145 - lcd.getTextWidth(FONT_BIG,dispLbl),0,dispLbl,FONT_BIG)
end
--------------------------------------------------------------------------------
-- Actions when settings changed
local function sw1Changed(value)
    local pSave = system.pSave
	sw1 = value
	pSave("sw1", value)
end

local function sw2Changed(value)
    local pSave = system.pSave
	sw2 = value
	pSave("sw2", value)
end

local function sw3Changed(value)
    local pSave = system.pSave
	sw3 = value
	pSave("sw3", value)
end

local function sw4Changed(value)
    local pSave = system.pSave
	sw4 = value
	pSave("sw4", value)
end

local function sw5Changed(value)
    local pSave = system.pSave
	sw5 = value
	pSave("sw5", value)
end
-----------
local function labelMainChanged(value)
    local pSave = system.pSave
	lblMain = value
	pSave("lblMain", value)
    system.registerTelemetry(1,lblMain,1,printLabel)
end
-----------
local function label1Changed(value)
    local pSave = system.pSave
	lbl1 = value
	pSave("lbl1", value)
end

local function label2Changed(value)
    local pSave = system.pSave
	lbl2 = value
	pSave("lbl2", value)
end

local function label3Changed(value)
    local pSave = system.pSave
	lbl3 = value
	pSave("lbl3", value)
end

local function label4Changed(value)
    local pSave = system.pSave
	lbl4 = value
	pSave("lbl4", value)
end

local function label5Changed(value)
    local pSave = system.pSave
	lbl5 = value
	pSave("lbl5", value)
end
--------------------------------------------------------------------------------
-- Draw the main form (Application interface)
local function initForm()
        local form, addRow, addLabel = form, form.addRow ,form.addLabel
        local addTextbox, addInputbox = form.addTextbox, form.addInputbox
        
        addRow(1)
        addLabel({label="---     RC-Thoughts Jeti Tools      ---",font=FONT_BIG})
        
        addRow(2)
        addLabel({label=trans21.mainLbl})
        addTextbox(lblMain,18,labelMainChanged,{width=167})
        
        addRow(2)
        addLabel({label=trans21.label1})
        addTextbox(lbl1,18,label1Changed,{width=167})
        
        addRow(2)
        addLabel({label=trans21.swi1,width=220})
        addInputbox(sw1,true,sw1Changed)
        
        addRow(2)
        addLabel({label=trans21.label2})
        addTextbox(lbl2,18,label2Changed,{width=167})
        
        addRow(2)
        addLabel({label=trans21.swi2,width=220})
        addInputbox(sw2,true,sw2Changed)
        
        addRow(2)
        addLabel({label=trans21.label3})
        addTextbox(lbl3,18,label3Changed,{width=167})
        
        addRow(2)
        addLabel({label=trans21.swi3,width=220})
        addInputbox(sw3,true,sw3Changed)
        
        addRow(2)
        addLabel({label=trans21.label4})
        addTextbox(lbl4,18,label4Changed,{width=167})
        
        addRow(2)
        addLabel({label=trans21.swi4,width=220})
        addInputbox(sw4,true,sw4Changed)
        
        addRow(2)
        addLabel({label=trans21.label5})
        addTextbox(lbl5,18,label5Changed,{width=167})
        
        addRow(2)
        addLabel({label=trans21.swi5,width=220})
        addInputbox(sw5,true,sw5Changed)
        
        addRow(1)
        addLabel({label="Powered by RC-Thoughts.com - v."..labelerVersion.." ", font=FONT_MINI, alignRight=true})
    end
--------------------------------------------------------------------------------
local function loop()
	local sw1,sw2,sw3,sw4,sw5  = system.getInputsVal(sw1,sw2,sw3,sw4,sw5)
    if(sw1 == 1) then
        dispLbl = lbl1
        elseif (sw2 == 1) then
        dispLbl = lbl2
        elseif (sw3 == 1) then
        dispLbl = lbl3
        elseif (sw4 == 1) then
        dispLbl = lbl4
        elseif (sw5 == 1) then
        dispLbl = lbl5
        else
        dispLbl = ""
    end
    collectgarbage()
end
--------------------------------------------------------------------------------
local function init()
    local pLoad = system.pLoad
    sw1 = pLoad("sw1")
    sw2 = pLoad("sw2")
    sw3 = pLoad("sw3")
    sw4 = pLoad("sw4")
    sw5 = pLoad("sw5")
    lblMain = pLoad("lblMain", trans21.mainLabel)
    lbl1 = pLoad("lbl1", trans21.label1)
    lbl2 = pLoad("lbl2", trans21.label2)
    lbl3 = pLoad("lbl3", trans21.label3)
    lbl4 = pLoad("lbl4", trans21.label4)
    lbl5 = pLoad("lbl5", trans21.label5)
    system.registerTelemetry(1,lblMain,1,printLabel)
    system.registerForm(1, MENU_APPS, trans21.appName, initForm)
    collectgarbage()
end
--------------------------------------------------------------------------------
labelerVersion = "1.0"
setLanguage()
collectgarbage()
return {init=init, loop=loop, author="RC-Thoughts", version=labelerVersion, name=trans21.appName}
