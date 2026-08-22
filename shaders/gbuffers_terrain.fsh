#version 330 compatibility

uniform sampler2D lightmap;
uniform sampler2D gtexture;

#include "settings.glsl"

uniform float alphaTestRef = 0.1;

in vec2 lmcoord;
in vec2 texcoord;
in vec4 glcolor;

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

void main() {

    vec4 foliage = glcolor;

	#ifdef oldFoliageGreen 
		bool tinted = foliage.r == foliage.g && foliage.r == foliage.b;
		if (!tinted) {
            foliage.r += 0.0921;
            foliage.g += 0.4412;
            foliage.g *= foliageGreenAmount;
		}
	#endif
    
#include "light.glsl"

}
