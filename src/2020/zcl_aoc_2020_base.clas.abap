class ZCL_AOC_2020_BASE definition
  public
  abstract
  create public .

public section.

  interfaces ZIF_AOC_PROBLEM
      abstract methods RUN
                       PRINT .

  aliases PRINT
    for ZIF_AOC_PROBLEM~PRINT .
  aliases RUN
    for ZIF_AOC_PROBLEM~RUN .
  aliases SET_INPUT
    for ZIF_AOC_PROBLEM~SET_INPUT .
  PROTECTED SECTION.
    DATA: mo_input_helper      TYPE REF TO zif_aoc_input_helper.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_AOC_2020_BASE IMPLEMENTATION.


  METHOD zif_aoc_problem~set_input.
    mo_input_helper = io_input_helper.
  ENDMETHOD.
ENDCLASS.
