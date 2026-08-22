#version 330 compatibility

#include "settings.glsl"

uniform sampler2D colortex0;
uniform sampler2D depthtex0;
uniform vec3 skyColor;
uniform float fogEnd;
uniform float fogStart;
uniform float eyeAltitude;

in vec2 texcoord;

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

void main() {    

    vec4 outputColor = texture(colortex0, texcoord);

    #ifdef fogToggle
        float depth = texture(depthtex0, texcoord).r;

        #ifndef fogSkyOverlap
            if (depth < 1.0) {
                vec3 caveFactor = skyColor - smoothstep(80.0, 0.0, eyeAltitude);
                outputColor.rgb = mix(outputColor.rgb, caveFactor, smoothstep(fogStrenth, 1.0, depth));
            }
        #endif

        #ifdef fogSkyOverlap
                vec3 caveFactor = skyColor - smoothstep(80.0, 0.0, eyeAltitude);
                outputColor.rgb = mix(outputColor.rgb, caveFactor, smoothstep(fogStrenth, 1.0, depth));
        #endif


    #endif

    
    color = vec4(outputColor);
}
