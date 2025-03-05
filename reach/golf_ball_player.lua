--[[ **SCRIPT PURPOSE**
  This script will attach the player's biped to a golf_ball.
  Notes:
    - The player on the golf ball has a constant view-height (camera DOESN'T spin crazy unless you offset the .attach_to)
]]

--[[ Player Objects ]]
alias golf_ball = player.object[0]
alias weapon = player.object[1]

-- =========================================================
-- **SPAWN & ATTACH PLAYER TO GOLF BALL**
-- =========================================================
for each player do
  current_player.weapon = current_player.get_weapon(primary)
  if current_player.golf_ball == no_object and current_player.biped != no_object and not current_player.weapon.is_of_type(magnum) then 
    -- Spawn the golf ball
    current_player.golf_ball = current_player.biped.place_at_me(golf_ball, none, none, 0, 0, 0, none)
    current_player.biped.attach_to(current_player.golf_ball, 0, 0, 0, relative) -- Attach player to golf_ball
    current_player.golf_ball.set_shape(box, 5, 5, 5, 5)
    current_player.golf_ball.set_shape_visibility(everyone)
  end
end

-- =========================================================
-- **DETACH/ATTACH BIPED FROM GOLF BALL (Fixes Invincible Biped)**
-- ========================================================
for each player do
  if current_player.golf_ball != no_object and current_player.biped != no_object then
	current_player.biped.attach_to(current_player.golf_ball, 0, 0, 0, relative)
	current_player.biped.detach()
  end
end

-- =========================================================
-- **REMOVE GOLF BALL IF PLAYER DIES**
-- =========================================================
for each player do
  if current_player.biped == no_object then
    if current_player.golf_ball != no_object then
        current_player.biped.detach()
      current_player.golf_ball.delete()
    end
  end
end

-- =========================================================
-- **DETACH GOLF BALL IF PLAYER EQUIPS A MAGNUM** (Development Purposes - Switch weapons to something else to re-equip)
-- =========================================================
for each player do
  if current_player.weapon.is_of_type(magnum) then
    if current_player.golf_ball != no_object then
      current_player.biped.detach()
      current_player.golf_ball.delete()
    end
  end
end
