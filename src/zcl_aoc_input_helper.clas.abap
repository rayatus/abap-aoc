CLASS zcl_aoc_input_helper DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_aoc_input_helper .

    ALIASES add
      FOR zif_aoc_input_helper~add .
    ALIASES goto_begin
      FOR zif_aoc_input_helper~goto_begin .
    ALIASES has_next
      FOR zif_aoc_input_helper~has_next .
    ALIASES is_empty
      FOR zif_aoc_input_helper~is_empty .
    ALIASES next
      FOR zif_aoc_input_helper~next .
    ALIASES add_list
      FOR zif_aoc_input_helper~add_list.
    ALIASES get_all_values
      FOR zif_aoc_input_helper~get_all_values.


    METHODS get_from_http
      IMPORTING
        !id_url      TYPE string
        !id_split_at TYPE any DEFAULT cl_abap_char_utilities=>newline
      EXCEPTIONS
        error .

    METHODS get_from_local_file
      IMPORTING
        !id_path TYPE string
      EXCEPTIONS
        error .

    .

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA:
      mt_input_values TYPE zif_aoc_input_helper~mtyp_t_input_values,
      md_index        TYPE i VALUE 0.

ENDCLASS.



CLASS zcl_aoc_input_helper IMPLEMENTATION.


  METHOD get_from_http.

    DATA lt_string_tab TYPE STANDARD TABLE OF string.

    "Switch to a SSL conection?
    DATA(ld_url) = to_upper( id_url ).
    FIND 'HTTPS' IN ld_url.
    IF sy-subrc IS INITIAL.
      "ensure that Certs are in STRUST under ANONYM id.
      DATA(ld_ssl_id) = 'ANONYM'.
    ENDIF.


    cl_http_client=>create_by_url( EXPORTING  url     = id_url
                                              ssl_id  = ld_ssl_id
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
    ENDIF.

    IF sy-subrc IS INITIAL.
      lo_http_client->response->get_status( IMPORTING code   = DATA(ld_http_error_code)
                                                      reason = DATA(ld_http_error_text)  ).
    ENDIF.

    IF ld_http_error_code = 200.
      SPLIT lo_http_client->response->get_cdata(  ) AT id_split_at INTO TABLE lt_string_tab.
      add_list( lt_string_tab ).
    ENDIF.

    IF sy-subrc IS INITIAL.
      lo_http_client->close( EXCEPTIONS OTHERS = 999 ).
    ENDIF.


    IF ld_http_error_code <> 200.
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
      add_list( lt_string_tab ).
    ENDIF.

    IF sy-subrc IS NOT INITIAL.
      MESSAGE ID      sy-msgid
              TYPE    sy-msgty
              NUMBER  sy-msgno
              WITH    sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
              RAISING error.
    ENDIF.


  ENDMETHOD.


  METHOD zif_aoc_input_helper~add.
    INSERT INITIAL LINE INTO TABLE mt_input_values ASSIGNING FIELD-SYMBOL(<ld_input_value>).
    <ld_input_value> = id_input.
  ENDMETHOD.


  METHOD zif_aoc_input_helper~goto_begin.
    md_index = 0.
  ENDMETHOD.


  METHOD zif_aoc_input_helper~has_next.
    IF md_index < lines( mt_input_values ) AND is_empty(  ) = abap_false.
      rf_has_next = abap_true.
    ELSE.
      rf_has_next = abap_false.
    ENDIF.
  ENDMETHOD.


  METHOD zif_aoc_input_helper~is_empty.
    IF mt_input_values IS INITIAL.
      rf_empty = abap_true.
    ELSE.
      rf_empty = abap_false.
    ENDIF.
  ENDMETHOD.


  METHOD zif_aoc_input_helper~next.
    ADD 1 TO md_index.
    rd_next = mt_input_values[ md_index ].
  ENDMETHOD.

  METHOD zif_aoc_input_helper~add_list.
    LOOP AT it_list ASSIGNING FIELD-SYMBOL(<ld_val>).
      add( <ld_val> ).
    ENDLOOP.
  ENDMETHOD.

  METHOD zif_aoc_input_helper~get_all_values.
    rt_list[] = mt_input_values[].
  ENDMETHOD.

ENDCLASS.
