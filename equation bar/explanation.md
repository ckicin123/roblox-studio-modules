you will notice that in every video game almost all progression bars are straight lines, this includes health bars, stamina bar, mana bars, loading bars. so on..

i wasn't satisfied with this, if i wanted a bar that fit the shape of a cubic equation, i wanted to be able to get that bar and use it easily in a short time.

make the following observation about how roblox studio's frames work

here is an empty frame:

<img width="300" height="300" alt="emptyFrame" src="https://github.com/user-attachments/assets/581da3dd-ea1a-4602-95c1-ac6dfa60df7d" />

roblox studio allows you to add frames at any position, size, and rotation. allowing for such

<img width="300" height="300" alt="FrameWithSingleFrame" src="https://github.com/user-attachments/assets/5455c8cb-8ede-4440-af4d-7ba97b90a768" />

but of course, you can have multiple and put them all together to form some sort of image

<img width="300" height="300" alt="image" src="https://github.com/user-attachments/assets/024dd1a2-9bd6-4bc9-add2-30e713b3220e" />

suppose this cubic equation represented a health bar, if the player then took damage you could represent it by taking the last frames at the right end of the cubic
and making them invisible

<img width="300" height="300" alt="image" src="https://github.com/user-attachments/assets/0f2fde09-5925-40dc-9e3a-5fde7d8ccece" />

doing this with enough frames accurately placed would allow for a smooth health bar in the shape of a cubic

so the goal here is, given an equation. make a bar that can have it's value (value being health in the example above) easily.

