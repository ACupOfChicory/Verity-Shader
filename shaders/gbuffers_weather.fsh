#version 330 compatibility

#include "settings.glsl"

uniform sampler2D lightmap;
uniform sampler2D gtexture;

in vec2 lmcoord;
in vec2 texcoord;
in vec4 glcolor;

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

#include "fog.glsl"

//light function
#include "light.glsl"

void main() {
	color = texture(gtexture, texcoord) * glcolor;
    //color = lightFunction(lightmap, lmcoord);
    //color *= texture(lightmap, lmcoord);
    vec3 fogTint;
    float fogAmount = FoggyFog(gl_FragCoord.xy / vec2(viewWidth, viewHeight), gl_FragCoord.z, fogTint);
    color.rgb = mix(color.rgb, fogTint, fogAmount);
}




Русский язык - 48

Литература - 48

Алгебра - 98

Геометрия - 98

Иностранный язык - 48

Физика - 98

Химия - Тетрадь общая на 48 листов, Тетрадь на 12 листов. в клетку. Калькулятор обычный

Биология - 48

История - 48

География - 48

(возможно) Информатика

(возможно) Вероятность и статистика

прочее:
Карандаши, ручки обычные шариковые.
пенал, точилка, ластик
