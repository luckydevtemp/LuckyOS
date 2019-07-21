#===========================================================================
# Este arquivo pertence ao Projeto do Sistema Operacional LuckyOS (LOS).
# --------------------------------------------------------------------------
# Copyright (C) 2013 - Luciano L. Goncalez
# --------------------------------------------------------------------------
# eMail : dev.lucianogoncalez@gmail.com
# Home  : http://lucky-labs.blogspot.com.br
# ==========================================================================
# Este programa e software livre; voce pode redistribui-lo e/ou modifica-lo
# sob os termos da Licenca Publica Geral GNU, conforme publicada pela Free
# Software Foundation; na versao 2 da Licenca.
#
# Este programa e distribuido na expectativa de ser util, mas SEM QUALQUER
# GARANTIA; sem mesmo a garantia implicita de COMERCIALIZACAO ou de
# ADEQUACAO A QUALQUER PROPOSITO EM PARTICULAR. Consulte a Licenca Publica
# Geral GNU para obter mais detalhes.
#
# Voce deve ter recebido uma copia da Licenca Publica Geral GNU junto com
# este programa; se nao, escreva para a Free Software Foundation, Inc., 59
# Temple Place, Suite 330, Boston, MA 02111-1307, USA. Ou acesse o site do
# GNU e obtenha sua licenca: http://www.gnu.org/
# ==========================================================================
# Makefile (Principal)
# --------------------------------------------------------------------------
#   Este é o arquivo de makefile, ele é responsavel pelas construção do
# sistema.
# --------------------------------------------------------------------------
# Criado em: 18/07/2019
# --------------------------------------------------------------------------
# Uso:
# > make
# ------------------------------------------------------------------------
# Executar: Arquivo de configuracao.
#============================================================================


## Configurações gerais ##
ASSEMBLER_NAME = nasm
COMPILER_NAME = ppc386
LINKER_NAME = ld

COMPILER_VERSIONR = 2.4.4


# Tools #
ASSEMBLER = $(shell which $(ASSEMBLER_NAME))
COMPILER = $(shell which $(COMPILER_NAME))
LINKER = $(shell which $(LINKER_NAME))

export ASSEMBLER COMPILER LINKER

MAIN_DIR := $(CURDIR)
BUILD_DIR := $(MAIN_DIR)/build

export MAIN_DIR BUILD_DIR


## Checagens ##

# Assembler
ifeq ("$(ASSEMBLER)", "")
assembler_error:
	@echo >&2
	@echo >&2 "Não foi possível detectar o assembler: $(ASSEMBLER_NAME)"
	@echo >&2
	@exit 1
endif

# Compiler
ifeq ("$(COMPILER)", "")
compiler_error:
	@echo >&2
	@echo >&2 "Não foi possível detectar o compilador: $(COMPILER_NAME)"
	@echo >&2
	@exit 1
endif

ifneq ("$(COMPILER)", "")
  COMPILER_VERSION = $(shell $(COMPILER) -iV)
endif

ifneq ("$(COMPILER_VERSION)", "$(COMPILER_VERSIONR)")
compiler_version_error:
	@echo >&2
	@echo >&2 "Versão incorreta do compilador:"
	@echo >&2 "Encontrada: $(COMPILER_VERSION)"
	@echo >&2 "Requerida: $(COMPILER_VERSIONR)"
	@echo >&2
	@exit 1
endif

# Linker
ifeq ("$(LINKER)", "")
linker_error:
	@echo >&2
	@echo >&2 "Não foi possível detectar o linker: $(LINKER_NAME)"
	@echo >&2
	@exit 1
endif


# Phony

.PHONY: all clean distclean kernel _build


# Geral

all: submodules kernel

clean:
	rm -rf $(BUILD_DIR)/*

distclean: clean
	-rmdir $(BUILD_DIR)
	-rm *.bin *.map

submodules:
	git submodule init
	git submodule update


# Kernel

kernel: _build
	ln -s $(MAIN_DIR)/Makefile.kernel -T $(BUILD_DIR)/Makefile
	@$(MAKE) -C $(BUILD_DIR)
	cp $(BUILD_DIR)/kernel.bin .
	cp $(BUILD_DIR)/kernel.map .


# Interno

_build: clean
	-mkdir $(BUILD_DIR)
