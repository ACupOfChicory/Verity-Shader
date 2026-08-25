#version 330 compatibility

#include "settings.glsl"

uniform sampler2D lightmap;
uniform sampler2D gtexture;


in vec2 lmcoord;
in vec2 texcoord;
in vec4 glcolor;

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

//light function
#include "light.glsl"

void main() {
	color = texture(gtexture, texcoord) * glcolor;
    lightFunction(lightmap, lmcoord);
}
