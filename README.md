* Are you returning to SA-MP / OpenMP?
--------------------------------------
While you might see me playing sometimes, the answer is a big NO. I've wasted years on that, and I'm not interested in returning to actually host a server. 90% of all servers are dead, and I have no interest.

* What's This?
-------------
EdgeRP is a small project I've been working on when I have nothing to do. It might get finished, but probaly not. That's why it's a public GitHub release - anyone can pick up where I left off, at any time.
Anyway, Edge RP is meant to bring lots of features you would find in FiveM to the game, allowing people to expierience what a general FiveM roleplay server would be like. It can be played alone or with others.
Features include:

  - Inventory System
  - Jobs
  - Houses
  - Economy
  - Real-Living World NPC's

* Can I contact you about issues?
---------------------------------
No. Use the Wikis. There is loads of information about there.

* How Can I create a new EdgeNPC?
---------------------------------
Each EdgeNPC works by analyzing where the player is, at all times. It then spawns in NPCs based on the server time, and economy. EdgeNPCs use two different things: a Actor Assignment, and a checkpoint. _You will only need a checkpoint if you want to interact with a menu._

    
    CitizenPeds[0] = CreateDynamicActor(259, 2182.5356,1500.6664,10.8203,273.7369,0,100.0); // Sitting Ped
	  ApplyActorAnimation(CitizenPeds[0],"INT_OFFICE", "OFF_Sit_Bored_Loop", 1.800001, true, false, false, true, 600);
    // This is a citizen ped, which just sit around and sometimes move. We can apply animations to allow them to ' fake walk '. The above animation will have them sit at a bench.
    // You can reference the NPC with CitizenPeds[0]

Be aware that these NPC's will cause a server-load issue if you use too many. It's a good idea to delete them if a player goes out of bounds.    

* How Can I create a new Shop?
---------------------------------
We have two different shops - always open, and hourly based. Shops that close open around 8 in the morning, and have a closing time. All shops require inventory, which can be delivered by trucking. We use the Shops[] enumerator to make a new shop. Each shop has a 'cashier', and a checkpoint
for interacting. We do all this work in the _GeneratePedestrianShops()_ callback.

    
    Shops[7][Ped] = CreateDynamicActor(205, 2537.2112,2291.2808,10.8203,94.8887,0,100.0); // Noodle Shop
    Shops[7][CP] = CreateDynamicCP(2534.9871,2291.1130,10.8203,1,-1,-1,-1,35); // Noodle Shop

We can then use callbacks like _OnPlayerEnterDynamicCP_ to control how the NPC works.
    
