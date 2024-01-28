#
# RCSid:
#	$Id: ccm.dep.mk,v 1.1 2024/01/28 21:37:10 sjg Exp $
#
#	@(#) Copyright (c) 2024, Simon J. Gerraty
#
#	This file is provided in the hope that it will
#	be of use.  There is absolutely NO WARRANTY.
#	Permission to copy, redistribute or otherwise
#	use this file is hereby granted provided that
#	the above copyright notice and this notice are
#	left intact.
#
#	Please send copies of changes and bug-fixes to:
#	sjg@crufty.net
#

# C++ Modules need extra help - at least in a clean tree

.if !target(__${_this}__)
__${_this}__: .NOTMAIN

CCM_SUFFIXES ?= ${.SUFFIXES:M*.c*m}
# should be set by now
OBJ_SUFFIXES ?= ${.SUFFIXES:M*o}

.ccm_srcs := ${CCM_SUFFIXES:@s@${SRCS:M*$s}@}
.if !empty(.ccm_srcs)
.ccm_depend: ${.ccm_srcs}
	@rm -f ${.TARGET}
.for s r e in ${.ccm_srcs:@x@$x ${x:T:R} ${x:E}@}
	@mlist=`sed -n '/^import/s,.*[[:space:]]\([^[:space:];]*\);.*,\1,p' ${.ALLSRC:M*$s}`; \
	for o in ${OBJ_SUFFIXES:O:u}; do \
		for m in $$mlist; do \
			echo $r$$o: $$m$$o; \
		done; \
	done >> ${.TARGET}
.endfor

.if make(depend)
beforedepend: .ccm_depend
.endif

.if !make(.ccm_depend)
.if ${MKDEP_MK:U:M*auto*} != "" && !exists(.ccm_depend)
# a bit ugly...
x != echo; ${.MAKE} -B -C ${.CURDIR} -f ${MAKEFILE} .ccm_depend
.endif

CLEANFILES += .ccm_depend
# the ${.OBJDIR}/ is necessary!
.dinclude <${.OBJDIR}/.ccm_depend>
.endif
.endif
.endif
