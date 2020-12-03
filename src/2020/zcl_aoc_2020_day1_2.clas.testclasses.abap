CLASS ltcl_aoc_2020_day1_2 DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      first_test FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_aoc_2020_day1_2 IMPLEMENTATION.

  METHOD first_test.

    "Given
    DATA(input) = NEW zcl_aoc_input_helper(  ).

    input->add( 1721 ).
    input->add( 979 ).
    input->add( 366 ).
    input->add( 299 ).
    input->add( 675 ).
    input->add( 1456 ).

    "When
    DATA(cut) = NEW zcl_aoc_2020_day1_2(  ).
    cut->zif_aoc_problem~set_input( input ).
    cut->zif_aoc_problem~run(  ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut->ms_solution-result exp = 241861950 ).

  ENDMETHOD.

ENDCLASS.
