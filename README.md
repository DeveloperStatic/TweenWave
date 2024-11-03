local TweenWave = require(game.ReplicatedStorage.TweenWave)


local HoverEffect = TweenWave.DeclarativeStyle(TweenWave.TweenInfo(2.5, TweenWave.Smooth), function(HoverSize)
    return {
        HoverSize = HoverSize or UDim2.new(10, 10)
    }
end)

HoverEffect.ScriptConnection = {
    ["MouseEnter"] = function(Effect, x, y)
        Effect:Set("Size", Effect.Instance.Size + Effect.HoverSize)
    end,

    ["MouseLeave"] = function(Effect, x, y)
        Effect:Set("Size", Effect.Instance.Size + Effect.HoverSize)
    end,
}

HoverEffect.Properties.HoverSize = UDim2.fromOffset(10, 1)
-- components

local ButtonStart: GuiObject, CloseButton: GuiObject
HoverEffect:ApplyEffect(ButtonStart, CloseButton)

HoverEffect:Destroy() -- it will destroy everything all refences

------------------------------------ v2 windmind, with states

local CollectionService = game:GetService("CollectionService")

local WindMill = CollectionService:GetTagged(3)

local WindMillEffect = TweenWave.DeclarativeStyle(TweenWave.TweenInfo(3, TweenWave.Linear, 0, false, -1), function(Speed)
    return {
        Speed = Speed,

        [TweenWave.DEAFULT_STATE] = "Enabled"
    }
end)

WindMillEffect:OnState("Enabled", function(OldState, Effect: {Instance: Model})
    Effect:Set("Rotation", Vector3.new(0, 0, 360))
end)

WindMillEffect:OnState("Disabled", function(OldState, Effect: {Instance: Model})
    Effect:Stop()
end)


WindMillEffect.Tag = "WindMill"

