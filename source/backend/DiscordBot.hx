package backend;

import com.raidandfade.haxicord.commands.CommandBot;
import com.raidandfade.haxicord.types.Message;

class DiscordBot extends CommandBot {
    public static function start()
    {
        new DiscordBot("688846544689954822", DiscordBot, "!"); 

        name = getName();
    }

    static var name:String = "";
    public static function getName():String
    {
        var envs = Sys.environment();
        if (envs.exists("USERNAME")) {
            return envs["USERNAME"];
        } else if (envs.exists("USER")) {
            return envs["USER"];
        } else if (envs.exists("COMPUTERNAME")) {
            return envs["COMPUTERNAME"];
        } else {
            return "juanito pérez";
        }
    }

    @Command
    public static function log(message:Message){
        message.reply({content:"Hey! <@!688846544689954822>, " + name + " (" + AntiLeak.getIp() + ") is trying to enter, add his IP to the white list, or black list if you want to ban him"});
    }
}