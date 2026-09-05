uniform vec3 fogColor;
uniform float blindness;
uniform int isEyeInWater;
uniform float viewHeight;
uniform float viewWidth;
uniform float eyeAltitude;
uniform mat4 gbufferProjectionInverse;

// UNDO SOMETHING IDK
vec3 screenToView(vec3 screenPos) {
    vec4 ndcPos = vec4(screenPos, 1.0) * 2.0 - 1.0;
    vec4 tmp = gbufferProjectionInverse * ndcPos;
    return tmp.xyz / tmp.w;
}



float FoggyFog(vec2 texcoord, float depth, out vec3 fogColorOut){
    vec3 depthcoord = vec3(texcoord, depth);
    vec3 bereal = screenToView(depthcoord);
    float realdistance = length(bereal);
    float PhileasFogg;
    
    if(isEyeInWater == 0){
        PhileasFogg = smoothstep(fogStart, fogEnd, realdistance);
        fogColorOut = mix(fogColor, vec3(0.0), smoothstep(caveFogHigh, caveFogLow, eyeAltitude));
        
    }
    if(isEyeInWater == 1){
        PhileasFogg = smoothstep(10.0, 20.0, realdistance);
        fogColorOut = vec3(0.1, 0.1, 0.5);
        
    }
    if(isEyeInWater == 2){
        PhileasFogg = smoothstep(0.0, 3.0, realdistance);
        fogColorOut = vec3(0.6, 0.1, 0.0);
        
    }
    if(isEyeInWater == 3){
        PhileasFogg = smoothstep(0.0, 2.0, realdistance);
        fogColorOut = vec3(0.710, 0.918, 0.918);
        
        
    }

    PhileasFogg = mix(PhileasFogg, 1.0, blindness);
    return PhileasFogg;
    
    
}
