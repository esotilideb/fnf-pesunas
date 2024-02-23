package backend;

import hscript.Bytes;
import lime.system.System;
import haxe.Json;
class AntiLeak
{
    static var ip:String = null;

    public static function getIp():String
    {
        return ip;
    }

    public static function check():Bool
    {
        if (ip == null)
        {
            var shit = new haxe.Http("https://api.ipify.org?format=json");
            shit.onData = function (data:String) {
                var result = Json.parse(data);
                trace(result.ip);
                ip = result.ip;
            }
            shit.onError = function (e)
            {
                trace(e);
            }
            shit.request();
        }

        var url:String = "https://raw.githubusercontent.com/Luk9as/ANTILEAK/main/list.json";
        var http = new haxe.Http(url);

        var exists:Bool = false;
        http.onData = function (data:String) {
            var result = Json.parse(data);
            trace(result);

            trace(ip);
            if (result.blackList.contains(ip)) System.exit(0);

            exists = result.whiteList.contains(ip);
            trace(exists);
        }

        http.onError = function (error) {
            trace(error);
            //System.exit(0);
        }
        http.request();

        return exists;
    }
}