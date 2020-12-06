"! <p class="shorttext synchronized" lang="en">Advents of Code : 2020 - Runner</p>
CLASS zcl_aoc_2020 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS main.

  PROTECTED SECTION.

    DATA: md_input_root_url TYPE string VALUE 'https://raw.githubusercontent.com/rayatus/abap-aoc/master/input/2020'.

  PRIVATE SECTION.

    METHODS solve_day1_1 IMPORTING io_out TYPE REF TO if_demo_output .
    METHODS solve_day1_2 IMPORTING io_out TYPE REF TO if_demo_output .
    METHODS solve_day2_1 IMPORTING io_out TYPE REF TO if_demo_output .
    METHODS solve_day2_2 IMPORTING io_out TYPE REF TO if_demo_output .
ENDCLASS.



CLASS zcl_aoc_2020 IMPLEMENTATION.

  METHOD main.
    DATA(lo_out) = cl_demo_output=>new( ).

    solve_day1_1( lo_out ).
    solve_day1_2( lo_out ).
    solve_day2_1( lo_out ).
    solve_day2_2( lo_out ).

    lo_out->display( ).

  ENDMETHOD.

  METHOD solve_day1_1.

    io_out->write( |*** Problem - Day1 #1 - Started ***| ).


    DATA(lo_input_helper) = NEW zcl_aoc_input_helper( ).
    lo_input_helper->get_from_http( EXPORTING  id_url = md_input_root_url && '/day1_1'
                                    EXCEPTIONS OTHERS = 999 ).
    IF sy-subrc IS NOT INITIAL.

      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
          WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
          INTO DATA(ld_error).

      io_out->write( |Error while reading input data.| ).
      io_out->write( ld_error ).
    ELSE.
      DATA(lo_problem) = NEW zcl_aoc_2020_day1_1( ).
      lo_problem->zif_aoc_problem~set_input( lo_input_helper ).
      lo_problem->zif_aoc_problem~run( ).
      lo_problem->zif_aoc_problem~print( io_out ).

    ENDIF.

    io_out->write( |*** Problem - Day1 #1 - Finished ***| ).

  ENDMETHOD.

  METHOD solve_day1_2.

    io_out->write( |*** Problem - Day1 #2 - Started ***| ).


    DATA(lo_input_helper) = NEW zcl_aoc_input_helper( ).
    lo_input_helper->get_from_http( EXPORTING  id_url = md_input_root_url && '/day1_2'
                                    EXCEPTIONS OTHERS = 999 ).
    IF sy-subrc IS NOT INITIAL.

      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
          WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
          INTO DATA(ld_error).

      io_out->write( |Error while reading input data.| ).
      io_out->write( ld_error ).
    ELSE.
      DATA(lo_problem) = NEW zcl_aoc_2020_day1_2( ).
      lo_problem->zif_aoc_problem~set_input( lo_input_helper ).
      lo_problem->zif_aoc_problem~run( ).
      lo_problem->zif_aoc_problem~print( io_out ).

    ENDIF.

    io_out->write( |*** Problem - Day1 #2 - Finished ***| ).

  ENDMETHOD.

  METHOD solve_day2_1.
    io_out->write( |*** Problem - Day2 #1 - Started ***| ).


    DATA(lo_input_helper) = NEW zcl_aoc_input_helper( ).
    lo_input_helper->get_from_http( EXPORTING  id_url = md_input_root_url && '/day2_1'
                                    EXCEPTIONS OTHERS = 999 ).
    IF sy-subrc IS NOT INITIAL.

      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
          WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
          INTO DATA(ld_error).

      io_out->write( |Error while reading input data.| ).
      io_out->write( ld_error ).
    ELSE.
      DATA(lo_problem) = NEW zcl_aoc_2020_day2_1( ).
      lo_problem->zif_aoc_problem~set_input( lo_input_helper ).
      lo_problem->zif_aoc_problem~run( ).
      lo_problem->zif_aoc_problem~print( io_out ).

    ENDIF.

    io_out->write( |*** Problem - Day2 #1 - Finished ***| ).

  ENDMETHOD.

  METHOD solve_day2_2.
 io_out->write( |*** Problem - Day2 #2 - Started ***| ).


    DATA(lo_input_helper) = NEW zcl_aoc_input_helper( ).
    lo_input_helper->get_from_http( EXPORTING  id_url = md_input_root_url && '/day2_2'
                                    EXCEPTIONS OTHERS = 999 ).
    IF sy-subrc IS NOT INITIAL.

      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
          WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
          INTO DATA(ld_error).

      io_out->write( |Error while reading input data.| ).
      io_out->write( ld_error ).
    ELSE.
      DATA(lo_problem) = NEW zcl_aoc_2020_day2_2( ).
      lo_problem->zif_aoc_problem~set_input( lo_input_helper ).
      lo_problem->zif_aoc_problem~run( ).
      lo_problem->zif_aoc_problem~print( io_out ).

    ENDIF.

    io_out->write( |*** Problem - Day2 #2 - Finished ***| ).
  ENDMETHOD.

ENDCLASS.
