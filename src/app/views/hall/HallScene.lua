local M = class("HallScene", function (  )
	local scene = cc.Scene:create()
	scene.name = "HallScene"
	return scene
end)

function M:ctor()
	self.frameSize = cc.Director:getInstance():getWinSize()
    self.origin = cc.Director:getInstance():getVisibleOrigin()
    self.schedulerID = nil
	self:init()
end

function M:init()
	self:initBgLayer()
	
	self:initItems()
end

function M:initBgLayer()
	local bgLayer = cc.Layer:create()

	local bg = cc.Sprite:create("hall_bg.jpg")
	bg:setAnchorPoint(cc.p(0.5, 0.5))
    bg:setPosition(self.frameSize.width/2, self.frameSize.height/2)
    bgLayer:addChild(bg)
	-- 女人
	local woman = cc.Sprite:create("girl.png")
	woman:setAnchorPoint(cc.p(0.5, 0.5))
	woman:setPosition(self.frameSize.width / 2 - 150, self.frameSize.height / 2)
	bg:addChild(woman)

	-- 头像背景
	--local headBg = cc.Sprite:create("head_bg.png")
    --headBg:setPosition(190, self.frameSize.height-90)
    --bg:addChild(headBg)
	
	-- 昵称
	local nameLabel = cc.Label:createWithSystemFont("昵称：请叫我雷峰", "arial", 24)
    nameLabel:setColor(cc.c3b(255,255,255))
	nameLabel:setAnchorPoint(0,1)
	nameLabel:setPosition(100, self.frameSize.height-15)
	bg:addChild(nameLabel)
	
	-- 积分
	local scoreLabel = cc.Label:createWithSystemFont("积分：100", "arial", 24)
    scoreLabel:setColor(cc.c3b(255,255,255))
	scoreLabel:setAnchorPoint(0,1)
	scoreLabel:setPosition(100, self.frameSize.height-45)
	bg:addChild(scoreLabel)
	
	-- 房卡数量
	local cardNumLabel = cc.Label:createWithSystemFont("房卡:  10张", "arial", 24)
    cardNumLabel:setColor(cc.c3b(255,255,255))
	cardNumLabel:setAnchorPoint(0,1)
	cardNumLabel:setPosition(100, self.frameSize.height-75)
	bg:addChild(cardNumLabel)
	

	local room5Btn = ccui.Button:create( "matchRoomRankBg.png" )
	room5Btn:setAnchorPoint(cc.p(0.5, 0.5))
	room5Btn:setPosition(self.frameSize.width/2 + 280, self.frameSize.height - 150)
	room5Btn:setTitleText("欢乐4+1")
	room5Btn:setTitleFontSize(35)
	bg:addChild(room5Btn)
	self.room5Btn = room5Btn

	-- local room6Btn = ccui.Button:create( "matchRoomRankBg.png" )
	-- room6Btn:setAnchorPoint(cc.p(0.5, 0.5))
	-- room6Btn:setPosition(self.frameSize.width/2 + 280, self.frameSize.height - 250)
	-- room6Btn:setTitleText("斗地主")
	-- room6Btn:setTitleFontSize(35)
	-- bg:addChild(room6Btn)


	self:addChild(bgLayer)
	self.bg = bg
end



function M:initItems()
	  -- handling touch events
	-- local function onTouchBegan(touch, event)
	-- 	print("-----?")
    --     return true
    -- end

    -- local function onTouchMoved(touch, event)
		
	-- end
	-- local function onTouchEnded(touch, event)
	-- 	local layer = require("app.views.hall.CreateRooomDlg").new()
	-- 	self.bg:addChild(layer)
    -- end
	-- local listener = cc.EventListenerTouchOneByOne:create()
	-- listener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
	-- listener:registerScriptHandler(onTouchMoved, cc.Handler.EVENT_TOUCH_MOVED)
	-- listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
	-- local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
	-- eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self.room5Btn)
	local function createRoom()
		-- local layer = require("app.views.hall.CreateRoomDlg").new(self)
		-- self.bg:addChild(layer)
		local scene = require("app.views.table.TableScene").new()
		if cc.Director:getInstance():getRunningScene() then
			cc.Director:getInstance():replaceScene(scene)
		else
			cc.Director:getInstance():runWithScene(scene)
		end


	end

	self.room5Btn:addClickEventListener(handler(self,createRoom))
end

return M