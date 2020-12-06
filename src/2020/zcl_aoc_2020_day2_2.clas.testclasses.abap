CLASS ltcl_aoc_2020_day2_2 DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      example_test     FOR TESTING RAISING cx_static_check,
      outofbounds_test FOR TESTING RAISING cx_static_check,
      index_1_test     FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_aoc_2020_day2_2 IMPLEMENTATION.

  METHOD example_test.
    "Given
    DATA(cut)    = NEW zcl_aoc_2020_day2_2(  ).
    DATA(input)  = NEW zcl_aoc_input_helper(  ).

    input->add( '1-3 a: abcde' ). "ok
    input->add( '1-3 b: cdefg' ). "ko
    input->add( '2-9 c: ccccccccc' ). "ko
    input->add( '3-11 z: zzzzzdzzzzlzz' ). "ok

    "When
    cut->set_input( input ).
    cut->run(  ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut->ms_solution-result exp = 2 ).
  ENDMETHOD.

  METHOD outofbounds_test.
    "Given
    DATA(cut)    = NEW zcl_aoc_2020_day2_2(  ).
    DATA(input)  = NEW zcl_aoc_input_helper(  ).

    input->add( '1-50 z: abcde' ). "ko - OutOfBounds

    "When
    cut->set_input( input ).
    cut->run(  ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut->ms_solution-result exp = 0 ).
  ENDMETHOD.

  METHOD index_1_test.
    "Given
    DATA(cut)    = NEW zcl_aoc_2020_day2_2(  ).
    DATA(input)  = NEW zcl_aoc_input_helper(  ).

    input->add( '1-5 a: cbcda' ).

    "When
    cut->set_input( input ).
    cut->run(  ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut->ms_solution-result exp = 1 ).
  ENDMETHOD.

ENDCLASS.
