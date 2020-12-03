*"* use this source file for your ABAP unit test classes
CLASS ltcl_aoc2018_input_helper DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      mo_cut TYPE REF TO zcl_aoc_input_helper.

    METHODS:
      setup,
      teardown,
      test_http FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_aoc2018_input_helper IMPLEMENTATION.
  METHOD setup.
    mo_cut = NEW zcl_aoc_input_helper( ).
  ENDMETHOD.

  METHOD teardown.
    CLEAR mo_cut.
  ENDMETHOD.

  METHOD test_http.

    mo_cut->get_from_http( EXPORTING id_url  = 'https://bitbucket.org/jorgesancho/abap_adventsofcode_2018/src/master/d1/input_1'
                           EXCEPTIONS OTHERS = 999 ).
    cl_abap_unit_assert=>assert_subrc( exp = 0 symsg = CORRESPONDING #( sy ) ).

    cl_abap_unit_assert=>assert_true( mo_cut->has_next( ) ).

  ENDMETHOD.

ENDCLASS.
