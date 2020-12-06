CLASS ltcl_aoc_2020_day2_1 DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      map_input_test FOR TESTING RAISING cx_static_check,
      example_test   FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_aoc_2020_day2_1 IMPLEMENTATION.

  METHOD map_input_test.
    DATA(lo_input) = NEW zcl_aoc_input_helper(  ).
    DATA(lo_cut) = NEW zcl_aoc_2020_day2_1(  ).
    DATA lt_mapped_input  TYPE zcl_aoc_2020_day2_1=>mtyp_t_mapped_input.
    DATA lt_mapped_result TYPE zcl_aoc_2020_day2_1=>mtyp_t_mapped_input.

    "Given
    lo_input->add( '1-3 a: abcde' ).
    lo_input->add( '1-3 b: cdefg' ).
    lo_input->add( '2-9 c: ccccccccc' ).
    lo_input->add( '3-11 z: zzzzzdzzzzlzz' ).

    "When
    lo_cut->map_input( EXPORTING io_input_helper = lo_input
                       CHANGING  ct_mapped_input = lt_mapped_input ).

    "Then
    lt_mapped_result = VALUE #( ( min = '1' max = '3'  character = 'a' password = 'abcde' )
                                ( min = '1' max = '3'  character = 'b' password = 'cdefg' )
                                ( min = '2' max = '9'  character = 'c' password = 'ccccccccc' )
                                ( min = '3' max = '11' character = 'z' password = 'zzzzzdzzzzlzz' ) ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lt_mapped_input[]
        exp                  = lt_mapped_result[] ).


  ENDMETHOD.

  METHOD example_test.

    DATA(lo_input) = NEW zcl_aoc_input_helper(  ).
    DATA(lo_cut) = NEW zcl_aoc_2020_day2_1(  ).

    "Given
    lo_input->add( '1-3 a: abcde' ).
    lo_input->add( '1-3 b: cdefg' ).
    lo_input->add( '2-9 c: ccccccccc' ).
    lo_cut->set_input( lo_input ).
    "When
    lo_cut->run(  ).
    "Then
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lo_cut->ms_solution-result
        exp                  = 2 ).
  ENDMETHOD.

ENDCLASS.
