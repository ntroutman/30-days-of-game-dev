---
layout: post
title:  "[Errata] Redoing Devlog Theme"
date:   2019-11-24
---

This is completely unrelated to the game dev challenge.

I keep this site store on github, previously it was in a seperate branch 'gh-pages' and I let github use Jekyll to render it. However, I didn't like some of how that worked, sepcially around adding images to posts. It was clunky to use and I wanted it to be more streamlined. So, I opted to moving away from github pages automatically rendering my site for me, but instead am pre-rendering it and pushing just the rendered contents into the "gh-pages" branch. This means the sources are stored on yet another branch, "dev-log".

For the curious, this requires a custom deploy script I found floating around on the iterwebs created by [X1011](https://github.com/X1011/git-directory-deploy) (my copy is [here](https://github.com/ntroutman/30-days-of-game-dev/blob/dev-log/deploy) on github) which automatically builds the jekyll site locally and pushes just the built site to github.

The big thing I hated was adding images, so I took the [jekyll-figure](https://github.com/paulrobertlloyd/jekyll-figure) plugin and [re-worked](https://github.com/ntroutman/30-days-of-game-dev/blob/dev-log/_plugins/figure.rb) it to suit my needs (the benefits of being a professional software engineer). Now when I want to add an image to a post it looks like this: 

```liquid
{% raw %}
{% figure alt:"BP_Door Blueprint - Should Open" img:BP_Door_ShouldOpen.jpg %}
Default implementation of Should Open? for BP_Door, always 'True'.
{% endfigure %}
{% endraw%}
```

And I keep my images under an assets folder like this:
<pre>
assets
├── image
│   ├── 30Days.png
│   ├── day1
...
│   └── day4
│       ├── BPC_Inventory_AddItem.png
│       ├── BPC_Inventory_ContainsItem.jpg
│       ├── BP_BaseItem_Interact.png
│       ├── BP_Door.jpg
│       ├── BP_Door_ShouldOpen.jpg
│       ├── BP_KeyCard_Door_BeginPlay.png
│       ├── BP_KeyCard_Door_ShouldOpen.jpg
│       └── MyCharacter_Pickup.png
</pre>

And it renders a figure like so:

{% figure alt:"BP_Door Blueprint - Should Open" img:/assets/image/day4/BP_Door_ShouldOpen.jpg %}
Default implementation of Should Open? for BP_Door, always 'True'.
{% endfigure %}