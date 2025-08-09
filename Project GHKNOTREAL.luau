-- PROJECT GHKNOTREAL - Fake Executor GUI with Tabs (CoreGui)
local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")

-- Root
local gui = Instance.new("ScreenGui")
gui.Name = "PROJECT_GHKNOTREAL"
gui.ResetOnSpawn = false
gui.Parent = CoreGui

-- Main Frame (draggable)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 500, 0, 340)
frame.Position = UDim2.new(0.5, -250, 0.5, -170)
frame.BackgroundTransparency = 1
frame.Active = true
frame.Draggable = true
frame.Parent = gui

-- Gradient container
local bg = Instance.new("Frame")
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(80, 0, 120)
bg.BorderSizePixel = 0
bg.Parent = frame

local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 0, 100)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 80, 200))
}
gradient.Parent = bg

-- Main outline (light purple)
local outline = Instance.new("UIStroke")
outline.Color = Color3.fromRGB(200, 150, 255)
outline.Thickness = 2
outline.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
outline.Parent = bg

-- Title
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 32)
titleBar.BackgroundTransparency = 1
titleBar.Parent = bg

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -48, 1, 0)
title.Position = UDim2.new(0, 8, 0, 0)
title.BackgroundTransparency = 1
title.Text = "LUNARIA (beta)"
title.TextColor3 = Color3.new(245, 1, 245)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

-- Status (right side)
local status = Instance.new("TextLabel")
status.Size = UDim2.new(0, 220, 1, 0)
status.Position = UDim2.new(1, -268, 0, 0)
status.BackgroundTransparency = 1
status.Text = "Ready"
status.TextColor3 = Color3.fromRGB(220, 200, 255)
status.Font = Enum.Font.SourceSans
status.TextSize = 16
status.TextXAlignment = Enum.TextXAlignment.Right
status.Parent = titleBar

-- Close button (dark purple + darker outline)
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 40, 1, 0)
closeBtn.Position = UDim2.new(1, -40, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(50, 0, 80) -- dark purple
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextSize = 20
closeBtn.BorderSizePixel = 0
closeBtn.Parent = titleBar

local closeStroke = Instance.new("UIStroke")
closeStroke.Color = Color3.fromRGB(160, 100, 200) -- darker than main outline
closeStroke.Thickness = 2
closeStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
closeStroke.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Tab bar
local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, -16, 0, 30)
tabBar.Position = UDim2.new(0, 8, 0, 36)
tabBar.BackgroundTransparency = 1
tabBar.Parent = bg

local function makeTabButton(text, xOffset)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, 120, 1, 0)
    b.Position = UDim2.new(0, xOffset, 0, 0)
    b.BackgroundColor3 = Color3.fromRGB(30, 0, 60) -- very dark purple
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.SourceSansBold
    b.TextSize = 16
    b.Text = text
    b.BorderSizePixel = 0
    b.Parent = tabBar
    return b
end

local tabExecutor = makeTabButton("💻 Executor", 0)
local tabScript   = makeTabButton("📜 Script", 128)

-- Content container
local content = Instance.new("Frame")
content.Size = UDim2.new(1, -16, 1, -36 - 30 - 8) -- leave room for title + tabs + padding
content.Position = UDim2.new(0, 8, 0, 36 + 30 + 8)
content.BackgroundTransparency = 1
content.Parent = bg

-- Pages
local pageExec = Instance.new("Frame")
pageExec.Size = UDim2.new(1, 0, 1, 0)
pageExec.BackgroundTransparency = 1
pageExec.Parent = content

local pageScript = Instance.new("Frame")
pageScript.Size = UDim2.new(1, 0, 1, 0)
pageScript.BackgroundTransparency = 1
pageScript.Visible = false
pageScript.Parent = content

-- Highlight selected tab
local function setTabSelected(which)
    -- Reset
    tabExecutor.BackgroundColor3 = Color3.fromRGB(30, 0, 60)
    tabScript.BackgroundColor3   = Color3.fromRGB(30, 0, 60)
    -- Selected color
    local selectedColor = Color3.fromRGB(70, 0, 110)
    if which == "exec" then
        tabExecutor.BackgroundColor3 = selectedColor
        pageExec.Visible = true
        pageScript.Visible = false
        status.Text = "Executor tab"
    else
        tabScript.BackgroundColor3 = selectedColor
        pageExec.Visible = false
        pageScript.Visible = true
        status.Text = "Script tab"
    end
end

tabExecutor.MouseButton1Click:Connect(function() setTabSelected("exec") end)
tabScript.MouseButton1Click:Connect(function() setTabSelected("script") end)

-- EXECUTOR PAGE -------------------------------------------
-- Editor box
local box = Instance.new("TextBox")
box.Size = UDim2.new(1, -20, 0, 200)
box.Position = UDim2.new(0, 10, 0, 0)
box.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
box.TextColor3 = Color3.new(1, 1, 1)
box.Font = Enum.Font.Code
box.TextSize = 16
box.TextWrapped = true
box.TextXAlignment = Enum.TextXAlignment.Left
box.TextYAlignment = Enum.TextYAlignment.Top
box.ClearTextOnFocus = false
box.MultiLine = true
box.Text = "-- Paste your script here"
box.Parent = pageExec

-- Button factory (very dark purple + bold)
local function createActionButton(text, xPos, yPos, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 150, 0, 32)
    btn.Position = UDim2.new(0, xPos, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(30, 0, 60) -- very dark purple
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.SourceSansBold -- bold
    btn.TextSize = 16
    btn.Text = text
    btn.BorderSizePixel = 0
    btn.Parent = pageExec
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- Execute
createActionButton("Execute", 10, 210, function()
    local ok, err = pcall(function()
        loadstring(box.Text)()
    end)
    status.Text = ok and "Executed script" or ("Error: "..tostring(err))
end)

-- Clear
createActionButton("Clear", 170, 210, function()
    box.Text = ""
    status.Text = "Cleared editor"
end)

-- Clipboard
createActionButton("Clipboard", 330, 210, function()
    local clip = GuiService:GetClipboard()
    local ok, err = pcall(function()
        loadstring(clip)()
    end)
    status.Text = ok and "Executed from clipboard" or ("Clipboard error: "..tostring(err))
end)

-- SCRIPT PAGE ---------------------------------------------
local function createScriptButton(label, y, onPress)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 36)
    btn.Position = UDim2.new(0, 10, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(30, 0, 60) -- very dark purple
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 16
    btn.Text = label
    btn.BorderSizePixel = 0
    btn.Parent = pageScript
    btn.MouseButton1Click:Connect(onPress)
    return btn
end

-- Safe behavior: pre-fill editor and switch to Executor tab
local function fillEditorAndSwitch(name)
    box.Text = ("-- %s\n-- (Placeholder) This button just fills the editor for testing.\n\n"):format(name)
    status.Text = ("Pressed: %s"):format(name)
    setTabSelected("exec")
end

createScriptButton("Infinite Yield", 0, function()
    fillEditorAndSwitch("Infinite Yield")
end)

createScriptButton("Dex Explorer", 46, function()
    fillEditorAndSwitch("Dex Explorer")
end)

-- Start on Executor tab
setTabSelected("exec")

