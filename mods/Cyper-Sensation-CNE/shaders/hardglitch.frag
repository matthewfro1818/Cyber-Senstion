// The MIT License
// Copyright © 2013 Jianing Zhang
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#pragma header
uniform float iTime;
uniform float density;
//uniform sampler2D iChannel1;
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main

#define NOISE 0.00346020761245674740484429065744f
#define FREQUENCY 10.3
#define RGBSPLIT 37.8
#define JUMPINDENSITY 0.15
#define SPLITTINGNUMBER 14.0
#define JITTERAMOUNT 9.7
#define JITTERSPEED 0.15
#define BLOCKSIZE 10.0
#define MAXRGBSPLITX 1.0
#define MAXRGBSPLITY 1.0
#define FADING 2.0
#define LUMINANCEJITTERTHREASHOLD 0.895
#define NOISESPEED 0.102
#define SCANLINEJITTERAMOUNT 3.45
#define WAVEJITTERAMOUNT 1.0
#define WAVESPEED 10.32

vec3 taylorInvSqrt(vec3 r){return 1.79284291400159 - 0.85373472095314 * r;}

vec2 mod289(vec2 x)
{
	return x - floor(x * NOISE) * 289.0;
}

vec3 mod289(vec3 x)
{
	return x - floor(x * NOISE) * 289.0;
}

vec3 permute(vec3 x)
{
	return mod289(x * x * 34.0 + x);
}

float randomNoise(vec2 seed)
{
	return fract(sin(dot(seed * floor(iTime * 30.0), vec2(17.13, 3.71))) * 43758.5453123);
}

float randomNoise(float seed)
{
	return randomNoise(vec2(seed, 1.0));
}

    
float randomNoise(float x, float y)
{
	return fract(sin(dot(vec2(x, y), vec2(12.9898, 78.233))) * 43758.5453);
}

float snoise(vec2 v)
{
	const vec4 C = vec4(0.211324865405187, 0.366025403784439, - 0.577350269189626, 0.024390243902439);
	vec2 i = floor(v + dot(v, C.yy));
	vec2 x0 = v - i + dot(i, C.xx);
	
	vec2 i1;
	i1.x = step(x0.y, x0.x);
	i1.y = 1.0 - i1.x;
	vec2 x1 = x0 + C.xx - i1;
	vec2 x2 = x0 + C.zz;
	
	i = mod289(i);
	vec3 p = permute(permute(i.y + vec3(0.0, i1.y, 1.0))
	+ i.x + vec3(0.0, i1.x, 1.0));
	
	vec3 m = max(0.5 - vec3(dot(x0, x0), dot(x1, x1), dot(x2, x2)), 0.0);
	m = m * m;
	m = m * m;
	
	vec3 x = 2.0 * fract(p * C.www) - 1.0;
	vec3 h = abs(x) - 0.5;
	vec3 ox = floor(x + 0.5);
	vec3 a0 = x - ox;
	
	m *= taylorInvSqrt(a0 * a0 + h * h);
	
	vec3 g;
	g.x = a0.x * x0.x + h.x * x0.y;
	g.y = a0.y * x1.x + h.y * x1.y;
	g.z = a0.z * x2.x + h.z * x2.y;
	return 130.0 * dot(m, g);
}

void mainImage()
{
    vec2 uv = openfl_TextureCoordv.xy;
    vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
    vec2 iResolution = openfl_TextureSize;
    float strength = 0.5 + 0.5 *cos(iTime * FREQUENCY);
    vec2 uv2 = fragCoord/iResolution.xy;
    
    // Screen jump
    float _JumpTime = iTime * JUMPINDENSITY * 5.8;
    float hJump = mix(uv2.x, fract(uv2.x + _JumpTime), JUMPINDENSITY);    
    //float vJump = mix(uv2.y, fract(uv2.y + _JumpTime), JUMPINDENSITY);
    
    // Tile Jitter
	float pixelSizeX = 1.0 / iResolution.x;

	if (mod(uv2.y * SPLITTINGNUMBER, 2.0) < 1.0)
	{
        uv2.x += pixelSizeX * cos(iTime * JITTERSPEED) * JITTERAMOUNT * strength;
	}
    
    // Image Block
    float block = randomNoise(floor(uv2 * BLOCKSIZE));

	float displaceNoise = pow(block, 8.0) * pow(block, 3.0);
	float splitRGBNoise = pow(randomNoise(7.2341), 17.0);
	float offsetX = displaceNoise - splitRGBNoise * MAXRGBSPLITX;
	float offsetY = displaceNoise - splitRGBNoise * MAXRGBSPLITY;

	float noiseX = 0.05 * randomNoise(13.0);
	float noiseY = 0.05 * randomNoise(7.0);
	vec2 offset = vec2(offsetX * noiseX, offsetY* noiseY);

	vec4 iColorR = texture(iChannel0, uv2);
	vec4 iColorG = texture(iChannel0, uv2 + offset);
	vec4 iColorB = texture(iChannel0, uv2 - offset);
    
    // Wave Jitter
    float noise_wave_1 = snoise(vec2(uv2.y, iTime * WAVESPEED * 20.0)) * (strength * WAVEJITTERAMOUNT * 32.0);
    float noise_wave_2 = snoise(vec2(uv2.y, iTime * WAVESPEED * 10.0)) * (strength * WAVEJITTERAMOUNT * 4.0);
	float noise_wave_x = noise_wave_1 * noise_wave_2 / iResolution.x;
	float uv2_x = uv2.x + noise_wave_x;
    float rgbSplit_uv2_x = (RGBSPLIT * 50.0 + (20.0 * strength + 1.0)) * noise_wave_x / iResolution.x;;
    
    // Scanline Jitter
	float jitter = randomNoise(uv2.y, iTimeDelta) * 2.0 - 1.0;
    float threshold = clamp(1.0f - JUMPINDENSITY * 1.2f, 0.0, 1.0);
	jitter *= step(threshold, abs(jitter)) * SCANLINEJITTERAMOUNT * strength;	
    
    // Analog Noise
    vec4 sceneColor = texture(iChannel0, uv2);
    vec4 noiseColor = sceneColor;

    float luminance = dot(noiseColor.rgb, vec3(0.22, 0.707, 0.071));
    if (randomNoise(vec2(iTimeDelta * NOISESPEED, iTimeDelta * NOISESPEED)) > LUMINANCEJITTERTHREASHOLD)
	{
		noiseColor = vec4(luminance, luminance, luminance, luminance);
	}

	float aNoiseX = randomNoise(iTimeDelta * NOISESPEED + uv2 / vec2(-213, 5.53));
	float aNoiseY = randomNoise(iTimeDelta * NOISESPEED - uv2 / vec2(213, -5.53));
	float aNoiseZ = randomNoise(iTimeDelta * NOISESPEED + uv2 / vec2(213, 5.53));

	noiseColor.rgb += 0.25 * vec3(aNoiseX,aNoiseY,aNoiseZ) - 0.125;
    
    
    // Mixing
    vec4 originalColor = texture(iChannel0, uv2);
    vec4 colorG = texture(iChannel0, vec2(uv2_x, uv2.y));
    vec4 colorRB = texture(iChannel0, vec2(uv2_x + rgbSplit_uv2_x, uv2.y));
    vec4 jumpColor = texture(iChannel0, fract(vec2(uv2.x, hJump)));
    vec4 waveColor = vec4(colorRB.r, colorG.g, colorRB.b, colorRB.a + colorG.a);
    vec4 jumpWaveMix = mix(jumpColor, waveColor, jumpColor.a);
    vec4 imageBlockColor = vec4(iColorR.r , iColorG.g, iColorB.z, (iColorR.a + iColorG.a + iColorB.a));
    vec4 tileColor = mix(originalColor, jumpWaveMix, originalColor.a);
    vec4 scanlineJitterColor = texture(iChannel0, fract(uv2 + vec2(jitter, 0)));
    vec4 imageBlockTileMix = mix(imageBlockColor, tileColor, imageBlockColor.a);
    vec4 analogNoiseColor = mix(sceneColor, noiseColor, FADING);
    vec4 scanlineImageBlockTileMix = mix(scanlineJitterColor, imageBlockTileMix, scanlineJitterColor.a);
    
    
    // Output to screen
    fragColor = mix(analogNoiseColor, scanlineImageBlockTileMix, 0.0);
}