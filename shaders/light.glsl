
//when gray scale light is ON
#ifdef grayscaleLight
    color = texture(gtexture, texcoord) * foliage;
    vec4 lightGRAY = texture(lightmap, lmcoord);
    float scalar1 = lightGRAY.r * 0.299;
    float scalar2 = lightGRAY.g * 0.587;
    float scalar3 = lightGRAY.b * 0.114;
    float scalarF = scalar1 + scalar2 + scalar3;
    lightGRAY.r = scalarF;
    lightGRAY.g = scalarF;
    lightGRAY.b = scalarF;
    color.rgb *= pow(lightGRAY.rgb, vec3(4));
    if (color.a < alphaTestRef) {
        discard;
    }
#endif
//when gray scale light is OFF
#ifndef grayscaleLight
    color = texture(gtexture, texcoord) * foliage;
        color.rgb *= pow(texture(lightmap, lmcoord).rgb, vec3(4));
        if (color.a < alphaTestRef) {
          discard;
        }
#endif

