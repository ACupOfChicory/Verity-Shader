#version 330 compatibility

#include "settings.glsl"

uniform sampler2D colortex0;

in vec2 texcoord;

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

void main() {

    vec4 outputColor = texture(colortex0, texcoord);
    color = vec4(outputColor);
}
