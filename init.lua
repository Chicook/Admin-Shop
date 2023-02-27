-- Fonction pour ajouter un article à l'inventaire du joueur en échange d'un coin
local function acheter_article(player, article, prix)
    local name = player:get_player_name()
    local inv = player:get_inventory()

    if inv:contains_item("main", "shop:coin") then
        inv:remove_item("main", "shop:coin")
        inv:add_item("main", article)
        minetest.chat_send_player(name, "You bought " .. article .. " for " .. prix .. " Coin")
    else
        minetest.chat_send_player(name, "You don't have enough Coin to buy " .. article .. ".")
    end
end

-- Fonction pour acheter un article
local function acheter_article(player, nom_article, prix_article)
    local name = player:get_player_name()
    local inventory = player:get_inventory()

    -- Vérifier si le joueur a suffisamment coin
    if inventory:contains_item("main", "shop:coin "..prix_article) then
        -- Retirer les coin de l'inventaire du joueur
        inventory:remove_item("main", "shop:coin "..prix_article)

        -- Ajouter l'article à l'inventaire du joueur
        local itemstack = ItemStack(nom_article.." 1")
        local leftover = inventory:add_item("main", itemstack)

        -- Si l'inventaire est plein, déposer l'article au sol
        if not leftover:is_empty() then
            minetest.add_item(player:get_pos(), leftover)
        end
    else
        -- Afficher un message si le joueur n'a pas suffisamment de coin
        minetest.chat_send_player(name, "You do not have enough Coin to purchase this item.")
    end
end

-- Fonction pour gérer les clics sur les boutons d'image
minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname == "interface_achat" then
        if fields.stone then
            acheter_article(player, "default:stone", 1)
        elseif fields.stone5 then
            acheter_article(player, "default:stone 5", 5)
        elseif fields.stone20 then
            acheter_article(player, "default:stone 20", 20)
        elseif fields.torch then
            acheter_article(player, "default:torch", 1)
        elseif fields.torch5 then
            acheter_article(player, "default:torch 5", 5)
        elseif fields.torch20 then
            acheter_article(player, "default:torch 20", 20)
        elseif fields.apple then
            acheter_article(player, "default:apple", 1)
        elseif fields.apple5 then
            acheter_article(player, "default:apple 5", 5)
        elseif fields.apple20 then
            acheter_article(player, "default:apple 20", 20)
        elseif fields.tree then
            acheter_article(player, "default:tree", 2)
        elseif fields.tree5 then
            acheter_article(player, "default:tree 5", 10)
        elseif fields.tree20 then
            acheter_article(player, "default:tree 20", 40)
        elseif fields.close then
            minetest.close_formspec(player:get_player_name(), "interface_achat")
        end
    end
end)

-- Fonction pour afficher l'interface d'achat
local function afficher_interface_achat(player)
    local name = player:get_player_name()

    local formspec = "size[8,5.5]" ..
        "label[0,0;Buy items : "..minetest.colorize("#ff8c00", "              1 = 1 Coin").."]"..
-----------------------Stone---------------------------------
        "item_image_button[0.8,1;1,1;default:stone;stone;"..
            "1]" ..
        "item_image_button[0.8,2;1,1;default:stone 5;stone5;"..
            "5]" ..
        "item_image_button[0.8,3;1,1;default:stone 20;stone20;"..
            "20]" ..
-----------------------Torch---------------------------------
        "item_image_button[2.3,1;1,1;default:torch;torch;"..
            "1]" ..
        "item_image_button[2.3,2;1,1;default:torch 5;torch5;"..
            "5]" ..
        "item_image_button[2.3,3;1,1;default:torch 20;torch20;"..
            "20]" ..
-----------------------tree---------------------------------
        "item_image_button[3.8,1;1,1;default:tree;tree;"..
            "2]" ..
        "item_image_button[3.8,2;1,1;default:tree 5;tree5;"..
            "10]" ..
        "item_image_button[3.8,3;1,1;default:tree 20;tree20;"..
            "40]" ..
-----------------------snow---------------------------------
        "item_image_button[5.3,1;1,1;default:apple;apple;"..
            "1]" ..
        "item_image_button[5.3,2;1,1;default:apple 5;apple5;"..
            "5]" ..
        "item_image_button[5.3,3;1,1;default:apple 20;apple20;"..
            "20]" ..

        "button[0,4;2,1;info;Info]"..
        "button[7,2;1,1;nexts;->]"..
        "button_exit[3,4;2,1;close;Close]"

    minetest.show_formspec(name, "interface_achat", formspec)
end

-- Fonction pour afficher l'interface d'information
local function afficher_interface_info(player)
local name = player:get_player_name()

local formspec = "size[8,5.5]" ..
"button[0,4;2,1;retour;Return]"..
    "label[0,0;"..minetest.colorize("#ff8c00", "Information about the Shop").."]"..
    "label[0,0.7;Welcome to the Shop!Here's how it works:\nFirst of all there are items in boxes, there is also a number\nin the middle of this box which indicates the cost in Coin\n.I also assume that you must have seen that there was\nanother number at the bottom right? Well it indicates\nthe quantity.\nI hope you like this /shop :D\nSigned Atlante]"..
    "button_exit[3,4;2,1;exit;Close]"

    minetest.show_formspec(name, "interface_info", formspec)
end

-- Fonction pour afficher l'interface d'achat 2
local function afficher_interface_achat_2(player)
local name = player:get_player_name()
local formspec = "size[8,5.5]" ..
        "button[0,2;1,1;precedent;<-]"..
        "button[0,4;2,1;info;Info]"..
    "label[0,0;"..minetest.colorize("#ff8c00", "Future functionality").."]"..
    "button_exit[3,4;2,1;exit;Close]"
    minetest.show_formspec(name, "interface_achat_2", formspec)
end
-- Enregistrement de la fonction pour le bouton "<- (precedent page)"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_achat_2" and fields.precedent then
afficher_interface_achat(player)
    end
end)
-- Enregistrement de la fonction pour le bouton "-> (next page)"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_achat" and fields.nexts then
afficher_interface_achat_2(player)
    end
end)

-- Enregistrement de la fonction pour le bouton "return"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_info" and fields.retour then
afficher_interface_achat(player)
    end
end)
-- Enregistrement de la fonction pour le bouton "info"
    minetest.register_on_player_receive_fields(function(player, formname, fields)
        if formname == "interface_achat" and fields.info then
afficher_interface_info(player)
    end
end)


-- Enregistrer la commande pour afficher l'interface
minetest.register_chatcommand("shop", {
    description = "Open The Admin Shop",
    func = function(name, param)
        local player = minetest.get_player_by_name(name)
        afficher_interface_achat(player)
    end,
})

-- Enregistrement de l'item coin
minetest.register_craftitem("shop:coin", {
    description = "Gold Coin",
    inventory_image = "coin.png",
})

-- Enregistrement de l'item bag coin
minetest.register_craftitem("shop:coin_bag", {
    description = "Bag of Coin",
    inventory_image = "bag_coin.png",
})
minetest.register_craft({
    output = "shop:coin_bag",
    recipe = {
        {"shop:coin", "shop:coin", "shop:coin"},
        {"default:paper", "farming:string", "shop:coin"},
        {"shop:coin", "shop:coin", "shop:coin"}
    },
})
-- Recette pour fabriquer un coin à partir d'une gold_ingot et de tin_ingot
minetest.register_craft({
    output = "shop:coin 5",
    recipe = {
        {"default:gold_ingot", "default:tin_ingot"},
    },
})

-- Recette pour fabriquer un coin 
minetest.register_craft({
    output = "shop:coin 7 ",
    recipe = {
        {"shop:coin_bag"},
    },
})



