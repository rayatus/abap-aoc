"! <p class="shorttext synchronized" lang="en">Advents of Code : 2020 - Day 2 / Problem 1</p>
CLASS zcl_aoc_2020_day2_1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  INHERITING FROM zcl_aoc_2020_base.

  PUBLIC SECTION.

    TYPES: mtyp_t_pass TYPE STANDARD TABLE OF string WITH DEFAULT KEY,
           BEGIN OF mtyp_s_solution,
             result  TYPE i,
             ok_pass TYPE mtyp_t_pass,
             ko_pass TYPE mtyp_t_pass,
           END   OF mtyp_s_solution.

    DATA: ms_solution TYPE mtyp_s_solution READ-ONLY.

    TYPES: BEGIN OF mtyp_s_mapped_input,
             min       TYPE i,
             max       TYPE i,
             character TYPE c LENGTH 1,
             password  TYPE string,
           END   OF mtyp_s_mapped_input,
           mtyp_t_mapped_input TYPE STANDARD TABLE OF mtyp_s_mapped_input.

    METHODS:
      zif_aoc_problem~run REDEFINITION,
      map_input IMPORTING io_input_helper TYPE REF TO zif_aoc_input_helper
                CHANGING  ct_mapped_input TYPE mtyp_t_mapped_input.



  PROTECTED SECTION.

  PRIVATE SECTION.

    DATA mt_input TYPE mtyp_t_mapped_input.


ENDCLASS.



CLASS zcl_aoc_2020_day2_1 IMPLEMENTATION.


  METHOD map_input.

    DATA ld_min_max   TYPE string.
    DATA ld_min       TYPE string.
    DATA ld_max       TYPE string.
    DATA ld_character TYPE string.

    LOOP AT io_input_helper->get_all_values(  ) INTO DATA(ls_non_mapped_input).

      INSERT INITIAL LINE INTO TABLE ct_mapped_input ASSIGNING FIELD-SYMBOL(<ls_mapped_input>).

      SPLIT ls_non_mapped_input AT space INTO ld_min_max ld_character <ls_mapped_input>-password.
      SPLIT ld_min_max AT '-' INTO ld_min ld_max.
      <ls_mapped_input>-min = ld_min.
      <ls_mapped_input>-max = ld_max.
      <ls_mapped_input>-character  = ld_character+0(1).

    ENDLOOP.
  ENDMETHOD.


  METHOD zif_aoc_problem~run.
    map_input( EXPORTING io_input_helper = get_input( )
               CHANGING  ct_mapped_input = mt_input ).

    LOOP AT mt_input INTO DATA(ls_input).
      FIND ALL OCCURRENCES OF ls_input-character IN ls_input-password MATCH COUNT DATA(ld_n_times).
      IF ld_n_times BETWEEN ls_input-min AND ls_input-max.
        INSERT ls_input-password INTO TABLE ms_solution-ok_pass.
      ELSE.
        INSERT ls_input-password INTO TABLE ms_solution-ko_pass.
      ENDIF.
    ENDLOOP.

    ms_solution-result = lines( ms_solution-ok_pass ).

    set_result( conv #( ms_solution-result ) ).

  ENDMETHOD.
ENDCLASS.
