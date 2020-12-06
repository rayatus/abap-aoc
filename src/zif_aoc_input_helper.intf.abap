INTERFACE zif_aoc_input_helper
  PUBLIC .
  types mtyp_d_input_value  type string.
  TYPES mtyp_t_input_values TYPE STANDARD TABLE OF mtyp_d_input_value WITH NON-UNIQUE KEY table_line.

  METHODS has_next
    RETURNING
      VALUE(rf_has_next) TYPE abap_bool.
  METHODS next
    RETURNING
      VALUE(rd_next) TYPE mtyp_d_input_value.


  METHODS is_empty
    RETURNING
      VALUE(rf_empty) TYPE abap_bool .

  METHODS goto_begin .

  METHODS add
    IMPORTING
      !id_input TYPE any .

  METHODS add_list
    IMPORTING
      !it_list TYPE STANDARD TABLE.

  METHODS get_all_values
    RETURNING VALUE(rt_list) TYPE mtyp_t_input_values.

ENDINTERFACE.
