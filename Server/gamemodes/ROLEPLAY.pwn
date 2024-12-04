#include <open.mp>
#include <streamer>
#include </YSI_Storage/y_ini>
#include </YSI_Data/y_foreach>
#include <format>

#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_BLUE 0x0000BBAA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_ORANGE 0xFF9900AA
#define COLOR_RED 0xAA3333AA
#define COLOR_LIME 0x10F441AA
#define COLOR_MAGENTA 0xFF00FFFF
#define COLOR_NAVY 0x000080AA
#define COLOR_AQUA 0xF0F8FFAA
#define COLOR_CRIMSON 0xDC143CAA
#define COLOR_FLBLUE 0x6495EDAA
#define COLOR_BISQUE 0xFFE4C4AA
#define COLOR_BLACK 0x000000AA
#define COLOR_CHARTREUSE 0x7FFF00AA
#define COLOR_BROWN 0XA52A2AAA
#define COLOR_CORAL 0xFF7F50AA
#define COLOR_GOLD 0xB8860BAA
#define COLOR_GREENYELLOW 0xADFF2FAA
#define COLOR_INDIGO 0x4B00B0AA
#define COLOR_IVORY 0xFFFF82AA
#define COLOR_LAWNGREEN 0x7CFC00AA
#define COLOR_LIMEGREEN 0x32CD32AA //<--- Dark lime
#define COLOR_MIDNIGHTBLUE 0X191970AA
#define COLOR_MAROON 0x800000AA
#define COLOR_OLIVE 0x808000AA
#define COLOR_ORANGERED 0xFF4500AA
#define COLOR_PINK 0xFFC0CBAA // - Light light pink
#define COLOR_SEAGREEN 0x2E8B57AA
#define COLOR_SPRINGGREEN 0x00FF7FAA
#define COLOR_TOMATO 0xFF6347AA // - Tomato >:/ sounds wrong lol... well... :P
#define COLOR_YELLOWGREEN 0x9ACD32AA //- like military green
#define COLOR_MEDIUMAQUA 0x83BFBFAA
#define COLOR_MEDIUMMAGENTA 0x8B008BAA // dark magenta ^^

// INI Defines
#define PATH "/Users/%s.ini"


enum PlayerI
{
	Deaths,
	Kills,
	Admin,
	JobID,
	Cash,
	DaysPlayed,
	JobPickup,
	JobMarker,
	CurrentJob
}

new ServerHr,ServerMin;
new DaysPassed;
new PlayerInfo[MAX_PLAYERS][PlayerI];

main()
{
	printf("====================================");
	printf("|        Edge Roleplay Loaded      |");
	printf("====================================");
	SendRconCommand("hostname Edge Roleplay v1.0 ~ Jobs, Shops, Economy, and More");
	SendRconCommand("mode Roleplay RP");
}

#define MAX_SHOPS 500
enum ShopData
{
	TotalInventory,
	bool:RecentlyRobbed,
	MapIcon,
	Ped,
	CP,
	bool:IsAlwaysOpen
}

new Shops[MAX_SHOPS][ShopData];
new xstring[650];
new CitizenPeds[120];

new Float:TrashCollect[][4] =
{
	{2190.7634,2790.9290,10.8203},
	{2107.6182,2649.9553,10.8130},
	{1062.1455,1978.5819,10.8203},
	{1050.9185,2036.8643,10.8203},
	{2255.6868,2525.9492,10.8203},
	{2515.0464,2316.8599,10.8203},
	{2543.7639,2319.2180,10.8133}	
};

#define SHOP_DIALOG_ICECREAM 1
#define SHOP_DIALOG_PIZZA 2
#define SHOP_DIALOG_BURGER 3

new Text: Text_Global[2];

public OnGameModeInit()
{
	Text_Global[0] = TextDrawCreate(563.000, 24.000, "00:00");
	TextDrawLetterSize(Text_Global[0], 0.300, 1.500);
	TextDrawAlignment(Text_Global[0], TEXT_DRAW_ALIGN_LEFT);
	TextDrawColour(Text_Global[0], -1);
	TextDrawSetShadow(Text_Global[0], 1);
	TextDrawSetOutline(Text_Global[0], 1);
	TextDrawBackgroundColour(Text_Global[0], 150);
	TextDrawFont(Text_Global[0], TEXT_DRAW_FONT_3);
	TextDrawSetProportional(Text_Global[0], true);
	
	
	AddPlayerClass(0, 1683.9470,1449.7870,10.7710,270.2240, WEAPON_M4, 500, WEAPON_KNIFE, 1, WEAPON_COLT45, 100);
	ServerHr = 9;
	ServerMin = 0;
	// ----- CARS ---- 
	
	AddStaticVehicle(593,1279.4697,1359.3501,11.2830,273.3942,6,0); // dodo
	AddStaticVehicle(593,1280.7917,1323.3904,11.2811,271.1504,6,0); // dodo
	AddStaticVehicle(436,1328.7172,1279.6434,10.5862,180.2061,9,9); // admiral
	AddStaticVehicle(436,1325.5079,1279.7207,10.5899,180.6171,9,9); // admiral
	AddStaticVehicle(411,1315.8975,1279.0265,10.5474,178.8518,0,1); // iunferu
	AddStaticVehicle(411,1309.5820,1278.8048,10.5474,179.5518,0,1); // iunferu
	AddStaticVehicle(485,1335.8530,1319.2660,10.4762,303.0998,1,74); // baggage
	AddStaticVehicle(485,1337.6387,1316.5970,10.4776,300.0621,1,74); // baggage
	AddStaticVehicle(577,1558.5013,1356.0759,10.7844,297.9281,8,7); // at400
	AddStaticVehicle(577,1564.1150,1482.0624,10.7405,316.0948,8,7); // at400
	AddStaticVehicle(519,1560.4548,1550.8806,11.7419,58.0841,1,1); // shamal
	AddStaticVehicle(487,1320.6785,1494.5867,11.0703,127.2781,95,36); // heli
	AddStaticVehicle(555,1669.7504,1306.5001,10.5043,179.9526,67,67); // winsor
	AddStaticVehicle(555,1669.8331,1317.1667,10.5044,179.4584,67,67); // winsor
	AddStaticVehicle(451,1685.7433,1305.8717,10.5271,179.0531,52,52); // tur
	AddStaticVehicle(562,1698.6923,1286.8737,10.4794,180.3787,16,12); // elegy
	AddStaticVehicle(562,2039.7568,1173.6367,10.3299,181.5828,21,21); // eleg
	AddStaticVehicle(562,2040.2186,1156.9451,10.3300,181.5822,26,6); // elg
	AddStaticVehicle(474,2103.8936,1397.4515,10.5528,359.4109,2,2); // blis
	AddStaticVehicle(445,2119.9912,1408.8604,10.6874,179.9090,96,96); // solair
	AddStaticVehicle(445,2207.4912,1787.9709,10.6953,182.9287,96,96); // ca
	AddStaticVehicle(400,2185.7876,1787.7565,10.9119,0.7390,123,1); // tr
	AddStaticVehicle(500,2174.3804,1821.3627,10.9228,358.8137,8,0); // mesa
	AddStaticVehicle(586,2141.2222,1797.3552,10.3405,63.6228,14,14); // bike
	AddStaticVehicle(400,2172.7532,1996.8448,10.9127,90.2046,1,6); // ca
	AddStaticVehicle(418,2186.2034,2004.5765,10.9135,91.1683,117,227); // 12
	AddStaticVehicle(411,2102.7737,2059.3308,10.5474,269.6510,55,55); // inf
	AddStaticVehicle(411,1493.1327,712.6501,10.4709,83.6686,55,55); // inf
	AddStaticVehicle(401,1413.5717,707.9953,10.5995,89.5515,47,47); // ca
	AddStaticVehicle(446,1625.2955,572.0429,-0.3486,268.5662,1,5); // squ
	AddStaticVehicle(411,1499.7469,2002.2495,10.5474,180.8993,102,102); // inf
	AddStaticVehicle(419,1512.0457,2001.5237,10.6171,0.0000,47,76); // ca
	AddStaticVehicle(524,2422.6802,1891.2036,6.9437,0.3365,1,0); // cement
	AddStaticVehicle(586,2463.2249,2035.7441,10.3405,270.9655,93,93); // pizzadel
	AddStaticVehicle(422,-1675.9596,436.6256,7.1845,224.0565,97,25); // truck
	AddStaticVehicle(522,2074.9817,1683.7039,10.2338,0.2144,0,1); // nrg
	AddStaticVehicle(507,2103.3108,2079.1077,10.6463,269.7477,42,42); // eleg
	AddStaticVehicle(533,2103.4370,2098.8354,10.5294,270.4597,1,1); // feltz
	AddStaticVehicle(498,2060.5454,2238.3621,10.4191,89.6724,13,120); // box
	AddStaticVehicle(498,2059.4597,2264.2383,10.5111,90.6731,13,120); // box
	AddStaticVehicle(416,1879.4105,2255.5425,10.9687,359.2235,1,3); // ambu
	AddStaticVehicle(416,1856.1458,2241.7744,10.9695,271.1921,1,3); // ambu
	AddStaticVehicle(416,1888.8673,2242.5200,10.9692,271.2827,1,3); // ambu
	AddStaticVehicle(411,2065.6304,2479.6406,10.5474,359.7939,42,42); // car
	AddStaticVehicle(598,2256.2461,2460.2512,10.5632,1.2875,0,1); // lvpd-car
	AddStaticVehicle(598,2255.8752,2476.7737,10.5684,1.2877,0,1); // lvpd-car
	AddStaticVehicle(598,2260.7600,2460.8550,10.5694,359.0131,0,1); // lvpd-car
	AddStaticVehicle(598,2260.4626,2443.4919,10.5643,359.0130,0,1); // lvpd-car
	AddStaticVehicle(598,2256.0557,2443.9529,10.5628,359.4865,0,1); // lvpd-car
	AddStaticVehicle(598,2251.6587,2443.1450,10.5655,359.5373,0,1); // lvpd-car
	AddStaticVehicle(598,2277.8682,2458.8552,10.5659,359.8265,0,1); // lvpd-car
	AddStaticVehicle(598,2277.9170,2475.6567,10.5664,359.8353,0,1); // lvpd-car
	AddStaticVehicle(598,2282.4492,2477.5544,10.5657,1.9684,0,1); // lvpd-car
	AddStaticVehicle(598,2298.6968,2451.4912,3.0148,89.3121,0,1); // lvpd-car
	AddStaticVehicle(598,2299.0308,2455.8665,3.0211,90.5431,0,1); // lvpd-car
	AddStaticVehicle(598,2313.3777,2455.6709,3.0260,88.4198,0,1); // lvpd-car
	AddStaticVehicle(598,2307.8005,2431.5718,3.0202,181.3263,0,1); // lvpd-car
	AddStaticVehicle(400,2352.2249,1493.8596,42.9127,90.6489,0,1); // car
	AddStaticVehicle(480,2302.1794,1487.3093,42.5902,270.8328,16,15); // comet
	AddStaticVehicle(401,2352.3816,1408.6620,23.0558,270.3108,47,47); // car
	AddStaticVehicle(521,2321.2458,1472.9844,18.7162,89.7828,75,13); // car
	AddStaticVehicle(559,2564.9614,2196.3032,10.4767,179.0787,58,8); // jester
	AddStaticVehicle(559,2511.1660,2360.2271,10.4765,268.2413,0,1); // jester
	AddStaticVehicle(422,2195.3345,2502.8171,10.8014,359.8926,111,31); // bobcat
	AddStaticVehicle(463,2142.7998,2795.7075,10.3599,91.8512,31,31); // harley
	AddStaticVehicle(421,2578.9309,1986.9517,10.7046,92.2313,13,1); // car
	AddStaticVehicle(411,2442.6379,1629.3756,10.5422,2.6393,34,34); // infernus	
	AddStaticVehicle(408,2347.1025,2747.8022,11.3620,270.6524,26,26); // trashcar
	AddStaticVehicle(408,2367.8472,2754.5681,11.3572,181.1145,26,26); // trashcar
	AddStaticVehicle(408,2346.3000,2763.9543,11.3595,269.8662,26,26); // trashcar
	AddStaticVehicle(408,2346.4824,2738.3337,11.3643,269.2464,26,26); // trashcar
	AddStaticVehicle(408,2295.3586,2738.4097,11.3741,268.7410,26,26); // trashcar
	AddStaticVehicle(408,2295.2695,2754.4895,11.3681,269.9722,26,26); // trashcar
	AddStaticVehicle(416,1590.2196,1819.6315,10.9675,181.6526,1,3); // ambu
	AddStaticVehicle(416,1623.2496,1818.4192,10.9699,178.6918,1,3); // ambu
	AddStaticVehicle(416,1626.4774,1817.7908,10.9696,183.0746,1,3); // ambu
	
	new TempVehicle;	
	TempVehicle = AddStaticVehicle(451,2145.6262,1397.2570,10.5188,1.4779,125,125); // turismo - locked
	new engine, lights, alarm, doors, bonnet, boot, objective;
	GetVehicleParamsEx(TempVehicle, engine, lights, alarm, doors, bonnet, boot, objective);
	SetVehicleParamsEx(TempVehicle, engine, lights, alarm, 1, bonnet, boot, objective);
	TempVehicle = AddStaticVehicle(451,2148.8779,1398.0405,10.5194,0.5812,21,21); // turismo - locked
	GetVehicleParamsEx(TempVehicle, engine, lights, alarm, doors, bonnet, boot, objective);
	SetVehicleParamsEx(TempVehicle, engine, lights, alarm, 1, bonnet, boot, objective);


	// ------ peds	
	CreateDynamicActor(282, 232.4309,160.7520,1003.0234,221.5054,0,100.0); // police peds?
	CreateDynamicActor(282, 2238.6243,2449.5745,11.0372,11.0516,0,100.0);

	
	// Hours (Shop)
	Shops[1][IsAlwaysOpen] = false;
	Shops[2][IsAlwaysOpen] = false;
	Shops[3][IsAlwaysOpen] = false;
	Shops[5][IsAlwaysOpen] = false;
	Shops[6][IsAlwaysOpen] = true;
	Shops[4][IsAlwaysOpen] = true;
	
	
	// ------ weapons	
	
	
	// ------ MAPICONS
	CreateDynamicMapIcon(1675.9456,1448.2476,10.7859, 5, COLOR_WHITE);
	CreateDynamicMapIcon(2415.3672,1123.8721,10.8203, 58, COLOR_WHITE);
	CreateDynamicMapIcon(2348.1782,2728.2561,10.8203, 51, COLOR_WHITE); // trash job
	
	UsePlayerPedAnims();
	
	// Shop Reference Code	
	/*
		0 = sex shop LV (1)
		1 = ice cream street shop (1)
	*/
	
	GeneratePedestrianShops();
	GenerateCitizens();	
	
	for(new i=0; i< MAX_PLAYERS; i++)
	{
		PlayerInfo[i][DaysPlayed] = 0;
		PlayerInfo[i][Admin] = 0;
		PlayerInfo[i][Kills] = 0;
		PlayerInfo[i][Deaths] = 0;
		PlayerInfo[i][JobID] = -1;	
	}
	
	SetTimer("TimeDayUpdate",1000,true);
	return 1;
}

forward TimeDayUpdate();
public TimeDayUpdate()
{
	// every min add a minute,
	// 24 mins is a hr.
	ServerMin++;
	if(ServerMin == 60)
	{
		ServerHr+=1;
		ServerMin = 0;
		if(ServerHr == 24)
		{
			ServerHr = 0;			
		}		
	}
	
	new time[10];
	if(ServerMin < 10)
	{
		format(time,sizeof time,"%d:0%d",ServerHr,ServerMin);	
	}	else format(time,sizeof time,"%d:%d",ServerHr,ServerMin);
	TextDrawSetString(Text_Global[0],time);
	
	foreach(new i:Player)
	{
		SetPlayerTime(i,ServerHr,ServerMin);		
	}

	switch(ServerHr)
	{		
		case 20:
		{
			// Business Close		
			if(ServerMin == 1)
			{	
				DestroyActor(Shops[0][Ped]);
				DestroyActor(Shops[1][Ped]);
				DestroyActor(Shops[2][Ped]);
				DestroyActor(Shops[3][Ped]);
				DestroyActor(Shops[5][Ped]);
				format(xstring,sizeof xstring,"**[TimeAndDay Update]**: I closed all the static businesses!");
				printf(xstring);	
			}
		}		

		case 8:
		{
			// Business ReOpen		
			if(ServerMin == 1)
			{
				GeneratePedestrianShops();
				format(xstring,sizeof xstring,"**[TimeAndDay Update]**: I reopened all the static businesses!");
				printf(xstring);	
			}
		}		
		
		case 0:
		{
			// New Day	
			if(ServerMin == 1)
			{		
				DaysPassed++;
				format(xstring,sizeof xstring,"**[TimeAndDay Update]**: %d Days Have Passed!",DaysPassed);
				printf(xstring);
			}	
		}
	}
	
	return 1;	
}

forward GenerateCitizens();
public GenerateCitizens()
{
	CitizenPeds[0] = CreateDynamicActor(259, 2182.5356,1500.6664,10.8203,273.7369,0,100.0); // Sitting Ped
	ApplyActorAnimation(CitizenPeds[0],"INT_OFFICE", "OFF_Sit_Bored_Loop", 1.800001, true, false, false, true, 600);
	return 1;	
}

forward GeneratePedestrianShops();
public GeneratePedestrianShops()
{
	Shops[0][Ped] = CreateDynamicActor(178, -104.7445,-8.9149,1000.7188,176.1184,0,100.0); // Sex Shop LV (1)
	Shops[1][Ped] = CreateDynamicActor(264, 1031.0038,1361.7461,10.8203,359.3373,0,100.0); // Street Ice Cream Shop
	Shops[2][Ped] = CreateDynamicActor(264, 2125.6304,1441.1274,10.8203,359.3230,0,100.0); // Street Ice Cream Shop
	Shops[3][Ped] = CreateDynamicActor(264, 2175.5830,1522.5038,10.8203,1.6959,0,100.0); // Street Ice Cream Shop
	Shops[4][Ped] = CreateDynamicActor(155, 374.8131,-117.2772,1001.4922,183.1783,0,100.0); // Pizza Shop PED
	Shops[5][Ped] = CreateDynamicActor(264, 2538.9419,2154.2546,10.8203,91.5766,0,100.0); // Street Ice Cream Shop
	Shops[6][Ped] = CreateDynamicActor(205, 376.4229,-65.6079,1001.5078,184.6889,0,100.0); // Burger Shot 
	Shops[7][Ped] = CreateDynamicActor(205, 2537.2112,2291.2808,10.8203,94.8887,0,100.0); // Noodle Shop
		
	// PICKUPS
	Shops[1][CP] = CreateDynamicCP(1030.8544,1364.0277,10.8203,1,-1,-1,-1,35); // Ice Cream Shop
	Shops[2][CP] = CreateDynamicCP(2125.4719,1443.1877,10.8203,1,-1,-1,-1,35); // Ice Cream Shop
	Shops[3][CP] = CreateDynamicCP(2175.3667,1524.5238,10.8125,1,-1,-1,-1,35); // Ice Cream Shop
	Shops[4][CP] = CreateDynamicCP(374.6728,-119.3662,1001.4995,1,-1,-1,-1,35); // Pizza
	Shops[5][CP] = CreateDynamicCP(2536.9209,2154.0181,10.8203,1,-1,-1,-1,35); // Ice Cream Shop
	Shops[6][CP] = CreateDynamicCP(376.6030,-67.7141,1001.5151,1,-1,-1,-1,35); // Burger Shot
	Shops[7][CP] = CreateDynamicCP(2534.9871,2291.1130,10.8203,1,-1,-1,-1,35); // Noodle Shop
	
	return 1;	
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerEnterDynamicCP(playerid, checkpointid) 
{
	if(checkpointid == Shops[1][CP])
	{
		ShowPlayerDialog(playerid,SHOP_DIALOG_ICECREAM,DIALOG_STYLE_TABLIST,"Ice Cream Shop","Small Ice Cream Cone\t$1\nMedium Ice Cream Cone\t$2\nLarge Ice Cream Cone\t$4","Buy","Cancel");
	}
	if(checkpointid == Shops[2][CP])
	{
		ShowPlayerDialog(playerid,SHOP_DIALOG_ICECREAM,DIALOG_STYLE_TABLIST,"Ice Cream Shop","Small Ice Cream Cone\t$1\nMedium Ice Cream Cone\t$2\nLarge Ice Cream Cone\t$4","Buy","Cancel");
	}
	if(checkpointid == Shops[3][CP])
	{
		ShowPlayerDialog(playerid,SHOP_DIALOG_ICECREAM,DIALOG_STYLE_TABLIST,"Ice Cream Shop","Small Ice Cream Cone\t$1\nMedium Ice Cream Cone\t$2\nLarge Ice Cream Cone\t$4","Buy","Cancel");
	}
	if(checkpointid == Shops[5][CP])
	{
		ShowPlayerDialog(playerid,SHOP_DIALOG_ICECREAM,DIALOG_STYLE_TABLIST,"Ice Cream Shop","Small Ice Cream Cone\t$1\nMedium Ice Cream Cone\t$2\nLarge Ice Cream Cone\t$4","Buy","Cancel");
	}
	if(checkpointid == Shops[4][CP])
	{
		ShowPlayerDialog(playerid,SHOP_DIALOG_PIZZA,DIALOG_STYLE_TABLIST,"Well Stacked Pizza","One Slice Pizza\t$1\n2 Slices Pizza\t$5\nBoxed Pizza\t$15\nSalad\t$5","Buy","Cancel");
	}
	if(checkpointid == Shops[6][CP])
	{
		ShowPlayerDialog(playerid,SHOP_DIALOG_PIZZA,DIALOG_STYLE_TABLIST,"Burger Shot","Burger\t$2\nBurger and Fries\t$5\nSalad\t$5","Buy","Cancel");
	}
	if(checkpointid == Shops[7][CP])
	{
		ShowPlayerDialog(playerid,SHOP_DIALOG_PIZZA,DIALOG_STYLE_TABLIST,"Noodle Shop","Wonton Soup\t$2\nCup of Noodles\t$3\nChicken Noodle Chow\t$5\nBeef Noodle Chow\t$5","Buy","Cancel");
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
	ApplyActorAnimation(playerid,"INT_OFFICE", "OFF_Sit_Bored_Loop", 1.800001, true, false, false, true, 600);
	TextDrawShowForPlayer(playerid,Text_Global[0]);
	SendClientMessage(playerid,COLOR_GREEN,"*** Welcome to Edge Roleplay.");
	SendClientMessage(playerid,COLOR_RED,"*** You have been automatically registered/logged in.");
	SendClientMessage(playerid,COLOR_GREEN,"*** This server is meant to be the most realistic advanced roleplay.");
	
	if(fexist(UserPath(playerid)))
    {
		format(xstring,sizeof xstring,"%p (ID:%d) has joined Edge Roleplay (existing player)",playerid,playerid);
		SendClientMessageToAll(COLOR_GREY,xstring);
		INI_ParseFile(UserPath(playerid), "LoadUser_%s", .bExtra = true, .extra = playerid);
	}	
	else
	{
		format(xstring,sizeof xstring,"%p (ID:%d) has joined Realistic Open Roleplay (new player)",playerid,playerid);
		SendClientMessageToAll(COLOR_GREY,xstring);
		
		new INI:File = INI_Open(UserPath(playerid));
        INI_SetTag(File,"data");
        INI_WriteInt(File,"Cash",0);
		new ip[19];
		GetPlayerIp(playerid,ip,sizeof ip);
		INI_WriteString(File,"IP",ip);
        INI_WriteInt(File,"Admin",0);
        INI_WriteInt(File,"Kills",0);
        INI_WriteInt(File,"Deaths",0);
		INI_WriteInt(File,"DaysPlayed",0);
		INI_WriteInt(File,"JobID",-1);
        INI_Close(File);
	}	
	
	PlayerInfo[playerid][JobID] = 1;
	PlayerInfo[playerid][Admin] = 0;
	return 1;
}

forward LoadUser_data(playerid,name[],value[]);
public LoadUser_data(playerid,name[],value[])
{
	new ip[16],newip[16];
	INI_String("IP",ip,sizeof ip);
	if(!strcmp(ip,newip))
	{
	    INI_Int("Cash",PlayerInfo[playerid][Cash]);
	    INI_Int("Admin",PlayerInfo[playerid][Admin]);
	    INI_Int("Kills",PlayerInfo[playerid][Kills]);
	    INI_Int("Deaths",PlayerInfo[playerid][Deaths]);
		INI_Int("DaysPlayed",PlayerInfo[playerid][DaysPlayed]);
		INI_Int("JobID",PlayerInfo[playerid][JobID]);
	}
	else
	{
		SendClientMessage(playerid,COLOR_GREY,"[!] We couldn't recognize your Computer/IP Address. Since this might not be your account, we have given you a temporary name.");
		new tmpName[24];
		format(tmpName,sizeof tmpName,"CarlJohnson%d",playerid);
		SetPlayerName(playerid,tmpName);		
	}
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	new INI:File = INI_Open(UserPath(playerid));
    INI_SetTag(File,"data");
    INI_WriteInt(File,"Cash",0);
	new ip[19];
	GetPlayerIp(playerid,ip,sizeof ip);
	INI_WriteString(File,"IP",ip);
    INI_WriteInt(File,"Admin",0);
    INI_WriteInt(File,"Kills",0);
    INI_WriteInt(File,"Deaths",0);
	INI_WriteInt(File,"DaysPlayed",0);
	INI_WriteInt(File,"JobID",-1);
    INI_Close(File);


	if(PlayerInfo[playerid][JobID] == 1)
	{
		DestroyDynamicMapIcon(PlayerInfo[playerid][JobMarker]);
		DestroyDynamicPickup(PlayerInfo[playerid][JobPickup]);
		PlayerInfo[playerid][JobID] = 0;
	}
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 217.8511, -98.4865, 1005.2578);
	SetPlayerFacingAngle(playerid, 113.8861);
	SetPlayerInterior(playerid, 15);
	SetPlayerCameraPos(playerid, 215.2182, -99.5546, 1006.4);
	SetPlayerCameraLookAt(playerid, 217.8511, -98.4865, 1005.2578);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	SendClientMessage(playerid,COLOR_GREY,"** You have just flown in to San Andreas from Vice City. Enjoy your stay.");
	SetPlayerInterior(playerid, 0);
	return 1;
}

public OnPlayerDeath(playerid, killerid, WEAPON:reason)
{
	return 1;
}

/*
     ___              _      _ _    _
    / __|_ __  ___ __(_)__ _| (_)__| |_
    \__ \ '_ \/ -_) _| / _` | | (_-<  _|
    |___/ .__/\___\__|_\__,_|_|_/__/\__|
        |_|
*/

public OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
{
	if(newkeys & KEY_NO)
	{
		if(PlayerInfo[playerid][JobID] == 1)
		{
			if(PlayerInfo[playerid][CurrentJob] != 0) return SendClientMessage(playerid,COLOR_GREY,"* Finish the current job you started!");
			new rTrash = random(sizeof(TrashCollect));
			PlayerInfo[playerid][JobPickup] =  CreateDynamicPickup(1265, 19,TrashCollect[rTrash][0], TrashCollect[rTrash][1], TrashCollect[rTrash][2],-1,-1, playerid);
			PlayerInfo[playerid][JobMarker] =  CreateDynamicMapIcon(TrashCollect[rTrash][0], TrashCollect[rTrash][1], TrashCollect[rTrash][2], 0, COLOR_WHITE,-1,-1,playerid,10000);
		}		
	}
	return 1;
}

public OnPlayerPickUpDynamicPickup(playerid, pickupid) 
{
	if(PlayerInfo[playerid][JobID] == 1)
	{
		DestroyDynamicMapIcon(PlayerInfo[playerid][JobMarker]);
		DestroyDynamicPickup(PlayerInfo[playerid][JobPickup]);
		new rTrash = random(sizeof(TrashCollect));
		PlayerInfo[playerid][JobPickup] =  CreateDynamicPickup(1265, 19,TrashCollect[rTrash][0], TrashCollect[rTrash][1], TrashCollect[rTrash][2],-1,-1, playerid);
		PlayerInfo[playerid][JobMarker] =  CreateDynamicMapIcon(TrashCollect[rTrash][0], TrashCollect[rTrash][1], TrashCollect[rTrash][2], 0, COLOR_WHITE,-1,-1,playerid,10000);
		GivePlayerMoney(playerid,150);
	}
	return 1;	
}

public OnPlayerStateChange(playerid, PLAYER_STATE:newstate, PLAYER_STATE:oldstate)
{
	if (oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER) // Player entered a vehicle as a driver
    {
		new vModel;
		vModel = GetVehicleModel(GetPlayerVehicleID(playerid));
		switch(vModel)
		{
			case 416:
			{
				if(PlayerInfo[playerid][JobID] == 1)
				{
					SendClientMessage(playerid,COLOR_GREEN,"You are employed as a Trash Collector. Press 'N' to start a job.");					
				}				
			}			
		}
	}
	return 1;
}


public OnPlayerGiveDamageActor(playerid, damaged_actorid, Float:amount, WEAPON:weaponid, bodypart)
{
	return 1;
}

public OnActorStreamIn(actorid, forplayerid)
{
	return 1;
}

public OnActorStreamOut(actorid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case SHOP_DIALOG_ICECREAM:
		{
			// Ice Cream Shop Code
		}		
	}
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z)
{
	return 1;
}

stock UserPath(playerid)
{
    new string[128],playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid,playername,sizeof(playername));
    format(string,sizeof(string),PATH,playername);
    return string;
}