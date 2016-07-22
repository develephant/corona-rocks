## LuaRocks with Corona SDK

It's not perfect, but if you'd like to add a little [LuaRocks](https://luarocks.org) in to your __Corona SDK__ dev, it's possible, with a little configuration wrangling.

Nothing to make this work is outside of the standard configuration options available to LuaRocks, though there are a few caveats.

### Don't Path Me In
The big roadblock with using LuaRocks and Corona SDK "normally" are two things; Resolving the module paths, and compiling of the more complicated "rocks".

There isn't too much we can do about the latter. Some __rocks__ require additional compilation than just a plain Lua module. You'll need to test, especially on devices, to be sure that you'll be able to use a particular __rock__.

> Most "pure" Lua rocks should work, unless the developer decided to get creative.

### Module Mud

The only way to work out the pathing issue, is to customize the LuaRocks installation, and creation paths. By doing this, LuaRocks still operates as it usually would. ___The downside is that all of the modules live in the root directory of the project.___ Kind of a bummer, but that's what it is. It would be nice to at least have the module files in directories, but I have not been able to figure that out yet. Maybe someone else will have input.

### Script Installation

With __[this handy script](https://github.com/develephant/corona-rocks)__ (currently only available for MacOS, maybe someone can pitch in a Windows one. :) ) placed __in your project root__, can install a local LuaRocks instance and generate the configuration file.

> Be sure you are in your project root when using LuaRocks.

 - Run `./corona-rocks.sh` from the command line.

If it doesn't run, you may need to make it executable, enter:

    > sudo chmod a+x corona-rocks.sh

And then try running it again: `./corona-rocks.sh`

The installer should only take a few seconds. After it's done, you can start using LuaRocks:

    > ./luarocks install moses

    > ./luarocks remove moses

    > ./luarocks search objects

## Things to note:

  - You must be in your project root when working with the local LuaRocks instance.
  - Make sure to place a dot-slash in front of the command, this is the correct usage: `./luarocks`, not `luarocks`. If you forget the dot-slash you may run a system wide version, which won't do you much good.
  - While not ideal, modules are installed in the root directory. Don't move them. If you want to remove a LuaRocks module, use: `./luarocks remove <mod_name>`.
  - You can copy, and run, the `corona-rocks.sh` script in any Corona SDK project folder to add LuaRocks.
