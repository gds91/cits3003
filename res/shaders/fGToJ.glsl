varying vec4 position;
varying vec3 normal;
varying vec2 texCoord;  // The third coordinate is always 0.0 and is discarded

uniform sampler2D texture;

// Naomi: Part G: moved vertex shader variables to fragment shader for per-fragment lighting
uniform vec3 AmbientProduct, DiffuseProduct, SpecularProduct;
uniform mat4 ModelView;
uniform mat4 Projection;
uniform float Shininess;

//First light source
uniform vec4 LightPosition;
uniform vec4 LightBrightness;

//Part I: second light source
uniform vec4 LightPosition2;
uniform vec4 LightBrightness2;

vec4 color;


//Part G: copied main from vertex shader to fragment shader
void main()
{

    // Transform vertex position into eye coordinates
    vec3 pos = (ModelView * position).xyz;


    // The vector to the light from the vertex    
    vec3 Lvec = LightPosition.xyz - pos;
    // Part I: vector to the origin from light 2 
    vec3 Lvec2 = LightPosition2.xyz;

    // Unit direction vectors for Blinn-Phong shading calculation
    vec3 L = normalize( Lvec );   // Direction to the light source
    vec3 E = normalize( -pos );   // Direction to the eye/camera
    vec3 H = normalize( L + E );  // Halfway vector

    vec3 L2 = normalize(Lvec2); //Direction 
    vec3 H2 = normalize (L2 + E);

    // Transform vertex normal into eye coordinates (assumes scaling
    // is uniform across dimensions)
    vec3 N = normalize( (ModelView*vec4(normal, 0.0)).xyz );

    // Compute terms in the illumination equation
    vec3 ambient = AmbientProduct;

    float Kd = max( dot(L, N), 0.0 );
    vec3  diffuse = Kd*DiffuseProduct;

    float Kd2 = max( dot(L2, N), 0.0 );
    vec3  diffuse2 = Kd2 * DiffuseProduct;

    float Ks = pow( max(dot(N, H), 0.0), Shininess );
    vec3  specular = Ks * SpecularProduct;

    float Ks2 = pow( max(dot(N, H2), 0.0), Shininess );
    vec3  specular2 = Ks2 * SpecularProduct;
    
    if (dot(L, N) < 0.0 ) {
	specular = vec3(0.0, 0.0, 0.0);
    } 

    if (dot(L2, N) < 0.0 ) {
	specular2 = vec3(0.0, 0.0, 0.0);
    } 

    // globalAmbient is independent of distance from the light source
    vec3 globalAmbient = vec3(0.1, 0.1, 0.1);
    color.rgb = globalAmbient  + ambient + diffuse + specular;
    color.a = 1.0;

    gl_FragColor = color * texture2D(texture, texCoord * 2.0);
}