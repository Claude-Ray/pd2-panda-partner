if RequiredScript == "lib/managers/blackmarketmanager" then
  Hooks:PostHook(BlackMarketManager, "view_mask_with_mask_id", "panda_rewards_id", function (self, mask_id)
    if mask_id == "panda" then
      local infamy = managers.experience:current_rank()
      local level = managers.experience:current_level()
      if infamy <= 1 and level < 100 then
        local xp = 24e6
        managers.experience:add_points(xp, false, true)
        managers.custom_safehouse:give_upgrade_points(xp)
        managers.skilltree:give_specialization_points(xp)
        managers.money:add_to_total(2e8 / 0.8)
      elseif infamy < 5 then
        managers.custom_safehouse:add_coins(12)
        managers.skilltree:give_specialization_points(137e5)
      else
        managers.custom_safehouse:add_coins(6)
      end
    end
  end)
elseif RequiredScript == "lib/managers/customsafehousemanager" then
  Hooks:PreHook(CustomSafehouseManager, "deduct_coins", "panda_deduct_coins_id", function (self, amount, ...)
    local current_mask_id = managers.blackmarket:equipped_mask().mask_id
    if current_mask_id == "panda" then
      managers.custom_safehouse:add_coins(amount)
    end
  end)
elseif RequiredScript == "lib/managers/menumanager" then
  Hooks:PostHook(MenuCallbackHandler, "become_infamous", "panda_become_infamous_id", function (self, params)
    local current_mask_id = managers.blackmarket:equipped_mask().mask_id
    if current_mask_id == "panda" then
      local infamy = managers.experience:current_rank()
      local level = managers.experience:current_level()
      if infamy > 25 and infamy <= 100 and level == 0 then
        managers.experience:add_points(24e6, false, true)
      end
    end
  end)
elseif RequiredScript == "lib/managers/moneymanager" then
  Hooks:PreHook(MoneyManager, "_deduct_from_total", "panda_deduct_total_id", function (self, amount)
    local current_mask_id = managers.blackmarket:equipped_mask().mask_id
    if current_mask_id == "panda" then
      managers.money:_add_to_total(amount, { no_offshore = true })
    end
  end)

  Hooks:PreHook(MoneyManager, "_deduct_from_offshore", "panda_deduct_offshore_id", function (self, amount)
    local current_mask_id = managers.blackmarket:equipped_mask().mask_id
    if current_mask_id == "panda" then
      managers.money:add_to_offshore(amount)
    end

  Hooks:PreHook(MoneyManager, "deduct_from_spending", "panda_deduct_spending_id", function (self, amount)
    local current_mask_id = managers.blackmarket:equipped_mask().mask_id
    if current_mask_id == "panda" then
      managers.money:add_to_spending(amount)
    end
  end)
 end)
end
