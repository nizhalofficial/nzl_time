ESX.RegisterCommand('settime', 'admin', function(xPlayer, args, showError)
    local hour = tonumber(args[1])
    local minute = tonumber(args[2])
    if hour and minute then
        TriggerClientEvent('nzl_time:setTime', -1, hour, minute)
    else
        showError('Usage: /settime [hour] [minute]')
    end
end, true, {help = 'Set server time'})

ESX.RegisterCommand('setweather', 'admin', function(xPlayer, args, showError)
    local weather = args[1]
    if weather then
        TriggerClientEvent('nzl_time:setWeather', -1, weather)
    else
        showError('Usage: /setweather [weather]')
    end
end, true, {help = 'Set server weather'})

RegisterNetEvent('nzl_time:freezeTime')
AddEventHandler('nzl_time:freezeTime', function(freeze)
    NetworkOverrideClockTime(0, 0, freeze)
end)

RegisterNetEvent('nzl_time:freezeWeather')
AddEventHandler('nzl_time:freezeWeather', function(freeze)
    SetWeatherTypePersist(freeze)
end)

function IsTimeFrozen()
    return IsClockTimeFrozen()
end

function IsWeatherFrozen()
    return IsWeatherTypePersisted()
end
