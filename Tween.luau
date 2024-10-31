--[[

]]

local delcare = require(script.Parent.delcare)
local complie = require(script.Parent.complie)

local RunService: RunService = game:GetService("RunService")

local clamp = math.clamp

return function (TweenInfo, Goal: {}, update: Instance | {Instance} | (...any) -> (), EventStep: RBXScriptConnection?): RBXScriptConnection?
    delcare(typeof(TweenInfo) == "table" or "TweenWave.Tween: TweenInfo is not a table")

    delcare(TweenInfo.Time ~= nil or "TweenWave.Tween: TweenInfo.Time isn't Set")
    delcare(TweenInfo.EasingStyle ~= nil or "TweenWave.Tween: TweenInfo.EasingStyle isn't Set")
    delcare(TweenInfo.repeatCount ~= nil or "TweenWave.Tween: TweenInfo.repeatCount isn't Set")
    delcare(TweenInfo.reverses ~= nil or "TweenWave.Tween: TweenInfo.repeatCount isn't Set")
    delcare(TweenInfo.delayTime ~= nil or "TweenWave.Tween: TweenInfo.Time isn't Set")

    delcare(typeof(Goal) == "table" or "TweenWave.Tween Goal is not a table")
 
    delcare((typeof(update) == "Instance" or "table" or "function") or "TweenWave.Tween: third agrument update, is not a Instance or table or function")

    if not EventStep then
        EventStep = (RunService:IsClient()) and RunService.RenderStepped or RunService.Heartbeat
    end

    local type_of_update: string = typeof(update)
    local TweenComplie: string
    local data = {}
        
     if type_of_update == "Instance" then 
		data = complie.Instance(Goal, update)
		TweenComplie = "Instance"
    end

	if type_of_update == "table" then
		data = complie.Table(Goal, update)
		TweenComplie = "table"
	end

	if type_of_update == "function" then
		data = complie.callback(Goal, update)
	end

    if not (TweenInfo.delayTime == 0) then -- that just delay time
        task.wait(TweenInfo.delayTime)
    end

    local elapsed_time_for_tween: number = 0

    local elapsed_time_for_delay: number = (TweenInfo.delayTime ~= 0) and 0 or nil
    local CanDelay: boolean = (elapsed_time_for_delay == 0)

    local Layer: number = TweenInfo.repeatCount
    local CurrentlyReversing = false


    local connection: RBXScriptConnection

    connection = EventStep:Connect(function(deltaTime: number)

        -- so if delay does exist, add towards deltatime
        if not (elapsed_time_for_delay == nil)  then
            elapsed_time_for_delay = elapsed_time_for_delay + deltaTime
        end

        -- if the delay does exist, it check if delaytime is over and is ready to start the tween
        --  So for people who don't use delay it would show, elapsed_time_for_delay (nil)  IsReady (false)
        -- but for people who do use it, elapsed_time_for_delay (number) IsReady (false)
        local IsReady = (elapsed_time_for_delay ~= nil and elapsed_time_for_delay > TweenInfo.delayTime) and true or false 

        if (elapsed_time_for_delay ~= nil and IsReady == true) then -- it means it ready pass delay to start
            elapsed_time_for_delay = nil
        elseif (elapsed_time_for_delay == nil and IsReady == false) then

            
            if not (elapsed_time_for_tween <= TweenInfo.Time) then -- this mean tween duration has ended, and we can stop

                if TweenInfo.repeatCount ~= 0 and not (Layer <= 0) then
                    Layer = Layer - 1
                    CurrentlyReversing = (TweenInfo.reverses) and not CurrentlyReversing
                    elapsed_time_for_delay = (CanDelay) and 0 or nil
                    elapsed_time_for_tween = 0
                else
                    connection:Disconnect()
                end

            else
                elapsed_time_for_tween = elapsed_time_for_tween + deltaTime
            end
        
            -- if TweenComplie == "Instance" then
            --     for Property, Lerp in pairs(data) do
            --         if CurrentlyReversing == false then
		    -- 			update[Property] = data[Property] (clamp(TweenInfo.EasingStyle(elapsed_time_for_tween/TweenInfo.Time), 0, 1) )
		    -- 		else
		    -- 			update[Property] = data[Property] (clamp(TweenInfo.EasingStyle(1 - elapsed_time_for_tween/TweenInfo.Time), 0, 1) )
		    -- 		end
            --     end
            -- end


            -- 
            local Delta = CurrentlyReversing and (1 - elapsed_time_for_tween/TweenInfo.Time) or (elapsed_time_for_tween/TweenInfo.Time)

            if TweenComplie == "Instance" then
                for Property, Lerp in pairs(data) do
                    update[Property] = data[Property] (clamp(TweenInfo.EasingStyle(Delta), 0, 1) )
                end
            end

            if TweenComplie == "table" then
                for Property, data in pairs(data) do
                    -- for instance, lerp in pairs(data) do
                    --     instance[Property] = lerp( clamp(TweenInfo.EasingStyle(elapsed_time_for_tween/TweenInfo.Time), 0, 1) )
                    -- end
                    data[1][Property] = data[2](clamp(TweenInfo.EasingStyle(elapsed_time_for_tween/TweenInfo.Time), 0, 1))
                end
            end
        end
    end)

    return connection -- in case repeatcount is -1, you can disconnet it 
end