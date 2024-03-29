--Script creado por Roval, autorizo su uso para otros mods si me dan creditos :p
-- NO PERMITO SUBIR MI SCRIPT A GB O GAMEJOLT, ya lo hare cuando este mejor adaptado
-- Si tienes alguna duda con el script puedes hablaarme por discord: Roval

-------------Parte del Script que si puedes modificar dependiendo que necesites---------------------------
int = 30; -- INTENSIDAD DE MOVIMIENTO DE CAMARA, mas = intenso
opacidadhud = 1; -- La opacidad del hud que tiene AL INICIO DE LA CANCION, luego lo cambias con el evento "hudz" o "hud"
zoomextra = 0.25; --Coloca con cuanto zoom extra quieres que inicie la cancion, el predeterminado de extra es 0 (solo el que tiene el stage)
velcaminicio = 1; --A que velocidad de camara inicias la cancion, el predeterminado es 1
seguircamara = true; -- ACTIVA O DESACTIVA LA CAMARA ACTIVA, false = desactivado
mediocamara = true; -- ACTIVA O DESACTIVA - true = camara empieza desde el medio, luego tienes que cambiarlo con el evento "p" para que sea normal
showcasemode = false; -- SI ACTIVAS EL MODO SHOWCASE SE ELIMINA PUNTACION, BARRA DE TIEMPO Y EL SCORE -- Para subir videos con poco hud
saltearcontador = true; -- Saltear el contador del inicio de la cancion, puede generar bugs asi que no recomiendo usarlo tanto xd
pantallanegra = false; -- ACTIVA O DESACTIVA - true = la pantalla esta negra y con el evento "flash" o "flashz" lo quitas, pero despues cambia el color a blanco para que funcione como flash
opacidadflash = 1 -- SI ACTIVAS PANTALLA NEGRA, COMO QUIERES QUE EMPIECE EL FLASH NEGRO

dadx1 = 0; --Eje X de camara de dad (Menos = Izquierda  Mas = Derecha)
dady1 = 0; --Eje Y de camara de dad (Menos = Arriba  Mas = Abajo)
bfx1 = -170; --Eje X de camara de bf (Menos = Izquierda  Mas = Derecha)
bfy1 = 120; --Eje Y de camara de bf (Menos = Arriba  Mas = Abajo)
gfx1 = 0; --Eje X de camara de gf (Menos = Izquierda  Mas = Derecha) Recomiendo usarlo para otra posicion de camara extra si gf no canta
gfy1 = 0; --Eje Y de camara de gf (Menos = Arriba  Mas = Abajo) Recomiendo usarlo para otra posicion de camara extra si gf no canta
centrox1 = 0;
centroy1 = 0;


---------Parte necesaria del Script que no debes tocar excepto que le sepas------

si = 0; --Switch que activa o desactiva cierto evento
si2 = 0; --Switch que activa o desactiva cierto evento
si3 = 0; --Switch que activa o desactiva cierto evento
sibf = 0; --Switch que activa o desactiva cierto otro evento
sigf = 0; --Switch que activa o desactiva cierto otro evento
sidad = 0; --Switch que activa o desactiva cierto otro evento

dadx = getMidpointX('dad') + (getProperty('dad.cameraPosition[0]') - getProperty('opponentCameraOffset[0]')) + 175 + dadx1
dady = getMidpointY('dad') + (getProperty('dad.cameraPosition[1]') - getProperty('opponentCameraOffset[1]')) - 100 + dady1
bfx = getMidpointX('boyfriend') + (getProperty('boyfriend.cameraPosition[0]') - getProperty('boyfriendCameraOffset[0]')) - 150 + bfx1
bfy = getMidpointY('boyfriend') + (getProperty('boyfriend.cameraPosition[1]') - getProperty('boyfriendCameraOffset[1]')) - 100 + bfy1
gfx = getMidpointX('gf') + (getProperty('gf.cameraPosition[0]') - getProperty('girlfriendCameraOffset[0]')) + 0 + gfx1
gfy = getMidpointY('gf') + (getProperty('gf.cameraPosition[1]') - getProperty('girlfriendCameraOffset[1]')) - 100 + gfy1
centrox = ((dadx + bfx)/2 + centrox1) ; --Eje X de camara medio entre dad y bf
centroy = ((dady + bfy)/2 + centroy1) ; --Eje Y de camara medio entre dad y bf

if mediocamara == true then

    xx = centrox;
    yy = centroy;
    xx2 = centrox;
    yy2 = centroy;
    xx3 = centrox;
    yy3 = centroy;
else
    xx = dadx;
    yy = dady;
    xx2 = bfx;
    yy2 = bfy;
    xx3 = gfx;
    yy3 = gfy;
end
del = 0;
del2 = 0;
-----------





if saltearcontador == true then
    function onCreate() -- Por cierto, si al activar esto y al iniciar la song por primera vez el audio esta bug, mejor desactiva esto :p
        setProperty('skipCountdown', true)
    end
end

--Aca te dejo un listado de todos eases/transiciones, puedes buscar en google como funciona cada uno de ellos
tiposease = {"linear","quadIn","quadOut","quadInOut","cubeIn","cubeOut","cubeInOut","quartIn","quartOut","quartInOut","quintIn","quintOut","quintInOut","sineIn","sineOut","sineInOut","bounceIn","bounceOut","bounceInOut","elasticIn","elasticOut","elasticInOut","backIn","backOut","backInOut"}
----------------------------------------------

function onCreatePost()
    zoom = getProperty('defaultCamZoom'); --Zoom que tiene el stage
    velocidad = getProperty('cameraSpeed'); --Velocidad al que va la camara - Se lo cambia con eventos o desde aca

    makeLuaSprite('negro', '', -100, -100); --lo puse negro pq en un principio lo estaba, pero lo cambie para mejor configuracion
    makeGraphic('negro', 1280*2, 720*2, 'FFFFFF');
    setScrollFactor('negro', 0, 0); --Set Scroll factor = Determina cuanto se mueve al mover la camara, con 0 no se mueve, con 1 se mueve mucho
    screenCenter('negro'); -- Lo coloca al centro
    setProperty('negro.alpha',0); --Es invisible hasta que lo actives
    addLuaSprite('negro', false); --Se ubica ATRAS de los personajes

    makeLuaSprite('flash', '', -100, -100); 
    makeGraphic('flash', 1280*2, 720*2, 'FFFFFF'); --Esto si es blanco p
    setScrollFactor('flash', 0, 0);
    screenCenter('flash');
    if pantallanegra == true then
        setProperty('flash.alpha',opacidadflash);
        setProperty('flash.colorTransform.greenOffset', -255)
        setProperty('flash.colorTransform.redOffset', -255)
        setProperty('flash.colorTransform.blueOffset', -255)
    else
        setProperty('flash.alpha',0); -- esta transparente
    end
    addLuaSprite('flash', true); --Se ubica ADELANTE de los personajes  


    if showcasemode == true then
        setProperty('scoreTxt.visible', false);
        setProperty('timeBar.visible', false);
        setProperty('timeBarBG.visible', false);
        setProperty('timeTxt.visible', false);       
    end

    if zoomextra == 0 then
        setProperty('defaultCamZoom', zoom)  
    else
        doTweenZoom('zoomtween', 'camGame', zoom + zoomextra, 0.001, 'linear')
        setProperty('defaultCamZoom', (zoom + zoomextra))  
    end

    if opacidadhud == 1 then
    else
        doTweenAlpha('camaaHUD', 'camHUD', opacidadhud, 0.001)
    end

    if velcaminicio == 1 then
    else
        setProperty('cameraSpeed', velcaminicio);
    end

    makeLuaSprite('luz', 'luz', -400, 400)
    setGraphicSize('luz', 2000, 400)
    setScrollFactor('luz', 0, 0.75)
    setProperty('luz.alpha', 0)
    setObjectCamera("luz", 'hud');
    updateHitbox('luz')
    addLuaSprite('luz', true)

    makeLuaText('texto', '', 1000, -180, 500)
    setTextFont('texto', 'mario.ttf') --LA FUENTE QUE SE USA
    setTextColor('texto', 'f1f348') --AJUSTAS EL COLOR DEL TEXTO EN DAD
    setTextSize('texto', 50); -- EL TAMANO DE LA LETRA
    setTextAlignment('texto', 'center')
    setObjectCamera("texto", 'hud');
    addLuaText('texto')

    makeLuaText('textob', '', 1000, 140, 500)
    setTextFont('textob', 'vcr.ttf') --LA FUENTE QUE SE USA
    setTextColor('textob', '83d5f2') --AJUSTAS EL COLOR DEL TEXTO EN MEDIO
    setTextSize('textob', 40); -- EL TAMANO DE LA LETRA
    setTextAlignment('textob', 'center')
    setObjectCamera("textob", 'hud');
    addLuaText('textob')

    makeLuaText('textoc', '', 1000, 460, 500)
    setTextFont('textoc', 'vcr.ttf') --LA FUENTE QUE SE USA
    setTextColor('textoc', 'BFBFBF') --AJUSTAS EL COLOR DEL TEXTO EN BF
    setTextSize('textoc', 40); -- EL TAMANO DE LA LETRA
    setTextAlignment('textoc', 'center')
    setObjectCamera("textoc", 'hud');
    addLuaText('textoc')

    strumYOrigin = getPropertyFromGroup('strumLineNotes', 0, 'y') --Saca el valor de la Y
    strumXOrigin = getPropertyFromGroup('strumLineNotes', 0, 'x') --Saca el valor de la X



    if mediocamara == true then
        setProperty('camFollow.x', centrox)
        setProperty('camFollow.y', centroy)
        setProperty('camera.target.x', centrox)
        setProperty('camera.target.y', centroy)
        setProperty('isCameraOnForcedPos', true);
    end
end



function onEvent(n,v1,v2)

    if n == "Change Character" then
        dadx = getMidpointX('dad') + (getProperty('dad.cameraPosition[0]') - getProperty('opponentCameraOffset[0]')) + 175 + dadx1
        dady = getMidpointY('dad') + (getProperty('dad.cameraPosition[1]') - getProperty('opponentCameraOffset[1]')) - 100 + dady1
        bfx = getMidpointX('boyfriend') + (getProperty('boyfriend.cameraPosition[0]') - getProperty('boyfriendCameraOffset[0]')) - 150 + bfx1
        bfy = getMidpointY('boyfriend') + (getProperty('boyfriend.cameraPosition[1]') - getProperty('boyfriendCameraOffset[1]')) - 100 + bfy1
        gfx = getMidpointX('gf') + (getProperty('gf.cameraPosition[0]') - getProperty('girlfriendCameraOffset[0]')) + 0 + gfx1
        gfy = getMidpointY('gf') + (getProperty('gf.cameraPosition[1]') - getProperty('girlfriendCameraOffset[1]')) - 100 + gfy1
        xx = dadx
        yy = dady
        xx2 = bfx
        yy2 = bfy
        xx3 = gfx
        yy3 = gfy
        centrox = (bfx + dadx) / 2
        centroy =  (bfy + dady) / 2
    end

    if n == "roval" then

        if v1 == 'extra' then
            local coso = split(v2,",")            
            camarachar = (coso[1])
            extrax = tonumber(coso[2])
            extray = tonumber(coso[3])

            if camarachar == 'bf' or camarachar == 'boyfriend' or camarachar == 'c' or camarachar == 'player' or camarachar == 'jugador' then
                bfx1 = extrax
                bfy1 = extray
            end
            
            if camarachar == 'gf' or camarachar == 'girlfriend' or camarachar == 'b' then
                gfx1 = extrax
                gfy1 = extray
            end

            if camarachar == 'dad' or camarachar == 'a' or camarachar == 'opponent' or camarachar == 'oponente' or  camarachar == 'rival' or camarachar == 'enemy' then
                dadx1 = extrax
                dady1 = extray
            end

            dadx = getMidpointX('dad') + (getProperty('dad.cameraPosition[0]') - getProperty('opponentCameraOffset[0]')) + 175 + dadx1
            dady = getMidpointY('dad') + (getProperty('dad.cameraPosition[1]') - getProperty('opponentCameraOffset[1]')) - 100 + dady1
            bfx = getMidpointX('boyfriend') + (getProperty('boyfriend.cameraPosition[0]') - getProperty('boyfriendCameraOffset[0]')) - 150 + bfx1
            bfy = getMidpointY('boyfriend') + (getProperty('boyfriend.cameraPosition[1]') - getProperty('boyfriendCameraOffset[1]')) - 100 + bfy1
            gfx = getMidpointX('gf') + (getProperty('gf.cameraPosition[0]') - getProperty('girlfriendCameraOffset[0]')) + 0 + gfx1
            gfy = getMidpointY('gf') + (getProperty('gf.cameraPosition[1]') - getProperty('girlfriendCameraOffset[1]')) - 100 + gfy1
            xx = dadx
            yy = dady
            xx2 = bfx
            yy2 = bfy
            xx3 = gfx
            yy3 = gfy
            centrox = (bfx + dadx) / 2
            centroy =  (bfy + dady) / 2
        end

        if v1 == 'a' then
            setProperty('camFollow.x', dadx)
            setProperty('camFollow.y', dady)
            setProperty('camera.target.x', dadx)
            setProperty('camera.target.y', dady)
            setProperty('isCameraOnForcedPos', true);
            xx = dadx
            yy = dady
            xx2 = dadx
            yy2 = dady
            xx3 = dadx
            yy3 = dady
        end

        if v1 == 'ab' or v1 == 'ba' then
            xx = (dadx + centrox)/2
            yy = (dady + centroy)/2
            xx2 = (dadx + centrox)/2
            yy2 = (dady + centroy)/2
            xx3 = (dadx + centrox)/2
            yy3 = (dady + centroy)/2
        end
        
        if v1 == 'b' then
            setProperty('camFollow.x', centrox)
            setProperty('camFollow.y', centroy)
            setProperty('camera.target.x', centrox)
            setProperty('camera.target.y', centroy)
            setProperty('isCameraOnForcedPos', true);
            xx = centrox
            yy = centroy
            xx2 = centrox
            yy2 = centroy
            xx3 = centrox
            yy3 = centroy
        end

        if v1 == 'cb' or v1 == 'bc' then
            xx = (bfx + centrox)/2
            yy = (bfy + centroy)/2
            xx2 = (bfx + centrox)/2
            yy2 = (bfy + centroy)/2
            xx3 = (bfx + centrox)/2
            yy3 = (bfy + centroy)/2
        end

        if v1 == 'c' then
            setProperty('camFollow.x', bfx)
            setProperty('camFollow.y', bfy)
            setProperty('camera.target.x', bfx)
            setProperty('camera.target.y', bfy)
            setProperty('isCameraOnForcedPos', true);
            xx = bfx
            yy = bfy
            xx2 = bfx
            yy2 = bfy
            xx3 = bfx
            yy3 = bfy
        end

        if v1 == 'g' then
            xx = gfx
            yy = gfy
            xx2 = gfx
            yy2 = gfy
            xx3 = gfx
            yy3 = gfy
        end

        if v1 == 'p' then
            setProperty('isCameraOnForcedPos', false);
            xx = dadx
            yy = dady
            xx2 = bfx
            yy2 = bfy
            xx3 = gfx
            yy3 = gfy
        end
        
        if v1 == 'boomzoom' then
            if v2 == '' then
                zoomboom = 1
            else
                zoomboom = v2
            end
            setProperty('camZoomingMult', zoomboom)
        end

        if v1 == 'aa' then
            setProperty('cameraSpeed', 999)
            setProperty('camFollow.x', dadx)
            setProperty('camFollow.y', dady)
            setProperty('camera.target.x', dadx)
            setProperty('camera.target.y', dady)
            xx = dadx
            yy = dady
            xx2 = dadx
            yy2 = dady
            xx3 = dadx
            yy3 = dady
            runTimer('fininstacam', 0.08)
        end

        if v1 == 'bb' then
            setProperty('cameraSpeed', 999)
            setProperty('camFollow.x', centrox)
            setProperty('camFollow.y', centroy)
            setProperty('camera.target.x', centrox)
            setProperty('camera.target.y', centroy)
            setProperty('isCameraOnForcedPos', true);
            xx = centrox
            yy = centroy
            xx2 = centrox
            yy2 = centroy
            xx3 = centrox
            yy3 = centroy
            runTimer('fininstacam', 0.08)
        end

        if v1 == 'cc' then
            setProperty('cameraSpeed', 999)
            setProperty('camFollow.x', bfx)
            setProperty('camFollow.y', bfy)
            setProperty('camera.target.x', bfx)
            setProperty('camera.target.y', bfy)
            xx = bfx
            yy = bfy
            xx2 = bfx
            yy2 = bfy
            xx3 = bfx
            yy3 = bfy
            runTimer('fininstacam', 0.08)
        end

        if v1 == 'gg' then
            setProperty('cameraSpeed', 999)
            setProperty('camFollow.x', gfx)
            setProperty('camFollow.y', gfy)
            setProperty('camera.target.x', gfx)
            setProperty('camera.target.y', gfy)
            xx = gfx
            yy = gfy
            xx2 = gfx
            yy2 = gfy
            xx3 = gfx
            yy3 = gfy
            runTimer('fininstacam', 0.08)
        end

        if v1 == 'canta' then --Activar para cambiar el texto de karaoke
            if v2 == '' then
                textito = '' --Si no escribes nada borras el texto
            else
                textito = v2
            end
            setTextString('texto',  '' .. textito)
        end

        if v1 == 'cantab' then --Activar para cambiar el texto de karaoke - Segundo texto
            if v2 == '' then
                textitob = '' --Si no escribes nada borras el texto
            else
                textitob = v2
            end
            setTextString('textob',  '' .. textitob)
        end

        if v1 == 'cantac' then --Activar para cambiar el texto de karaoke - Segundo texto
            if v2 == '' then
                textitoc = '' --Si no escribes nada borras el texto
            else
                textitoc = v2
            end
            setTextString('textoc',  '' .. textitoc)
        end

        if v1 == 'cantacolor' then --Cambia el color
            local colortx = split(v2,",")            
            letras = (colortx[1])
            colorr = (colortx[2])

            if letras == '' then
                letras = 'a'
            end

            if colorr == '' then
                colorr = 'ffffff'
            end

            if letras == 'a' then
                setTextColor('texto', colorr) --AJUSTAS EL COLOR DEL TEXTO EN DAD
            end
            if letras == 'b' then
                setTextColor('textob', colorr) --AJUSTAS EL COLOR DEL TEXTO EN DAD
            end
            if letras == 'c' then
                setTextColor('textoc', colorr) --AJUSTAS EL COLOR DEL TEXTO EN DAD
            end
        end
        

        if v1 == 'velcam' then --Ajusta la velocidad del movimiento de la camara - 1 solo valor en Value2
            if v2 == '' then
                velocidad = 1 --Si no escribes nada el predeterminado siempre es 1
            else
                velocidad = v2
            end
            setProperty('cameraSpeed', velocidad)
        end


        if v1 == 'fondo' then --Ajustar opacidad del fondo atras de los personajes, en value2 puedes modificar el tiempo en el que se vuelve asi
            if v2 == '' then
                opacidad = 0 --Si no colocas nada en v2 la velocidad predeterminada es 0 (Invisible)
            else
                opacidad = v2
            end
            doTweenAlpha('negro', 'negro', opacidad, 0.13)
        end

        if v1 == 'fondoz' then --Ajustar opacidad y tiempo del fondo atras de los personajes, ejemplo: 0.45,0.01 
            local fondoz = split(v2,",")            
            fopacidad = tonumber(fondoz[1])
            ftiempoz = tonumber(fondoz[2])   

            if fopacidad == '' then         --Si no colocas nada en v2 la opacidad predeterminada es 0 (Invisible)
                fopacidad = 0
            end

            if ftiempoz == '' then         -- No escribes tiempo, el predeterminado es 0.13
                ftiempoz = 0.13 
            end
            doTweenAlpha('negro', 'negro', fopacidad, ftiempoz)
        end

        if v1 == 'fondon' then --Fondo oscuro atras de los personajes, en value2 puedes modificar el tiempo en el que se vuelve asi
            if v2 == '' then
                velfondo = 0.13 --Si no colocas nada en v2 la velocidad predeterminada es 0.13
            else
                velfondo = v2
            end
            setProperty('negro.colorTransform.greenOffset', -255)
            setProperty('negro.colorTransform.redOffset', -255)
            setProperty('negro.colorTransform.blueOffset', -255)
            if si == 0 then
                doTweenAlpha('negro', 'negro', 0.45, velfondo)
                doTweenAlpha('camHUD', 'camHUD', 0.7, velfondo)
                si = 1
            else
                doTweenAlpha('negro', 'negro', 0, velfondo)
                doTweenAlpha('camHUD', 'camHUD', 1, velfondo)
                si = 0
            end
        end

        if v1 == 'beathud' then --Mover hud con beat
            if v2 == '' then
                beatt = 8 --Si no colocas nada en v2 el beat sera 8
            else
                beatt = v2
            end

            if si3 == 0 then
                si3 = 1
            else
                si3 = 0
            end
        end

        if v1 == 'bfcolor' then --Cambiar de color a bf (No tan piola como el 0.7)
            local bfcolorz = split(v2,",")            -- Ejemplo: ff0ff0,3            <--- Cambia de color en 3 segundos
            bfcolor = (bfcolorz[1])
            bftiempo = tonumber(bfcolorz[2])   

            if bfcolor == '' then         -- Se vuelve negro si no haces nada D:
                bfcolor = '000000'  --Colocar ffffff en el color para que vuelva a la normalidad
            end

            if bftiempo == '' then         -- No escribes tiempo, el predeterminado es 0.01
                bftiempo = 0.01
            end
            doTweenColor('bf', 'boyfriend', bfcolor, bftiempo, 'linear')
            runTimer('sibf', bftiempo)
        end

        if v1 == 'gfcolor' then --Cambiar de color a gf (No tan piola como el 0.7)
            local gfcolorz = split(v2,",")            -- Ejemplo: ff0ff0,3            <--- Cambia de color en 3 segundos
            gfcolor = (gfcolorz[1])
            gftiempo = tonumber(gfcolorz[2])   

            if gfcolor == '' then         -- Se vuelve negro si no haces nada D:
                gfcolor = '000000'  --Colocar ffffff en el color para que vuelva a la normalidad
            end

            if gftiempo == '' then         -- No escribes tiempo, el predeterminado es 0.01
                gftiempo = 0.01
            end
            doTweenColor('gif', 'gf', gfcolor, gftiempo, 'linear')
            runTimer('sigf', gftiempo)
        end

        if v1 == 'dadcolor' then --Cambiar de color a dad (No tan piola como el 0.7)
            local dadcolorz = split(v2,",")            -- Ejemplo: ff0ff0,3            <--- Cambia de color en 3 segundos
            dadcolor = (dadcolorz[1])
            dadtiempo = tonumber(dadcolorz[2])   

            if dadcolor == '' then         -- Se vuelve negro si no haces nada D:
                dadcolor = '000000'  --Colocar ffffff en el color para que vuelva a la normalidad
            end

            if dadtiempo == '' then         -- No escribes tiempo, el predeterminado es 0.01
                dadtiempo = 0.01
            end
            doTweenColor('viejoo', 'dad', dadcolor, dadtiempo, 'linear')
            runTimer('sidad', dadtiempo)
        end

        if v1 == 'charcolor' then --Cambiar de color a cualquier personaje (No tan piola como el 0.7)
            local charcolorz = split(v2,",")            -- Ejemplo: pedrito,ff0ff0,3            <--- Cambia de color a pedritoen 3 segundos
            char = (charcolorz[1])       -- el  Character puede ser uno extra o un sprite del escenario incluso pero solo puede ser 1 a la vez
            charcolor = (charcolorz[2])   
            chartiempo = tonumber(charcolorz[3])   

            if charcolor == '' then         -- Se vuelve negro si no haces nada D:
                charcolor = '000000'  --Colocar ffffff en el color para que vuelva a la normalidad
            end

            if chartiempo == '' then         -- No escribes tiempo, el predeterminado es 0.01
                chartiempo = 0.01
            end
            doTweenColor('olaola', char, charcolor, chartiempo, 'linear')
            runTimer('si2', chartiempo)
        end

        if v1 == 'fcolor' then --Cambiar de color el fondo por el que te de la gana - Lo contrarresta el fondon al cambiarlo por negro siempre
            if v2 == '' then
                fcolor = '000000' -- Se vuelve negro si no escribes nada
            else
                fcolor = v2 --El color que escribas es en HEX o hexadecimal, se escribe 6 digitos (puede ser minuscula creo)
            end
            local rojo, verde, azul = hex_rgb(fcolor)

            setProperty('negro.colorTransform.greenOffset', (-verde))
            setProperty('negro.colorTransform.redOffset', (-rojo))
            setProperty('negro.colorTransform.blueOffset', (-azul))
        end

        if v1 == 'flcolor' then --Cambiar de color el flash
            if v2 == '' then
                flcolor = 'FFFFFF' -- Se vuelve blanco si no escribes nada
            else
                flcolor = v2 --El color que escribas es en HEX o hexadecimal, se escribe 6 digitos (puede ser minuscula creo)
            end
            local rojo, verde, azul = hex_rgb(flcolor)

            setProperty('flash.colorTransform.greenOffset', (-verde))
            setProperty('flash.colorTransform.redOffset', (-rojo))
            setProperty('flash.colorTransform.blueOffset', (-azul))
        end

        if v1 == 'fcolorz' then --Cambiar de color el fondo en X tiempo - Lo contrarresta fondon al cambiarlo por negro siempre
            local fcolorz = split(v2,",")            
            fcolor = (fcolorz[1])
            ftiempo = tonumber(fcolorz[2])   

            if fcolor == '' then         -- Se vuelve negro si no escribes nada
                fcolor = '000000'
            end

            if ftiempo == '' then         -- No escribes tiempo, el predeterminado es 0.01
                ftiempo = 0.01
            end

            doTweenColor('fcoloro', 'negro', fcolor, ftiempo, 'linear')
        end

        if v1 == 'flcolorz' then --Cambiar de color el flash en X tiempo
            local flcolorz = split(v2,",")            
            flcolor = (flcolorz[1])
            fltiempo = tonumber(flcolorz[2])   

            if flcolor == '' then         -- Se vuelve blanco si no escribes nada
                flcolor = 'FFFFFF'
            end

            if fltiempo == '' then         -- No escribes tiempo, el predeterminado es 0.01
                fltiempo = 0.01
            end
            doTweenColor('flcoloro', 'flash', flcolor, fltiempo, 'linear')
        end

        if v1 == 'luzcolorz' then --Cambiar de color el fondo en X tiempo - Lo contrarresta fondon al cambiarlo por negro siempre
            local luzcolorz = split(v2,",")            
            luzcolor = (luzcolorz[1])
            luztiempoo = tonumber(luzcolorz[2])   

            if luzcolor == '' then         -- Se vuelve blanco si no escribes nada
                luzcolor = 'FFFFFF'
            end

            if luztiempoo == '' then         -- No escribes tiempo, el predeterminado es 0.01
                luztiempoo = 0.01
            end
            doTweenColor('colorluz', 'luz', luzcolor, luztiempoo, 'linear')
        end

        if v1 == 'flash' then --Flash, Si no metes nada en value2 la duracion es 2.1 segundos (Solo ajustar velocidad si es necesario)
            if v2 == '' then
                flashtiempo = 1.9
            else
                flashtiempo = v2
            end
            opacidadflash = 0
            setProperty('flash.colorTransform.greenOffset', 0)
            setProperty('flash.colorTransform.redOffset', 0)
            setProperty('flash.colorTransform.blueOffset', 0)
            setProperty('flash.alpha',0.75);
            doTweenAlpha('flash', 'flash', opacidadflash, flashtiempo, 'linear')
        end

        if v1 == 'flashz' then --Flash complejo, se ajusta la opacidad y el tiempo en value2
            local flashero = split(v2,",")            
            opacidadflash = tonumber(flashero[1])   
            flashtiempo = tonumber(flashero[2])

            if opacidadflash == '' then         -- No escribes opacidad, el predeterminado es 0.7, no se recomienda que sea mas alto
                opacidadflash = 0.7
            end

            if flashtiempo == '' then         -- No escribes tiempo, el predeterminado es 0.2
                flashtiempo = 0.2
            end
            setProperty('flash.alpha',opacidadflash);
            doTweenAlpha('flash', 'flash', 0, flashtiempo, 'linear')
        end

        if v1 == 'flasho' then --Flash al reves, una transicion hacia la opacidad que elijas 
            local flasheroa = split(v2,",")            
            flashopacidada = tonumber(flasheroa[1])   
            flashtiempoa = tonumber(flasheroa[2])

            if flashopacidada == '' then         -- No escribes opacidad, el predeterminado es 0.7, no se recomienda que sea mas alto
                flashopacidada = 1
            end

            if flashtiempoa == '' then         -- No escribes tiempo, el predeterminado es 0.2
                flashtiempoa = 0.2
            end
            doTweenAlpha('flash', 'flash', flashopacidada, flashtiempoa, 'linear')
        end

        if v1 == 'luz' then     --Lucesita que sale abajo de los personajes, requiere la imagen adjunta al script, sin ella no funciona
            -- Recomiendo usarlo con fondo negro, con el value2 puedes cambiar en el que desaparece, sino es 1.2 segundos por predeterminado
            if v2 == '' then
                luztiempo = 1.2
            else
                luztiempo = v2
            end

            setProperty('luz.alpha',0.7);
            doTweenAlpha('luza', 'luz', 0, luztiempo, 'linear')
        end

        if v1 == 'luzz' then --Lucesita compleja, se ajusta la opacidad y el tiempo en value2 - ejemplo: 0.5,1    - Recuerda respetar comas
            local lucero = split(v2,",")            
            luzopacidad = tonumber(lucero[1])   
            luztiempo = tonumber(lucero[2])

            if luzopacidad == '' then         -- No escribes opacidad, el predeterminado es 0.7, no se recomienda que sea mas alto
                luzopacidad = 0.7
            end

            if luztiempo == '' then         -- No escribes tiempo, el predeterminado es 1.2
                luztiempo = 1.2
            end
            setProperty('luz.alpha',luzopacidad);
            doTweenAlpha('luza', 'luz', 0, luztiempo, 'linear')
        end

        if v1 == 'cam' then --Activa o desactiva el seguir camara con la nota, no se debe colocar nada en value 2
            if seguircamara == false then
                seguircamara = true
            else
                seguircamara = false
            end
        end

        if v1 == 'xdad' then
            dadx1 = v2
        end

        if v1 == 'ydad' then
            dady1 = v2
        end

        if v1 == 'xbf' then
            bfx1 = v2
        end

        if v1 == 'ybf' then
            bfy1 = v2
        end

        if v1 == 'xgf' then
            gfx1 = v2
        end

        if v1 == 'ygf' then
            gfy1 = v2
        end

        if v1 == 'visible' then --oculta o pone visible a los personajes
            if v2 == 'bf' or v2 == 'boyfriend' or v2 == 'player' or v2 == 'jugador' then
                if getProperty('boyfriend.visble') == false then
                    setProperty('boyfriend.visible', true)
                else
                    setProperty('boyfriend.visible', false)
                end
            end
            if v2 == 'gf' or v2 == 'girlfriend' then
                if getProperty('gf.visble') == false then
                    setProperty('gf.visible', true)
                else
                    setProperty('gf.visible', false)
                end
            end
            if v2 == 'dad' or v2 == 'opponent' or v2 == 'oponente' then
                if getProperty('dad.visble') == false then
                    setProperty('dad.visible', true)
                else
                    setProperty('dad.visible', false)
                end
            end
        end

        if v1 == 'zoom' then --Ajustar solo zoom agregado, 1 valor en value2 (zoom extra)
            if v2 == '' then -- ZOOM EXTRA: Zoom extra a la que tiene el stage, puede ser negativo, con 0 o nada vuelve al zoom del stage
                v2 = 0
            end
            doTweenZoom('zoomtween', 'camGame', zoom + v2, 0.2, 'linear')
            setProperty('defaultCamZoom', zoom + v2)  
        end

        if v1 == 'zooma' then --2 valores (Zoom agregado,Tiempo,Tipo de transicion), ejemplo: 0.5,3      Solo numeros negativos en zoomextra
            local zoomero = split(v2,",")            
            zoomextra = tonumber(zoomero[1])   
            zoomtiempo = tonumber(zoomero[2])

            if tonumber(zoomero[2]) == '' then         -- No escribes tiempo, el predeterminado es 0.2, para hacer instantaneo tiempo = 0.001
                zoomtiempo = 0.2
            end

            doTweenZoom('zoomtween', 'camGame', (zoom + zoomextra), zoomtiempo, 'linear')
            setProperty('defaultCamZoom', (zoom + zoomextra))  
        end

        if v1 == 'zoomz' then --Zoom mas complejo, 3 valores (Zoom agregado,Tiempo,Tipo de transicion), ejemplo: 0.2,5,backInOut
            local zumero = split(v2,",")       --Mismas reglas que la anterior
            zumextra = tonumber(zumero[1])
            zumtiempo = tonumber(zumero[2])
            zumtipo = (zumero[3])

            if tonumber(zumextra) == '' then --No creo que funcione//Si no escribes zoom extra el predeterminado es 0 (El que tiene el stage)
                zumextra = 0
            end

            if tonumber(zumero[2]) == '' then --Si no escribes tiempo el predeterminado es 0.2
                zumtiempo = 0.2
            end

            if zumtipo == '' then --Si no escribes transicion lo escribis mal el predeterminado el linear
                zumtipo = 'linear'
            end

            doTweenZoom('zoomtween', 'camGame', (zoom + zumextra), zumtiempo, zumtipo)
            setProperty('defaultCamZoom', (zoom + zumextra))  
        end


        if v1 == 'hud' then --ajusta opacidad del HUD - Simple (v2 = opacidad cambiada) 1 es 100% y 0 es 0% de opacidad
            if v2 == '' then --La opacidad es 1 si no escribes nada
                v2 = 1
            end
            opacidadhud = v2
            doTweenAlpha('camHUD', 'camHUD', opacidadhud, 0.12) --El tiempo predeterminado es 0.12s
        end

        if v1 == 'hudz' then
            local hudero = split(v2,",")            
            opacidadhud = tonumber(hudero[1])   
            hudtiempo = tonumber(hudero[2])
            if opacidadhud == '' then         -- No escribes opacidad, el predeterminado es 1
                opacidadhud = 1
            end
            if hudtiempo == '' then         -- No escribes tiempo, el predeterminado es 1.2
                hudtiempo = 1.2
            end
            doTweenAlpha('camHUD', 'camHUD', opacidadhud, hudtiempo)
        end

        if v1 == 'int' then --ajusta la distancia del movimiento de la camara (Intensidad) - Mas = mayor movimiento - Menos = Menor movimiento
            if v2 == '' then --Solo en value2, si no escribes nada el predeterminado es 30
                int = 30
            else
                int = v2
            end
        end

        if v1 == 'modcharty' then --Complejo - Hacer modchart por valor y (Arriba = mas - Abajo = menos)     - Tiene 3 valores
            --                                 con Downscroll va al reves (En vez de arriba, va para abajo)  - (Distancia, Tiempo, Transicion)
            --                      Ejemplo: 25,0.13,linear (Las flechas van para arriba en 0.13 en transicion linear)
            local mochary = split(v2,",")       
            distancia = tonumber(mochary[1]) --distancia puede ser negativo
            tiempomod = tonumber(mochary[2])
            transmod = (mochary[3])

            if tonumber(distancia) == '' then --No creo que funcione//Si no escribes el predeterminado es 0 (Reinicia a la altura normal)
                distancia = 0 
            end

            if distancia == '' then --No creo que funcione//Si no escribes el predeterminado es 0 (Reinicia a la altura normal)
                distancia = 0
            end

            if tonumber(mochary[2]) == '' then --Si no escribes tiempo el predeterminado es 0.15
                tiempomod = 0.15
            end

            if transmod == '' then --Si no escribes transicion lo escribis mal el predeterminado el linear
                transmod = 'linear'
            end

            if not downscroll then -- En downscroll pasa al reves para que sea simetrico
                for i = 0,7 do
                    for i = 0,7 do
                        noteTweenY('oppo0', 0, (strumYOrigin - distancia), tiempomod, transmod)
                        noteTweenY('oppo1', 1, (strumYOrigin - distancia), tiempomod, transmod)
                        noteTweenY('oppo2', 2, (strumYOrigin - distancia), tiempomod, transmod)
                        noteTweenY('oppo3', 3, (strumYOrigin - distancia), tiempomod, transmod)
                        noteTweenY('play0', 4, (strumYOrigin - distancia), tiempomod, transmod)
                        noteTweenY('play1', 5, (strumYOrigin - distancia), tiempomod, transmod)
                        noteTweenY('play2', 6, (strumYOrigin - distancia), tiempomod, transmod)
                        noteTweenY('play3', 7, (strumYOrigin - distancia), tiempomod, transmod)
                    end
                end
            else
                for i = 0,7 do
                    noteTweenY('oppo0', 0, (strumYOrigin + distancia), tiempomod, transmod)
                    noteTweenY('oppo1', 1, (strumYOrigin + distancia), tiempomod, transmod)
                    noteTweenY('oppo2', 2, (strumYOrigin + distancia), tiempomod, transmod)
                    noteTweenY('oppo3', 3, (strumYOrigin + distancia), tiempomod, transmod)
                    noteTweenY('play0', 4, (strumYOrigin + distancia), tiempomod, transmod)
                    noteTweenY('play1', 5, (strumYOrigin + distancia), tiempomod, transmod)
                    noteTweenY('play2', 6, (strumYOrigin + distancia), tiempomod, transmod)
                    noteTweenY('play3', 7, (strumYOrigin + distancia), tiempomod, transmod)
                end
            end
        end

        if v1 == 'modchartx' then --Complejo - Hacer modchart por valor x (Izq = menos - Der = mas)-Tiene 3 valores (Distancia, Tiempo, Transicion)
            --                      Ejemplo: 25,0.13,linear (Las flechas van para la derecha en 0.13 en transicion linear)
            local mocharx = split(v2,",")       
            distanciax = tonumber(mocharx[1]) --distancia puede ser negativo
            tiempomodx = tonumber(mocharx[2])
            transmodx = (mocharx[3])

            if tonumber(distanciax) == '' then --No creo que funcione//Si no escribes el predeterminado es 0 (Reinicia a la distancia normal)
                distanciax = 0
            end

            if distanciax == '' then --No creo que funcione//Si no escribes el predeterminado es 0 (Reinicia a la distancia normal)
                distanciax = 0
            end

            if tonumber(mocharx[2]) == '' then --Si no escribes tiempo el predeterminado es 0.15
                tiempomodx = 0.15
            end

            if transmodx == '' then --Si no escribes transicion lo escribis mal el predeterminado el linear
                transmodx = 'linear'
            end

            for i = 0,7 do
                for i = 0,7 do
                    noteTweenY('oppo0', 0, (strumYOrigin + distanciax), tiempomodx, transmodx)
                    noteTweenY('oppo1', 1, (strumYOrigin + distanciax), tiempomodx, transmodx)
                    noteTweenY('oppo2', 2, (strumYOrigin + distanciax), tiempomodx, transmodx)
                    noteTweenY('oppo3', 3, (strumYOrigin + distanciax), tiempomodx, transmodx)
                    noteTweenY('play0', 4, (strumYOrigin + distanciax), tiempomodx, transmodx)
                    noteTweenY('play1', 5, (strumYOrigin + distanciax), tiempomodx, transmodx)
                    noteTweenY('play2', 6, (strumYOrigin + distanciax), tiempomodx, transmodx)
                    noteTweenY('play3', 7, (strumYOrigin + distanciax), tiempomodx, transmodx)
                end
            end
        end
	end
end


function split(s, delimiter) -- Parte copiada de un script de RamenDominoes, porfa siganlo en GB que hace buenos eventos
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, tostring(match));
    end
    return result;
end

function hex_rgb(hex)
    local rojo = 255 - tonumber("0x"..hex:sub(1,2))
    local verde = 255 - tonumber("0x"..hex:sub(3,4))
    local azul = 255 - tonumber("0x"..hex:sub(5,6))    
    return rojo, verde, azul 
end

function onUpdate()

    if del > 0 then
        del = del - 1
    end
    if del2 > 0 then
        del2 = del2 - 1
    end

    if seguircamara == false then
        inta = 0;
    else
        inta = int
    end

    animbf = getProperty('boyfriend.animation.curAnim.name')
    animgf = getProperty("gf.animation.curAnim.name")
    animdad = getProperty('dad.animation.curAnim.name')

    if mustHitSection == false then
        if animdad == 'singLEFT' then
            triggerEvent('Camera Follow Pos',xx-inta,yy)
        elseif animdad == 'singRIGHT' then
            triggerEvent('Camera Follow Pos',xx+inta,yy)
        elseif animdad == 'singUP' then
            triggerEvent('Camera Follow Pos',xx,yy-inta)
        elseif animdad == 'singDOWN' then
            triggerEvent('Camera Follow Pos',xx,yy+inta)
        elseif animdad == 'idle' then
            triggerEvent('Camera Follow Pos',xx,yy)
        end
    end
    
    if mustHitSection == true then
        if animbf == 'singLEFT' then
            triggerEvent('Camera Follow Pos',xx2-inta,yy2)
        elseif animbf == 'singRIGHT' then
            triggerEvent('Camera Follow Pos',xx2+inta,yy2)
        elseif animbf == 'singUP' then
            triggerEvent('Camera Follow Pos',xx2,yy2-inta)
        elseif animbf == 'singDOWN' then
            triggerEvent('Camera Follow Pos',xx2,yy2+inta)
        elseif animbf == 'idle' then
            triggerEvent('Camera Follow Pos',xx2,yy2)
        end
    end
    
    if gfSection == true then 
        if animgf == 'singLEFT' then 
            triggerEvent('Camera Follow Pos',xx3-inta,yy3)
        elseif animgf == 'singRIGHT' then
            triggerEvent('Camera Follow Pos',xx3+inta,yy3)
        elseif animgf == 'singUP' then
            triggerEvent('Camera Follow Pos',xx3,yy3-inta)
        elseif animgf == 'singDOWN' then
            triggerEvent('Camera Follow Pos',xx3,yy3+inta)
        elseif animgf == 'singLEFT-alt' then
            triggerEvent('Camera Follow Pos',xx3-inta,yy3)
        elseif animgf == 'singRIGHT-alt' then
            triggerEvent('Camera Follow Pos',xx3+inta,yy3)
        elseif animgf == 'singUP-alt' then
            triggerEvent('Camera Follow Pos',xx3,yy3-inta)
        elseif animgf == 'singDOWN-alt' then
            triggerEvent('Camera Follow Pos',xx3,yy3+inta)
        else
            triggerEvent('Camera Follow Pos',xx3,yy3)
        end
    end

    if si3 == 1 then
        if curStep % beatt == 0 then
            setProperty('camHUD.angle',1.1)
            doTweenAngle('cama', 'camHUD', 0, 0.7, 'circOut')
        end
        if curStep % beatt == (beatt/2) then
            setProperty('camHUD.angle',-1.1)
            doTweenAngle('cama', 'camHUD', 0, 0.7, 'circOut')       --(60 / bpm) / 4 * 2
        end
    elseif si3 == 0 then
    end
end



local allowCountdown = false -- Code for the dialog to work, don't delete it!
function onStartCountdown() -- Code to display a dialog
    -- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
    if not allowCountdown and isStoryMode and not seenCutscene then
        setProperty('inCutscene', true);
        runTimer('startDialogue', 0.8);
        allowCountdown = true;
        return Function_Stop;
    end
    return Function_Continue;
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'startDialogue' then -- Timer completed, play dialogue
        startDialogue('dialogue', 'breakfast');
    end
    
    if tag == 'fininstacam' then
        setProperty('cameraSpeed', velocidad);
    end
    --if tag == 'sibf' then
    --    if sibf = 0 then
    --        sibf = 1
    --    else
    --        setProperty('boyfriend.color', 'ffffff');
    --        sibf = 0
    --    end
    --end
    --if tag == 'sigf' then
    --    if sigf = 0 then
    --        sigf = 1
    --    else
    --        setProperty('gf.color', 'ffffff');
    --        sigf = 0
    --    end
    --end
    --if tag == 'si2' then
    --    if si2 = 0 then
    --        si2 = 1
    --    else
    --        setProperty(char..'.color', 'ffffff');
    --        si2 = 0
    --    end
    --end
    --if tag == 'sidad' then
    --    if sidad = 0 then
    --        sidad = 1
    --    else
    --        setProperty('dad.color', 'ffffff');
    --        sidad = 0
    --    end
    --end
end

-- Dialogue (When a dialogue is finished, it calls startCountdown again)
function onNextDialogue(count)
    -- triggered when the next dialogue line starts, 'line' starts with 1
end

function onSkipDialogue(count)
    -- triggered when you press Enter and skip a dialogue line that was still being typed, dialogue line starts with 1
end
