function onload()
    initialization()
    -- setMutiNames("f7c567","公社",3)
    -- setMutiNames("94624a","研究实验室",3)
    -- print(getObjectFromGUID("d5fa63").getColorTint())
    -- print(getObjectFromGUID("0f6128").getColorTint())
end

function setMutiNames(guid, Name, CardNumbers)
    local setItems = getObjectFromGUID(guid)
    local originalPosition = setItems.getPosition()
    local spreadItems = setItems.spread()
    for i = 1, CardNumbers, 1 do
        spreadItems[i].setName(Name)
        spreadItems[i].setPosition(originalPosition)
    end
end

function getObject()
    Policy_Cards_Era_1 = getObjectFromGUID("5d498b")
    Policy_Cards_Era_2 = getObjectFromGUID("5a70b5")
    Policy_Cards_Era_3 = getObjectFromGUID("aa9449")
    Policy_Cards_Crisis = getObjectFromGUID("431a3f")
    Red_Charactor_Deck = getObjectFromGUID("1aa22c")
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
    Party_Deck = getObjectFromGUID("8fb984")
    Solidarity_Dice = getObjectFromGUID("365b93")
    Class_Conciousness_Spinner = getObjectFromGUID("1e9206")
    Innovation_Dice = getObjectFromGUID("4fbf0b")
    Innovation_Spinner = getObjectFromGUID("c453d0")
    RedMelee_Bag = getObjectFromGUID("731116")
    NeuralMelee_Bag = getObjectFromGUID("452b4b")

    setupButtonToBe = getObjectFromGUID("66a0bc")
    testButtonToBe = getObjectFromGUID("507453")
    calProductionButtonToBe = getObjectFromGUID("d5d57a")
    calMeleeActionButtonToBe = getObjectFromGUID("de1245")
    ClassPlusButtonTobe = getObjectFromGUID("ce4b9f")
    ClassMinusButtonTobe = getObjectFromGUID("6c790d")
    InnovationPlusButtonTobe = getObjectFromGUID("2dee80")
    InnovationMinusButtonTobe = getObjectFromGUID("396af4")
    calReproductionButtonToBe = getObjectFromGUID("adbaa3")

    flipPolicyDecksButtonToBe = getObjectFromGUID("d32217")
    customBoard = getObjectFromGUID("541194")
    PhaseMarker = getObjectFromGUID("ed95e3")
    nextPhaseButtonToBe = getObjectFromGUID("17a99e")

    ResourcesBag = getObjectFromGUID("6a37ad")

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
    createPersonalButton(calMeleeActionButton, calMeleeActionButtonToBe, "calculateMelleAction", "棋子行动")
    createPersonalButton(ClassPlusButton, ClassPlusButtonTobe, "ClassPlus", "+1")
    createPersonalButton(ClassMinusButton, ClassMinusButtonTobe, "ClassMinus", "-1")
    createPersonalButton(InnovationPlusButton, InnovationPlusButtonTobe, "InnovationPlus", "+1")
    createPersonalButton(InnovationMinusButton, InnovationMinusButtonTobe, "InnovationMinus", "-1")
    createPersonalButton(calReproductionButton, calReproductionButtonToBe, "calReproduction", "繁育结算")
    Policy_Deck_Empty = false
    Phases = 2
    GreatDpression = false
    Size_of_Card = {2.16, 0.05, 3.10}

    Class_Conciousness_Value = 0
    Innovation_Value = 0
    Solidarity_Value = 1
    PartyCardsDealt = 0

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

function checkForPolicyCard(CardName)
    local returnBool = false
    local hitList = Physics.cast({
        origin = {25.81, 3, 1.61},
        size = {6, 2, 15.4},
        direction = {0, -1, 0},
        max_distance = 5,
        type = 3,
        debug = false
    })
    for i = 1, #hitList do
        if hitList[i].hit_object.getName() == CardName then
            returnBool = true
            break
        end
    end
end

function calReproduction()
    local death = 0
    local proletarianized = 0

    TaxSurplus = 0
    WageSurplus = 0
    RentSurplus = 0

    calWageSurplus()
    calTaxSurplus()
    calRentSurplus()

    calClergyNunmbers()
    calNobilityNunmbers()

    workerNumber = calculateWorkers()

    if nobleNum <= RentSurplus then
        RentSurplus = RentSurplus - nobleNum
    else
        print(nobleNum - RentSurplus, "个贵族棋子无法承受繁育花费，成为无产阶级。")
        proletarianized = nobleNum - RentSurplus
        nobleNum = RentSurplus
        RentSurplus = 0
        setNoble(nobleNum)
    end

    if clergyNum <= RentSurplus then
        RentSurplus = RentSurplus - clergyNum
    else
        if checkForPolicyCard("国教") then
            if TaxSurplus + RentSurplus >= clergyNum then
                TaxSurplus = TaxSurplus - RentSurplus - clergyNum
                RentSurplus = 0
            else
                print(clergyNum - RentSurplus - TaxSurplus,
                    "个教士棋子无法承受繁育花费，成为无产阶级。")
                proletarianized = clergyNum - RentSurplus - TaxSurplus
                RentSurplus = 0
                TaxSurplus = 0
                setClergy(clergyNum)
            end
        else
            if clergyNum <= RentSurplus then
                RentSurplus = RentSurplus - clergyNum
            else
                print(clergyNum - RentSurplus, "个贵族棋子无法承受繁育花费，成为无产阶级。")
                proletarianized = clergyNum - RentSurplus
                clergyNum = RentSurplus
                RentSurplus = 0
                setClergy(clergyNum)
            end
        end
    end

    setRentSurplus(RentSurplus)

    if workerNumber <= WageSurplus then
        WageSurplus = WageSurplus - workerNumber
        setWageSurplus(WageSurplus)
        setWorkers(workerNumber + proletarianized + 2)
        print("本次繁育阶段，没有一个无产阶级饿死。")
    else
        if checkForPolicyCard("福利国家") then
            if TaxSurplus + WageSurplus >= workerNumber then
                WageSurplus = 0
                setWageSurplus(WageSurplus)
                TaxSurplus = TaxSurplus - WageSurplus - workerNumber
                setWorkers(workerNumber + 2)
            else
                death = workerNumber - TaxSurplus - WageSurplus
                WageSurplus = 0
                setWageSurplus(WageSurplus)
                TaxSurplus = 0
                setWorkers(workerNumber - death + 1 + proletarianized)
                print("本次繁育阶段中，共计", death, "个工人棋子死亡，请移除", death - 1,
                    "个棋子。")
            end
        else
            death = workerNumber - WageSurplus
            WageSurplus = 0
            setWageSurplus(WageSurplus)
            setWorkers(workerNumber - death + 1 + proletarianized)
            print("本次繁育阶段中，共计", death, "个工人棋子死亡。")
        end
    end

    setTaxSurplus(TaxSurplus)

    print("贵族、教士、无产阶级的繁结算完成，其余部分尚未开发，请")
end

function calClergyNunmbers()
    hitClergy = return_hit_Clergy_Zone()
    redClergy = 0
    neutralClergy = 0
    for i = 1, #hitClergy, 1 do
        if hitClergy[i].hit_object.type == "Figurine" then
            if hitClergy[i].hit_object.getName() == "红色棋子" then
                redClergy = redClergy + 1
            else
                neutralClergy = neutralClergy + 1
            end
        end
    end
    clergyNum = redClergy + neutralClergy
end

function calNobilityNunmbers()
    hitNobility = return_hit_Nobility_Zone()
    nobleNum = 0
    for i = 1, #hitNobility, 1 do
        if hitNobility[i].hit_object.type == "Figurine" then
            nobleNum = nobleNum + 1
        end
    end
    return nobleNum
end

function setNoble(Numbers)
    local gap = 0
    for i = 1, #hitNobility do
        if hitNobility[i].hit_object.type == "Figurine" then
            destroyObject(hitNobility[i].hit_object)
        end
    end
    for i = 1, Numbers do
        NeuralMelee_Bag.takeObject({
            position = {0.80 + gap, 2.50, 1.00}
        })
        gap = gap + 0.6
    end
end

function setClergy(Numbers)
    local redNum = redClergy
    local blackNum = neutralClergy
    local gap = 0
    local up = 0
    for i = 1, #hitClergy do
        if hitClergy[i].hit_object.type == "Figurine" then
            destroyObject(hitClergy[i].hit_object)
        end
    end
    if blackNum >= Numbers then
        for i = 1, Numbers do
            NeuralMelee_Bag.takeObject({
                position = {-3.39 + gap, 2.50, 0.75 + up},
                smooth = false
            })
            if gap <= 2.4 then
                gap = gap + 0.6
            else
                gap = 0
                up = up + 0.6
            end
        end
    else
        for i = 1, blackNum do
            NeuralMelee_Bag.takeObject({
                position = {-3.39 + gap, 2.50, 0.75 + up},
                smooth = false
            })
            if gap <= 2.4 then
                gap = gap + 0.6
            else
                gap = 0
                up = up + 0.6
            end
        end
        for i = 1, Numbers - blackNum do
            RedMelee_Bag.takeObject({
                position = {-3.39 + gap, 2.50, 0.75 + up},
                smooth = false
            })
            if gap <= 2.4 then
                gap = gap + 0.6
            else
                gap = 0
                up = up + 0.6
            end
        end
    end
end

function setWorkers(Numbers)
    local RedWorkers = 0
    local NeutralWokers = 0
    local gap = 0.8
    for i = 1, #WorkerZone do
        if WorkerZone[i].hit_object.getName() == "红色棋子" or WorkerZone[i].hit_object.getName() == "黑色棋子" then
            destroyObject(WorkerZone[i].hit_object)
        end
    end
    for i = 1, #WorkerZone do
        if WorkerZone[i].hit_object.getName() == "红色棋子" then
            RedWorkers = RedWorkers + 1
        else
            if WorkerZone[i].hit_object.getName() == "黑色棋子" then
                NeutralWokers = NeutralWokers + 1
            end
        end
    end
    if Numbers >= RedWorkers + NeutralWokers then
        for i = 1, RedWorkers do
            RedMelee_Bag.takeObject({
                position = {-7.32 + gap, 2.51, -6.94},
                smooth = false
            })
            gap = gap + 0.8
        end
        for i = 1, Numbers - RedWorkers do
            NeuralMelee_Bag.takeObject({
                position = {-7.32 + gap, 2.51, -6.94},
                smooth = false
            })
            gap = gap + 0.8
        end
    end
    if Numbers < RedWorkers + NeutralWokers then
        if Numbers <= RedWorkers then
            for i = 1, Numbers do
                RedMelee_Bag.takeObject({
                    position = {-7.32 + gap, 2.51, -6.94},
                    smooth = false
                })
                gap = gap + 0.8
            end
        else
            for i = 1, RedWorkers do
                RedMelee_Bag.takeObject({
                    position = {-7.32 + gap, 2.51, -6.94},
                    smooth = false
                })
                gap = gap + 0.8
            end
            for i = 1, Numbers - RedWorkers do
                NeuralMelee_Bag.takeObject({
                    position = {-7.32 + gap, 2.51, -6.94},
                    smooth = false
                })
                gap = gap + 0.8
            end
        end
    end
end

function setWageSurplus(WageSurplus)
    for i = 1, #WageHit do
        if WageHit[i].hit_object.getName() == "₽" or WageHit[i].hit_object.getName() == "x5₽" then
            destroyObject(WageHit[i].hit_object)
        end
    end
    for i = 1, WageSurplus do
        ResourcesBag.takeObject({
            position = {10.07, 2.48, -6.35},
            smooth = false
        })
    end
end

function setTaxSurplus(TaxSurplus)
    for i = 1, #TaxHit do
        if TaxHit[i].hit_object.getName() == "₽" or TaxHit[i].hit_object.getName() == "x5₽" then
            destroyObject(TaxHit[i].hit_object)
        end
    end
    for i = 1, TaxSurplus do
        ResourcesBag.takeObject({
            position = {7.70, 2.48, -2.87},
            smooth = false
        })
    end
end

function setRentSurplus(RentSurplus)
    for i = 1, #RentHit do
        if RentHit[i].hit_object.getName() == "₽" or RentHit[i].hit_object.getName() == "x5₽" then
            destroyObject(RentHit[i].hit_object)
        end
    end
    for i = 1, RentSurplus do
        ResourcesBag.takeObject({
            position = {5.68, 2.49, 1.10},
            smooth = false
        })
    end
end

function calculateWorkers()
    WorkerZone = return_hit_Workers_Zone()
    local workerNumber = 0
    for i = 1, #WorkerZone do
        if WorkerZone[i].hit_object.type == "Figurine" then
            workerNumber = workerNumber + 1
        end
    end
    return workerNumber
end

function calTaxSurplus()
    TaxHit = Physics.cast({
        origin = {9.08, 2.48, -1.93},
        direction = {0, -1, 0},
        max_distance = 8,
        type = 3,
        size = {7.5, 1, 3.8},
        debug = false
    })
    local n = 1
    local TaxList = {}

    for i = 1, #TaxHit, 1 do
        if TaxHit[i].hit_object.getName() == "₽" or TaxHit[i].hit_object.getName() == "x5₽" then
            TaxList[n] = TaxHit[i].hit_object
            n = n + 1
        end
    end
    for i = 1, #TaxList do
        if TaxList[i].getName() == "₽" then
            if inRange(TaxList[i].mass, 0.925, 0.001) then
                TaxSurplus = TaxSurplus + 1
            else
                if inRange(TaxList[i].mass, 1.05, 0.001) then
                    TaxSurplus = TaxSurplus + 2
                else
                    local temp = (TaxList[i].mass - 1.05) / 0.025 + 2
                    local tempTo = math.ceil(temp)
                    if inRange(temp, tempTo, 0.1) then
                        temp = tempTo
                    else
                        temp = math.floor(temp)
                    end
                    TaxSurplus = TaxSurplus + temp
                end
            end
        else
            TaxSurplus = TaxSurplus + 5
        end
    end
end

function calRentSurplus()
    RentHit = Physics.cast({
        origin = {8.02, 2.49, 1.97},
        direction = {0, -1, 0},
        max_distance = 8,
        type = 3,
        size = {10, 1, 3.8},
        debug = false
    })
    local n = 1
    local RentList = {}

    for i = 1, #RentHit, 1 do
        if RentHit[i].hit_object.getName() == "₽" or RentHit[i].hit_object.getName() == "x5₽" then
            RentList[n] = RentHit[i].hit_object
            n = n + 1
        end
    end
    for i = 1, #RentList do
        if RentList[i].getName() == "₽" then
            if inRange(RentList[i].mass, 0.925, 0.001) then
                RentSurplus = RentSurplus + 1
            else
                if inRange(RentList[i].mass, 1.05, 0.001) then
                    RentSurplus = RentSurplus + 2
                else
                    local temp = (RentList[i].mass - 1.05) / 0.025 + 2
                    local tempTo = math.ceil(temp)
                    if inRange(temp, tempTo, 0.1) then
                        temp = tempTo
                    else
                        temp = math.floor(temp)
                    end
                    RentSurplus = RentSurplus + temp
                end
            end
        else
            RentSurplus = RentSurplus + 5
        end
    end
end

function calWageSurplus()
    WageHit = Physics.cast({
        origin = {10.60, 5, -5.93},
        direction = {0, -1, 0},
        max_distance = 8,
        type = 3,
        size = {5.5, 1, 3.8},
        debug = false
    })
    local n = 1
    local WageList = {}

    for i = 1, #WageHit, 1 do
        if WageHit[i].hit_object.getName() == "₽" or WageHit[i].hit_object.getName() == "x5₽" then
            WageList[n] = WageHit[i].hit_object
            n = n + 1
        end
    end
    for i = 1, #WageList do
        if WageList[i].getName() == "₽" then
            if inRange(WageList[i].mass, 0.925, 0.001) then
                WageSurplus = WageSurplus + 1
            else
                if inRange(WageList[i].mass, 1.05, 0.001) then
                    WageSurplus = WageSurplus + 2
                else
                    local temp = (WageList[i].mass - 1.05) / 0.025 + 2
                    local tempTo = math.ceil(temp)
                    if inRange(temp, tempTo, 0.1) then
                        temp = tempTo
                    else
                        temp = math.floor(temp)
                    end
                    WageSurplus = WageSurplus + temp
                end
            end
        else
            WageSurplus = WageSurplus + 5
        end
    end
end

function inRange(compared, to, range)
    local returnBool = false
    if compared < to + range and compared > to - range then
        returnBool = true
    end
    return returnBool
end

function calculateMelleAction()
    calculateSolidarity()
    calculateClergy()
    calculateIntelligentsia()
    nobleAction()
    print("工人、贵族、教士、知识分子的行动结算完毕，其余行动请自行结算。")
end

function nobleAction()
    local proletarianized = 0
    RentSurplus = 0
    calRentSurplus()
    nobleNum = 0
    calNobilityNunmbers()
    workerNumber = calculateWorkers()
    if nobleNum <= RentSurplus then
        RentSurplus = RentSurplus - nobleNum
    else
        print(nobleNum - RentSurplus,
            "个贵族棋子无法承担奢侈的消费，在人们的议论中沦为无产阶级。")
        proletarianized = nobleNum - RentSurplus
        nobleNum = RentSurplus
        RentSurplus = 0
        setNoble(nobleNum)
    end
    setRentSurplus(RentSurplus)
    setWorkers(workerNumber + proletarianized)
end

function calculateIntelligentsia()
    local hitList = return_hit_Intel_Zone()
    local InnovationAdd = 0
    local CC_add = 0

    for i = 1, #hitList, 1 do
        if hitList[i].hit_object.getName() == "黑色棋子" then
            InnovationAdd = InnovationAdd + 1
        else
            if hitList[i].hit_object.getName() == "红色棋子" then
                CC_add = CC_add + 1
            else
                if hitList[i].hit_object.getName() == "紫色棋子" or hitList[i].hit_object.getName() ==
                    "绿色棋子" or hitList[i].hit_object.getName() == "橙色棋子" then
                    CC_add = CC_add - 1
                end
            end
        end
    end

    Innovation_Value = Innovation_Value + InnovationAdd
    setInnovationSpinner(Innovation_Value)

    if InnovationAdd > 0 then
        checkForInnovation()
    end

    Class_Conciousness_Value = Class_Conciousness_Value + CC_add
    setClassSpinner(Class_Conciousness_Value)
end

function checkForInnovation()
    local rotationValue = math.random(8)
    Innovation_Dice.setRotationValue(rotationValue)
    if Innovation_Value >= rotationValue then
        Innovation_Deck.takeObject({
            position = {14.79, 5, 10.75},
            flip = true
        })
        print("一张研究牌被翻开")
        Innovation_Value = 0
        setInnovationSpinner(0)
    end
end

function InnovationPlus()
    Innovation_Value = Innovation_Value + 1
    setInnovationSpinner(Innovation_Value)
end

function InnovationMinus()
    Innovation_Value = Innovation_Value - 1
    setInnovationSpinner(Innovation_Value)
end

function setInnovationSpinner(value)
    if value <= 0 then
        Innovation_Spinner.setRotationValue(0)
        Innovation_Value = 0
    else
        if value > 8 then
            Innovation_Value = 8
            Innovation_Spinner.setRotationValue(8)
        else
            Innovation_Spinner.setRotationValue(value)
        end
    end
end

function calculateClergy()
    local hitClergy = return_hit_Clergy_Zone()
    local redClergy = 0
    local neutralClergy = 0
    for i = 1, #hitClergy, 1 do
        if hitClergy[i].hit_object.type == "Figurine" then
            if hitClergy[i].hit_object.getName() == "红色棋子" then
                redClergy = redClergy + 1
            else
                neutralClergy = neutralClergy + 1
            end
        end
    end

    Class_Conciousness_Value = Class_Conciousness_Value + redClergy - neutralClergy

    setClassSpinner(Class_Conciousness_Value)
end

function ClassPlus()
    Class_Conciousness_Value = Class_Conciousness_Value + 1
    setClassSpinner(Class_Conciousness_Value)
end

function ClassMinus()
    Class_Conciousness_Value = Class_Conciousness_Value - 1
    setClassSpinner(Class_Conciousness_Value)
end

function setClassSpinner(value)
    if value <= 0 then
        Class_Conciousness_Spinner.setRotationValue(9)
        Class_Conciousness_Value = 0
    else
        if value > 8 then
            Class_Conciousness_Value = 8
            Class_Conciousness_Spinner.setRotationValue(8)
        else
            Class_Conciousness_Spinner.setRotationValue(value)
        end
    end
end

function return_hit_Workers_Zone()
    local hitWorkers = Physics.cast({
        origin = {-0.02, 3.99, -6.10},
        direction = {0, -1, 0},
        max_distance = 6,
        type = 3,
        size = {18.5, 0.1, 3.9},
        debug = false
    })
    return hitWorkers
end

function return_hit_Intel_Zone()
    local hitPeople = Physics.cast({
        origin = {-4.67, 2.50, -1.97},
        direction = {0, -1, 0},
        max_distance = 6,
        type = 3,
        size = {4, 0.1, 3.7},
        debug = false
    })
    return hitPeople
end

function return_hit_Soliders_Zone()
    local hitPeople = Physics.cast({
        origin = {-0.01, 2.50, -2.03},
        direction = {0, -1, 0},
        max_distance = 6,
        type = 3,
        size = {2.7, 0.1, 3.7},
        debug = false
    })
    return hitPeople
end

function return_hit_Beura_Zone()
    local hitPeople = Physics.cast({
        origin = {4.66, 2.49, -2.04},
        direction = {0, -1, 0},
        max_distance = 6,
        type = 3,
        size = {4, 0.1, 3.7},
        debug = false
    })
    return hitPeople
end

function return_hit_Clergy_Zone()
    local hitPeople = Physics.cast({
        origin = {-2.23, 2.50, 1.93},
        direction = {0, -1, 0},
        max_distance = 6,
        type = 3,
        size = {4, 0.1, 3.7},
        debug = false
    })
    return hitPeople
end

function return_hit_Nobility_Zone()
    local hitPeople = Physics.cast({
        origin = {2.29, 2.50, 1.91},
        direction = {0, -1, 0},
        max_distance = 6,
        type = 3,
        size = {4, 0.1, 3.7},
        debug = false
    })
    return hitPeople
end

function calculateSolidarity()
    local hitWorkers = return_hit_Workers_Zone()
    local redWorkers = 0
    for i = 1, #hitWorkers, 1 do
        if hitWorkers[i].hit_object.type == "Figurine" then
            if hitWorkers[i].hit_object.getName() == "红色棋子" then
                redWorkers = redWorkers + 1
            end
        end
    end

    Solidarity_Value = Solidarity_Value + redWorkers
    while Solidarity_Value >= 8 and PartyCardsDealt < 10 do
        Solidarity_Value = Solidarity_Value - 7
        Party_Deck.deal(1, "Red")
        PartyCardsDealt = PartyCardsDealt + 1
    end
    if PartyCardsDealt == 9 then
        print("请手动抽出最后一张政党牌！")
        PartyCardsDealt = PartyCardsDealt + 1
    end
    Solidarity_Dice.setRotationValue(Solidarity_Value)
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
                smooth = false
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
        direction = {0, -1, 0},
        max_distance = 3,
        type = 3,
        size = {14.89, 1, 4.2},
        debug = false
    })
    local length = #hitTable
    for i = 1, length, 1 do
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
    for i = 1, length, 1 do
        if hitList[i].hit_object.type == "Figurine" then
            worker = worker + 1
        end
    end
    -- 计算自动化
    automation = automation + repeatAnd_return_times(hitList, "自动化-动力织布", false)
    automation = automation + repeatAnd_return_times(hitList, "自动化-轧棉机", false)
    automation = automation + repeatAnd_return_times(hitList, "自动化-高炉", false)
    automation = automation + repeatAnd_return_times(hitList, "自动化-蒸汽机", false)
    -- 计算所有权
    purple = repeatAnd_return_bool(hitList, "紫色所有")
    green = repeatAnd_return_bool(hitList, "绿色所有")
    oranage = repeatAnd_return_bool(hitList, "橙色所有")
    red = repeatAnd_return_bool(hitList, "工人所有")
    -- 计算罢工数量
    strike = strike + repeatAnd_return_times(hitList, "罢工", nil)
    -- 检查建筑类型
    factory = repeatAnd_return_bool(hitList, "工厂", nil)
    if factory == false then
        mill = repeatAnd_return_bool(hitList, "作坊", nil)
    end
    if mill == false then
        commons = repeatAnd_return_bool(hitList, "自给农场", true)
    end
    if commons == false then
        fence = repeatAnd_return_bool(hitList, "自给农场", false)
    end
    if fence == false then
        lab = repeatAnd_return_bool(hitList, "研究实验室", nil)
    end
    if lab == false then
        commune = repeatAnd_return_bool(hitList, "公社", nil)
    end
    -- 计算自给农场租金
    if commons == true and worker == 2 then
        CommonsRent = CommonsRent + 1
    end
    -- 计算围栏产出
    if fence == true then
        if worker > 1 then
            print("位于土地格", LandSlot, "的围栏人数过多，请检查并手动计算。")
        else
            if worker + automation == 1 then
                if GreatDpression == true then
                    Earn = 2
                else
                    Earn = 3
                end
            else
                if worker < 1 then
                    print("位于土地格", LandSlot, "的围栏人数不足，请检查并手动计算。")
                end
            end
        end
    end
    -- 计算工厂产出
    if factory == true then
        if worker + automation > 3 then
            print("位于土地格", LandSlot, "的工厂人数过多，请检查并手动计算。")
        else
            if worker + automation == 3 then
                if GreatDpression == true then
                    Earn = 6
                else
                    Earn = 7
                end
            else
                if worker + automation < 3 then
                    print("位于土地格", LandSlot, "的工厂人数不足，请检查并手动计算。")
                end
            end
        end
    end
    -- 计算作坊产出
    if mill == true then
        if worker + automation > 2 then
            print("位于土地格", LandSlot, "的作坊人数过多，请检查并手动计算。")
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
    -- 给予盈余
    if purple == true then
        if factory == true then
            giveResourcesTo(Earn, "purple")
            print("紫色玩家通过位于土地格", LandSlot, "的工厂获得了", Earn, "资源")
        else
            if mill == true then
                giveResourcesTo(Earn, "purple")
                print("紫色玩家通过位于土地格", LandSlot, "的作坊获得了", Earn, "资源")
            else
                if fence == true then
                    giveResourcesTo(Earn, "purple")
                    print("紫色玩家通过位于土地格", LandSlot, "的农场获得了", Earn, "资源")
                end
            end
        end

    end
    if green == true then
        if factory == true then
            giveResourcesTo(Earn, "green")
            print("绿色玩家通过位于土地格", LandSlot, "的工厂获得了", Earn, "资源")
        else
            if mill == true then
                giveResourcesTo(Earn, "green")
                print("绿色玩家通过位于土地格", LandSlot, "的作坊获得了", Earn, "资源")
            else
                if fence == true then
                    giveResourcesTo(Earn, "green")
                    print("紫色玩家通过位于土地格", LandSlot, "的农场获得了", Earn, "资源")
                end
            end
        end

    end
    if oranage == true then
        if factory == true then
            giveResourcesTo(Earn, "oranage")
            print("橙色玩家通过位于土地格", LandSlot, "的工厂获得了", Earn, "资源")
        else
            if mill == true then
                giveResourcesTo(Earn, "oranage")
                print("橙色玩家通过位于土地格", LandSlot, "的作坊获得了", Earn, "资源")
            else
                if fence == true then
                    giveResourcesTo(Earn, "oranage")
                    print("紫色玩家通过位于土地格", LandSlot, "的农场获得了", Earn, "资源")
                end
            end
        end

    end
    if red == true then
        if factory == true then
            giveResourcesTo(Earn, "red")
            print("工人玩家通过位于土地格", LandSlot, "的工厂获得了", Earn, "资源")
        else
            if mill == true then
                giveResourcesTo(Earn, "red")
                print("工人玩家通过位于土地格", LandSlot, "的作坊获得了", Earn, "资源")
            else
                if fence == true then
                    giveResourcesTo(Earn, "red")
                    print("紫色玩家通过位于土地格", LandSlot, "的农场获得了", Earn, "资源")
                end
            end
        end
    end

    LandSlot = LandSlot + 1
end

function giveResourcesTo(resourcesNumber, destination)
    if destination == "purple" then
        for i = 1, resourcesNumber, 1 do
            ResourcesBag.takeObject({
                position = {2.63, 2.99, 6.15},
                smooth = false
            })
        end
    end
    if destination == "green" then
        for i = 1, resourcesNumber, 1 do
            ResourcesBag.takeObject({
                position = {6.21, 2.49, 7.07},
                smooth = false
            })
        end
    end
    if destination == "orange" then
        for i = 1, resourcesNumber, 1 do
            ResourcesBag.takeObject({
                position = {10.13, 2.48, 6.86},
                smooth = false
            })
        end
    end
    if destination == "red" then
        for i = 1, resourcesNumber, 1 do
            ResourcesBag.takeObject({
                position = {12.13, 2.48, -5.19},
                smooth = false
            })
        end
    end
end

function repeatAnd_return_bool(hitList, Name, faceDown)
    local returnBool = false
    local length = #hitList
    if faceDown == nil then
        for i = 1, length, 1 do
            if hitList[i].hit_object.getName() == Name then
                returnBool = true
                break
            end
        end
    else
        for i = 1, length, 1 do
            if hitList[i].hit_object.getName() == Name and hitList[i].hit_object.is_face_down == faceDown then
                returnBool = true
                break
            end
        end
    end
    return returnBool
end

function repeatAnd_return_times(hitList, Name, faceDown)
    local showTimes = 0
    local length = #hitList
    if faceDown == nil then
        for i = 1, length, 1 do
            if hitList[i].hit_object.getName() == Name then
                showTimes = showTimes + 1
            end
        end
    else
        for i = 1, length, 1 do
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
        print("现在是政治阶段，请移步政治市场。")
    else
        if Phases % 7 == 2 then
            PhaseMarker.setPositionSmooth({26.31, 1.48, -20.71})
            print("现在是劳工阶段，请到人才市场进行劳动力招聘。")
        else
            if Phases % 7 == 3 then
                PhaseMarker.setPositionSmooth({26.20, 1.48, -21.84})
                print(
                    "现在是生产阶段，请在资产卡上摆放好棋子与标记，然后点击结算生产按钮。")
            else
                if Phases % 7 == 4 then
                    PhaseMarker.setPositionSmooth({26.21, 1.48, -22.97})
                    print("现在是投资阶段，请移步投资市场。")
                else
                    if Phases % 7 == 5 then
                        PhaseMarker.setPositionSmooth({26.24, 1.48, -24.06})
                        print("现在是支出阶段，请自行计算支出。")
                    else
                        if Phases % 7 == 6 then
                            PhaseMarker.setPositionSmooth({26.32, 1.48, -25.31})
                            print("现在是繁育阶段，请摆放好棋子与资源，点击繁育结算按钮。")
                        else
                            if Phases % 7 == 0 then
                                PhaseMarker.setPositionSmooth({26.39, 1.48, -26.38})
                            end
                            print("现在是行动阶段，请摆放好棋子与资源，点击棋子行动按钮。")
                        end
                    end
                end
            end
        end
    end
    Phases = Phases + 1
end

function flipPolicyDecks()
    Policy_Deck_Top_Left = findHitsInRay({15.39, 4, 6.02})[1].hit_object
    Policy_Deck_Top_Right = findHitsInRay({17.98, 4, 6.04})[1].hit_object
    Policy_Deck_Buttom_Left = findHitsInRay({15.37, 4, 2.62})[1].hit_object
    Policy_Deck_Buttom_Right = findHitsInRay({17.95, 4, 2.62})[1].hit_object

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

function findHitsInRay(pos)
    local hitList = Physics.cast({
        origin = pos,
        type = 1,
        direction = {0, -1, 0},
        max_distance = 5,
        debug = false
    })

    return hitList
end

function setup()

    policySetup1()
    Wait.frames(policySetup2, 1)
    Wait.frames(policySetup3, 2)

    flipAndShuffle(Red_Charactor_Deck)
    flipAndShuffle(Charactor_Deck)
    flipAndShuffle(Innovation_Deck)
    flipAndShuffle(Commodity_Deck)
    flipAndShuffle(Prime_Debt_Deck)
    flipAndShuffle(Subprime_Debt_Deck)
    flipAndShuffle(Party_Deck)

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
