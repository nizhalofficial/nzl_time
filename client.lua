RegisterNetEvent('nzl_time:setTime')
AddEventHandler('nzl_time:setTime', function(hour, minute)
    if hour and minute then
        NetworkOverrideClockTime(hour, minute, 0)
    end
end)

RegisterNetEvent('nzl_time:freezeTime')
AddEventHandler('nzl_time:freezeTime', function(freeze)
    NetworkOverrideClockTime(0, 0, freeze)
end)

RegisterNetEvent('nzl_time:setWeather')
AddEventHandler('nzl_time:setWeather', function(weather)
    if weather then
        SetWeatherTypePersist(weather)
        SetWeatherTypeNowPersist(weather)
        SetWeatherTypeNow(weather)
    end
end)

RegisterNetEvent('nzl_time:freezeWeather')
AddEventHandler('nzl_time:freezeWeather', function(freeze)
    SetWeatherTypePersist(freeze)
end)

RegisterCommand('f', function()
    TriggerServerEvent('nzl_time:freezeTime', true)
    TriggerServerEvent('nzl_time:freezeWeather', true)
end)

RegisterCommand('uf', function()
    TriggerServerEvent('nzl_time:freezeTime', false)
    TriggerServerEvent('nzl_time:freezeWeather', false)
end)

RegisterCommand('weathers', function()
    local weathers = {
        'EXTRASUNNY',
        'CLEAR',
        'NEUTRAL',
        'SMOG',
        'FOGGY',
        'OVERCAST',
        'CLOUDS',
        'CLEARING',
        'RAIN',
        'THUNDER',
        'SNOW',
        'BLIZZARD',
        'SNOWLIGHT',
        'XMAS',
        'HALLOWEEN',
        'THUNDERSTORM'
    }
    
    local weatherList = "Available weathers:\n"
    for _, weather in ipairs(weathers) do
        weatherList = weatherList .. weather .. "\n"
    end

    TriggerEvent('chat:addMessage', { args = { '^1SYSTEM', weatherList } })
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustReleased(0, Config.freezeKey) then
            TriggerEvent('chat:addMessage', { args = { '^1SYSTEM', 'Toggled time and weather freezing' } })
            TriggerServerEvent('nzl_time:freezeTime', not IsTimeFrozen())
            TriggerServerEvent('nzl_time:freezeWeather', not IsWeatherFrozen())
        end
    end
end)

function IsTimeFrozen()
    return IsClockTimeFrozen()
end

function IsWeatherFrozen()
    return IsWeatherTypePersisted()
end
