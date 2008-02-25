hooksecurefunc("WorldStateScoreFrame_Update", function()
	local isArena = IsActiveBattlefieldArena()
	local dataFailure
	
	-- It's possible to get a bad arena game where you go up against no team
	-- so make sure both sides are found before setting the rating change
	if( isArena ) then
		for i=0, 1 do
			if( select(2, GetBattlefieldTeamInfo(i)) == 0 ) then
				dataFailure = true
			end
		end
	end

	for i=1, MAX_WORLDSTATE_SCORE_BUTTONS do
		local name, _, _, _, _, faction = GetBattlefieldScore(FauxScrollFrame_GetOffset(WorldStateScoreScrollFrame) + i)
		if( name ) then
			if( isArena ) then
				local teamName, oldRating, newRating = GetBattlefieldTeamInfo(faction)
				if( not dataFailure ) then
					getglobal("WorldStateScoreButton" .. i .. "HonorGained"):SetFormattedText("%d (%d)", newRating - oldRating, newRating)
				else
					getglobal("WorldStateScoreButton" .. i .. "HonorGained"):SetText("----")
				end
			end
		end
	end
end)