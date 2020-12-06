"! <p class="shorttext synchronized" lang="en">Advents of Code : 2020 - Day 3 / Problem 2</p>
CLASS zcl_aoc_2020_day3_2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  INHERITING FROM zcl_aoc_2020_base.

  PUBLIC SECTION.

    METHODS:
      zif_aoc_problem~run REDEFINITION.
    METHODS set_movement IMPORTING id_rigth TYPE i id_down TYPE i.

    METHODS run_per_movement
        IMPORTING id_rigth TYPE i id_down TYPE i.

  PROTECTED SECTION.

  PRIVATE SECTION.
    CONSTANTS:
      mc_tree  TYPE c VALUE '#',
      mc_empty TYPE c VALUE '.'.

    DATA: BEGIN OF ms_move,
            right TYPE i VALUE '0',
            down  TYPE i VALUE '0',
          END   OF ms_move.


ENDCLASS.



CLASS zcl_aoc_2020_day3_2 IMPLEMENTATION.


  METHOD zif_aoc_problem~run.

    run_per_movement( id_rigth = 1 id_down = 1 ).
    DATA(ld_result) = get_result( ).
    run_per_movement( id_rigth = 3 id_down = 1 ).
    ld_result = ld_result * get_result(  ).
    run_per_movement( id_rigth = 5 id_down = 1 ).
    ld_result = ld_result * get_result(  ).
    run_per_movement( id_rigth = 7 id_down = 1 ).
    ld_result = ld_result * get_result(  ).
    run_per_movement( id_rigth = 1 id_down = 2 ).
    ld_result = ld_result * get_result(  ).

    set_result( ld_result ).

  ENDMETHOD.

  METHOD set_movement.
    ms_move-right = id_rigth.
    ms_move-down  = id_down.
  ENDMETHOD.


  METHOD run_per_movement.
    set_result( 0 ).
    mo_input_helper->goto_begin(  ).

    set_movement( id_down = id_down id_rigth = id_rigth ).

    DATA(ld_position) = 0.
    DATA(lf_continue) = abap_true.

    DO ms_move-down TIMES.
      IF mo_input_helper->has_next( ) = abap_true.
        mo_input_helper->next(  ).
      ENDIF.
    ENDDO.

    WHILE lf_continue = abap_true.

      DO ms_move-down TIMES.
        IF mo_input_helper->has_next( ) = abap_true.
          DATA(ld_value)  = mo_input_helper->next(  ).

        ELSE.
          lf_continue = abap_false.
        ENDIF.
      ENDDO.

      ld_position = ld_position + ms_move-right.
      "Expand
      WHILE ld_position >= strlen( ld_value ).
        ld_value = ld_value && ld_value.
      ENDWHILE.

      IF ld_value+ld_position(1) = mc_tree.
        set_result( get_result( ) + 1 ).
      ENDIF.

    ENDWHILE.

  ENDMETHOD.

ENDCLASS.
