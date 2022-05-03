#version 150

in vec3 vPosition;
in vec3 vNormal;
in vec2 vTexCoord;

//Part G: output values to be interpolated per fragment
out vec3 fN;
out vec3 fE;
out vec3 fL; 
out vec3 fL2;

out vec2 texCoord;
out vec4 position;
out vec3 normal;

uniform mat4 ModelView;
uniform mat4 Projection;
uniform vec4 LightPosition;
uniform vec4 LightPosition2;

void main()
{

    fN = vNormal;
    fE = vPosition.xyz;
    fL = LightPosition.xyz - vPosition;
    fL2 = LightPosition2.xyz - vPosition;

    texCoord = vTexCoord;
    position = vec4(vPosition, 1.0);
    normal = vNormal;
    
    gl_Position = Projection * ModelView * position;
}
