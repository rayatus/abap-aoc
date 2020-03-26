*"* use this source file for your ABAP unit test classes

CLASS ltcl_aoc2018_d1_1_ DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      mo_cut   TYPE REF TO zcl_aoc2018_d1,
      mo_input TYPE REF TO zcl_aoc2018_input_helper.

    METHODS:
      setup,
      teardown,
      test_1 FOR TESTING RAISING cx_static_check,
      test_2 FOR TESTING RAISING cx_static_check,
      test_3 FOR TESTING RAISING cx_static_check,
      test_4 FOR TESTING RAISING cx_static_check,
      test_5 FOR TESTING RAISING cx_static_check.

ENDCLASS.


CLASS ltcl_aoc2018_d1_1_ IMPLEMENTATION.

  METHOD setup.
    mo_cut   = NEW zcl_aoc2018_d1( ).
    mo_input = NEW zcl_aoc2018_input_helper( ).
  ENDMETHOD.

  METHOD teardown.
    CLEAR: mo_cut,
           mo_input.
  ENDMETHOD.


  METHOD test_1.

    mo_input->add( '+1' ).
    mo_input->add( '-2' ).
    mo_input->add( '+3' ).
    mo_input->add( '+1' ).

    mo_cut->set_input( mo_input ).
    mo_cut->calculate_first_part( ).

    cl_abap_unit_assert=>assert_equals( act = mo_cut->get_first_result( )  exp = 3 ).
  ENDMETHOD.

  METHOD test_2.

    mo_input->add( '+1' ).
    mo_input->add( '+1' ).
    mo_input->add( '+1' ).

    mo_cut->set_input( mo_input ).
    mo_cut->calculate_first_part( ).

    cl_abap_unit_assert=>assert_equals( act = mo_cut->get_first_result( )  exp = 3 ).
  ENDMETHOD.

  METHOD test_3.

    mo_input->add( '+1' ).
    mo_input->add( '+1' ).
    mo_input->add( '-2' ).

    mo_cut->set_input( mo_input ).
    mo_cut->calculate_first_part( ).

    cl_abap_unit_assert=>assert_equals( act = mo_cut->get_first_result( )  exp = 0 ).
  ENDMETHOD.

  METHOD test_4.

    mo_input->add( '-1' ).
    mo_input->add( '-2' ).
    mo_input->add( '-3' ).

    mo_cut->set_input( mo_input ).
    mo_cut->calculate_first_part( ).

    cl_abap_unit_assert=>assert_equals( act = mo_cut->get_first_result( )  exp = -6 ).
  ENDMETHOD.

  METHOD test_5.

    mo_input->add( '+1' ).
    mo_input->add( '-2' ).
    mo_input->add( '+3' ).
    mo_input->add( '+1' ).
    mo_input->add( '+1' ).
    mo_input->add( '-2' ).

    mo_cut->set_input( mo_input ).
    mo_cut->calculate_second_part( ).

    cl_abap_unit_assert=>assert_equals( act = mo_cut->get_second_result( )  exp = 2 ).
  ENDMETHOD.
ENDCLASS.
