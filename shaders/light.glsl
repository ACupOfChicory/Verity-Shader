
// light making function
uniform float alphaTestRef = 0.1;

vec4 lightFunction(sampler2D lightmap, vec2 lmcoord){
    
#ifdef grayscaleLight
    //when gray scale light is ON
    vec4 lightGRAY = texture(lightmap, lmcoord);
    float scalarF = lightGRAY.r * 0.299 + lightGRAY.g * 0.587 + lightGRAY.b * 0.114;
    lightGRAY.rgb = vec3(scalarF);
    color.rgb *= pow(lightGRAY.rgb, vec3(4));
#endif
    //when gray scale light is OFF
#ifndef grayscaleLight
    color.rgb *= pow(texture(lightmap, lmcoord).rgb, vec3(4));
#endif
    // if we wont check this it will make things not transparent
    if (color.a < alphaTestRef) {
        discard;
    }
    // return refined color
    return color;
}

