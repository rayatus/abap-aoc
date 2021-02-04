"! <p class="shorttext synchronized" lang="en">Advents of Code : 2020 - Day 2 / Problem 2</p>
CLASS zcl_aoc_2020_day2_2 DEFINITION
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
             pos_1     TYPE i,
             pos_2     TYPE i,
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



CLASS zcl_aoc_2020_day2_2 IMPLEMENTATION.


  METHOD map_input.

    DATA ld_pos_1_pos_2   TYPE string.
    DATA ld_pos_1       TYPE string.
    DATA ld_pos_2       TYPE string.
    DATA ld_character TYPE string.

    LOOP AT io_input_helper->get_all_values(  ) INTO DATA(ls_non_mapped_input).

      INSERT INITIAL LINE INTO TABLE ct_mapped_input ASSIGNING FIELD-SYMBOL(<ls_mapped_input>).

      SPLIT ls_non_mapped_input AT space INTO ld_pos_1_pos_2 ld_character <ls_mapped_input>-password.
      SPLIT ld_pos_1_pos_2 AT '-' INTO ld_pos_1 ld_pos_2.
      <ls_mapped_input>-pos_1 = ld_pos_1.
      <ls_mapped_input>-pos_2 = ld_pos_2.
      <ls_mapped_input>-character  = ld_character+0(1).

    ENDLOOP.
  ENDMETHOD.



  METHOD zif_aoc_problem~run.
    DATA ld_character_pos_1 TYPE i.
    DATA ld_character_pos_2 TYPE i.

    map_input( EXPORTING io_input_helper = get_input( )
               CHANGING  ct_mapped_input = mt_input ).

    LOOP AT mt_input INTO DATA(ls_input).

      ld_character_pos_1 = ls_input-pos_1 - 1.
      ld_character_pos_2 = ls_input-pos_2 - 1.

      IF ( ld_character_pos_1 <= strlen( ls_input-password ) ).
        DATA(ld_characeter_1) = ls_input-password+ld_character_pos_1(1).
      ENDIF.
      IF ( ld_character_pos_2 <= strlen( ls_input-password ) ).
        DATA(ld_characeter_2) = ls_input-password+ld_character_pos_2(1).
      ENDIF.

      IF ( ( ld_characeter_1 = ls_input-character ) AND ( ld_characeter_2 <> ls_input-character ) )
      OR ( ( ld_characeter_2 = ls_input-character ) AND ( ld_characeter_1 <> ls_input-character ) ).
        insert ls_input-password INTO TABLE ms_solution-ok_pass.
      ELSE.
        INSERT ls_input-password INTO TABLE ms_solution-ko_pass.
      ENDIF.
    ENDLOOP.
    ms_solution-result = lines( ms_solution-ok_pass ).
    set_result( conv #( ms_solution-result ) ).
  ENDMETHOD.
ENDCLASS.
