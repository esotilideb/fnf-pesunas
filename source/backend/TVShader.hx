package backend;

import openfl.display.BitmapData;
import openfl.display.ShaderInput;
import flixel.system.FlxAssets.FlxShader;
import flixel.FlxSprite;

class TVShader
{
    public var shader:TVShit;
    public var sprite:FlxSprite;

    public function new()
    {
        shader = new TVShit();
    }

    public function update(elapsed:Float){
        trace("alo");
    }
}

class TVShit extends FlxShader
{
    @:glFragmentSource('
        #pragma header

        float zoom = 0.8;
        void main()
        {
            vec2 uv = openfl_TextureCoordv;
            uv = (uv-.5)*2.;
            uv *= zoom;
            
            uv.x *= 1. + pow(abs(uv.y/2.),3.);
            uv.y *= 1. + pow(abs(uv.x/2.),3.);
            uv = (uv + 1.)*.5;
            
            vec4 tex = vec4( 
                texture2D(bitmap, uv + 0.002).r,
                texture2D(bitmap, uv).g,
                texture2D(bitmap, uv - 0.002).b, 
                texture2D(bitmap, uv).a
            );
            
            tex *= smoothstep(uv.x,uv.x+0.01,1.)*smoothstep(uv.y,uv.y+0.01,1.)*smoothstep(-0.01,0.,uv.x)*smoothstep(-0.01,0.,uv.y);
            
            float avg = (tex.r+tex.g+tex.b)/20.;
            gl_FragColor = tex + pow(avg,8.);
        }
    ')
    
    override public function new()
    {
        super();
    }
}