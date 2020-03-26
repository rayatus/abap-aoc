CLASS zcl_aoc2018_d1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zif_aoc2018_problem.

    ALIASES: print      FOR zif_aoc2018_problem~print,
             run        FOR zif_aoc2018_problem~run,
             set_input  FOR zif_aoc2018_problem~set_input.


    METHODS:
      constructor                  IMPORTING id_initial_freq TYPE i DEFAULT 0,
      calculate_first_part,
      calculate_second_part,
      get_first_result             RETURNING VALUE(rd_result) TYPE i,
      get_second_result            RETURNING VALUE(rd_result) TYPE i.

    EVENTS:
      freq_duplicated.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA:
      mf_freq_duplicated   TYPE abap_bool VALUE abap_false,
      mt_freq_already_seen TYPE STANDARD TABLE OF i,
      md_frequency         TYPE i VALUE 0,
      mo_input_helper      TYPE REF TO zif_aoc2018_input_helper,
      md_first_result      TYPE i VALUE 0,
      md_second_result     TYPE i VALUE 0.

    METHODS:
      change_frequency             IMPORTING id_input TYPE i,
      get_frequency                RETURNING VALUE(rd_frequency) TYPE i,
      set_frequency                IMPORTING id_frequency TYPE i,
      get_first_reached_freq_twice RETURNING VALUE(rd_frequency) TYPE i,
      freq_has_been_duplicated     RETURNING VALUE(rf_freq_duplicated) TYPE abap_bool.

ENDCLASS.



CLASS ZCL_AOC2018_D1 IMPLEMENTATION.


  METHOD calculate_first_part.

    set_frequency( 0 ).

    WHILE mo_input_helper->has_next( ).
      change_frequency( CONV #( mo_input_helper->next( ) ) ).
    ENDWHILE.
    md_first_result = get_frequency( ).

  ENDMETHOD.


  METHOD calculate_second_part.
    set_frequency( 0 ).

    IF mo_input_helper->is_empty( ) = abap_false.

      WHILE freq_has_been_duplicated( ) <> abap_true.
        mo_input_helper->goto_begin( ).

        WHILE mo_input_helper->has_next( ) AND freq_has_been_duplicated( ) <> abap_true. "#EC CI_NESTED
          change_frequency( CONV #( mo_input_helper->next( ) ) ).
        ENDWHILE.

      ENDWHILE.

      md_second_result = get_frequency( ).

    ENDIF.


  ENDMETHOD.


  METHOD change_frequency.
    md_frequency = md_frequency + ( id_input ).

    IF line_exists(  mt_freq_already_seen[ table_line = md_frequency ] ).
      mf_freq_duplicated = abap_true.
    ELSE.
      INSERT INITIAL LINE INTO TABLE mt_freq_already_seen ASSIGNING FIELD-SYMBOL(<ld_freq_already_seen>).
      <ld_freq_already_seen> = md_frequency.
    ENDIF.


  ENDMETHOD.


  METHOD constructor.
    set_frequency( id_initial_freq ).
  ENDMETHOD.


  METHOD freq_has_been_duplicated.
    rf_freq_duplicated = mf_freq_duplicated.
  ENDMETHOD.


  METHOD get_first_reached_freq_twice.
    rd_frequency = get_frequency( ).
  ENDMETHOD.


  METHOD get_first_result.
    rd_result = md_first_result.
  ENDMETHOD.


  METHOD get_frequency.
    rd_frequency = md_frequency.
  ENDMETHOD.


  METHOD get_second_result.
    rd_result = md_second_result.
  ENDMETHOD.


  METHOD set_frequency.
    md_frequency = id_frequency.
  ENDMETHOD.


  METHOD zif_aoc2018_problem~print.
    io_out->write( |Result #1: { md_first_result }| ).
    io_out->write( |Result #2: { md_second_result }| ).
  ENDMETHOD.


  METHOD zif_aoc2018_problem~run.

    calculate_first_part( ).
    calculate_second_part( ).

  ENDMETHOD.


  METHOD zif_aoc2018_problem~set_input.
    mo_input_helper = io_input_helper.
  ENDMETHOD.
ENDCLASS.
