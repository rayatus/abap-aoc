CLASS zcl_aoc2018_input_helper DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES zif_aoc2018_input_helper.

    ALIASES:
     has_next   FOR zif_aoc2018_input_helper~has_next,
     next       FOR zif_aoc2018_input_helper~next,
     add        FOR zif_aoc2018_input_helper~add,
     goto_begin FOR zif_aoc2018_input_helper~goto_begin,
     is_empty   FOR zif_aoc2018_input_helper~is_empty.

    METHODS:
      get_from_http IMPORTING  id_url TYPE string
                    EXCEPTIONS error,
      get_from_local_file IMPORTING  id_path TYPE string
                          EXCEPTIONS error.
  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA:
      mt_input_values TYPE STANDARD TABLE OF i,
      md_index        TYPE i VALUE 0.

ENDCLASS.



CLASS ZCL_AOC2018_INPUT_HELPER IMPLEMENTATION.


  METHOD get_from_http.

    "Only HTTP is allowed
    DATA(ld_url) = to_upper( id_url ).
    FIND 'HTTPS' IN ld_url.
    IF sy-subrc IS INITIAL.
      MESSAGE ID 'BD' TYPE 'E' NUMBER 899
                 WITH |HTTPS method not allowed|
                 RAISING error.
    ENDIF.


    cl_http_client=>create_by_url( EXPORTING  url     = id_url
                                   IMPORTING  client  = DATA(lo_http_client)
                                   EXCEPTIONS OTHERS  = 999 ).
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                 WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
                 RAISING error.
    ENDIF.

    lo_http_client->send( EXCEPTIONS OTHERS = 999 ).
    IF sy-subrc IS INITIAL.
      lo_http_client->receive( EXCEPTIONS OTHERS = 999 ).
      IF sy-subrc IS INITIAL.
        lo_http_client->close( EXCEPTIONS OTHERS = 999 ).
      ENDIF.
    ENDIF.

    IF sy-subrc <> 0.
      lo_http_client->get_last_error( IMPORTING code    =  DATA(ld_http_error_code)
                                                message =  DATA(ld_http_error_text) ).
      MESSAGE ID 'BD' TYPE 'E' NUMBER 899
                 WITH |HTTP error - code: | ld_http_error_code | message: | ld_http_error_text
                 RAISING error.
    ENDIF.



  ENDMETHOD.


  METHOD get_from_local_file.

    DATA: lt_string_tab TYPE STANDARD TABLE OF string.

    cl_gui_frontend_services=>file_exist( EXPORTING file    = id_path
                                          RECEIVING result  = DATA(lf_exists)
                                          EXCEPTIONS OTHERS = 999 ).

    IF lf_exists <> abap_true AND sy-subrc IS NOT INITIAL.
      MESSAGE ID 'BD' TYPE 'E' NUMBER 899
             WITH |File does not exits: | id_path
             RAISING error.
    ENDIF.

    IF sy-subrc IS INITIAL.
      cl_gui_frontend_services=>gui_upload( EXPORTING filename = id_path
                                            CHANGING  data_tab = lt_string_tab
                                            EXCEPTIONS OTHERS  = 999 ).
    ENDIF.

    IF sy-subrc IS INITIAL.
      LOOP AT lt_string_tab INTO DATA(ld_string_tab).
        add( CONV #( ld_string_tab ) ).
      ENDLOOP.
    ENDIF.

    IF sy-subrc IS NOT INITIAL.
      MESSAGE ID      sy-msgid
              TYPE    sy-msgty
              NUMBER  sy-msgno
              WITH    sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
              RAISING error.
    ENDIF.


  ENDMETHOD.


  METHOD zif_aoc2018_input_helper~add.
    INSERT INITIAL LINE INTO TABLE mt_input_values ASSIGNING FIELD-SYMBOL(<ld_input_value>).
    <ld_input_value> = id_input.
  ENDMETHOD.


  METHOD zif_aoc2018_input_helper~goto_begin.
    md_index = 0.
  ENDMETHOD.


  METHOD zif_aoc2018_input_helper~has_next.
    IF md_index < lines( mt_input_values ) AND mt_input_values IS NOT INITIAL.
      rf_has_next = abap_true.
    ELSE.
      rf_has_next = abap_false.
    ENDIF.
  ENDMETHOD.


  METHOD zif_aoc2018_input_helper~is_empty.
    IF mt_input_values IS INITIAL.
      rf_empty = abap_true.
    ELSE.
      rf_empty = abap_false.
    ENDIF.
  ENDMETHOD.


  METHOD zif_aoc2018_input_helper~next.
    ADD 1 TO md_index.
    rd_next = mt_input_values[ md_index ].
  ENDMETHOD.
ENDCLASS.
