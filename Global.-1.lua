function onload()
    initialization()
end

function initialization()
    getObject()
    createPersonalButton(setupButton, setupButtonToBe, "setup", "setup")
    createPersonalButton(testButton, testButtonToBe, "test", "test")
    createPersonalButton(flipPolicyDecksButton, flipPolicyDecksButtonToBe, "flipPolicyDecks", "Flip")
    createPersonalButton(nextPhaseButton, nextPhaseButtonToBe, "setPhaseMarker", "Next")

    Policy_Deck_Empty = false
    Phases = 2
end

function test()
    
end

function setPhaseMarker()
    if Phases % 7 == 1 then
        PhaseMarker.setPosition({26.43, 1.48, -19.47})
    else
        if Phases % 7 == 2 then
            PhaseMarker.setPosition({26.31, 1.48, -20.71})
        else
            if Phases % 7 == 3 then
                PhaseMarker.setPosition({26.20, 1.48, -21.84})
            else
                if Phases % 7 == 4 then
                    PhaseMarker.setPosition({26.21, 1.48, -22.97})
                else
                    if Phases % 7 == 5 then
                        PhaseMarker.setPosition({26.24, 1.48, -24.06})
                    else
                        if Phases % 7 == 6 then
                            PhaseMarker.setPosition({26.32, 1.48, -25.31})
                        else
                            if Phases % 7 == 0 then
                                PhaseMarker.setPosition({26.39, 1.48, -26.38})
                            end
                        end
                    end
                end
            end
        end
    end
    Phases = Phases + 1
end

function createPersonalButton(buttonName, obejctName, onclickFunction, text)
    local buttonName = {}
    buttonName.click_function = onclickFunction
    buttonName.fuction_owner = obejctName
    buttonName.label = text
    buttonName.position = {0, 0.5, 0}
    buttonName.rotation = {0, 180, 0}
    buttonName.width = 450
    buttonName.height = 250
    obejctName.createButton(buttonName)
end

function flipPolicyDecks()
    Policy_Deck_Top_Left = findHitsInRadius({15.39, 4, 6.02}, 0.5)[1].hit_object
    Policy_Deck_Top_Right = findHitsInRadius({17.98, 4, 6.04}, 0.5)[1].hit_object
    Policy_Deck_Buttom_Left = findHitsInRadius({15.37, 4, 2.62}, 0.5)[1].hit_object
    Policy_Deck_Buttom_Right = findHitsInRadius({17.95, 4, 2.62}, 0.5)[1].hit_object

    if (Policy_Deck_Top_Left == customBoard and Policy_Deck_Top_Right == customBoard and Policy_Deck_Buttom_Left ==
        customBoard and Policy_Deck_Buttom_Right == customBoard) then
        Policy_Deck_Empty = true
    else
        Policy_Deck_Top_Left.takeObject({
            flip = true,
            position = {15.39, 2.56, 6.02}
        })
        Policy_Deck_Top_Right.takeObject({
            flip = true,
            position = {17.98, 2.55, 6.04}
        })
        Policy_Deck_Buttom_Left.takeObject({
            flip = true,
            position = {15.37, 2.55, 2.62}
        })
        Policy_Deck_Buttom_Right.takeObject({
            flip = true,
            position = {17.95, 2.55, 2.62}
        })
    end
end

function findHitsInRadius(pos, radius)
    local radius = (radius or 1)
    local hitList = Physics.cast({
        origin = pos,
        type = 2,
        direction = {0, -10, 0},
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
    flipPolicyDecksButtonToBe = getObjectFromGUID("511e1b")
    customBoard = getObjectFromGUID("541194")
    PhaseMarker = getObjectFromGUID("ed95e3")
    nextPhaseButtonToBe = getObjectFromGUID("d68d87")
end

function setup()

    policySetup1()
    Wait.frames(policySetup2, 1)
    Wait.frames(policySetup3, 2)

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
    ColonyCrisis.takeObject({
        smooth = false
    }).putObject(colonyA)
    ColonyCrisis.takeObject({
        smooth = false
    }).putObject(colonyB)
    ColonyCrisis.takeObject({
        smooth = false
    }).putObject(colonyC)
end

function policySetup1()
    split_Policy_Cards_Era_1 = Policy_Cards_Era_1.split(2)
    split_Policy_Cards_Era_2 = Policy_Cards_Era_2.split(2)
    split_Policy_Cards_Era_3 = Policy_Cards_Era_3.split(2)
    Policy_Cards_Crisis.shuffle()
    Spread_Policy_Cards_Crisis = Policy_Cards_Crisis.spread()
end

function policySetup2()
    Spread_Policy_Cards_Crisis[1].flip()
    Spread_Policy_Cards_Crisis[2].flip()
    Spread_Policy_Cards_Crisis[3].flip()
    split_Policy_Cards_Era_1[1].putObject(Spread_Policy_Cards_Crisis[1])
    split_Policy_Cards_Era_2[1].putObject(Spread_Policy_Cards_Crisis[2])
    split_Policy_Cards_Era_3[1].putObject(Spread_Policy_Cards_Crisis[3])
end

function policySetup3()
    split_Policy_Cards_Era_1[1].shuffle()
    split_Policy_Cards_Era_1[2].shuffle()
    split_Policy_Cards_Era_2[1].shuffle()
    split_Policy_Cards_Era_2[2].shuffle()
    split_Policy_Cards_Era_3[1].shuffle()
    split_Policy_Cards_Era_3[2].shuffle()
    Deal_Policy_Cards(split_Policy_Cards_Era_3[1])
    Deal_Policy_Cards(split_Policy_Cards_Era_3[2])
    Deal_Policy_Cards(split_Policy_Cards_Era_2[1])
    Deal_Policy_Cards(split_Policy_Cards_Era_2[2])
    Deal_Policy_Cards(split_Policy_Cards_Era_1[1])
    Deal_Policy_Cards(split_Policy_Cards_Era_1[2])
end

Deal_Policy_Cards_height = 2.49
function Deal_Policy_Cards(PolicyCards)
    for i = 1, 8, 1 do
        if i % 4 == 1 then
            PolicyCards.takeObject({
                position = {15.39, Deal_Policy_Cards_height, 6.02},
                rotation = {0.02, 179.99, 180.08},
                smooth = false,
                top = true
            })
        else
            if i % 4 == 2 then
                PolicyCards.takeObject({
                    position = {17.98, Deal_Policy_Cards_height, 6.04},
                    rotation = {0.02, 179.99, 180.08},
                    smooth = false,
                    top = true
                })
            else
                if i % 4 == 3 then
                    PolicyCards.takeObject({
                        position = {17.95, Deal_Policy_Cards_height, 2.62},
                        rotation = {0.02, 179.55, 180.08},
                        smooth = false,
                        top = true
                    })
                else
                    if i % 4 == 0 then
                        PolicyCards.takeObject({
                            position = {15.37, Deal_Policy_Cards_height, 2.62},
                            rotation = {0.02, 180.39, 180.08},
                            smooth = false,
                            top = true
                        })
                        Deal_Policy_Cards_height = Deal_Policy_Cards_height + 0.3
                    end
                end
            end
        end
    end
end
