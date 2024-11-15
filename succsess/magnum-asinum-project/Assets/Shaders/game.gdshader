shader_type canvas_item;

uniform float glitch_intensity : hint_range(0.0, 1.0) = 0.3;
uniform float scan_line_speed : hint_range(0.0, 10.0) = 1.0;
uniform float distortion_amount : hint_range(0.0, 1.0) = 0.2;
uniform vec4 tint_color : source_color = vec4(0.8, 0.3, 0.2, 1.0);

float random(vec2 pos) {
    return fract(sin(dot(pos + TIME * 0.1, vec2(12.9898, 78.233))) * 43758.5453123);
}

void fragment() {
    // Base UV coordinates
    vec2 uv = SCREEN_UV;

    // Digital glitch effect
    float glitch = step(1.0 - glitch_intensity * 0.5, random(vec2(TIME * 0.1, floor(uv.y * 20.0))));
    vec2 glitch_offset = vec2(
        glitch * (random(vec2(TIME * 0.1)) * 2.0 - 1.0) * 0.1,
        0.0
    );
    uv += glitch_offset;

    // Vertical distortion
    float distortion = sin(uv.y * 10.0 + TIME * scan_line_speed) * distortion_amount;
    uv.x += distortion;

    // CRT scan lines
    float scan_lines = abs(sin(uv.y * 100.0 + TIME * scan_line_speed));
    scan_lines = 1.0 - (1.0 - scan_lines) * 0.5;

    // Get base color with offset for chromatic aberration
    vec4 color = texture(TEXTURE, uv);
    vec4 color_r = texture(TEXTURE, uv + vec2(0.01, 0.0) * distortion_amount);
    vec4 color_b = texture(TEXTURE, uv - vec2(0.01, 0.0) * distortion_amount);

    // Combine color channels with chromatic aberration
    color = vec4(color_r.r, color.g, color_b.b, color.a);

    // Apply scan lines and tint
    color.rgb *= scan_lines;
    color.rgb = mix(color.rgb, color.rgb * tint_color.rgb, 0.5);

    // Add noise
    float noise = random(uv + vec2(TIME * 0.1));
    color.rgb += noise * 0.1;

    // Vignette effect
    float vignette = length(vec2(0.5, 0.5) - uv);
    vignette = smoothstep(0.5, 1.5, vignette);
    color.rgb *= 1.0 - vignette * 0.5;

    COLOR = color;
}