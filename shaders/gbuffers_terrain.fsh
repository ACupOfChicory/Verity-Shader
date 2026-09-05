#version 330 compatibility

#include "settings.glsl"

uniform sampler2D lightmap;
uniform sampler2D gtexture;

// settings

in vec2 lmcoord;
in vec2 texcoord;
in vec4 glcolor;

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

//light function
#include "light.glsl"

void main() {

    vec4 foliage = glcolor;

	#ifdef oldFoliageGreen 
		bool tinted = foliage.r == foliage.g && foliage.r == foliage.b;
		if (!tinted) {
    
            foliage.r += 0.0921;
            foliage.g += 0.4412;
        #ifdef verityGrass
            foliage.b += 0.07;
        #endif
            foliage.g *= foliageGreenAmount;
		}
	#endif
    color = texture(gtexture, texcoord) * foliage;
    lightFunction(lightmap, lmcoord);


}
