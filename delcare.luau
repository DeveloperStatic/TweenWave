--[[
    delcare is faster than assert shoutout to @majdtrm, is quite fast
    
    My results were
    TEST 1 - Assert 0.7698663999981363
    TEST 2 - Declare 0.04456980000031763

    Here the method to test it.
    ```lua
    local function declare(conexp: true | string)
        if conexp ~= true then error(conexp) end
    end

    local t = os.clock()

    for i = 1, 1000000 do
        assert(typeof(i) == "number", string.format("Bad argument %i", i))
    end
    print("TEST 1 - Assert", os.clock() - t)

    local t = os.clock()

    for i = 1, 1000000 do
        declare(typeof(i) == "number" or string.format("Bad argument %i", i))
    end

    print("TEST 2 - Declare", os.clock() - t)
    ```
]]

local function declare(conexp: true | string)
	if conexp ~= true then error(conexp, 3) end
end

return declare