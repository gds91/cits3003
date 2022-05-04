varying vec4 position;
varying vec3 normal;
varying vec2 texCoord;  // The third coordinate is always 0.0 and is discarded

uniform sampler2D texture;

// Naomi: Part G: moved vertex shader variables to fragment shader for per-fragment lighting
uniform vec3 AmbientProduct, DiffuseProduct, SpecularProduct;
uniform mat4 ModelView;
uniform mat4 Projection;
uniform vec4 LightPosition;
uniform float Shininess;

vec4 color;


//Part G: copied main from vertex shader to fragment shader
void main()
{

    // Transform vertex position into eye coordinates
    vec3 pos = (ModelView * position).xyz;


    // The vector to the light from the vertex    
    vec3 Lvec = LightPosition.xyz - pos;

    // Unit direction vectors for Blinn-Phong shading calculation
    vec3 L = normalize( Lvec );   // Direction to the light source
    vec3 E = normalize( -pos );   // Direction to the eye/camera
    vec3 H = normalize( L + E );  // Halfway vector

    // Transform vertex normal into eye coordinates (assumes scaling
    // is uniform across dimensions)
    vec3 N = normalize( (ModelView*vec4(normal, 0.0)).xyz );

    // Compute terms in the illumination equation
    vec3 ambient = AmbientProduct;

    float Kd = max( dot(L, N), 0.0 );
    vec3  diffuse = Kd*DiffuseProduct;

    float Ks = pow( max(dot(N, H), 0.0), Shininess );
    vec3  specular = Ks * SpecularProduct;
    
    if (dot(L, N) < 0.0 ) {
	specular = vec3(0.0, 0.0, 0.0);
    } 

    // globalAmbient is independent of distance from the light source
    vec3 globalAmbient = vec3(0.1, 0.1, 0.1);
    float lightReduction = 1.0 / (0.2 + 0.3*length(Lvec) + 0.4*pow(length(Lvec), 2.0));
    // color.rgb = globalAmbient  + ambient + diffuse + specular;
    // color.rgb = globalAmbient  + ((ambient + diffuse + specular) / lightReduction);
    // part H: Texture specular - shifted specular value from color.rgb to gl_FragColor
    // color.rgb = globalAmbient  + ((ambient + diffuse) / lightReduction);
    color.rgb = globalAmbient  + ((ambient + diffuse) * lightReduction);
    color.a = 1.0;

    gl_FragColor = color * texture2D(texture, texCoord * 2.0) + vec4(specular * lightReduction, 1.0);
}
