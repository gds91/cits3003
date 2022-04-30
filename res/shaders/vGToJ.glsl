#version 150

in vec3 vPosition;
in vec3 vNormal;
in vec2 vTexCoord;

//Part G: added the below variables
out vec4 position;
out vec3 normal;
out vec2 texCoord;

uniform mat4 ModelView;
uniform mat4 Projection;

void main()
{
    position = vec4(vPosition, 1.0);
    texCoord = vTexCoord;
    normal = vNormal;

    gl_Position = Projection * ModelView * position;
}
