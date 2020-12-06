CLASS zcl_aoc_2020_base DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_aoc_problem
      ABSTRACT METHODS run.

    ALIASES run
      FOR zif_aoc_problem~run .
    ALIASES set_input
      FOR zif_aoc_problem~set_input .
    ALIASES set_result
    FOR zif_aoc_problem~set_result .
    ALIASES get_result
    FOR zif_aoc_problem~get_result.
    ALIASES get_input
    FOR zif_aoc_problem~get_input.

  PROTECTED SECTION.
    DATA: mo_input_helper TYPE REF TO zif_aoc_input_helper,
          md_result       TYPE decfloat34.

  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_aoc_2020_base IMPLEMENTATION.


  METHOD zif_aoc_problem~set_input.
    mo_input_helper = io_input_helper.
  ENDMETHOD.

  METHOD zif_aoc_problem~get_result.
    rd_result = md_result.
  ENDMETHOD.

  METHOD zif_aoc_problem~set_result.
    md_result = id_result.
  ENDMETHOD.

  METHOD zif_aoc_problem~get_input.
    ro_input_helper = mo_input_helper.
  ENDMETHOD.

ENDCLASS.
