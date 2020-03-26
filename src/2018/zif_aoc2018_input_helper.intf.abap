INTERFACE zif_aoc2018_input_helper
  PUBLIC .
  METHODS:
    has_next      RETURNING VALUE(rf_has_next) TYPE abap_bool,
    next          RETURNING VALUE(rd_next) TYPE i,
    add           IMPORTING id_input TYPE i,
    is_empty      RETURNING VALUE(rf_empty) type abap_bool,
    goto_begin.

ENDINTERFACE.
