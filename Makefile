#Some Makefile for CLASS.
#Julien Lesgourgues, 18.04.2010

MDIR := $(shell pwd)
WRKDIR = $(MDIR)/build
#PMCLIB = $(MDIR)/../../../pmclib

.base:
	if ! [ -a $(WRKDIR) ]; then mkdir $(WRKDIR) ; mkdir $(WRKDIR)/lib; fi;
	touch build/.base

vpath %.c source:tools:main:test
vpath %.o build
vpath .base build

CC       = gcc

#CCFLAG   = -fast -mp -mp=nonuma -mp=allcores -g
#LDFLAG   = -fast -mp -mp=nonuma -mp=allcores -g
#CCFLAG   = -O3 -fopenmp -Wall -g
#LDFLAG   = -O3 -fopenmp -Wall -g
CCFLAG   = -O4 -fopenmp -Wall
LDFLAG   = -O4 -fopenmp -Wall
#CCFLAG = -O2 -ggdb
#LDFLAG = -O2 -ggdb
#CCFLAG = -O2
#LDFLAG = -O2

#-L$(PMCLIB)/lib -lerrorio -lreadConf -lgsl -lgslcblas -llua

INCLUDES = ../include
#-I../../../../pmclib/include/pmclib/tools -I../../../../pmclib/include

%.o:  %.c .base
	cd $(WRKDIR);$(CC) $(CCFLAG) -I$(INCLUDES) -c ../$< -o $*.o

#TOOLS = growTable.o dei_rkck.o evolver_rkck.o arrays.o parser.o
TOOLS = growTable.o dei_rkck.o sparse.o evolver_ndf15.o arrays.o parser.o

INPUT = input.o

PRECISION = precision.o

BACKGROUND = background.o

THERMO = thermodynamics.o

PERTURBATIONS = perturbations.o 

BESSEL = bessel.o

TRANSFER = transfer.o

PRIMORDIAL = primordial.o

SPECTRA = spectra.o

LENSING = lensing.o

OUTPUT = output.o

CLASS = class.o

TRG = trg.o

TEST_OPTIMIZE_1D = test_optimize_1D.o

TEST_LOOPS = test_loops.o

TEST_SPECTRA = test_spectra.o

TEST_TRANSFER = test_transfer.o

TEST_BESSEL = test_bessel.o

TEST_PERTURBATIONS = test_perturbations.o

TEST_THERMODYNAMICS = test_thermodynamics.o

TEST_BACKGROUND = test_background.o

TEST_TRG = test_trg.o

TEST_KARIM = test_karim.o

TEST_PBC = test_pbc.o

class: $(TOOLS) $(INPUT) $(BACKGROUND) $(THERMO) $(PERTURBATIONS) $(BESSEL) $(TRANSFER) $(PRIMORDIAL) $(SPECTRA) $(LENSING) $(OUTPUT) $(CLASS)
	$(CC) $(LDFLAG) -o  $@ $(addprefix build/,$(notdir $^)) -lm

test_pbc: $(TOOLS) $(INPUT) $(BACKGROUND) $(THERMO) $(PERTURBATIONS) $(BESSEL) $(TRANSFER) $(PRIMORDIAL) $(SPECTRA) $(OUTPUT) $(TEST_PBC)
	$(CC) $(LDFLAG) -o  $@ $(addprefix build/,$(notdir $^)) -lm

test_optimize_1D: $(TOOLS) $(INPUT) $(BACKGROUND) $(THERMO) $(PERTURBATIONS) $(BESSEL) $(TRANSFER) $(PRIMORDIAL) $(SPECTRA) $(OUTPUT) $(TEST_OPTIMIZE_1D)
	$(CC) $(LDFLAG) -o  $@ $(addprefix build/,$(notdir $^)) -lm

test_loops: $(TOOLS) $(INPUT) $(BACKGROUND) $(THERMO) $(PERTURBATIONS) $(BESSEL) $(TRANSFER) $(PRIMORDIAL) $(SPECTRA) $(OUTPUT) $(TEST_LOOPS)
	$(CC) $(LDFLAG) -o  $@ $(addprefix build/,$(notdir $^)) -lm

test_trg: $(TOOLS) $(INPUT) $(BACKGROUND) $(THERMO) $(PERTURBATIONS) $(BESSEL) $(TRANSFER) $(PRIMORDIAL) $(SPECTRA) $(TRG) $(TEST_TRG)
	$(CC) $(LDFLAG) -o  $@ $(addprefix build/,$(notdir $^)) -lm

test_spectra: $(TOOLS) $(INPUT) $(BACKGROUND) $(THERMO) $(PERTURBATIONS) $(BESSEL) $(TRANSFER) $(PRIMORDIAL) $(SPECTRA) $(TEST_SPECTRA)
	$(CC) $(LDFLAG) -o  $@ $(addprefix build/,$(notdir $^)) -lm

test_transfer: $(TOOLS) $(INPUT) $(BACKGROUND) $(THERMO) $(PERTURBATIONS) $(BESSEL) $(TRANSFER) $(TEST_TRANSFER)
	$(CC) $(LDFLAG) -o  $@ $(addprefix build/,$(notdir $^)) -lm

test_bessel: $(TOOLS) $(INPUT) $(BACKGROUND) $(THERMO) $(PERTURBATIONS) $(BESSEL) $(TEST_BESSEL)
	$(CC) $(LDFLAG) -o  $@ $(addprefix build/,$(notdir $^)) -lm

test_perturbations: $(TOOLS) $(INPUT) $(BACKGROUND) $(THERMO) $(PERTURBATIONS) $(TEST_PERTURBATIONS)
	$(CC) $(LDFLAG) -o  $@ $(addprefix build/,$(notdir $^)) -lm

test_thermodynamics: $(TOOLS) $(INPUT) $(BACKGROUND) $(THERMO) $(TEST_THERMODYNAMICS)
	$(CC) $(LDFLAG) -o  $@ $(addprefix build/,$(notdir $^)) -lm

test_background: $(TOOLS) $(INPUT) $(BACKGROUND) $(TEST_BACKGROUND)
	$(CC) $(LDFLAG) -o  $@ $(addprefix build/,$(notdir $^)) -lm

test_karim: $(TOOLS) $(INPUT) $(BACKGROUND) $(THERMO) $(PERTURBATIONS) $(BESSEL) $(TRANSFER) $(PRIMORDIAL) $(SPECTRA) $(OUTPUT) $(TEST_KARIM)
	$(CC) $(LDFLAG) -o  $@ $(addprefix build/,$(notdir $^)) -lm

clean: .base
	rm -rf $(WRKDIR);
