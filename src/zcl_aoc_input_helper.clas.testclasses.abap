CLASS ltcl_aoc_input_helper DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      test_200_ok        FOR TESTING RAISING cx_static_check,
      test_404_not_found for testing raising cx_static_check.
ENDCLASS.


CLASS ltcl_aoc_input_helper IMPLEMENTATION.

  METHOD test_404_not_found.

    DATA(input) = NEW zcl_aoc_input_helper(  ).
    input->get_from_http( EXPORTING id_url  = 'https://raw.githubusercontent.com/rayatus/abap-aoc/master/input/2020/dummy'
                          EXCEPTIONS OTHERS = 999 ).
    cl_abap_unit_assert=>assert_subrc( EXPORTING exp = 999 act = sy-subrc ).
  ENDMETHOD.

  METHOD test_200_ok.
    DATA(input) = NEW zcl_aoc_input_helper(  ).
    input->get_from_http( EXPORTING id_url  = 'https://raw.githubusercontent.com/rayatus/abap-aoc/master/input/2020/day1_1'
                          EXCEPTIONS OTHERS = 999 ).
    cl_abap_unit_assert=>assert_subrc( EXPORTING exp = 0 act = sy-subrc ).
  ENDMETHOD.

ENDCLASS.
