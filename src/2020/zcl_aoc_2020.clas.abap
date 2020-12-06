CLASS zcl_aoc_2020 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS main.

  PROTECTED SECTION.

    DATA: md_input_root_url TYPE string VALUE 'https://raw.githubusercontent.com/rayatus/abap-aoc/master/input/2020/day'.

  PRIVATE SECTION.
    TYPES: BEGIN OF mtyp_s_solution,
             problem TYPE string,
             result  TYPE string,
           END   OF mtyp_s_solution,
           mtyp_t_solutions TYPE STANDARD TABLE OF mtyp_s_solution.
    DATA mt_solutions TYPE mtyp_t_solutions.

ENDCLASS.



CLASS zcl_aoc_2020 IMPLEMENTATION.

  METHOD main.
    DATA ld_day      TYPE n VALUE '1'.
    DATA ld_problem  TYPE n VALUE '1'.
    DATA lo_problem  TYPE REF TO zif_aoc_problem.
    DATA lo_ref      TYPE REF TO object.
    DATA ls_solution LIKE LINE OF mt_solutions.

    DATA(lo_out) = cl_demo_output=>new( ).

    TRY.
        DATA(lt_subclasses) = NEW cl_oo_class( 'ZCL_AOC_2020_BASE' )->get_subclasses(  ).
        SORT lt_subclasses.
        LOOP AT lt_subclasses INTO DATA(ls_subclass).

          ls_solution-problem = |Day{ ld_day } #{ ld_problem }|.

          DATA(lo_input_helper) = NEW zcl_aoc_input_helper( ).
          lo_input_helper->get_from_http( EXPORTING  id_url = md_input_root_url && ld_day && '_' && ld_problem
                                          EXCEPTIONS OTHERS = 999 ).
          IF sy-subrc IS NOT INITIAL.

            MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
                INTO DATA(ld_error).

            ls_solution-result = ld_error.
          ELSE.


            CREATE OBJECT lo_ref TYPE (ls_subclass-clsname).

            lo_problem ?= lo_ref.
            TRY.
                lo_problem->set_input( lo_input_helper ).
                lo_problem->run( ).

                ls_solution-result = lo_problem->get_result( ).
              CATCH cx_root INTO DATA(lo_exception).
                ls_solution-result = lo_exception->get_text(  ).
            ENDTRY.

          ENDIF.

          INSERT ls_solution INTO TABLE mt_solutions.

          CASE ld_problem.
            WHEN '1'.
              ld_problem = '2'.
            WHEN '2'.
              ld_problem = '1'.
              ADD 1 TO ld_day.
          ENDCASE.

        ENDLOOP.
      CATCH cx_class_not_existent.
        "handle exception
    ENDTRY.

    lo_out->display( data = mt_solutions name = 'Advents of Code - 2020').

  ENDMETHOD.



ENDCLASS.
