#ifndef OPENGL_GFX
#define OPENGL_GFX

// copied from glad.h
typedef unsigned int GLenum;
typedef unsigned char GLboolean;
typedef unsigned int GLbitfield;
typedef void GLvoid;
typedef signed char GLbyte;
typedef short GLshort;
typedef int GLint;
typedef int GLclampx;
typedef unsigned char GLubyte;
typedef unsigned short GLushort;
typedef unsigned int GLuint;
typedef int GLsizei;
typedef float GLfloat;
typedef float GLclampf;
typedef double GLdouble;
typedef double GLclampd;
typedef void *GLeglImageOES;
typedef char GLchar;
typedef char GLcharARB;

typedef typeof((int*)nullptr - (int*)nullptr) ptrdiff_t;
typedef ptrdiff_t GLsizeiptr;

extern void glBindBuffer(GLenum target, GLuint buffer);
extern void glEnableVertexAttribArray(GLuint index);
extern void glDisableVertexAttribArray(GLuint index);
extern void glVertexAttribPointer(GLuint index, GLint size, GLenum type, GLboolean normalized, GLsizei stride, const GLvoid* pointer);
extern void glDrawArrays(GLenum mode, GLint first, GLsizei count);

extern GLint glGetUniformLocation(GLuint program, GLchar* name);
extern GLint glGetAttribLocation(GLuint program, GLchar* name);

extern void glActiveTexture(GLenum texture);
extern void glAttachShader(GLuint program, GLuint texture);
extern void glBindTexture(GLenum target, GLuint texture);
extern void glBlendFunc(GLenum sfactor, GLenum dfactor);

extern void glBufferData(GLenum target, GLsizeiptr size, GLvoid* data, GLenum usage);
extern void glClear(GLbitfield mask);
extern void glClearColor(GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha);
extern void glCompileShader(GLuint shader);
extern void glDeleteBuffers(GLsizei n, GLuint* buffers);
extern void glDeleteShader(GLuint shader);
extern void glDetachShader(GLuint program, GLuint shader);
extern void glEnable(GLenum cap);
extern void glDisable(GLenum cap);

extern void glGenBuffers(GLsizei n, GLuint* buffers);
extern void glGenTextures(GLsizei n, GLuint* textures);

extern void glGetProgramInfoLog(GLuint program, GLsizei maxLength, GLsizei* length, GLchar* infoLog);
extern void glGetProgramiv(GLuint program, GLenum pname, GLint* params);

extern void glGetShaderInfoLog(GLuint shader, GLsizei maxLength, GLsizei* length, GLchar* infoLog);
extern void glGetShaderiv(GLuint shader, GLenum pname, GLint* params);

extern void glLineWidth(GLfloat width);
extern void glLinkProgram(GLuint program);

extern void glLogicOp(GLenum opcode);
extern void glPolygonOffset(GLfloat factor, GLfloat units);
extern void glScissor(GLint x, GLint y, GLsizei width, GLsizei height);
extern void glShaderSource(GLuint shader, GLsizei count, const GLchar** string, GLint* length);
extern void glTexImage2D(GLenum target, GLint level, GLint internalFormat, GLsizei width, GLsizei height, GLint border, GLenum format, GLenum type, const GLvoid* data);

extern void glTexParameteri(GLenum target, GLenum pname, GLint param);
extern GLuint glCreateProgram();
extern GLuint glCreateShader(GLenum shaderType);

extern void glUniform1f(GLint location, GLfloat v0);
extern void glUniform1i(GLint location, GLint v0);
extern void glUniform3f(GLint location, GLfloat v0, GLfloat v1, GLfloat v2);
extern void glUniformMatrix4fv(GLint location, GLsizei count, GLboolean transpose, GLfloat* value);

extern void glUseProgram(GLuint program);
extern void glViewport(GLint x, GLint y, GLsizei width, GLsizei height);

#endif
