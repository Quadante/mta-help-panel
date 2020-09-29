local font1 = dxCreateFont('fontlar/roboto.ttf', 10, false);
local font2 = dxCreateFont('fontlar/icons.ttf', 12, false);
local font3 = dxCreateFont('fontlar/icons.ttf', 10, false);

renderTimers = {}

function createRender(id, func)
    if not isTimer(renderTimers[id]) then
        renderTimers[id] = setTimer(func, 7, 0)
    end
end

function destroyRender(id)
    if isTimer(renderTimers[id]) then
        killTimer(renderTimers[id])
        renderTimers[id] = nil
        collectgarbage("collect")
    end
end

tiklama = 0
settings = {
[1] = { -- // Tablar
		{"Meslekler"},
		{"Destek"},
		{"Sosyal Medya"}
	},
[2] = { -- // Meslekler içi yazılar
		{"Çöpçülük Mesleği: Her tur başı 250$ alırsınız.\nKamyon Mesleği: Her tur başı 450$ alırsınız.\nCam Silme Mesleği: Her temizlemede 45$ alırsınız.\nTır Mesleği: Her tur başı 420$ alırsınız.\nBeton Mesleği: Her tur başı 420$ alırsınız.\nOtobüs Mesleği: Her yolcu başına 5$ alırsınız.\nBalık Tutma Mesleği: Tuttuğunuz her balık için fiyat değişir."}, 
		--{"Taşımacılık Mesleği Ücreti: 510$"},
		--{"Yer Temizleme Mesleği Ücreti: 540$"}
	},
[3] = { -- // Komutlar içi yazılar
		{"Biz kimiz?\n 2014 yılından beri çeşitli büyük projelere ev sahipliği yapan,\nkalitemizden ödün vermemek için çabalayan ufak bir ekibiz.\n Oyuncularımız için canla başla çalışmaktan asla yorulmayız. \nYetkili ekibimiz sizler için aktif şekilde mesaisini sürdürmektedir.\n F2 tuşuna basarak yetkililerimize rapor yollayabilirsiniz.\n Herhangi bir yetkili şikayetiniz olursa;\n Developer kadromuzla iletişime geçmenizi arz ederiz."}, 
	},
[4] = { -- // Sosyal Medya içi yazılar
		{"Facebook", "www.facebook.com/xxx"}, 
		{"Instagram:", "www.instagram.com/xxx"}, 
		{"Facebook Grup", "https://www.facebook.com/groups/xxx"}, 
	},
}
eren = 149
eren2 = 302
target = 1
function helppanel ()
	if panel then
	sX,sY = guiGetScreenSize()
	g,u = 450, 450
	x,y,w,h = sX/2-g/2,sY/2-u/2,g,u
	dxDrawRectangle(x,y,w,h,tocolor(44,44,44,240))
	w, h = w-4, h-4
	x, y = x+2, y+2
	-- // Arka Plan // --
	
	dxDrawRectangle(x,y,w,h,tocolor(44,44,44,80))
	dxDrawRectangle(x,y,w,25,tocolor(44,44,44,170))
	dxDrawRectangle(x,y+26,w,1,tocolor(79, 229, 249,255))
	
	dxDrawText("xxx Roleplay - Bilgi Paneli",x,y+4,w+x,h+y+4,tocolor(200,200,200),1,font1,"center","top")
	for i,v in ipairs(settings[1]) do
		if isInBox(x+(i*eren)-eren,y+27,w/3,25) then
			if getKeyState("mouse1") and tiklama+200 <= getTickCount() then
				tiklama = getTickCount()
				target = i
			end
			dxDrawRectangle(x+(i*eren)-eren,y+27,w/3-1,25,tocolor(79, 229, 249,255))
			dxDrawText(v[1],x+(i*eren2)-eren2,y+30,w/3+x,h+y+4,tocolor(31,31,31),1,font3,"center","top")
		else
			if i == target then
				dxDrawRectangle(x+(i*eren)-eren,y+27,w/3-1,25,tocolor(79, 229, 249,255))
				dxDrawText(v[1],x+(i*eren2)-eren2,y+30,w/3+x,h+y+4,tocolor(31,31,31),1,font3,"center","top")
			else
				dxDrawRectangle(x+(i*eren)-eren,y+27,w/3,25,tocolor(61, 61, 61,140))
				dxDrawText(v[1],x+(i*eren2)-eren2,y+30,w/3+x,h+y+4,tocolor(200,200,200),1,font3,"center","top")
			end
		end
	end
		for k,v in ipairs(settings[(target+1)]) do
			if (target+1) == 4 then
				if isInBox(x,y+70+(k*20)-20,w,16) then
					if getKeyState("mouse1") and tiklama+200 <= getTickCount() then
						tiklama = getTickCount()
						exports["infobox"]:addBox("info","Başarıyla adresi kopyaladınız. '"..v[2].."'")
						setClipboard(v[2])
					end
					dxDrawText(v[1],x+10,y+70+(k*20)-20,w/3+x,h+y+4,tocolor(111,111,111),1,font2,"left","top")
				else
					dxDrawText(v[1],x+10,y+70+(k*20)-20,w/3+x,h+y+4,tocolor(200,200,200),1,font1,"left","top")
				end
			else
			dxDrawText(v[1],x+10,y+70,w/3+x,h+y+4,tocolor(200,200,200),1,font1,"left","top")
			end
		end
	end
end

bindKey("F1","down",function()
if not localPlayer:getData("loggedin") == 1 then return end
	if not panel then
		panel = true
		createRender("help:panel",helppanel)
	else
		panel = nil
		destroyRender("help:panel")
	end

end)

function isInBox(xS,yS,wS,hS)
	if(isCursorShowing()) then
		local cursorX, cursorY = getCursorPosition()
		sX,sY = guiGetScreenSize()
		cursorX, cursorY = cursorX*sX, cursorY*sY
		if(cursorX >= xS and cursorX <= xS+wS and cursorY >= yS and cursorY <= yS+hS) then
			return true
		else
			return false
		end
	end	
end