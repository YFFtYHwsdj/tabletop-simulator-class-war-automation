function onload()
    getObject()
    createButton(setupButton, setupButtonToBe, "setup", "setup")
    createButton(testButton, testButtonToBe, "test", "test")
end

function createButton(buttonName, obejctName, onclickFunction, text)
    local buttonName = {}
    buttonName.click_function = text
    buttonName.fuction_owner = onclickFunction
    buttonName.label = text
    buttonName.position = {0, 0.5, 0}
    buttonName.rotation = {0, 180, 0}
    buttonName.width = 450
    buttonName.height = 250
    obejctName.createButton(buttonName)
end

function test()
    print(findHitsInRadius({15.39, 3, 6.02}, 0.8).hit_object)
end

function findHitsInRadius(pos, radius)
    local radius = (radius or 1)
    local hitList = Physics.cast({
        origin = pos,
        type = 2,
        direction = {0,1,0},
        size = {radius, radius, radius},
        max_distance = 1,
        debug = true
    })

    return hitList
end

function getObject()
    Policy_Cards_Era_1 = getObjectFromGUID("15087f")
    Policy_Cards_Era_2 = getObjectFromGUID("47157e")
    Policy_Cards_Era_3 = getObjectFromGUID("c7cc01")
    Policy_Cards_Crisis = getObjectFromGUID("ae7a79")
    Party_Deck = getObjectFromGUID("d9249a")
    Charactor_Deck = getObjectFromGUID("0b4e97")
    Commodity_Deck = getObjectFromGUID("538e5a")
    Innovation_Deck = getObjectFromGUID("d326fa")
    Prime_Debt_Deck = getObjectFromGUID("1f3f48")
    Subprime_Debt_Deck = getObjectFromGUID("3538d0")
    ColonyCrisis = getObjectFromGUID("48ecea")
    colonyA = getObjectFromGUID("6d814f")
    colonyB = getObjectFromGUID("5a7ef4")
    colonyC = getObjectFromGUID("f39afb")
    setupButtonToBe = getObjectFromGUID("6116b6")
    testButtonToBe = getObjectFromGUID("0ec8e8")
end

function setup()

    policySetup1()
    Wait.frames(policySetup2, 1)

    Party_Deck.shuffle()
    Charactor_Deck.shuffle()
    flipAndShuffle(Innovation_Deck)
    flipAndShuffle(Commodity_Deck)
    flipAndShuffle(Prime_Debt_Deck)
    flipAndShuffle(Subprime_Debt_Deck)

    colonySetup()

    destroyObject(setupButtonToBe)
end

function flipAndShuffle(Deck)
    Deck.flip()
    Deck.shuffle()
end

function colonySetup()
    ColonyCrisis.flip()
    ColonyCrisis.shuffle()
    ColonyCrisis.takeObject().putObject(colonyA)
    ColonyCrisis.takeObject().putObject(colonyB)
    ColonyCrisis.takeObject().putObject(colonyC)
end

function policySetup1()
    split_Policy_Cards_Era_1 = Policy_Cards_Era_1.split(2)
    Policy_Cards_Crisis.shuffle()
    Spread_Policy_Cards_Crisis = Policy_Cards_Crisis.spread()
end

function policySetup2()
    Spread_Policy_Cards_Crisis[1].flip()
    Spread_Policy_Cards_Crisis[2].flip()
    Spread_Policy_Cards_Crisis[3].flip()
    split_Policy_Cards_Era_1[1].putObject(Spread_Policy_Cards_Crisis[1])
    Policy_Cards_Era_2.putObject(Spread_Policy_Cards_Crisis[2])
    Policy_Cards_Era_3.putObject(Spread_Policy_Cards_Crisis[3])
    split_Policy_Cards_Era_1[1].shuffle()
    split_Policy_Cards_Era_1[2].shuffle()
    Policy_Cards_Era_2.shuffle()
    Policy_Cards_Era_3.shuffle()
    split_Policy_Cards_Era_1[1].putObject(split_Policy_Cards_Era_1[2])
    Deal_Policy_Cards(Policy_Cards_Era_3)
    Deal_Policy_Cards(Policy_Cards_Era_2)
    Deal_Policy_Cards(split_Policy_Cards_Era_1[1])
end

function Deal_Policy_Cards(PolicyCards)
    for i = 1, 16, 1 do
        if i % 4 == 1 then
            PolicyCards.takeObject({
                position = {15.39, 2.49, 6.02},
                rotation = {0.02, 179.99, 180.08}
            })
        else
            if i % 4 == 2 then
                PolicyCards.takeObject({
                    position = {17.98, 2.49, 6.04},
                    rotation = {0.02, 179.99, 180.08}
                })
            else
                if i % 4 == 3 then
                    PolicyCards.takeObject({
                        position = {17.95, 2.49, 2.62},
                        rotation = {0.02, 179.55, 180.08}
                    })
                else
                    if i % 4 == 0 then
                        PolicyCards.takeObject({
                            position = {15.37, 2.49, 2.62},
                            rotation = {0.02, 180.39, 180.08}
                        })
                    end
                end
            end
        end
    end
end
