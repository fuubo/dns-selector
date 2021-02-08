-- 创建顶部状态栏
dns = hs.menubar.new()
dns:setIcon(hs.image.imageFromURL("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAhElEQVQ4T63TsQ3CMBQG4S+bUDMFFRW0tDRIWSEdzMEKlHRULEHNKESPKpBIxM+49p3k/+RG5WkqeUPBq1D2ZqcELTbY/hBOCna4YIlHRnBFhxAdM4KSGUZPWJXQuH+PWC34S8YbIuMep8yIAZ+xwDMjCCYSHrDOCubGGGWcC37cq/6NPeoXFhF/1NbgAAAAAElFTkSuQmCC"):setSize({w=16,h=16}))

-- 获取网络配置对象
storeObject = hs.network.configuration.open()

-- 初始化状态栏
if(storeObject:location()~="/Sets/9A02CBCD-EDB1-4BB5-BFCD-C26EC7E4BE85") then
	dns:setTitle("prod")
else
	dns:setTitle("test")
end

-- 定义DNS切换函数
function changeDNS()
	-- uid获取方式 在terminal 输入命令 scselect 即可获取
	if(storeObject:location()~="/Sets/9A02CBCD-EDB1-4BB5-BFCD-C26EC7E4BE85") then
    	uid = "9A02CBCD-EDB1-4BB5-BFCD-C26EC7E4BE85"
    	os.execute("scselect " ..uid .." > /dev/null")
		dns:setTitle("test")
	else
		uid = "EC104E76-DE7D-4F74-9147-D21369619277"
        os.execute("scselect " ..uid .." > /dev/null")
		dns:setTitle("prod")
	end
end

-- 状态栏点击切换
dns:setClickCallback(changeDNS)

-- 快捷键切换DNS
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", changeDNS)

-- 重新读取配置
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
	hs.notify.new({title="锤子大勺", informativeText="HammerSpoon Config Reloaded"}):send()
    end
end
-- 创建配置文件修改监听任务
myWatcher = hs.pathwatcher.new("/Users/fuhaku/.hammerspoon/", reloadConfig):start()

