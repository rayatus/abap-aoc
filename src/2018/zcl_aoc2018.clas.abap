CLASS zcl_aoc2018 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS main.

  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS problem_d1 IMPORTING io_out TYPE REF TO if_demo_output.
ENDCLASS.



CLASS zcl_aoc2018 IMPLEMENTATION.

  METHOD main.
    DATA(lo_out) = cl_demo_output=>new( ).

    problem_d1( lo_out ).

    lo_out->display( ).

  ENDMETHOD.

  METHOD problem_d1.

    io_out->write( |*** Problem - Day1 #1 - Started ***| ).

    DATA(lo_input_helper) = NEW zcl_aoc2018_input_helper( ).
    lo_input_helper->get_from_local_file( EXPORTING id_path = 'C:\Users\rayat\Downloads\AOC2018_d1_1_input.txt'
                                          EXCEPTIONS OTHERS = 999 ).
    IF sy-subrc IS NOT INITIAL.
      io_out->write( |Error while reading input data.| ).
    ELSE.

      DATA(lo_aoc_d1)     = NEW zcl_aoc2018_d1( ).
      lo_aoc_d1->set_input( lo_input_helper ).
      lo_aoc_d1->run( ).
      lo_aoc_d1->print( io_out ).

    ENDIF.

    io_out->write( |*** Problem - Day1 #1 - Finished ***| ).

  ENDMETHOD.

ENDCLASS.
