local listOn = false

Citizen.CreateThread(function()
    listOn = false
    while true do
        Wait(0)

        if IsControlPressed(0, 27)--[[ INPUT_PHONE ]] then
            if not listOn then
                local players = {}
                ptable = GetPlayers()
                for _, i in ipairs(ptable) do
                    table.insert(players,
                    '<tr style="color: rgb(255, 255, 255); font-weight: 500;"><td>' .. GetPlayerServerId(i) .. '</td><td>' ..GetPlayerName(i)..'</td></tr>' -- The "color: rgb" sets the color of the list
                    )
                end

                SendNUIMessage({ text = table.concat(players) })

                listOn = true
                while listOn do
                    Wait(0)
                    if(IsControlPressed(0, 27) == false) then
                        listOn = false
                        SendNUIMessage({
                            meta = 'close'
                        })
                        break
                    end
                end
            end
        end
    end
end)

function GetPlayers()
    local players = {}

    for i = 0, 31 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end
