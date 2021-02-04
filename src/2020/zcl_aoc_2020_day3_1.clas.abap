"! <p class="shorttext synchronized" lang="en">Advents of Code : 2020 - Day 3 / Problem 1</p>
CLASS zcl_aoc_2020_day3_1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  INHERITING FROM zcl_aoc_2020_base.

  PUBLIC SECTION.

    METHODS:
      zif_aoc_problem~run REDEFINITION.
    "! <p class="shorttext synchronized" lang="en">Calculates expand times</p>
    "! Calculates expand times according to movement and lines in input.
    METHODS calculate_expand_times
      RETURNING
        VALUE(rd_expand_n_times) TYPE i.
    "! <p class="shorttext synchronized" lang="en">Expand input value</p>
    "! Expands input value according requested expand times.
    METHODS prepare_expanded_input IMPORTING id_expand_n_times TYPE i.

  PROTECTED SECTION.

  PRIVATE SECTION.
    CONSTANTS:
      mc_tree  TYPE c VALUE '#',
      mc_empty TYPE c VALUE '.',

      BEGIN OF mc_move,
        right TYPE i VALUE '3',
        down  TYPE i VALUE '1',
      END   OF mc_move.



ENDCLASS.



CLASS zcl_aoc_2020_day3_1 IMPLEMENTATION.


  METHOD zif_aoc_problem~run.

    prepare_expanded_input( calculate_expand_times(  ) ).

    DATA(ld_position) = 0.
    DATA(lf_continue) = abap_true.

    DO mc_move-down TIMES.
      IF get_input( )->has_next( ) = abap_true.
        get_input( )->next(  ).
      ENDIF.
    ENDDO.

    WHILE lf_continue = abap_true.

      DO mc_move-down TIMES.
        IF get_input( )->has_next( ) = abap_true.
          DATA(ld_value) = get_input( )->next(  ).
        ELSE.
          lf_continue = abap_false.
        ENDIF.
      ENDDO.

      ld_position = ld_position + mc_move-right.
      IF ld_value+ld_position(1) = mc_tree.
        set_result( get_result( ) + 1 ).
      ENDIF.

    ENDWHILE.



  ENDMETHOD.

  METHOD prepare_expanded_input.
    DATA ld_expanded_value TYPE string.

    DATA(ld_expand_n_times) = calculate_expand_times( ).

    IF ld_expand_n_times > 1.
      DATA(lo_expanded_input) = NEW zcl_aoc_input_helper(  ).

      WHILE get_input( )->has_next( ).
        DATA(ld_input_value) = get_input( )->next(  ).
        CLEAR ld_expanded_value.
        DO ld_expand_n_times TIMES.
          ld_expanded_value = ld_expanded_value && ld_input_value.
        ENDDO.
        lo_expanded_input->add( ld_expanded_value ).
      ENDWHILE.

    ENDIF.

    set_input( lo_expanded_input ).

  ENDMETHOD.


  METHOD calculate_expand_times.

    DATA(ld_lines) = lines( get_input( )->get_all_values(  ) ).
    IF ld_lines > mc_move-right.
      rd_expand_n_times  = ld_lines DIV mc_move-right.
      IF ( ld_lines MOD mc_move-right ) <> 0.
        ADD 1 TO rd_expand_n_times.
      ENDIF.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
