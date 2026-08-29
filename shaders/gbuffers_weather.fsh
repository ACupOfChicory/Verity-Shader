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
    color *= texture(lightmap, lmcoord);
#ifdef fogToggle
    vec3 fogTint;
    float fogAmount = FoggyFog(gl_FragCoord.xy / vec2(viewWidth, viewHeight), gl_FragCoord.z, fogTint);
    color.rgb = mix(color.rgb, fogTint, fogAmount);
#endif
    if (color.a < alphaTestRef) {
        discard;
    }
}
