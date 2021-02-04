"! <p class="shorttext synchronized" lang="en">Advents of Code : 2020 - Day 4 / Problem 1</p>
CLASS zcl_aoc_2020_day4_1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  INHERITING FROM zcl_aoc_2020_base.

  PUBLIC SECTION.

    METHODS:
      zif_aoc_problem~run REDEFINITION.

  PROTECTED SECTION.

  PRIVATE SECTION.
    CONSTANTS: BEGIN OF mc_passport_key,
                 birth_year      TYPE string VALUE 'byr',
                 issue_year      TYPE string VALUE 'iyr',
                 expiration_year TYPE string VALUE 'eyr',
                 height          TYPE string VALUE 'hgt',
                 hair_color      TYPE string VALUE 'hcl',
                 eye_color       TYPE string VALUE 'ecl',
                 passport_id     TYPE string VALUE 'pid',
                 country_id      TYPE string VALUE 'cid',
               END   OF mc_passport_key.

    TYPES: BEGIN OF mtyp_s_passport,
             birth_year      TYPE string,
             issue_year      TYPE string,
             expiration_year TYPE string,
             height          TYPE string,
             hair_color      TYPE string,
             eye_color       TYPE string,
             passport_id     TYPE string,
             country_id      TYPE string,
           END OF mtyp_s_passport,
           mtyp_t_passports TYPE STANDARD TABLE OF mtyp_s_passport.

    DATA mt_passports TYPE mtyp_t_passports.

    METHODS map_data_into_passport
      IMPORTING
        id_data     TYPE any
      CHANGING
        cs_passport TYPE zcl_aoc_2020_day4_1=>mtyp_s_passport.

    METHODS get_passports_from_input.
    METHODS validate_passports.

ENDCLASS.



CLASS zcl_aoc_2020_day4_1 IMPLEMENTATION.


  METHOD zif_aoc_problem~run.

    get_passports_from_input( ).
    validate_passports(  ).

  ENDMETHOD.


  METHOD map_data_into_passport.
    DATA lt_key_pairs TYPE string_table.

    SPLIT id_data AT space INTO TABLE lt_key_pairs.
    LOOP AT lt_key_pairs INTO DATA(ls_key_pair).
      SPLIT ls_key_pair AT ':' INTO DATA(ld_key) DATA(ld_value).

      CASE ld_key.
        WHEN mc_passport_key-birth_year.
          cs_passport-birth_year = ld_value.
        WHEN mc_passport_key-country_id.
          cs_passport-country_id = ld_value.
        WHEN mc_passport_key-expiration_year.
          cs_passport-expiration_year = ld_value.
        WHEN mc_passport_key-eye_color.
          cs_passport-eye_color = ld_value.
        WHEN mc_passport_key-hair_color.
          cs_passport-hair_color = ld_value.
        WHEN mc_passport_key-height.
          cs_passport-height = ld_value.
        WHEN mc_passport_key-issue_year.
          cs_passport-issue_year = ld_value.
        WHEN mc_passport_key-passport_id.
          cs_passport-passport_id = ld_value.
      ENDCASE.

    ENDLOOP.

  ENDMETHOD.


  METHOD get_passports_from_input.

    DATA ls_passport TYPE mtyp_s_passport.


    WHILE get_input(  )->has_next(  ).
      DATA(ld_data) = get_input(  )->next(  ).
      IF  ld_data IS INITIAL.
        INSERT ls_passport INTO TABLE mt_passports.
        CLEAR ls_passport.
      ELSE.
        map_data_into_passport( EXPORTING id_data = ld_data
                                CHANGING  cs_passport = ls_passport ).
      ENDIF.
    ENDWHILE.
    IF ls_passport IS NOT INITIAL.
      INSERT ls_passport INTO TABLE mt_passports.
    ENDIF.

  ENDMETHOD.


  METHOD validate_passports.
    set_result( 0 ).

    LOOP AT mt_passports INTO DATA(ls_passport).
      DATA(ld_empty_fields) = 0.
      DATA(ld_counter) = 0.

      DO.
        add 1 to ld_counter.
        ASSIGN COMPONENT ld_counter OF STRUCTURE ls_passport TO FIELD-SYMBOL(<ls_value>).
        IF sy-subrc IS INITIAL.
          IF <ls_value> IS INITIAL.
            ADD 1 TO ld_empty_fields.
          ENDIF.
        ELSE.
          EXIT.
        ENDIF.
      ENDDO.

      IF ls_passport-country_id IS INITIAL.
        SUBTRACT 1 FROM ld_empty_fields.
      ENDIF.

      IF ld_empty_fields = 0.
        set_result( get_result(  ) + 1 ).
      ENDIF.

    ENDLOOP.



  ENDMETHOD.

ENDCLASS.
