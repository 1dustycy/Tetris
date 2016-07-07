function hash2dcoordsList(t,ymax)
	local r = {}
	for i=1,#t do
		local h = (t[i][2]-1) * ymax + t[i][1]
		r[h] = h
	end
	return r
end

function hash2dcoords(c,ymax)
	return (c[2]-1)*ymax+c[1]
end

function hash2dcoordsReversed(n,ymax)
	x = math.ceil(n/ymax)
	y = n < ymax and n or n%ymax == 0 and ymax or n%ymax
	return {y,x}
end

function hash2dcoordsListReversed(t,ymax)
	local res = {}
	for k,v in pairs(t) do
		table.insert(res,hash2dcoordsReversed(v,ymax))
	end
	return res
end

function round(num,digits)
	return math.floor(num*10^digits + 0.5)/10^digits
end
