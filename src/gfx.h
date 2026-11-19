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

extern GLint glGetUniformLocation(GLuint program, GLchar* name);
extern GLint glGetAttribLocation(GLuint program, GLchar* name);

extern void glUniform1f(GLint location, GLfloat v0);
extern void glUniform1i(GLint location, GLint v0);
extern void glUniform3f(GLint location, GLfloat v0, GLfloat v1, GLfloat v2);
extern void glUniformMatrix4fv(GLint location, GLsizei count, GLboolean transpose, GLfloat* value);

extern void glUseProgram(GLuint program);

#endif
