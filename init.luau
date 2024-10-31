--[[
    TweenWave

    This is more a explansion towards BoatTween to add more power to module.

    This is inculde TweenSequnece, QuickTween without having to clean it up, and Delecares

    Thanks to @Boatbomber, for EasingStyles, Lerps, Beziers
    Thanks to @LucasMZ for FastSignal
	Thanks to @majdTRM

    You may tween any property with value of the following types:
			number				boolean					CFrame
			Color3				UDim2					UDim
			Ray					NumberRange				NumberSequenceKeypoint
			PhysicalProperties	NumberSequence			Region3
			Rect				Vector2					Vector3

    to be honest idk why your tweening a boolean, but that good :)


    (IMPORTANT NOTE)

    When using a tween with update agrument in (TweenWave.Tween, TweenWave.reactive), you need to use seq. the reason why is that lerp is
     a method for smoothly transitioning between two values. when you don't have two values(start and finish) and just one, you can't lerp at all.
     by deafult without update function and it just instance, it get start value from instance props
     when Setting a goal, it value will always be endvalue, never the start. 

     the best way to do this is  to use TweenWave.seq

    ```lua
        TweenWave.Seq(StartPoint: supported values, FinishPoint) -- 
     ```

      ```lua

        local function updateTween(BackgroundTransparency: number, BackgroundColor3: color3)
            Frame.BackgroundTransparency = BackgroundTransparency
            ShopUI.BackgroundColor3 = BackgroundColor3
        end

        TweenWave.Tween(TweenWave.Tween(2.5, TweenWave.Smooth), {
            BackgroundTransparency = TweenWave.seq(0,1),  
            BackgroundColor3 = TweenWave.seq(color3.new(255, 255, 255), color.new(0,0,0))-- white to black
        }, updateTween)

     ```

     This give codebase a clear example of start point and finish point, without these two is pretty cool 

     (YOU ARE NEVER SUPPOSE TO USE THIS IN TweenWave.Declarative): set is endpoint
    



]]

local DeafultInfo = {
-- easingStyle is Linear by deafult 
    repeatCount = 0,
    reverses = false,
    delayTime = 0,

}

local TweenFunctions = require(script.EasingStyles.TweenFunctions)
local Lerps = require(script.EasingStyles.Lerps)

local TweenWave = {
    FabricAccelerate = {
		In = TweenFunctions.InFabricAccelerate;
		Out = TweenFunctions.OutFabricAccelerate;
		InOut = TweenFunctions.InOutFabricAccelerate;
		OutIn = TweenFunctions.OutInFabricAccelerate;
	};

	UWPAccelerate = {
		In = TweenFunctions.InUWPAccelerate;
		Out = TweenFunctions.OutUWPAccelerate;
		InOut = TweenFunctions.InOutUWPAccelerate;
		OutIn = TweenFunctions.OutInUWPAccelerate;
	};

	Circular = {
		In = TweenFunctions.InCirc;
		Out = TweenFunctions.OutCirc;
		InOut = TweenFunctions.InOutCirc;
		OutIn = TweenFunctions.OutInCirc;
	};

	RevBack = {
		In = TweenFunctions.InRevBack;
		Out = TweenFunctions.OutRevBack;
		InOut = TweenFunctions.InOutRevBack;
		OutIn = TweenFunctions.OutInRevBack;
	};

	Spring = {
		In = TweenFunctions.InSpring;
		Out = TweenFunctions.OutSpring;
		InOut = TweenFunctions.InOutSpring;
		OutIn = TweenFunctions.OutInSpring;
	};

	Standard = {
		In = TweenFunctions.InStandard;
		Out = TweenFunctions.OutStandard;
		InOut = TweenFunctions.InOutStandard;
		OutIn = TweenFunctions.OutInStandard;
	};

	StandardExpressive = {
		In = TweenFunctions.InStandardExpressive;
		Out = TweenFunctions.OutStandardExpressive;
		InOut = TweenFunctions.InOutStandardExpressive;
		OutIn = TweenFunctions.OutInStandardExpressive;
	};

	Linear = {
		In = TweenFunctions.InLinear;
		Out = TweenFunctions.OutLinear;
		InOut = TweenFunctions.InOutLinear;
		OutIn = TweenFunctions.OutInLinear;
	};

	ExitProductive = {
		In = TweenFunctions.InExitProductive;
		Out = TweenFunctions.OutExitProductive;
		InOut = TweenFunctions.InOutExitProductive;
		OutIn = TweenFunctions.OutInExitProductive;
	};

	Deceleration = {
		In = TweenFunctions.InDeceleration;
		Out = TweenFunctions.OutDeceleration;
		InOut = TweenFunctions.InOutDeceleration;
		OutIn = TweenFunctions.OutInDeceleration;
	};

	Smoother = {
		In = TweenFunctions.InSmoother;
		Out = TweenFunctions.OutSmoother;
		InOut = TweenFunctions.InOutSmoother;
		OutIn = TweenFunctions.OutInSmoother;
	};

	FabricStandard = {
		In = TweenFunctions.InFabricStandard;
		Out = TweenFunctions.OutFabricStandard;
		InOut = TweenFunctions.InOutFabricStandard;
		OutIn = TweenFunctions.OutInFabricStandard;
	};

	RidiculousWiggle = {
		In = TweenFunctions.InRidiculousWiggle;
		Out = TweenFunctions.OutRidiculousWiggle;
		InOut = TweenFunctions.InOutRidiculousWiggle;
		OutIn = TweenFunctions.OutInRidiculousWiggle;
	};

	MozillaCurve = {
		In = TweenFunctions.InMozillaCurve;
		Out = TweenFunctions.OutMozillaCurve;
		InOut = TweenFunctions.InOutMozillaCurve;
		OutIn = TweenFunctions.OutInMozillaCurve;
	};

	Expo = {
		In = TweenFunctions.InExpo;
		Out = TweenFunctions.OutExpo;
		InOut = TweenFunctions.InOutExpo;
		OutIn = TweenFunctions.OutInExpo;
	};

	Sine = {
		In = TweenFunctions.InSine;
		Out = TweenFunctions.OutSine;
		InOut = TweenFunctions.InOutSine;
		OutIn = TweenFunctions.OutInSine;
	};

	Cubic = {
		In = TweenFunctions.InCubic;
		Out = TweenFunctions.OutCubic;
		InOut = TweenFunctions.InOutCubic;
		OutIn = TweenFunctions.OutInCubic;
	};

	EntranceExpressive = {
		In = TweenFunctions.InEntranceExpressive;
		Out = TweenFunctions.OutEntranceExpressive;
		InOut = TweenFunctions.InOutEntranceExpressive;
		OutIn = TweenFunctions.OutInEntranceExpressive;
	};

	Elastic = {
		In = TweenFunctions.InElastic;
		Out = TweenFunctions.OutElastic;
		InOut = TweenFunctions.InOutElastic;
		OutIn = TweenFunctions.OutInElastic;
	};

	Quint = {
		In = TweenFunctions.InQuint;
		Out = TweenFunctions.OutQuint;
		InOut = TweenFunctions.InOutQuint;
		OutIn = TweenFunctions.OutInQuint;
	};

	EntranceProductive = {
		In = TweenFunctions.InEntranceProductive;
		Out = TweenFunctions.OutEntranceProductive;
		InOut = TweenFunctions.InOutEntranceProductive;
		OutIn = TweenFunctions.OutInEntranceProductive;
	};

	Bounce = {
		In = TweenFunctions.InBounce;
		Out = TweenFunctions.OutBounce;
		InOut = TweenFunctions.InOutBounce;
		OutIn = TweenFunctions.OutInBounce;
	};

	Smooth = {
		In = TweenFunctions.InSmooth;
		Out = TweenFunctions.OutSmooth;
		InOut = TweenFunctions.InOutSmooth;
		OutIn = TweenFunctions.OutInSmooth;
	};

	Back = {
		In = TweenFunctions.InBack;
		Out = TweenFunctions.OutBack;
		InOut = TweenFunctions.InOutBack;
		OutIn = TweenFunctions.OutInBack;
	};

	Quart = {
		In = TweenFunctions.InQuart;
		Out = TweenFunctions.OutQuart;
		InOut = TweenFunctions.InOutQuart;
		OutIn = TweenFunctions.OutInQuart;
	};

	StandardProductive = {
		In = TweenFunctions.InStandardProductive;
		Out = TweenFunctions.OutStandardProductive;
		InOut = TweenFunctions.InOutStandardProductive;
		OutIn = TweenFunctions.OutInStandardProductive;
	};

	Quad = {
		In = TweenFunctions.InQuad;
		Out = TweenFunctions.OutQuad;
		InOut = TweenFunctions.InOutQuad;
		OutIn = TweenFunctions.OutInQuad;
	};

	FabricDecelerate = {
		In = TweenFunctions.InFabricDecelerate;
		Out = TweenFunctions.OutFabricDecelerate;
		InOut = TweenFunctions.InOutFabricDecelerate;
		OutIn = TweenFunctions.OutInFabricDecelerate;
	};

	Acceleration = {
		In = TweenFunctions.InAcceleration;
		Out = TweenFunctions.OutAcceleration;
		InOut = TweenFunctions.InOutAcceleration;
		OutIn = TweenFunctions.OutInAcceleration;
	};

	SoftSpring = {
		In = TweenFunctions.InSoftSpring;
		Out = TweenFunctions.OutSoftSpring;
		InOut = TweenFunctions.InOutSoftSpring;
		OutIn = TweenFunctions.OutInSoftSpring;
	};

	ExitExpressive = {
		In = TweenFunctions.InExitExpressive;
		Out = TweenFunctions.OutExitExpressive;
		InOut = TweenFunctions.InOutExitExpressive;
		OutIn = TweenFunctions.OutInExitExpressive;
	};

	Sharp = {
		In = TweenFunctions.InSharp;
		Out = TweenFunctions.OutSharp;
		InOut = TweenFunctions.InOutSharp;
		OutIn = TweenFunctions.OutInSharp;
	};
	Bezier = require(script.EasingStyles.Bezier)
} 

local Typechecks = require(script.typechecks)
local declare = require(script.delcare)
--[=[
	Creates a TweenInfo Table.

    Example
    ```lua
        TweenWave.Info(1, TweenWave.Linear.In) -- must need two agruments to aleast work
        TweenWave.Info(1, TweenWave.Linear) -- also EasingFunctions without having to put in In.
    ```
	@return TweenInfo
]=]
function TweenWave.TweenInfo(Time: number, EasingStyle, repeatCount: number, reverses: boolean, delayTime: number)
	assert(Typechecks.TweenInfoAgs(Time, EasingStyle, repeatCount, reverses, delayTime))
    return {
        Time = math.max(Time, 0.001) or error("TweenWave.TweenInfo: Time is needed", 2),
        EasingStyle = (typeof(EasingStyle) == "table") and EasingStyle.In or EasingStyle, 
        repeatCount = math.max(repeatCount or DeafultInfo.repeatCount, -1) or 0,
        reverses = reverses or DeafultInfo.reverses,
        delayTime = delayTime or DeafultInfo.delayTime
    }
end

function TweenWave.Seq(start_point, end_point)

	declare(typeof(start_point) ~= typeof(end_point) or "both points are suppose to equal same type")
	declare(Lerps[typeof(start_point)] or "both points are not supported")

	return {V0 = start_point, V1 = end_point}
end


--[=[
	Creates a Tween, without having to delete it.

    Example 1
    ```lua
        -- simple, no cleans or anything
        TweenWave.Tween(TweenWave.Tween(5, TweenWave.Smooth), {BackgroundTransparency = 1}, Frame)

        -- also support mutiples table full of instances {}
        TweenWave.Tween(TweenWave.Tween(2.5, TweenWave.Smooth), {BackgroundTransparency = 1}, {Frame, ShopUI})

        -- even better a update a function, for manual options
        TweenWave.Tween(TweenWave.Tween(2.5, TweenWave.Smooth), {
            BackgroundTransparency = TweenWave.seq(0,1),  
            BackgroundColor3 = TweenWave.seq(color3.new(255, 255, 255), color.new(0,0,0))
        } -- the reason why you need TweenWave.Seq when doing this, is that without a startpoint, like a table with instances or just insances, it won't be able to tween.
        , function(TweenPass, BackgroundTransparency: number, BackgroundColor3: color3)
            Frame.BackgroundTransparency = BackgroundTransparency
            ShopUI.BackgroundColor3 = BackgroundColor3
        end)
    ```
	@return TweenInfo
]=]
TweenWave.Tween = require(script.Tween)


return TweenWave