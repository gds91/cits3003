#version 150

in vec3 vPosition;
in vec3 vNormal;
in vec2 vTexCoord;

out vec2 texCoord;
out vec4 position;
out vec3 normal;

uniform mat4 ModelView;
uniform mat4 Projection;

void main()
{
    texCoord = vTexCoord;
    position = vec4(vPosition, 1.0);
    normal = vNormal;
    
    gl_Position = Projection * ModelView * position;
}
