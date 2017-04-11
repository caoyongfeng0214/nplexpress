local sessionitem = NPL.load('./sessionitem.lua');
local cookie = NPL.load('./cookie.lua');

local session = {};

session.__dt = 0;
session.__n = 0;

function session:new(req, res)
	local o = {
		req = req,
		res = res
	};
	setmetatable(o, self);
	self.__index = self;
	return o;
end


function session:get(name)
	if(session.data) then
		local cookieKey = '___npl_express_sid_' .. name:encodeURI();
		local cookie = self.req.cookies[cookieKey];
		if(cookie) then
			local sessionKey = cookie.value;
			return session.data[sessionKey];
		end
	end
	return nil;
end;


function session:set(obj)
	if(obj.name) then
		local cookieKey = '___npl_express_sid_' .. obj.name:encodeURI();
		local dt = os.time();
		if(dt ~= session.__dt) then
			session.__dt = dt;
			session.__n = 0;
		end
		session.__n = session.__n + 1;
		local sessionKey = string.format('%s_%s', dt, session.__n);
		obj.name = sessionKey;
		local session_item = sessionitem:new(obj);
		local cookie_item = cookie:new({
			name = cookieKey,
			value = sessionKey,
			maxAge = sessionitem.maxAge,
			path = session_item.path,
			domain = session_item.domain
		});
		self.res:appendCookie(cookie_item);
		if(not session.data) then
			session.data = {};
		end
		session.data[sessionKey] = session_item;
	end
	return session;
end;


session.handler = function(cnf)
	sessionitem.cnf = cnf or {};
	return function(req, res, next)
		req.session = session:new(req, res);
		next(req, res, next);
	end;
end;


NPL.export(session);