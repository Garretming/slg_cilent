local M = class("Player", function (config)
    return cc.LayerColor:create(cc.c4b(0,0,0,180), 100, 150)
end)

function M:ctor()
	self:init()
end

function M:init()
	local bg = cc.Sprite:create("hall_bg.jpg")
	bg:setAnchorPoint(cc.p(0.5, 0.5))
    bg:setPosition(self.frameSize.width/2, self.frameSize.height/2)
    bgLayer:addChild(bg)
	
	-- ͷ�񱳾�
	--local headBg = cc.Sprite:create("head_bg.png")
    --headBg:setPosition(190, self.frameSize.height-90)
    --bg:addChild(headBg)
	
	-- �ǳ�
	local nameLabel = cc.Label:createWithSystemFont("�ǳƣ�������׷�", "arial", 24)
    nameLabel:setColor(cc.c3b(255,255,255))
	nameLabel:setAnchorPoint(0,1)
	nameLabel:setPosition(100, self.frameSize.height-15)
	bg:addChild(nameLabel)
	
	-- ����
	local scoreLabel = cc.Label:createWithSystemFont("���֣�100", "arial", 24)
    scoreLabel:setColor(cc.c3b(255,255,255))
	scoreLabel:setAnchorPoint(0,1)
	scoreLabel:setPosition(100, self.frameSize.height-45)
	bg:addChild(scoreLabel)
end

return M