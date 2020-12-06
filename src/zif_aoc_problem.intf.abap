INTERFACE zif_aoc_problem
  PUBLIC .


  METHODS set_input  IMPORTING io_input_helper TYPE REF TO zif_aoc_input_helper .
  METHODS set_result IMPORTING id_result TYPE decfloat34.
  METHODS get_result RETURNING VALUE(rd_result) TYPE decfloat34.
  METHODS get_input  RETURNING VALUE(ro_input_helper) TYPE REF TO zif_aoc_input_helper .
  METHODS run .

ENDINTERFACE.
