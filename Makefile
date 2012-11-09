# GNU Make 3.81
#
SHELL = /bin/sh
RUSTC = rustc0.4

PCRE_DIR = ./rust-pcre

objects = pcre.so docopt.so agnostic_testee run_agnostic_tests

# TODO: in fututre need to remove it and use whole agnostic test suite
AGNOSTIC_TEST_IDS = `seq 1 3`

docopt: $(objects)

docopt.so: docopt.rs docopt.rc
	$(RUSTC) -L ./rust-pcre docopt.rc

pcre.so: $(PCRE_DIR)/pcre.rs $(PCRE_DIR)/pcre.rc
	$(RUSTC) $(PCRE_DIR)/pcre.rc

agnostic_testee: agnostic_testee.rs
	$(RUSTC) agnostic_testee.rs -L ./ -L ./rust-pcre

run_agnostic_tests:
		python ./python_docopt/language_agnostic_test/language_agnostic_tester.py ./agnostic_testee $(AGNOSTIC_TEST_IDS)

clean:
	rm *.so agnostic_testee $(PCRE_DIR)/*.so