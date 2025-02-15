---
layout: post
title:  "Day 2: Interact with a door to open it"
date:   2019-10-26
---

This seemed like it should be simple. Click on the door, it rotates. Simple, right. But, wrong. After futzing about myself and coming up with the below:

![My start to a door blueprint]DoorBlueprintStart.png)

I gave up and I looked up a tutorial on google and found this:

https://www.youtube.com/watch?v=dvRmx8fCgSM


Made perfect sense, seemd straight forward, implemented it. Then spent 3 hours trying to debug the stupid thing. I couldn't walk through the door, open or closed. I thought it was an issue with the door frame not have the right collisions, but despite what I tried I couldn't get thigs working. Also, pro tip, when Enabling and Disabling Input for a blueprint, definitely don't forget to set which player controller you are enabling input for, otherwise your blueprint won't recieve any events. It will be infuriating, trust me I know.

![Setting player controller on Enable/Disable Input in blueprint](day2/EnableDisableInputPlayerController.jpg)

After giving up and going to bed I googled "ue 4 collision mesh" only to discover ue4 does collisions completely differently than unity (the only other engine I have any experience with, and its pretty minimal). So given that, its time to dive back in and try looking at the actual collision meshes that are part of the static mesh.

Turns out the issue wasn't the collision mesh (though the door needed one), it was the navigation mesh. In the image below you can see how on the absurdly wide door does show a green path through, but the normal sized one doesn't:

![Navmesh issue](day2/NavmeshIssue.jpg)

To help that I decreased the tile size in the Navigation Mesh settings. That alone didn't fix it all, I also had to turn on the realtime rebuilding of the nav mesh, also in the Project Settings.

![Navmesh working](day2/WorkingNavMesh.jpg)

In the end it finally works.
