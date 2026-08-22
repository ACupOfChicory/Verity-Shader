#version 330 compatibility

#include "settings.glsl"

uniform sampler2D colortex0;
in vec2 texcoord;

uniform float viewHeight;
uniform float viewWidth;
uniform int frameCounter;

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

void main() {    

    vec2 resolution = vec2(viewWidth, viewHeight);
    ivec2 texSize = textureSize(colortex0, 0);       
    ivec2 fragCoord = ivec2(texcoord * vec2(texSize)); 
    vec2 uv = fragCoord/resolution;

    float noise = (fract(sin(dot((round(uv * noiseSize) / noiseSize) * float(frameCounter) * 0.01, vec2(12.9898,78.233))) * 43758.5453));

    vec2 shifted = uv - 0.5;

    #ifdef chromaticAbberation
        vec2 abberation = abs(shifted * 2.0);
        
        vec2 rOffset = vec2(0.009, 0.0024);
        vec2 gOffset = vec2(-0.004, 0.0);
        vec2 bOffset = vec2(0.011, -0.008);

        float r = texture(colortex0, clamp(texcoord + (abberation * rOffset * abberationAmount), 0.0, 1.0)).r;
        float g = texture(colortex0, clamp(texcoord + (abberation * gOffset * abberationAmount), 0.0, 1.0)).g;
        vec2 ba = texture(colortex0, clamp(texcoord + (abberation * bOffset * abberationAmount), 0.0, 1.0)).ba;

        vec4 outputColor = vec4(r, g, ba);
    #endif

    #ifndef chromaticAbberation
        vec4 outputColor = texture(colortex0, texcoord);
    #endif

    #ifdef vignette
        float dist = distance(shifted, vec2(0.0, 0.0));
        float vignetteFactor = smoothstep(0.2, 0.9, dist) * vignetteAmount;

        outputColor = outputColor - vignetteFactor;
    #endif

    #ifdef noiseToggle 
        outputColor += noise * 0.1;
    #endif
    
    color = vec4(outputColor);
}
