"! <p class="shorttext synchronized" lang="en">Advents of Code : 2020 - Day 3 / Problem 2</p>
CLASS zcl_aoc_2020_day3_2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  INHERITING FROM zcl_aoc_2020_base.

  PUBLIC SECTION.

    METHODS:
      zif_aoc_problem~run REDEFINITION.
    METHODS run_per_movement
        IMPORTING VALUE(id_right) TYPE i VALUE(id_down) TYPE i.

  PROTECTED SECTION.

  PRIVATE SECTION.
    CONSTANTS:
      mc_tree  TYPE c VALUE '#',
      mc_empty TYPE c VALUE '.'.


ENDCLASS.



CLASS zcl_aoc_2020_day3_2 IMPLEMENTATION.


  METHOD zif_aoc_problem~run.

    run_per_movement( id_right = 1 id_down = 1 ).
    DATA(ld_result) = get_result( ).
    run_per_movement( id_right = 3 id_down = 1 ).
    ld_result = ld_result * get_result(  ).
    run_per_movement( id_right = 5 id_down = 1 ).
    ld_result = ld_result * get_result(  ).
    run_per_movement( id_right = 7 id_down = 1 ).
    ld_result = ld_result * get_result(  ).
    run_per_movement( id_right = 1 id_down = 2 ).
    ld_result = ld_result * get_result(  ).

    set_result( ld_result ).

  ENDMETHOD.



  METHOD run_per_movement.
    set_result( 0 ).

    DATA(ld_position) = 0.
    DATA(ld_row)      = 1.

    DATA(lt_input) = mo_input_helper->get_all_values(  ).

    LOOP AT lt_input INTO DATA(ld_data).
      IF sy-tabix = ld_row.

        "Expand
        WHILE ld_position >= strlen( ld_data ).
          ld_data = ld_data && ld_data.
        ENDWHILE.

        IF ld_data+ld_position(1) = mc_tree.
          set_result( get_result( ) + 1 ).
        ENDIF.

        ADD id_down  TO ld_row.
        ADD id_right TO ld_position.

      ENDIF.

    ENDLOOP.


  ENDMETHOD.


ENDCLASS.
