INTERFACE zif_aoc2018_problem
  PUBLIC .
  METHODS:
    set_input IMPORTING io_input_helper TYPE REF TO zif_aoc2018_input_helper,
    run,
    print IMPORTING io_out TYPE REF TO IF_DEMO_OUTPUT.
ENDINTERFACE.
