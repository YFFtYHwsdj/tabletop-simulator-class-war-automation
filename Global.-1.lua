function onload()
    initialization()
    --setMutiNames("f7c567","公社",3)
    --setMutiNames("94624a","研究实验室",3)
end

function setMutiNames(guid,Name,CardNumbers)
    local setItems = getObjectFromGUID(guid)
    local originalPosition = setItems.getPosition()
    local spreadItems = setItems.spread()
    for i=1,CardNumbers,1 do
        spreadItems[i].setName(Name)
        spreadItems[i].setPosition(originalPosition)
    end
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

function initialization()
    getObject()
    createPersonalButton(setupButton, setupButtonToBe, "setup", "初始化")
    createPersonalButton(testButton, testButtonToBe, "test", "测试")
    createPersonalButton(flipPolicyDecksButton, flipPolicyDecksButtonToBe, "flipPolicyDecks", "翻面")
    createPersonalButton(nextPhaseButton, nextPhaseButtonToBe, "setPhaseMarker", "下一阶段")
    createPersonalButton(calProductionButton, calProductionButtonToBe, "calProduction", "结算生产")
    Policy_Deck_Empty = false
    Phases = 2
    GreatDpression = false
    Size_of_Card = {2.16, 0.05, 3.10}

    OriginSlot1 = {-11.32, 2.53, 6.01}
    OriginSlot2 = {-8.90, 2.52, 6.04}
    OriginSlot3 = {-6.42, 2.52, 6.06}
    OriginSlot4 = {-3.95, 2.52, 6.05}
    OriginSlot5 = {-11.35, 2.53, 2.00}
    OriginSlot6 = {-8.90, 2.52, 1.99}
    OriginSlot7 = {-6.41, 2.52, 2.00}
    OriginSlot8 = {-11.36, 2.53, -2.00}
    OriginSlot9 = {-8.87, 2.52, -1.98}
    OriginSlot10 = {-11.37, 2.52, -6.01}
end

function test()

end



function calProduction()
    CommonsRent = 0
    LandSlot = 1
    checkForDeppression()
    calculateProduction(OriginSlot1)
    calculateProduction(OriginSlot2)
    calculateProduction(OriginSlot3)
    calculateProduction(OriginSlot4)
    calculateProduction(OriginSlot5)
    calculateProduction(OriginSlot6)
    calculateProduction(OriginSlot7)
    calculateProduction(OriginSlot8)
    calculateProduction(OriginSlot9)
    calculateProduction(OriginSlot10)
    -- 自给农场结算
    if CommonsRent > 7 then
        CommonsRent = 7
    end
    if GreatDpression == true and CommonsRent > 0 then
        CommonsRent = 0
        print("由于大萧条，自给农场没有盈余产生。")
    end
    if CommonsRent > 0 then
        for i = 1, CommonsRent, 1 do
            ResourcesBag.takeObject({
                position = {5.35, 2.49, 1.68},
                smooth = true
            })
        end
        print("自给农场产生了", CommonsRent, "租金", "\n自给农场上的自给农消耗了", CommonsRent * 2,
            "资源")
    end

end

function checkForDeppression()
    local TrueThisTime = false
    local hitTable = Physics.cast({
        origin = {-0.04, 3.09, 18.69},
        direction = {0,-1,0},
        max_distance = 3,
        type = 3,
        size = {14.89,1,4.2},
        debug = false
    })
    local length = #hitTable
    for i=1,length,1 do
        if hitTable[i].hit_object.getName() == "大萧条" and hitTable[i].hit_object.is_face_down == false then
            GreatDpression = true
            TrueThisTime = true
            break
        end
    end
    if TrueThisTime == false then
        GreatDpression = false
    end
end

function calculateProduction(origin)
    local automation = 0
    local worker = 0
    local strike = 0
    local factory = false
    local Earn = 0
    local mill = false
    local purple = false
    local green = false
    local oranage = false
    local red = false
    local lab = false
    local commune = false
    local commons = false
    local fence = false
    local hitList = Physics.cast({
        origin = origin,
        direction = {0, -1, 0},
        max_distance = 10,
        type = 3,
        size = Size_of_Card,
        debug = false
    })
    local length = #hitList

    -- 计算工人数量
    for i=1,length,1 do
        if hitList[i].hit_object.type == "Figurine" then
            worker = worker + 1        
        end
    end
    -- 计算自动化
    automation = automation + repeatAnd_return_times(hitList,"自动化-动力织布",false)
    automation = automation + repeatAnd_return_times(hitList,"自动化-轧棉机",false)
    automation = automation + repeatAnd_return_times(hitList,"自动化-高炉",false)
    automation = automation + repeatAnd_return_times(hitList,"自动化-蒸汽机",false)
    -- 计算所有权
    purple = repeatAnd_return_bool(hitList,"紫色所有")
    green = repeatAnd_return_bool(hitList,"绿色所有")
    oranage = repeatAnd_return_bool(hitList,"橙色所有")
    red = repeatAnd_return_bool(hitList,"工人所有")
    -- 计算罢工数量
    strike = strike + repeatAnd_return_times(hitList,"罢工")
    -- 检查建筑类型
    factory = repeatAnd_return_bool(hitList,"工厂")
    if factory == false then
        mill = repeatAnd_return_bool(hitList,"作坊")
    end
    if mill == false then
        commons = repeatAnd_return_bool(hitList,"自给农场",true)
    end
    if commons == false then
        fence = repeatAnd_return_bool(hitList,"自给农场",false)
    end
    if fence == false then
        lab = repeatAnd_return_bool(hitList,"研究实验室")
    end 
    if lab == false then
        commune = repeatAnd_return_bool(hitList,"公社")
    end
    -- 计算自给农场租金
    if commons == true and worker == 2 then
        CommonsRent = CommonsRent + 1
    end
    -- 计算围栏产出
    if fence == true then
        if strike > 0 then
            print("位于土地格",LandSlot,"的围栏由于罢工无法运行。")
        else
            if worker > 1 then
                print("位于土地格",LandSlot,"的围栏人数过多，请检查并手动计算。")
            else
                if worker + automation == 1 then
                    if GreatDpression == true then
                        Earn = 2
                    else
                        Earn = 3
                    end
                else
                    if worker < 1 then
                        print("位于土地格",LandSlot,"的围栏人数不足，请检查并手动计算。")
                    end
                end
            end
        end
    end
    -- 计算工厂产出
    if factory == true then
        if strike > 0 then
            print("位于土地格",LandSlot,"的工厂由于罢工无法运行。")
        else
            if worker + automation > 3 then
                print("位于土地格",LandSlot,"的工厂人数过多，请检查并手动计算。")
            else
                if worker + automation == 3 then
                    if GreatDpression == true then
                        Earn = 6
                    else
                        Earn = 7
                    end
                else
                    if worker + automation < 3 then
                        print("位于土地格",LandSlot,"的工厂人数不足，请检查并手动计算。")
                    end
                end
            end
        end
    end
    -- 计算作坊产出
    if mill == true then
        if strike > 0 then
            print("位于土地格",LandSlot,"的作坊由于罢工无法运行。")
        else
            if worker + automation > 2 then
                print("位于土地格",LandSlot,"的作坊人数过多，请检查并手动计算。")
            else
                if worker + automation == 2 then
                    if GreatDpression == true then
                        Earn = 5
                    else
                        Earn = 6
                    end
                end
            end
        end
    end
    -- 给予盈余
    if purple == true then
        if factory == true then
            giveResourcesTo(Earn,"purple")
            print("紫色玩家通过位于土地格",LandSlot,"的工厂获得了",Earn,"资源")
        else
            if mill == true then
                giveResourcesTo(Earn,"purple")
            print("紫色玩家通过位于土地格",LandSlot,"的作坊获得了",Earn,"资源")
            else
                if fence == true then
                    giveResourcesTo(Earn,"purple")
                    print("紫色玩家通过位于土地格",LandSlot,"的农场获得了",Earn,"资源")
                end
            end
        end
       
    end
    if green == true  then
        if factory == true then
            giveResourcesTo(Earn,"green")
            print("绿色玩家通过位于土地格",LandSlot,"的工厂获得了",Earn,"资源")
        else
            if mill == true then
                giveResourcesTo(Earn,"green")
                print("绿色玩家通过位于土地格",LandSlot,"的作坊获得了",Earn,"资源")
            else
                if fence == true then
                    giveResourcesTo(Earn,"green")
                    print("紫色玩家通过位于土地格",LandSlot,"的农场获得了",Earn,"资源")
                end
            end
        end
        
    end
    if oranage == true then
        if factory == true then
            giveResourcesTo(Earn,"oranage")
            print("橙色玩家通过位于土地格",LandSlot,"的工厂获得了",Earn,"资源")
        else
            if mill == true then
                giveResourcesTo(Earn,"oranage")
                print("橙色玩家通过位于土地格",LandSlot,"的作坊获得了",Earn,"资源")
            else
                if fence == true then
                    giveResourcesTo(Earn,"oranage")
                    print("紫色玩家通过位于土地格",LandSlot,"的农场获得了",Earn,"资源")
                end
            end
        end
       
    end
    if red == true then
        if factory == true then
            giveResourcesTo(Earn,"red")
            print("工人玩家通过位于土地格",LandSlot,"的工厂获得了",Earn,"资源")
        else
            if mill == true then
                giveResourcesTo(Earn,"red")
                print("工人玩家通过位于土地格",LandSlot,"的作坊获得了",Earn,"资源")
            else
                if fence == true then
                    giveResourcesTo(Earn,"red")
                    print("紫色玩家通过位于土地格",LandSlot,"的农场获得了",Earn,"资源")
                end
            end
        end
    end

    LandSlot = LandSlot+1
end

function giveResourcesTo(resourcesNumber,destination)
    if destination == "purple" then
        for i=1,resourcesNumber,1 do
            ResourcesBag.takeObject({
                position = {2.63, 2.99, 6.15},
                smooth = false
            })
        end
    end
    if destination == "green" then
        for i=1,resourcesNumber,1 do
            ResourcesBag.takeObject({
                position = {6.21, 2.49, 7.07},
                smooth = false
            })
        end
    end
    if destination == "orange" then
        for i=1,resourcesNumber,1 do
            ResourcesBag.takeObject({
                position = {10.13, 2.48, 6.86},
                smooth = false
            })
        end
    end
    if destination == "red" then
        for i=1,resourcesNumber,1 do
            ResourcesBag.takeObject({
                position = {12.13, 2.48, -5.19},
                smooth = false
            })
        end
    end
end

function repeatAnd_return_bool(hitList,Name,faceDown)
    local returnBool = false
    local length = #hitList
    if faceDown == nil then
        for i=1,length,1 do
            if hitList[i].hit_object.getName() == Name then
                returnBool = true
                break
            end
        end
    else
        for i=1,length,1 do
            if hitList[i].hit_object.getName() == Name and hitList[i].hit_object.is_face_down == faceDown then
                returnBool = true
                break
            end
        end
    end
    return returnBool
end

function repeatAnd_return_times(hitList,Name,faceDown)
    local showTimes = 0
    local length = #hitList
    if faceDown == nil then
        for i=1,length,1 do
            if hitList[i].hit_object.getName() == Name then
                showTimes = showTimes + 1
            end
        end
    else
        for i=1,length,1 do
            if hitList[i].hit_object.getName() == Name and hitList[i].hit_object.is_face_down == faceDown then
                showTimes = showTimes + 1
            end
        end
    end
    return showTimes
end

function setPhaseMarker()
    if Phases % 7 == 1 then
        PhaseMarker.setPositionSmooth({26.43, 1.48, -19.47})
    else
        if Phases % 7 == 2 then
            PhaseMarker.setPositionSmooth({26.31, 1.48, -20.71})
        else
            if Phases % 7 == 3 then
                PhaseMarker.setPositionSmooth({26.20, 1.48, -21.84})
            else
                if Phases % 7 == 4 then
                    PhaseMarker.setPositionSmooth({26.21, 1.48, -22.97})
                else
                    if Phases % 7 == 5 then
                        PhaseMarker.setPositionSmooth({26.24, 1.48, -24.06})
                    else
                        if Phases % 7 == 6 then
                            PhaseMarker.setPositionSmooth({26.32, 1.48, -25.31})
                        else
                            if Phases % 7 == 0 then
                                PhaseMarker.setPositionSmooth({26.39, 1.48, -26.38})
                            end
                        end
                    end
                end
            end
        end
    end
    Phases = Phases + 1
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
        debug = flase
    })

    return hitList
end

function getObject()
    Policy_Cards_Era_1 = getObjectFromGUID("5d498b")
    Policy_Cards_Era_2 = getObjectFromGUID("5a70b5")
    Policy_Cards_Era_3 = getObjectFromGUID("aa9449")
    Policy_Cards_Crisis = getObjectFromGUID("431a3f")
    Party_Deck = getObjectFromGUID("1aa22c")
    Charactor_Deck = getObjectFromGUID("f1cf9b")
    Commodity_Deck = getObjectFromGUID("34e9f6")
    Innovation_Deck = getObjectFromGUID("369161")
    Prime_Debt_Deck = getObjectFromGUID("16a2cb")
    Subprime_Debt_Deck = getObjectFromGUID("9571c5")
    ColonyCrisis = getObjectFromGUID("5ae390")
    colonyA = getObjectFromGUID("37730a")
    colonyB = getObjectFromGUID("df262f")
    colonyC = getObjectFromGUID("88e0f3")
    Crisis_Card_Great_Depression = getObjectFromGUID("4c6eaf")

    setupButtonToBe = getObjectFromGUID("66a0bc")
    testButtonToBe = getObjectFromGUID("507453")
    calProductionButtonToBe = getObjectFromGUID("d5d57a")

    flipPolicyDecksButtonToBe = getObjectFromGUID("d32217")
    customBoard = getObjectFromGUID("541194")
    PhaseMarker = getObjectFromGUID("ed95e3")
    nextPhaseButtonToBe = getObjectFromGUID("17a99e")

    ResourcesBag = getObjectFromGUID("6a37ad")

end

function setup()

    policySetup1()
    Wait.frames(policySetup2, 1)
    Wait.frames(policySetup3, 2)

    flipAndShuffle(Party_Deck)
    flipAndShuffle(Charactor_Deck)
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
