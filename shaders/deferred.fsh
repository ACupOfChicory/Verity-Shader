#version 330 compatibility

uniform sampler2D colortex0;
uniform sampler2D depthtex0;
in vec2 texcoord;

#include "settings.glsl"

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

#include "fog.glsl"

void main() {
    vec4 outputColor = texture(colortex0, texcoord);
#ifdef fogToggle
    float depth = texture(depthtex0, texcoord).r;
    vec3 fogTint;
    float fogIndex = FoggyFog(texcoord, depth, fogTint);
    

    #ifndef fogSkyOverlap
        if (depth < 1.0) {
            outputColor.rgb = mix(outputColor.rgb, fogTint, fogIndex);
        }
    #endif

    #ifdef fogSkyOverlap
            outputColor.rgb = mix(outputColor.rgb, fogTint, fogIndex);
    #endif


#endif
    color = vec4(outputColor);
}
