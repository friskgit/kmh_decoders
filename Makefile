## Makefile for running the run_dec_KMH scripts
## 
## Following are the functions, called by the targets below,
## set by the parameter $(function): `make 108 function=5`
##
## The available functions are specified as follows:

##   - case 1 % AllRAD, mixed order: 4,3
##   - case 2 % EvenEnergy
##		Crisp but less pressence
##   - case 3 % Mode-Matching <NOT USABLE>
##   - case 4 % Energy limited 50%, 2 band, shelf filters, one matrix, HV
## 		Smooth and good sounding, clear
##   - case 5 % Spherical Slepian, order set by caller, 'HV', 'ACN', 'SN3D'
##		Not much difference
##   - case 6 % AllRAD ACN/N3D, HV
##		Nice presence, slightly muffled
##   - case 7 % Test
##
## Set the version of the array to use with the parameter $(array):
## `make 108 array=normal`
## 
## Copying and distribution of this file, with or without modification,
## are permitted in any medium without royalty provided the copyright
## notice and this notice are preserved.  This file is offered as-is,
## without any warranty.

## Copyright Henrik Frisk 2018 (C)
# ==========
# Fre Jul 20 15:51:18 CEST 2018

BIN	= /usr/local/bin
OCT 	= $(BIN)/octave --eval
SHELL 	:= $(BIN)/bash
AMBIX_INSTALL	:= ~/Library/ambix/binaural_presets
MAKEFILE_FAUST 	:= ~/Music/faust/faust_stuff.git/Makefile.adt
array 	= normal
function = 6

bindir	= ../decoders
108dir	= $(bindir)/KMH108
114dir	= $(bindir)/KMH114
lsdir	= $(bindir)/KMHLS
srcdir 	= src
ambdecdir= ambdec
ambixdir= ambix
imgdir	= img
csv 	= $(wildcard ../decoders/*.csv)
mat 	= $(wildcard ../decoders/*.mat)
png 	= $(wildcard ../decoders/*.png)

run_orders = run_orders
run_dec	= run_dec_KMH
loc108 	= KMH108_AE
loc114 	= KMH114_AE
locls 	= KMHLS_AE
order	= 1

108data = $(108dir)/$(loc108)_$(array)_$(function)
114data = $(114dir)/$(loc114)_$(array)_$(function)
lsdata = $(lsdir)/$(locls)_$(array)_$(function)

open_par	= (
close_par	= )

call_108 := $(open_par)$(order), '$(loc108)', '$(array)', $(function)$(close_par)
call_114 := $(open_par)$(order), '$(loc114)', '$(array)', $(function)$(close_par)
call_ls := $(open_par)$(order), '$(locls)', '$(array)', $(function)$(close_par)

call_108_orders := $(open_par)'$(loc108)', '$(array)', $(function)$(close_par)
call_114_orders := $(open_par)'$(loc114)', '$(array)', $(function)$(close_par)
call_ls_orders := $(open_par)'$(locls)', '$(array)', $(function)$(close_par)

trim108 = $(108data)/$(srcdir)/$(word 1, $(subst _, ,$(notdir $(var))))_$(word 2, $(subst _, ,$(notdir $(var))))_$(word 3, $(subst _, ,$(notdir $(var))))_$(array)_$(function).dsp

trim114 = $(114data)/$(srcdir)/$(word 1, $(subst _, ,$(notdir $(var))))_$(word 2, $(subst _, ,$(notdir $(var))))_$(word 3, $(subst _, ,$(notdir $(var))))_$(array)_$(function).dsp

trimls = $(lsdata)/$(srcdir)/$(word 1, $(subst _, ,$(notdir $(var))))_$(word 2, $(subst _, ,$(notdir $(var))))_$(word 3, $(subst _, ,$(notdir $(var))))_$(array)_$(function).dsp

## Add the path to the ADT matlab scripts
path	= '/Users/henrik_frisk/Music/ambidecodertoolbox/matlab'

.PHONY : 108 all_108 108_norm 108_norm_all 108_move 108_dirs

108 : 108_norm 108_move simplify_name_108

all_108 : 108_norm_all 108_move simplify_name_108

## Make one decoder in order $(order)
108_norm : 
	$(OCT) "$(run_dec)$(call_108)"

## Make decoders in order 1, 3, 5.
108_norm_all : 
	$(OCT) "$(run_orders)$(call_108_orders)"

108_move : 108_dirs install_make_108
	@echo "Cleaning up directory..."
	@mv $(bindir)/${loc108::3}*.dsp $(108data)/$(srcdir)/
	@mv $(bindir)/${loc108::3}*.config $(108data)/$(ambixdir)/
	$(eval ADEC = $(wildcard $(bindir)/*.ambdec))
	$(if $(ADEC), @mv $(bindir)/*ambdec $(108data)/$(ambdecdir), )
	@mv $(csv) $(108data)/$(imgdir)
	@mv $(mat) $(108data)/$(imgdir)
	$(eval TMP = $(wildcard $(bindir)/*.png))
	$(if $(TMP), @mv $(png) $(108data)/$(imgdir), )

108_dirs :
	@echo "Making directories"
	if [ ! -d $(108data) ]; then \
	   mkdir -p $(108data)/$(srcdir); \
	   mkdir -p $(108data)/$(ambixdir); \
	   mkdir -p $(108data)/$(ambdecdir); \
	   mkdir -p $(108data)/$(imgdir); \
	fi

.PHONY : 114 all_114 114_norm 114_norm_all 114_move 114_dirs

114 : 114_norm 114_move simplify_name_114

all_114 : 114_norm_all 114_move simplify_name_114

## Make one decoder in order $(order)
114_norm : 
	$(OCT) "$(run_dec)$(call_114)"

## Make decoders in order 1, 3, 5.
114_norm_all : 
	$(OCT) "$(run_orders)$(call_114_orders)"

114_move : 114_dirs install_make_114
	@echo "Cleaning up directory..."
	@mv $(bindir)/${loc114::3}*.dsp $(114data)/$(srcdir)/
	@mv $(bindir)/${loc114::3}*.config $(114data)/$(ambixdir)/
	$(eval ADEC = $(wildcard $(bindir)/*.ambdec))
	$(if $(ADEC), @mv $(bindir)/*ambdec $(114data)/$(ambdecdir), )
	@mv $(csv) $(114data)/$(imgdir)
	@mv $(mat) $(114data)/$(imgdir)
	$(eval TMP = $(wildcard $(bindir)/*.png))
	$(if $(TMP), @mv $(png) $(114data)/$(imgdir), )

114_dirs :
	@echo "Making directories"
	if [ ! -d $(114data) ]; then \
	   mkdir -p $(114data)/$(srcdir); \
	   mkdir -p $(114data)/$(ambdecdir); \
	   mkdir -p $(114data)/$(ambixdir); \
	   mkdir -p $(114data)/$(imgdir); \
	fi

.PHONY : ls all_ls ls_norm ls_norm_all ls_move ls_dirs

ls : ls_norm ls_move simplify_name_ls

all_ls : ls_norm_all ls_move simplify_name_ls

## Make one decoder in order $(order)
ls_norm : 
	$(OCT) "$(run_dec)$(call_ls)"

## Make decoders in order 1, 3, 5.
ls_norm_all : 
	$(OCT) "$(run_orders)$(call_ls_orders)" 	

ls_move : ls_dirs install_make_ls
	@echo "Cleaning up directory..."
	@mv $(bindir)/KMHLS*.dsp $(lsdata)/$(srcdir)/
	@mv $(bindir)/KMHLS*.config $(lsdata)/$(ambixdir)/
	$(eval ADEC = $(wildcard $(bindir)/*.ambdec))
	$(if $(ADEC), @mv $(bindir)/*ambdec $(lsdata)/$(ambdecdir), )
	@mv $(csv) $(lsdata)/$(imgdir)
	@mv $(mat) $(lsdata)/$(imgdir)
	$(eval TMP = $(wildcard $(bindir)/*.png))
	$(if $(TMP), @mv $(png) $(lsdata)/$(imgdir), )

ls_dirs :
	@echo "Making directories"
	if [ ! -d $(lsdata) ]; then \
	   mkdir -p $(lsdata)/$(srcdir); \
	   mkdir -p $(lsdata)/$(ambdecdir); \
	   mkdir -p $(lsdata)/$(ambixdir); \
	   mkdir -p $(lsdata)/$(imgdir); \
	fi

dirs :
	@echo $(108dir)/KMH108_AE_normal_9/$(img)

.PHONY : install_make_108 install_make_114 install_make_ls cleanup_108 cleanup_114 cleanup_ls simplify_name_108 simplify_name_114 simplify_name_ls test

install_make_108 :
	@install $(MAKEFILE_FAUST) $(108data)/Makefile 
	$(shell if [ ! -a "$(108data)/../Makefile" ] ; then install "Makefile.package" "$(108data)/../Makefile"; fi )

install_make_114 :
	@install $(MAKEFILE_FAUST) $(114data)/Makefile
	$(shell if [ ! -a "$(114data)/../Makefile" ] ; then install "Makefile.package" "$(108data)/../Makefile"; fi )

install_make_ls :
	@install $(MAKEFILE_FAUST) $(lsdata)/Makefile
	$(shell if [ ! -a "$(lsdata)/../Makefile" ] ; then install "Makefile.package" "$(108data)/../Makefile"; fi )

simplify_name_108 :
	$(eval dsp_files:=$(wildcard $(108data)/$(srcdir)/*.dsp))
	@echo $(foreach var, $(dsp_files), $(shell sed -i .bu 's/^declare name.*/declare name "$(notdir $(basename $(trim108)))";/' $(var) && mv "$(var)" $(trim108)))
	rm -f $(108data)/$(srcdir)/*.dsp.bu

## Unused
change_name_108 : 
	$(eval dsp_files:=$(wildcard $(108data)/$(srcdir)/*.dsp))	
	$(foreach var, $(dsp_files), $(shell sed -i .bu 's/^declare name.*/declare name "$(notdir $(var))"/' $(var)))
	rm -f $(108data)/$(srcdir)/*.dsp.bu

simplify_name_114 :
	$(eval dsp_files:=$(wildcard $(114data)/$(srcdir)/*.dsp))
	@echo $(foreach var, $(dsp_files), $(shell sed -i .bu 's/^declare name.*/declare name "$(notdir $(basename $(trim114)))";/' $(var) && mv "$(var)" $(trim114))) 
	rm -f $(114data)/$(srcdir)/*.dsp.bu

simplify_name_ls :
	$(eval dsp_files:=$(wildcard $(lsdata)/$(srcdir)/*.dsp))
	@echo $(foreach var, $(dsp_files), $(shell sed -i .bu 's/^declare name.*/declare name "$(notdir $(basename $(trimls)))";/' $(var) && mv "$(var)" $(trimls))) 
	rm -f $(lsdata)/$(srcdir)/*.dsp.bu

install_ambix_108 :
	@install -d $(108data)/$(ambixdir)/*.config $(AMBIX_INSTALL)/kmh_108

###################################################################
## Unused
cleanup_108 :
	@f2clearus $(108data)/$(srcdir)/ $(function)

cleanup_114 :
	@f2clearus $(114data)/$(srcdir)/ $(function)

cleanup_ls :
	@f2clearus $(lsdata)/$(srcdir)/ $(function)
