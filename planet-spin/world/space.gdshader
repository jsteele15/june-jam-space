shader_type sky;

uniform float star_density : hint_range(0.0, 5.0) = 1.5;
uniform float star_brightness : hint_range(0.0, 3.0) = 1.2;
uniform float nebula_strength : hint_range(0.0, 2.0) = 0.6;
uniform vec3 nebula_color : source_color = vec3(0.4, 0.1, 0.6);
uniform float nebula_scale = 2.5;
uniform float star_twinkle_speed = 0.5;

// Float hash
float hash(float n) {
    return fract(sin(n) * 43758.5453);
}

float noise(vec3 p) {
    vec3 i = floor(p);
    vec3 f = fract(p);

    float n = dot(i, vec3(1.0, 57.0, 113.0));

    return mix(
        mix(
            mix(hash(n + 0.0), hash(n + 1.0), f.x),
            mix(hash(n + 57.0), hash(n + 58.0), f.x),
            f.y
        ),
        mix(
            mix(hash(n + 113.0), hash(n + 114.0), f.x),
            mix(hash(n + 170.0), hash(n + 171.0), f.x),
            f.y
        ),
        f.z
    );
}

float fbm(vec3 p) {
    float f = 0.0;
    float scale = 1.0;
    for (int i = 0; i < 5; i++) {
        f += noise(p * scale) / scale;
        scale *= 2.0;
    }
    return f;
}

void sky() {
    // SKY_COORDS is vec2 in Godot 4
    vec2 uv = SKY_COORDS;

    // Convert to a 3D direction vector
    vec3 dir = normalize(vec3(uv, 1.0));

    // Nebula
    float n = fbm(dir * nebula_scale + TIME * 0.05);
    vec3 nebula = nebula_color * n * nebula_strength;

    // Stars
    float star_noise = hash(dot(dir, vec3(12.9898, 78.233, 45.164)) * 200.0);
    float stars = step(1.0 - star_density, star_noise);

    // Twinkle
    stars *= (0.8 + 0.2 * sin(TIME * star_twinkle_speed + star_noise * 10.0));

    vec3 star_color = vec3(stars * star_brightness);

    COLOR = nebula + star_color;
}
