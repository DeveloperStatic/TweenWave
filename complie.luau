
local declare = require(script.Parent.delcare)
local lerps = require(script.Parent.EasingStyles.Lerps)

local complie = {tranform = {}}

function complie.Instance(Goal: {}, Instance: Instance)
    local data = {}

    for property_name: string, finish_value: any in pairs(Goal) do
        
        local type_of_instance_property = typeof(Instance[property_name])
        local type_of_finished_value = typeof(finish_value)

		declare(Instance[property_name] ~= nil or `{property_name} is doesn't existed in {Instance:GetFullName()}`)
        declare(type_of_instance_property == type_of_finished_value or `{type_of_finished_value} doesn't equal to {property_name} ({type_of_instance_property})`)

        data[property_name] = lerps[type_of_instance_property](Instance[property_name], finish_value)
    end

    return data
end

function complie.Table(Goal: {}, instance_lists: {Instance})
    local data = {}

    for property_name: string, finish_value in pairs(Goal) do
        data[property_name] = {}

	    for index, Instance in pairs(instance_lists) do
            
            local type_of_instance_property = typeof(Instance[property_name])
            local type_of_finished_value = typeof(finish_value)

            declare(Instance[property_name] ~= nil or `{property_name} is doesn't existed in {Instance:GetFullName()}`)
            declare(type_of_instance_property == type_of_finished_value or `{type_of_finished_value} doesn't equal to {property_name} ({type_of_instance_property})`)

			data[property_name][Instance] =  lerps[type_of_instance_property](Instance[property_name], finish_value)
        end
    end
    
    return data
end

function complie.callback(Goal, func)
    
    local data = {}

    for property_name: string, seq in pairs(Goal) do
        data = lerps[typeof(seq)](seq.V0, seq.V1)
    end
    -- goal, and unpack as value and return as function

    return data
end

return complie