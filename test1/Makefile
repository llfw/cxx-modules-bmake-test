.META.MODE=	meta
.SUFFIXES:	.cc .ccm .pcm .o

CXX=		clang++
CXXFLAGS=	-std=c++23 -fprebuilt-module-path=${.CURDIR}
PROG=		test
MAN=
SRCS=		main.cc hello.ccm

.ccm.pcm:
	${CXX} --precompile ${CXXFLAGS} -c $< -o $@

.include <ccm.dep.mk>
.include <prog.mk>
